-- ============================================================
-- Project 3: Value-Based Care Quality Analysis
-- Analyzes quality measure performance, care gaps,
-- patient risk, provider performance, and utilization
-- ============================================================

USE value_based_care_quality;

-- ============================================================
-- 1. Overall Quality Measure Completion Rates
-- Business Question:
-- What percentage of eligible patients completed each
-- quality measure?
-- ============================================================
SELECT
    qm.measure_name,
    qm.measure_category,
    COUNT(pq.patient_quality_id) AS eligible_patients,
    SUM(
        CASE
            WHEN pq.completed = 1 THEN 1
            ELSE 0
        END
    ) AS completed_patients,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN pq.completed = 1 THEN 1
                ELSE 0
            END
        ) / COUNT(pq.patient_quality_id),
        1
    ) AS completion_rate
FROM PatientQuality AS pq
JOIN QualityMeasures AS qm
    ON pq.measure_id = qm.measure_id
GROUP BY
    qm.measure_id,
    qm.measure_name,
    qm.measure_category
ORDER BY completion_rate DESC;

-- ============================================================
-- 2. Provider-Level Quality Performance
-- Business Question:
-- Which providers have the highest and lowest overall
-- quality measure completion rates?
-- ============================================================
SELECT
    p.provider_id,
    p.provider_name,
    p.specialty,
    p.clinic_name,
    COUNT(DISTINCT pt.patient_id) AS patient_panel_size,
    COUNT(pq.patient_quality_id) AS eligible_quality_records,
    SUM(
        CASE
            WHEN pq.completed = 1 THEN 1
            ELSE 0
        END
    ) AS completed_quality_records,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN pq.completed = 1 THEN 1
                ELSE 0
            END
        ) / COUNT(pq.patient_quality_id),
        1
    ) AS completion_rate
FROM Providers AS p
JOIN Patients AS pt
    ON p.provider_id = pt.provider_id
JOIN PatientQuality AS pq
    ON pt.patient_id = pq.patient_id
GROUP BY
    p.provider_id,
    p.provider_name,
    p.specialty,
    p.clinic_name
ORDER BY completion_rate DESC;

-- ============================================================
-- 3. Quality Performance by Patient Risk Level
-- Business Question:
-- How do quality measure completion rates differ
-- across patient risk levels?
-- ============================================================
SELECT
    pt.risk_level,
    COUNT(DISTINCT pt.patient_id) AS patient_count,
    COUNT(pq.patient_quality_id) AS eligible_quality_records,
    SUM(
        CASE
            WHEN pq.completed = 1 THEN 1
            ELSE 0
        END
    ) AS completed_quality_records,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN pq.completed = 1 THEN 1
                ELSE 0
            END
        ) / COUNT(pq.patient_quality_id),
        1
    ) AS completion_rate
FROM Patients AS pt
JOIN PatientQuality AS pq
    ON pt.patient_id = pq.patient_id
GROUP BY
    pt.risk_level
ORDER BY
    completion_rate DESC;

-- ============================================================
-- 3. Quality Performance by Patient Risk Level
-- Business Question:
-- How do quality measure completion rates differ
-- across patient risk levels?
-- ============================================================
SELECT
    pt.risk_level,
    COUNT(DISTINCT pt.patient_id) AS patient_count,
    COUNT(pq.patient_quality_id) AS eligible_quality_records,
    SUM(
        CASE
            WHEN pq.completed = 1 THEN 1
            ELSE 0
        END
    ) AS completed_quality_records,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN pq.completed = 1 THEN 1
                ELSE 0
            END
        ) / COUNT(pq.patient_quality_id),
        1
    ) AS completion_rate
FROM Patients AS pt
JOIN PatientQuality AS pq
    ON pt.patient_id = pq.patient_id
GROUP BY
    pt.risk_level
ORDER BY
    completion_rate DESC;

-- ============================================================
-- 4. High-Risk Patients with Open Quality Gaps
-- Business Question:
-- Which high-risk patients have the greatest number of
-- incomplete quality measures requiring potential outreach?
-- ============================================================

SELECT
    pt.patient_id,
    pt.patient_name,
    p.provider_name,
    p.clinic_name,
    COUNT(pq.patient_quality_id) AS eligible_measures,
    SUM(
        CASE
            WHEN pq.completed = 0 THEN 1
            ELSE 0
        END
    ) AS open_quality_gaps,
    SUM(
        CASE
            WHEN pq.completed = 1 THEN 1
            ELSE 0
        END
    ) AS completed_measures,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN pq.completed = 1 THEN 1
                ELSE 0
            END
        ) / COUNT(pq.patient_quality_id),
        1
    ) AS completion_rate
FROM Patients AS pt
JOIN Providers AS p
    ON pt.provider_id = p.provider_id
JOIN PatientQuality AS pq
    ON pt.patient_id = pq.patient_id
WHERE pt.risk_level = 'High'
GROUP BY
    pt.patient_id,
    pt.patient_name,
    p.provider_name,
    p.clinic_name
HAVING
    SUM(
        CASE
            WHEN pq.completed = 0 THEN 1
            ELSE 0
        END
    ) > 0
ORDER BY
    open_quality_gaps DESC,
    completion_rate ASC;

