-- ============================================================
-- Project 3: Value-Based Care Quality Analysis
-- Fictional dataset created for portfolio and educational use
-- ============================================================

CREATE DATABASE IF NOT EXISTS value_based_care_quality;

USE value_based_care_quality;


-- Providers table
CREATE TABLE Providers (
    provider_id INT PRIMARY KEY,
    provider_name VARCHAR(100),
    specialty VARCHAR(50),
    clinic_name VARCHAR(100)
);

-- Patients table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100),
    age INT,
    gender VARCHAR(20),
    provider_id INT,
    risk_level VARCHAR(20),
    FOREIGN KEY (provider_id) REFERENCES Providers(provider_id)
);

-- Encounters table
CREATE TABLE Encounters (
    encounter_id INT PRIMARY KEY,
    patient_id INT,
    provider_id INT,
    encounter_date DATE,
    encounter_type VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (provider_id) REFERENCES Providers(provider_id)
);

-- QualityMeasures table
CREATE TABLE QualityMeasures (
    measure_id INT PRIMARY KEY,
    measure_name VARCHAR(150),
    measure_category VARCHAR(100)
);

-- PatientQuality table
CREATE TABLE PatientQuality (
    patient_quality_id INT PRIMARY KEY,
    patient_id INT,
    measure_id INT,
    eligible BOOLEAN,
    completed BOOLEAN,
    due_date DATE,
    completion_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (measure_id) REFERENCES QualityMeasures(measure_id)
);

-- ============================================================
-- SAMPLE DATA
-- All patient, provider, encounter, and quality data below
-- are fictional and created solely for portfolio purposes.
-- ============================================================


-- ============================================================
-- 1. PROVIDERS
-- ============================================================

INSERT INTO Providers
    (provider_id, provider_name, specialty, clinic_name)
VALUES
    (1, 'Dr. Sarah Patel', 'Internal Medicine', 'Northside Primary Care'),
    (2, 'Dr. Daniel Lee', 'Family Medicine', 'Northside Primary Care'),
    (3, 'Dr. Maya Thompson', 'Internal Medicine', 'Riverside Medical Group'),
    (4, 'Dr. James Wilson', 'Family Medicine', 'Riverside Medical Group'),
    (5, 'Dr. Elena Garcia', 'Internal Medicine', 'Lakeside Health Center'),
    (6, 'Dr. Michael Brooks', 'Family Medicine', 'Lakeside Health Center'),
    (7, 'Dr. Priya Shah', 'Geriatric Medicine', 'Central Community Health'),
    (8, 'Dr. Robert Chen', 'Internal Medicine', 'Central Community Health');


-- ============================================================
-- 2. QUALITY MEASURES
-- ============================================================

INSERT INTO QualityMeasures
    (measure_id, measure_name, measure_category)
VALUES
    (1, 'Annual Wellness Visit', 'Preventive Care'),
    (2, 'Breast Cancer Screening', 'Cancer Screening'),
    (3, 'Colorectal Cancer Screening', 'Cancer Screening'),
    (4, 'Diabetes A1c Testing', 'Chronic Disease Management'),
    (5, 'Blood Pressure Control', 'Chronic Disease Management'),
    (6, 'Medication Adherence', 'Medication Management');


-- ============================================================
-- 3. PATIENTS
-- ============================================================

INSERT INTO Patients
    (patient_id, patient_name, age, gender, provider_id, risk_level)
