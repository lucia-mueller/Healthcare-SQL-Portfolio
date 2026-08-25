-- =============================================
-- Healthcare Claims & Risk Analysis
-- Sample Dataset
-- Fictional healthcare data created for portfolio use
-- =============================================


-- 1. PROVIDERS TABLE

CREATE TABLE Providers (
    provider_id INT PRIMARY KEY,
    provider_name VARCHAR(100),
    specialty VARCHAR(50),
    clinic_name VARCHAR(100)
);


-- 2. PATIENTS TABLE

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100),
    age INT,
    gender VARCHAR(20),
    provider_id INT,
    FOREIGN KEY (provider_id) REFERENCES Providers(provider_id)
);


-- 3. CONDITIONS TABLE

CREATE TABLE Conditions (
    condition_id INT PRIMARY KEY,
    patient_id INT,
    condition_name VARCHAR(100),
    hcc_category VARCHAR(20),
    risk_weight DECIMAL(5,3),
    diagnosis_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);


-- 4. CLAIMS TABLE

CREATE TABLE Claims (
    claim_id INT PRIMARY KEY,
    patient_id INT,
    provider_id INT,
    claim_date DATE,
    claim_type VARCHAR(50),
    claim_amount DECIMAL(10,2),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (provider_id) REFERENCES Providers(provider_id)
);

-- ============================================
-- SAMPLE DATA
-- ============================================

-- 1. PROVIDERS

INSERT INTO Providers
VALUES
    (1, 'Dr. Maya Thompson', 'Primary Care', 'Northside Health Center'),
    (2, 'Dr. James Wilson', 'Primary Care', 'Riverside Medical Group'),
    (3, 'Dr. Elena Garcia', 'Cardiology', 'Northside Health Center'),
    (4, 'Dr. Daniel Lee', 'Endocrinology', 'Central Health Clinic'),
    (5, 'Dr. Sarah Patel', 'Primary Care', 'Central Health Clinic'),
    (6, 'Dr. Michael Brooks', 'Pulmonology', 'Riverside Medical Group');

 -- 2. PATIENTS

INSERT INTO Patients
VALUES
    (101, 'Olivia Carter', 72, 'Female', 1),
    (102, 'Robert Mitchell', 68, 'Male', 1),
    (103, 'Linda Johnson', 75, 'Female', 1),
    (104, 'Thomas Anderson', 64, 'Male', 2),
    (105, 'Patricia Williams', 81, 'Female', 2),
    (106, 'James Robinson', 59, 'Male', 2),
    (107, 'Barbara Davis', 70, 'Female', 3),
    (108, 'William Martinez', 77, 'Male', 3),
    (109, 'Susan Clark', 66, 'Female', 3),
    (110, 'Richard Lewis', 73, 'Male', 4),
    (111, 'Karen Walker', 62, 'Female', 4),
    (112, 'Joseph Hall', 79, 'Male', 4),
    (113, 'Nancy Allen', 69, 'Female', 5),
    (114, 'Charles Young', 83, 'Male', 5),
    (115, 'Margaret Hernandez', 71, 'Female', 5),
    (116, 'Steven King', 57, 'Male', 6),
    (117, 'Donna Wright', 76, 'Female', 6),
    (118, 'George Lopez', 67, 'Male', 6),
    (119, 'Carol Hill', 74, 'Female', 1),
    (120, 'Edward Green', 65, 'Male', 2);

-- 3. CONDITIONS
-- Risk weights represent CMS-HCC V28 / 2024 CMS-HCC model
-- Community, Non-Dual, Aged (CNA) coefficients for portfolio analysis.

