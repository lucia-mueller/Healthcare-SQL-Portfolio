-- ============================================================
-- Query 1: Patient Condition Count
-- Business Question:
-- How many diagnosed conditions does each patient have?
-- ============================================================
SELECT
    pt.patient_id,
    pt.patient_name,
    COUNT(DISTINCT cd.condition_id) AS total_condition_count
FROM Patients AS pt
LEFT JOIN Conditions AS cd
    ON pt.patient_id = cd.patient_id
GROUP BY pt.patient_id, pt.patient_name
ORDER BY total_condition_count DESC, pt.patient_id ASC;

-- ============================================================
-- Query 2: Patient HCC Risk Weight
-- Business Question:
-- What is the total diagnosis-level HCC risk weight for each patient?
-- ============================================================
SELECT
    pt.patient_name,
    pt.patient_id,
    COALESCE(SUM(cd.risk_weight), 0) AS total_hcc_risk_weight
FROM Patients AS pt
LEFT JOIN Conditions AS cd
    ON pt.patient_id = cd.patient_id
GROUP BY pt.patient_name, pt.patient_id
ORDER BY total_hcc_risk_weight DESC, pt.patient_id ASC;

-- ============================================================
-- Query 3: Patient Claims Utilization and Cost
-- Business Question:
-- What is the total number of claims and total claims cost for
-- each patient, and which patients have the highest healthcare spending?
-- ============================================================
SELECT
    pt.patient_id,
    pt.patient_name,
    COUNT(cl.claim_id) AS total_claims,
    COALESCE(SUM(cl.claim_amount), 0) AS total_claim_cost
FROM Patients AS pt
LEFT JOIN Claims AS cl
    ON pt.patient_id = cl.patient_id
GROUP BY pt.patient_id, pt.patient_name
ORDER BY total_claim_cost DESC, pt.patient_id ASC;

-- ============================================================
-- Query 4: High-Risk, High-Cost Patients
-- Business Question:
-- Which patients have both an above-average diagnosis-level HCC
-- risk burden and above-average total claims spending?
-- ============================================================
WITH patient_risk AS (
    SELECT
        patient_id,
        SUM(risk_weight) AS total_hcc_risk_weight
    FROM Conditions
    GROUP BY patient_id
),
patient_cost AS (
    SELECT
        patient_id,
        SUM(claim_amount) AS total_claim_cost
    FROM Claims
    GROUP BY patient_id
),
population_averages AS (
    SELECT
        AVG(pr.total_hcc_risk_weight) AS avg_hcc_risk_weight,
        AVG(pc.total_claim_cost) AS avg_claim_cost
    FROM patient_risk AS pr
    JOIN patient_cost AS pc
        ON pr.patient_id = pc.patient_id
)
SELECT
    pt.patient_name,
    pt.patient_id,
    pc.total_claim_cost,
    pr.total_hcc_risk_weight
FROM Patients AS pt
LEFT JOIN patient_risk AS pr
    ON pt.patient_id = pr.patient_id
LEFT JOIN patient_cost AS pc
    ON pt.patient_id = pc.patient_id
CROSS JOIN population_averages AS pa
WHERE pc.total_claim_cost > pa.avg_claim_cost
  AND pr.total_hcc_risk_weight > pa.avg_hcc_risk_weight
ORDER BY
    pc.total_claim_cost DESC,
    pr.total_hcc_risk_weight DESC;

-- ============================================================
-- Query 5: Provider Panel Risk Burden
-- Business Question:
-- Which providers manage the highest-risk patient panels based
-- on the average diagnosis-level HCC risk weight of their assigned patients?
-- ============================================================
WITH patient_risk AS (
    SELECT
        patient_id,
        SUM(risk_weight) AS total_hcc_risk_weight
    FROM Conditions
    GROUP BY patient_id
)
SELECT
    p.provider_name,
    COUNT(pt.patient_id) AS panel_size,
    AVG(pr.total_hcc_risk_weight) AS avg_patient_hcc_risk_weight
FROM Providers AS p
LEFT JOIN Patients AS pt
    ON p.provider_id = pt.provider_id
LEFT JOIN patient_risk AS pr
    ON pt.patient_id = pr.patient_id
GROUP BY p.provider_id, p.provider_name
ORDER BY avg_patient_hcc_risk_weight DESC, panel_size DESC;

-- ============================================================
-- Query 6: Patient Risk Rank Within Provider Panel
-- Business Question:
-- How does each patient's diagnosis-level HCC risk burden rank
-- within their assigned provider's patient panel?
-- ============================================================
WITH patient_risk AS (
    SELECT
        patient_id,
        SUM(risk_weight) AS total_hcc_risk_weight
    FROM Conditions
    GROUP BY patient_id
)
SELECT
    p.provider_name,
    pt.patient_id,
    pt.patient_name,
    pr.total_hcc_risk_weight,
    DENSE_RANK() OVER (
        PARTITION BY p.provider_id
        ORDER BY pr.total_hcc_risk_weight DESC
    ) AS risk_rank
FROM Providers AS p
LEFT JOIN Patients AS pt
    ON p.provider_id = pt.provider_id
LEFT JOIN patient_risk AS pr
    ON pt.patient_id = pr.patient_id
ORDER BY p.provider_name, risk_rank, pt.patient_id;