VALUES
    (1, 'Linda Johnson', 67, 'Female', 1, 'High'),
    (2, 'Charles Young', 74, 'Male', 1, 'High'),
    (3, 'Patricia Williams', 63, 'Female', 1, 'Moderate'),
    (4, 'Joseph Hall', 71, 'Male', 1, 'High'),
    (5, 'William Martinez', 58, 'Male', 1, 'Low'),
    (6, 'Maria Davis', 66, 'Female', 1, 'Moderate'),
    (7, 'David Brown', 52, 'Male', 1, 'Low'),
    (8, 'Jennifer Miller', 61, 'Female', 1, 'Moderate'),

    (9, 'Robert Wilson', 69, 'Male', 2, 'High'),
    (10, 'Susan Moore', 57, 'Female', 2, 'Moderate'),
    (11, 'Michael Taylor', 64, 'Male', 2, 'Moderate'),
    (12, 'Karen Anderson', 76, 'Female', 2, 'High'),
    (13, 'James Thomas', 55, 'Male', 2, 'Low'),
    (14, 'Nancy Jackson', 62, 'Female', 2, 'Moderate'),
    (15, 'Thomas White', 49, 'Male', 2, 'Low'),
    (16, 'Lisa Harris', 70, 'Female', 2, 'High'),

    (17, 'Daniel Martin', 68, 'Male', 3, 'Moderate'),
    (18, 'Betty Thompson', 79, 'Female', 3, 'High'),
    (19, 'Mark Garcia', 54, 'Male', 3, 'Low'),
    (20, 'Sandra Martinez', 65, 'Female', 3, 'Moderate'),
    (21, 'Paul Robinson', 72, 'Male', 3, 'High'),
    (22, 'Ashley Clark', 51, 'Female', 3, 'Low'),
    (23, 'Steven Lewis', 60, 'Male', 3, 'Moderate'),
    (24, 'Donna Walker', 73, 'Female', 3, 'High'),

    (25, 'Kevin Allen', 56, 'Male', 4, 'Low'),
    (26, 'Emily King', 64, 'Female', 4, 'Moderate'),
    (27, 'Brian Wright', 75, 'Male', 4, 'High'),
    (28, 'Michelle Scott', 59, 'Female', 4, 'Moderate'),
    (29, 'George Green', 67, 'Male', 4, 'Moderate'),
    (30, 'Carol Baker', 78, 'Female', 4, 'High'),
    (31, 'Anthony Adams', 53, 'Male', 4, 'Low'),
    (32, 'Rebecca Nelson', 69, 'Female', 4, 'Moderate'),

    (33, 'Edward Carter', 70, 'Male', 5, 'High'),
    (34, 'Laura Mitchell', 58, 'Female', 5, 'Moderate'),
    (35, 'Jason Perez', 47, 'Male', 5, 'Low'),
    (36, 'Helen Roberts', 74, 'Female', 5, 'High'),
    (37, 'Ryan Turner', 61, 'Male', 5, 'Moderate'),
    (38, 'Angela Phillips', 55, 'Female', 5, 'Low'),
    (39, 'Eric Campbell', 66, 'Male', 5, 'Moderate'),
    (40, 'Deborah Parker', 72, 'Female', 5, 'High'),

    (41, 'Nathan Evans', 62, 'Male', 6, 'Moderate'),
    (42, 'Rachel Edwards', 77, 'Female', 6, 'High'),
    (43, 'Justin Collins', 50, 'Male', 6, 'Low'),
    (44, 'Cynthia Stewart', 68, 'Female', 6, 'Moderate'),
    (45, 'Adam Sanchez', 73, 'Male', 6, 'High'),
    (46, 'Monica Morris', 56, 'Female', 6, 'Low'),
    (47, 'Scott Rogers', 65, 'Male', 6, 'Moderate'),
    (48, 'Teresa Reed', 71, 'Female', 6, 'High'),

    (49, 'Patrick Cook', 69, 'Male', 7, 'High'),
    (50, 'Janet Morgan', 63, 'Female', 7, 'Moderate'),
    (51, 'Samuel Bell', 81, 'Male', 7, 'High'),
    (52, 'Diane Murphy', 58, 'Female', 7, 'Moderate'),
    (53, 'Gregory Bailey', 54, 'Male', 7, 'Low'),
    (54, 'Melissa Rivera', 76, 'Female', 7, 'High'),

    (55, 'Aaron Cooper', 60, 'Male', 8, 'Moderate'),
    (56, 'Christine Richardson', 70, 'Female', 8, 'High'),
    (57, 'Peter Cox', 48, 'Male', 8, 'Low'),
    (58, 'Vanessa Howard', 64, 'Female', 8, 'Moderate'),
    (59, 'Henry Ward', 75, 'Male', 8, 'High'),
    (60, 'Nicole Torres', 52, 'Female', 8, 'Low');


-- ============================================================
-- 4. ENCOUNTERS
-- ============================================================
-- Creates three encounters for each patient for a total of
-- 180 encounter records spanning January through June 2026.
--
-- The encounter types vary by patient and encounter number
-- to create realistic utilization patterns for later analysis.
-- ============================================================

INSERT INTO Encounters
    (encounter_id, patient_id, provider_id, encounter_date, encounter_type)
SELECT
    ((p.patient_id - 1) * 3) + e.encounter_number AS encounter_id,
    p.patient_id,
    p.provider_id,

    CASE e.encounter_number
        WHEN 1 THEN DATE_ADD(
            '2026-01-05',
            INTERVAL MOD(p.patient_id * 3, 45) DAY
        )
        WHEN 2 THEN DATE_ADD(
            '2026-03-01',
            INTERVAL MOD(p.patient_id * 5, 55) DAY
        )
        WHEN 3 THEN DATE_ADD(
            '2026-05-01',
            INTERVAL MOD(p.patient_id * 7, 55) DAY
        )
    END AS encounter_date,

    CASE
        WHEN e.encounter_number = 1
             AND MOD(p.patient_id, 4) = 0
            THEN 'Annual Wellness Visit'

        WHEN e.encounter_number = 1
            THEN 'Office Visit'

        WHEN e.encounter_number = 2
             AND MOD(p.patient_id, 5) = 0
            THEN 'Telehealth'

        WHEN e.encounter_number = 2
            THEN 'Follow-Up'

        WHEN e.encounter_number = 3
             AND MOD(p.patient_id, 10) = 0
            THEN 'Urgent Care'

        WHEN e.encounter_number = 3
             AND MOD(p.patient_id, 3) = 0
            THEN 'Telehealth'

        ELSE 'Office Visit'
    END AS encounter_type

FROM Patients p

CROSS JOIN (
    SELECT 1 AS encounter_number
    UNION ALL
    SELECT 2
    UNION ALL
    SELECT 3
) e;