INSERT INTO Conditions
VALUES
    (5001, 101, 'Diabetes with Chronic Complications', 'HCC 37', 0.166, '2026-01-12'),
    (5002, 101, 'Heart Failure, Except End-Stage and Acute', 'HCC 226', 0.360, '2026-02-03'),
    (5003, 101, 'Chronic Kidney Disease, Stage 3B', 'HCC 328', 0.127, '2026-02-03'),

    (5004, 102, 'Specified Heart Arrhythmias', 'HCC 238', 0.299, '2026-01-28'),
    (5005, 102, 'Diabetes with No, Glycemic, or Unspecified Complications', 'HCC 38', 0.166, '2026-03-04'),

    (5006, 103, 'Chronic Obstructive Pulmonary Disease', 'HCC 280', 0.319, '2026-01-17'),
    (5007, 103, 'Heart Failure, Except End-Stage and Acute', 'HCC 226', 0.360, '2026-01-17'),
    (5008, 103, 'Morbid Obesity', 'HCC 48', 0.186, '2026-04-08'),

    (5009, 104, 'Diabetes with Chronic Complications', 'HCC 37', 0.166, '2026-02-14'),

    (5010, 105, 'Chronic Kidney Disease, Severe Stage 4', 'HCC 327', 0.514, '2026-01-09'),
    (5011, 105, 'Heart Failure, Except End-Stage and Acute', 'HCC 226', 0.360, '2026-01-09'),
    (5012, 105, 'Specified Heart Arrhythmias', 'HCC 238', 0.299, '2026-03-22'),

    (5013, 106, 'Morbid Obesity', 'HCC 48', 0.186, '2026-05-05'),

    (5014, 107, 'Diabetes with Chronic Complications', 'HCC 37', 0.166, '2026-01-19'),
    (5015, 107, 'Chronic Kidney Disease, Stage 3 Except 3B', 'HCC 329', 0.127, '2026-01-19'),

    (5016, 108, 'Chronic Obstructive Pulmonary Disease', 'HCC 280', 0.319, '2026-02-11'),
    (5017, 108, 'Specified Heart Arrhythmias', 'HCC 238', 0.299, '2026-02-11'),
    (5018, 108, 'Heart Failure, Except End-Stage and Acute', 'HCC 226', 0.360, '2026-04-03'),

    (5019, 109, 'Diabetes with No, Glycemic, or Unspecified Complications', 'HCC 38', 0.166, '2026-03-01'),
    (5020, 109, 'Morbid Obesity', 'HCC 48', 0.186, '2026-03-01'),

    (5021, 110, 'Diabetes with Chronic Complications', 'HCC 37', 0.166, '2026-01-25'),
    (5022, 110, 'Chronic Kidney Disease, Stage 3B', 'HCC 328', 0.127, '2026-01-25'),
    (5023, 110, 'Heart Failure, Except End-Stage and Acute', 'HCC 226', 0.360, '2026-05-10'),

    (5024, 111, 'Chronic Obstructive Pulmonary Disease', 'HCC 280', 0.319, '2026-04-16'),

    (5025, 112, 'Cirrhosis of Liver', 'HCC 64', 0.447, '2026-02-07'),
    (5026, 112, 'Chronic Kidney Disease, Severe Stage 4', 'HCC 327', 0.514, '2026-02-07'),
    (5027, 112, 'Specified Heart Arrhythmias', 'HCC 238', 0.299, '2026-05-18'),

    (5028, 113, 'Diabetes with Chronic Complications', 'HCC 37', 0.166, '2026-01-30'),
    (5029, 113, 'Morbid Obesity', 'HCC 48', 0.186, '2026-01-30'),

    (5030, 114, 'Heart Failure, Except End-Stage and Acute', 'HCC 226', 0.360, '2026-01-06'),
    (5031, 114, 'Chronic Kidney Disease, Stage 5', 'HCC 326', 0.815, '2026-01-06'),
    (5032, 114, 'Specified Heart Arrhythmias', 'HCC 238', 0.299, '2026-03-12'),

    (5033, 115, 'Diabetes with No, Glycemic, or Unspecified Complications', 'HCC 38', 0.166, '2026-02-26'),
    (5034, 115, 'Chronic Obstructive Pulmonary Disease', 'HCC 280', 0.319, '2026-04-30'),

    (5035, 116, 'Morbid Obesity', 'HCC 48', 0.186, '2026-06-02'),

    (5036, 117, 'Heart Failure, Except End-Stage and Acute', 'HCC 226', 0.360, '2026-01-15'),
    (5037, 117, 'Specified Heart Arrhythmias', 'HCC 238', 0.299, '2026-01-15'),
    (5038, 117, 'Chronic Kidney Disease, Stage 3 Except 3B', 'HCC 329', 0.127, '2026-04-21'),

    (5039, 118, 'Diabetes with Chronic Complications', 'HCC 37', 0.166, '2026-03-18'),
    (5040, 118, 'Chronic Kidney Disease, Stage 3B', 'HCC 328', 0.127, '2026-03-18'),

    (5041, 119, 'Chronic Obstructive Pulmonary Disease', 'HCC 280', 0.319, '2026-02-20'),
    (5042, 119, 'Heart Failure, Except End-Stage and Acute', 'HCC 226', 0.360, '2026-02-20'),
    (5043, 119, 'Morbid Obesity', 'HCC 48', 0.186, '2026-05-27'),

    (5044, 120, 'Diabetes with No, Glycemic, or Unspecified Complications', 'HCC 38', 0.166, '2026-04-11'),
    (5045, 120, 'Specified Heart Arrhythmias', 'HCC 238', 0.299, '2026-04-11');

-- 4. CLAIMS