-- ============================================================
-- Query 7: Acute-Care Utilization and Cost by Patient
-- Business Question:
-- Which patients had the highest acute-care utilization,
-- based on Emergency Department and Inpatient claims?
-- ============================================================
SELECT
    pt.patient_id,
    pt.patient_name,
    SUM(
        CASE
            WHEN cl.claim_type = 'Emergency Department' THEN 1
            ELSE 0
        END
    ) AS ed_claims,
    SUM(
        CASE
            WHEN cl.claim_type = 'Inpatient' THEN 1
            ELSE 0
        END
    ) AS inpatient_claims,
    SUM(
        CASE
            WHEN cl.claim_type IN ('Emergency Department', 'Inpatient') THEN 1
            ELSE 0
        END
    ) AS acute_care_claims,
    SUM(
        CASE
            WHEN cl.claim_type IN ('Emergency Department', 'Inpatient')
                THEN cl.claim_amount
            ELSE 0
        END
    ) AS acute_care_cost
FROM Patients AS pt
LEFT JOIN Claims AS cl
    ON pt.patient_id = cl.patient_id
GROUP BY
    pt.patient_id,
    pt.patient_name
HAVING acute_care_claims > 0
ORDER BY
    acute_care_claims DESC,
    acute_care_cost DESC;

-- ============================================================
-- Query 8: Monthly Claims Trends
-- Business Question:
-- How do claim volume, total claim cost, and average claim cost
-- change by month?
-- ============================================================
WITH monthly_claims AS (
    SELECT
        DATE_FORMAT(claim_date, '%Y-%m') AS claim_month,
        COUNT(claim_id) AS total_claims,
        SUM(claim_amount) AS total_claim_cost,
        ROUND(AVG(claim_amount), 2) AS avg_claim_cost
    FROM Claims
    GROUP BY DATE_FORMAT(claim_date, '%Y-%m')
)

SELECT
    claim_month,
    total_claims,
    total_claim_cost,
    avg_claim_cost,
    ROUND(
        LAG(total_claim_cost) OVER (
            ORDER BY claim_month
        ), 2
    ) AS prior_month_claim_cost,
    ROUND(
        total_claim_cost
        - LAG(total_claim_cost) OVER (
            ORDER BY claim_month
        ), 2
    ) AS monthly_claim_cost_change
FROM monthly_claims
ORDER BY claim_month ASC;

-- ============================================================
-- Query 9: Provider Panel Claim Utilization and Cost
-- Business Question:
-- Which providers have the highest claim utilization and total
-- claim cost across the patients assigned to their panels?
-- ============================================================

SELECT
    p.provider_name,
    COUNT(DISTINCT pt.patient_id) AS panel_size,
    COUNT(cl.claim_id) AS total_claims,
    COALESCE(SUM(cl.claim_amount), 0) AS total_claim_cost,
    ROUND(COALESCE(AVG(cl.claim_amount), 0), 2) AS avg_claim_cost
FROM Providers AS p
LEFT JOIN Patients AS pt
    ON p.provider_id = pt.provider_id
LEFT JOIN Claims AS cl
    ON pt.patient_id = cl.patient_id
GROUP BY
    p.provider_id,
    p.provider_name
ORDER BY
    total_claim_cost DESC,
    total_claims DESC;

-- ============================================================
-- Query 10: Patient Risk-Cost Segmentation
-- Business Question:
-- How can patients be segmented based on whether their
-- diagnosis-level HCC risk burden and total claim cost are
-- above or below the population average?
-- ============================================================
WITH patient_risk AS (
    SELECT
        patient_id,
        SUM(risk_weight) AS total_hcc_risk_weight
    FROM Conditions
    GROUP BY patient_id
),
patient_cost AS (
    SELECT
        patient_id,
        SUM(claim_amount) AS total_claim_cost
    FROM Claims
    GROUP BY patient_id
),
population_averages AS (
    SELECT
        AVG(pr.total_hcc_risk_weight) AS avg_hcc_risk_weight,
        AVG(pc.total_claim_cost) AS avg_claim_cost
    FROM patient_risk AS pr
    JOIN patient_cost AS pc
        ON pr.patient_id = pc.patient_id
)

SELECT
    pt.patient_id,
    pt.patient_name,
    pr.total_hcc_risk_weight,
    pc.total_claim_cost,
    CASE
        WHEN pr.total_hcc_risk_weight > pa.avg_hcc_risk_weight
             AND pc.total_claim_cost > pa.avg_claim_cost
            THEN 'High Risk / High Cost'

        WHEN pr.total_hcc_risk_weight > pa.avg_hcc_risk_weight
             AND pc.total_claim_cost <= pa.avg_claim_cost
            THEN 'High Risk / Low Cost'

        WHEN pr.total_hcc_risk_weight <= pa.avg_hcc_risk_weight
             AND pc.total_claim_cost > pa.avg_claim_cost
            THEN 'Low Risk / High Cost'

        ELSE 'Low Risk / Low Cost'
    END AS risk_cost_segment
FROM Patients AS pt
LEFT JOIN patient_risk AS pr
    ON pt.patient_id = pr.patient_id
LEFT JOIN patient_cost AS pc
    ON pt.patient_id = pc.patient_id
CROSS JOIN population_averages AS pa
ORDER BY
    total_hcc_risk_weight DESC,
    total_claim_cost DESC;

    