-- ============================================================
-- 5. PATIENT QUALITY RECORDS
-- ============================================================
-- Generates quality-measure records according to basic
-- eligibility rules.
--
-- Eligibility:
--   Measure 1: Annual Wellness Visit
--       All patients
--
--   Measure 2: Breast Cancer Screening
--       Female patients age 50+
--
--   Measure 3: Colorectal Cancer Screening
--       Patients age 50+
--
--   Measure 4: Diabetes A1c Testing
--       Selected patients representing a diabetic population
--       and all high-risk patients
--
--   Measure 5: Blood Pressure Control
--       All patients
--
--   Measure 6: Medication Adherence
--       All patients
--
-- Completion patterns intentionally vary so later SQL queries
-- can identify care gaps, high-risk patients with unresolved
-- measures, provider variation, and improvement opportunities.
-- ============================================================

INSERT INTO PatientQuality
    (
        patient_quality_id,
        patient_id,
        measure_id,
        eligible,
        completed,
        due_date,
        completion_date
    )

SELECT
    ROW_NUMBER() OVER (
        ORDER BY p.patient_id, qm.measure_id
    ) AS patient_quality_id,

    p.patient_id,
    qm.measure_id,

    1 AS eligible,

    CASE

        -- High-risk patients intentionally have more
        -- unresolved care gaps.

        WHEN p.risk_level = 'High'
             AND MOD(p.patient_id + qm.measure_id, 3) = 0
            THEN 0

        WHEN p.risk_level = 'High'
             AND MOD(p.patient_id + qm.measure_id, 5) = 0
            THEN 0


        -- Moderate-risk patients have an intermediate
        -- completion pattern.

        WHEN p.risk_level = 'Moderate'
             AND MOD(p.patient_id + qm.measure_id, 5) = 0
            THEN 0


        -- Low-risk patients generally have stronger
        -- quality-measure completion.

        WHEN p.risk_level = 'Low'
             AND MOD(p.patient_id + qm.measure_id, 8) = 0
            THEN 0

        ELSE 1

    END AS completed,

    '2026-06-30' AS due_date,

    CASE

        WHEN
            CASE

                WHEN p.risk_level = 'High'
                     AND MOD(p.patient_id + qm.measure_id, 3) = 0
                    THEN 0

                WHEN p.risk_level = 'High'
                     AND MOD(p.patient_id + qm.measure_id, 5) = 0
                    THEN 0

                WHEN p.risk_level = 'Moderate'
                     AND MOD(p.patient_id + qm.measure_id, 5) = 0
                    THEN 0

                WHEN p.risk_level = 'Low'
                     AND MOD(p.patient_id + qm.measure_id, 8) = 0
                    THEN 0

                ELSE 1

            END = 1

        THEN DATE_ADD(
            '2026-01-10',
            INTERVAL MOD(
                (p.patient_id * 11) + (qm.measure_id * 17),
                160
            ) DAY
        )

        ELSE NULL

    END AS completion_date

FROM Patients p

CROSS JOIN QualityMeasures qm

WHERE

    -- Annual Wellness Visit
    qm.measure_id = 1

    -- Breast Cancer Screening
    OR (
        qm.measure_id = 2
        AND p.gender = 'Female'
        AND p.age >= 50
    )

    -- Colorectal Cancer Screening
    OR (
        qm.measure_id = 3
        AND p.age >= 50
    )

    -- Diabetes A1c Testing
    OR (
        qm.measure_id = 4
        AND (
            MOD(p.patient_id, 3) = 0
            OR p.risk_level = 'High'
        )
    )

    -- Blood Pressure Control
    OR qm.measure_id = 5

    -- Medication Adherence
    OR qm.measure_id = 6;


-- ============================================================
-- DATA VALIDATION
-- ============================================================
-- These queries confirm that the sample data loaded correctly.
-- ============================================================

SELECT COUNT(*) AS total_providers
FROM Providers;

SELECT COUNT(*) AS total_patients
FROM Patients;

SELECT COUNT(*) AS total_quality_measures
FROM QualityMeasures;

SELECT COUNT(*) AS total_encounters
FROM Encounters;

SELECT COUNT(*) AS total_patient_quality_records
FROM PatientQuality;


-- Review patient distribution by risk level

SELECT
    risk_level,
    COUNT(*) AS patient_count
FROM Patients
GROUP BY risk_level
ORDER BY patient_count DESC;


-- Review provider panel sizes

SELECT
    pr.provider_name,
    COUNT(p.patient_id) AS patient_count
FROM Providers pr
LEFT JOIN Patients p
    ON pr.provider_id = p.provider_id
GROUP BY
    pr.provider_id,
    pr.provider_name
ORDER BY patient_count DESC;


-- Review quality-measure record counts

SELECT
    qm.measure_name,
    COUNT(pq.patient_quality_id) AS eligible_patients,
    SUM(pq.completed) AS completed_patients
FROM QualityMeasures qm
LEFT JOIN PatientQuality pq
    ON qm.measure_id = pq.measure_id
GROUP BY
    qm.measure_id,
    qm.measure_name
ORDER BY qm.measure_id;