-- ============================================================
-- 5. Open Care Gaps by Quality Measure
-- Business Question:
-- Which quality measures have the greatest number of
-- incomplete patient care gaps?
-- ============================================================

SELECT
    qm.measure_name,
    qm.measure_category,
    COUNT(pq.patient_quality_id) AS eligible_patients,
    SUM(
        CASE
            WHEN pq.completed = 0 THEN 1
            ELSE 0
        END
    ) AS open_quality_gaps,
    SUM(
        CASE
            WHEN pq.completed = 1 THEN 1
            ELSE 0
        END
    ) AS completed_patients,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN pq.completed = 0 THEN 1
                ELSE 0
            END
        ) / COUNT(pq.patient_quality_id),
        1
    ) AS gap_rate
FROM PatientQuality AS pq
JOIN QualityMeasures AS qm
    ON pq.measure_id = qm.measure_id
GROUP BY
    qm.measure_id,
    qm.measure_name,
    qm.measure_category
ORDER BY
    open_quality_gaps DESC,
    gap_rate DESC;

-- ============================================================
-- 6. Clinic-Level Quality Performance
-- Business Question:
-- How does overall quality measure performance vary
-- across clinic locations?
-- ============================================================

SELECT
    p.clinic_name,
    COUNT(DISTINCT p.provider_id) AS provider_count,
    COUNT(DISTINCT pt.patient_id) AS patient_count,
    COUNT(pq.patient_quality_id) AS eligible_quality_records,
    SUM(
        CASE
            WHEN pq.completed = 1 THEN 1
            ELSE 0
        END
    ) AS completed_quality_records,
    SUM(
        CASE
            WHEN pq.completed = 0 THEN 1
            ELSE 0
        END
    ) AS open_quality_gaps,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN pq.completed = 1 THEN 1
                ELSE 0
            END
        ) / COUNT(pq.patient_quality_id),
        1
    ) AS completion_rate
FROM Providers AS p
JOIN Patients AS pt
    ON p.provider_id = pt.provider_id
JOIN PatientQuality AS pq
    ON pt.patient_id = pq.patient_id
GROUP BY
    p.clinic_name
ORDER BY
    completion_rate DESC;

-- ============================================================
-- 7. Clinic Care Gaps by Quality Measure
-- Business Question:
-- Which quality measures contribute the most open care gaps
-- within each clinic?
-- ============================================================

SELECT
    p.clinic_name,
    qm.measure_name,
    qm.measure_category,
    COUNT(pq.patient_quality_id) AS eligible_patients,
    SUM(
        CASE
            WHEN pq.completed = 0 THEN 1
            ELSE 0
        END
    ) AS open_quality_gaps,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN pq.completed = 1 THEN 1
                ELSE 0
            END
        ) / COUNT(pq.patient_quality_id),
        1
    ) AS completion_rate
FROM Providers AS p
JOIN Patients AS pt
    ON p.provider_id = pt.provider_id
JOIN PatientQuality AS pq
    ON pt.patient_id = pq.patient_id
JOIN QualityMeasures AS qm
    ON pq.measure_id = qm.measure_id
GROUP BY
    p.clinic_name,
    qm.measure_id,
    qm.measure_name,
    qm.measure_category
ORDER BY
    p.clinic_name,
    open_quality_gaps DESC,
    completion_rate ASC;

-- ============================================================
-- 8. Ranked Quality Improvement Opportunities by Clinic
-- Business Question:
-- What are the highest-priority quality improvement
-- opportunities within each clinic?
-- ============================================================

WITH clinic_measure_performance AS (
    SELECT
        p.clinic_name,
        qm.measure_name,
        qm.measure_category,
        COUNT(pq.patient_quality_id) AS eligible_patients,
        SUM(
            CASE
                WHEN pq.completed = 0 THEN 1
                ELSE 0
            END
        ) AS open_quality_gaps,
        ROUND(
            100.0 * SUM(
                CASE
                    WHEN pq.completed = 1 THEN 1
                    ELSE 0
                END
            ) / COUNT(pq.patient_quality_id),
            1
        ) AS completion_rate
    FROM Providers AS p
    JOIN Patients AS pt
        ON p.provider_id = pt.provider_id
    JOIN PatientQuality AS pq
        ON pt.patient_id = pq.patient_id
    JOIN QualityMeasures AS qm
        ON pq.measure_id = qm.measure_id
    GROUP BY
        p.clinic_name,
        qm.measure_id,
        qm.measure_name,
        qm.measure_category
),

ranked_opportunities AS (
    SELECT
        clinic_name,
        measure_name,
        measure_category,
        eligible_patients,
        open_quality_gaps,
        completion_rate,
        DENSE_RANK() OVER (
            PARTITION BY clinic_name
            ORDER BY
                open_quality_gaps DESC,
                completion_rate ASC
        ) AS opportunity_rank
    FROM clinic_measure_performance
)

SELECT
    clinic_name,
    opportunity_rank,
    measure_name,
    measure_category,
    eligible_patients,
    open_quality_gaps,
    completion_rate
FROM ranked_opportunities
WHERE opportunity_rank <= 3
ORDER BY
    clinic_name,
    opportunity_rank;