INSERT INTO Claims
VALUES
    (10001, 101, 1, '2026-01-12', 'Office Visit', 185.00),
    (10002, 101, 3, '2026-02-03', 'Specialist Visit', 325.00),
    (10003, 101, 1, '2026-03-18', 'Lab', 145.00),
    (10004, 101, 3, '2026-05-09', 'Diagnostic Imaging', 780.00),
    (10005, 101, 1, '2026-06-14', 'Office Visit', 195.00),

    (10006, 102, 1, '2026-01-28', 'Office Visit', 175.00),
    (10007, 102, 3, '2026-02-19', 'Specialist Visit', 310.00),
    (10008, 102, 1, '2026-04-07', 'Lab', 120.00),

    (10009, 103, 1, '2026-01-17', 'Office Visit', 190.00),
    (10010, 103, 6, '2026-02-08', 'Specialist Visit', 340.00),
    (10011, 103, 3, '2026-03-03', 'Diagnostic Imaging', 950.00),
    (10012, 103, 1, '2026-03-25', 'Emergency Department', 2450.00),
    (10013, 103, 3, '2026-04-14', 'Inpatient', 12800.00),
    (10014, 103, 1, '2026-05-21', 'Office Visit', 205.00),

    (10015, 104, 2, '2026-02-14', 'Office Visit', 165.00),
    (10016, 104, 4, '2026-03-11', 'Specialist Visit', 295.00),
    (10017, 104, 2, '2026-05-02', 'Lab', 135.00),

    (10018, 105, 2, '2026-01-09', 'Office Visit', 195.00),
    (10019, 105, 4, '2026-01-30', 'Specialist Visit', 350.00),
    (10020, 105, 3, '2026-02-16', 'Specialist Visit', 335.00),
    (10021, 105, 2, '2026-03-22', 'Emergency Department', 3100.00),
    (10022, 105, 4, '2026-04-02', 'Inpatient', 15400.00),
    (10023, 105, 2, '2026-05-17', 'Office Visit', 210.00),

    (10024, 106, 2, '2026-01-21', 'Office Visit', 160.00),
    (10025, 106, 2, '2026-05-05', 'Lab', 115.00),

    (10026, 107, 3, '2026-01-19', 'Specialist Visit', 315.00),
    (10027, 107, 4, '2026-02-23', 'Specialist Visit', 305.00),
    (10028, 107, 3, '2026-04-10', 'Lab', 140.00),

    (10029, 108, 3, '2026-02-11', 'Specialist Visit', 345.00),
    (10030, 108, 6, '2026-02-27', 'Specialist Visit', 330.00),
    (10031, 108, 3, '2026-03-16', 'Diagnostic Imaging', 1100.00),
    (10032, 108, 3, '2026-04-03', 'Emergency Department', 2750.00),
    (10033, 108, 3, '2026-05-08', 'Office Visit', 200.00),

    (10034, 109, 3, '2026-03-01', 'Office Visit', 170.00),
    (10035, 109, 4, '2026-04-06', 'Specialist Visit', 290.00),
    (10036, 109, 3, '2026-06-01', 'Lab', 125.00),

    (10037, 110, 4, '2026-01-25', 'Specialist Visit', 320.00),
    (10038, 110, 4, '2026-02-12', 'Lab', 150.00),
    (10039, 110, 3, '2026-03-09', 'Specialist Visit', 330.00),
    (10040, 110, 4, '2026-05-10', 'Diagnostic Imaging', 875.00),

    (10041, 111, 4, '2026-02-04', 'Office Visit', 165.00),
    (10042, 111, 6, '2026-04-16', 'Specialist Visit', 300.00),

    (10043, 112, 4, '2026-02-07', 'Specialist Visit', 355.00),
    (10044, 112, 4, '2026-02-28', 'Lab', 155.00),
    (10045, 112, 2, '2026-03-13', 'Emergency Department', 3600.00),
    (10046, 112, 4, '2026-03-20', 'Inpatient', 18750.00),
    (10047, 112, 4, '2026-05-18', 'Specialist Visit', 365.00),

    (10048, 113, 5, '2026-01-30', 'Office Visit', 180.00),
    (10049, 113, 4, '2026-03-05', 'Specialist Visit', 295.00),
    (10050, 113, 5, '2026-05-12', 'Lab', 130.00),

    (10051, 114, 5, '2026-01-06', 'Office Visit', 205.00),
    (10052, 114, 4, '2026-01-22', 'Specialist Visit', 375.00),
    (10053, 114, 3, '2026-02-15', 'Specialist Visit', 350.00),
    (10054, 114, 5, '2026-03-12', 'Emergency Department', 4200.00),
    (10055, 114, 4, '2026-03-14', 'Inpatient', 22100.00),
    (10056, 114, 5, '2026-04-19', 'Office Visit', 215.00),
    (10057, 114, 4, '2026-05-24', 'Lab', 165.00),

    (10058, 115, 5, '2026-02-26', 'Office Visit', 175.00),
    (10059, 115, 6, '2026-04-30', 'Specialist Visit', 310.00),
    (10060, 115, 5, '2026-06-03', 'Lab', 135.00),

    (10061, 116, 6, '2026-03-07', 'Office Visit', 155.00),
    (10062, 116, 6, '2026-06-02', 'Lab', 110.00),

    (10063, 117, 6, '2026-01-15', 'Office Visit', 190.00),
    (10064, 117, 3, '2026-02-10', 'Specialist Visit', 340.00),
    (10065, 117, 6, '2026-04-21', 'Diagnostic Imaging', 825.00),

    (10066, 118, 6, '2026-03-18', 'Office Visit', 175.00),
    (10067, 118, 4, '2026-04-25', 'Specialist Visit', 300.00),

    (10068, 119, 1, '2026-02-20', 'Office Visit', 195.00),
    (10069, 119, 6, '2026-03-26', 'Specialist Visit', 325.00),

    (10070, 120, 2, '2026-04-11', 'Office Visit', 180.00);
    
               