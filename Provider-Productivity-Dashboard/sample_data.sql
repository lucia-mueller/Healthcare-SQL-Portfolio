-- =============================================
-- Provider Productivity Dashboard
-- Sample Dataset
-- Fictional healthcare data created for portfolio use
-- =============================================


-- 1. CREATE TABLES

CREATE TABLE Providers (
  provider_id INT PRIMARY KEY,
  provider_name VARCHAR(100),
  speciality VARCHAR(50),
  clinic_name VARCHAR(100)
  );
CREATE TABLE Visits(
  visit_id INT PRIMARY KEY,
  provider_id INT,
  patient_id INT,
  visit_date DATE,
  visit_status VARCHAR(20),
  FOREIGN KEY (provider_id) REFERENCES Providers(provider_id)
  );

-- 2. INSERT PROVIDER DATA

INSERT INTO Providers (provider_id, provider_name, speciality, clinic_name)
VALUES
(101, 'Dr. Sarah Chen', 'Internal Medicine', 'North Clinic'),
(102, 'Dr. Michael Jones', 'Family Medicine', 'North Clinic'),
(103, 'Dr. Priya Patel', 'Internal Medicine', 'South Clinic'),
(104, 'Dr. David Smith', 'Geriatrics', 'South Clinic'),
(105, 'Dr. Emily Brown', 'Family Medicine', 'East Clinic'),
(106, 'Dr. Kayleigh Smith', 'Geriatrics', 'East Clinic'),
(107, 'Dr. Mark Brown', 'Family Medicine', 'South Clinic'),
(108, 'Dr. Tracy Smalls', 'Internal Medicine', 'North Clinic'),
(109, 'Dr. Emily Miller', 'Family Medicine', 'South Clinic'),
(110, 'Dr. Todd Packer', 'Geriatrics', 'East Clinic'),
(111, 'Dr. Michael Scott', 'Internal Medicine', 'South Clinic');

-- 3. INSERT VISIT DATA

INSERT INTO Visits (visit_id, provider_id, patient_id, visit_date, visit_status)
VALUES
(1001, 101, 2001, '2026-01-05', 'Completed'),
(1002, 101, 2002, '2026-01-12', 'Completed'),
(1003, 101, 2003, '2026-01-20', 'Not Completed'),
(1004, 101, 2004, '2026-02-03', 'Completed'),
(1005, 101, 2001, '2026-02-17', 'Completed'),
(1006, 101, 2005, '2026-03-06', 'Completed'),
(1007, 101, 2006, '2026-03-19', 'Not Completed'),
(1008, 101, 2002, '2026-04-08', 'Completed'),
(1009, 101, 2007, '2026-05-14', 'Completed'),
(1010, 101, 2004, '2026-06-22', 'Completed'),

(1011, 102, 2008, '2026-01-07', 'Completed'),
(1012, 102, 2009, '2026-01-28', 'Not Completed'),
(1013, 102, 2010, '2026-02-11', 'Completed'),
(1014, 102, 2011, '2026-03-02', 'Completed'),
(1015, 102, 2008, '2026-03-24', 'Completed'),
(1016, 102, 2012, '2026-04-16', 'Not Completed'),
(1017, 102, 2010, '2026-05-05', 'Completed'),
(1018, 102, 2013, '2026-06-09', 'Completed'),

(1019, 103, 2014, '2026-01-09', 'Completed'),
(1020, 103, 2015, '2026-02-06', 'Completed'),
(1021, 103, 2016, '2026-02-20', 'Completed'),
(1022, 103, 2017, '2026-03-11', 'Not Completed'),
(1023, 103, 2014, '2026-04-02', 'Completed'),
(1024, 103, 2018, '2026-04-27', 'Completed'),
(1025, 103, 2015, '2026-05-18', 'Completed'),
(1026, 103, 2019, '2026-06-04', 'Not Completed'),
(1027, 103, 2016, '2026-06-25', 'Completed'),

(1028, 104, 2020, '2026-01-14', 'Completed'),
(1029, 104, 2021, '2026-02-09', 'Not Completed'),
(1030, 104, 2022, '2026-03-05', 'Completed'),
(1031, 104, 2020, '2026-04-13', 'Completed'),
(1032, 104, 2023, '2026-05-21', 'Not Completed'),
(1033, 104, 2022, '2026-06-15', 'Completed'),

(1034, 105, 2024, '2026-01-16', 'Completed'),
(1035, 105, 2025, '2026-01-30', 'Completed'),
(1036, 105, 2026, '2026-02-13', 'Completed'),
(1037, 105, 2027, '2026-02-27', 'Not Completed'),
(1038, 105, 2024, '2026-03-13', 'Completed'),
(1039, 105, 2028, '2026-03-27', 'Completed'),
(1040, 105, 2025, '2026-04-10', 'Completed'),
(1041, 105, 2029, '2026-04-24', 'Not Completed'),
(1042, 105, 2026, '2026-05-08', 'Completed'),
(1043, 105, 2030, '2026-05-29', 'Completed'),
(1044, 105, 2028, '2026-06-12', 'Completed'),

(1045, 106, 2031, '2026-01-21', 'Not Completed'),
(1046, 106, 2032, '2026-02-04', 'Completed'),
(1047, 106, 2033, '2026-03-09', 'Completed'),
(1048, 106, 2034, '2026-04-06', 'Not Completed'),
(1049, 106, 2032, '2026-05-11', 'Completed'),
(1050, 106, 2035, '2026-06-08', 'Completed'),

(1051, 107, 2036, '2026-01-08', 'Completed'),
(1052, 107, 2037, '2026-01-22', 'Completed'),
(1053, 107, 2038, '2026-02-05', 'Completed'),
(1054, 107, 2039, '2026-02-19', 'Completed'),
(1055, 107, 2040, '2026-03-04', 'Not Completed'),
(1056, 107, 2036, '2026-03-18', 'Completed'),
(1057, 107, 2041, '2026-04-01', 'Completed'),
(1058, 107, 2038, '2026-04-22', 'Completed'),
(1059, 107, 2042, '2026-05-06', 'Not Completed'),
(1060, 107, 2037, '2026-05-27', 'Completed'),
(1061, 107, 2043, '2026-06-10', 'Completed'),
(1062, 107, 2041, '2026-06-24', 'Completed'),

(1063, 108, 2044, '2026-01-26', 'Completed'),
(1064, 108, 2045, '2026-02-23', 'Not Completed'),
(1065, 108, 2046, '2026-03-23', 'Completed'),
(1066, 108, 2044, '2026-04-20', 'Completed'),
(1067, 108, 2047, '2026-05-25', 'Completed'),

(1068, 109, 2048, '2026-01-06', 'Completed'),
(1069, 109, 2049, '2026-02-10', 'Completed'),
(1070, 109, 2050, '2026-02-24', 'Not Completed'),
(1071, 109, 2051, '2026-03-10', 'Completed'),
(1072, 109, 2048, '2026-04-14', 'Completed'),
(1073, 109, 2052, '2026-05-12', 'Not Completed'),
(1074, 109, 2049, '2026-06-16', 'Completed'),

(1075, 110, 2053, '2026-01-19', 'Not Completed'),
(1076, 110, 2054, '2026-02-16', 'Completed'),
(1077, 110, 2055, '2026-03-16', 'Not Completed'),
(1078, 110, 2056, '2026-04-17', 'Completed'),
(1079, 110, 2054, '2026-05-19', 'Completed'),
(1080, 110, 2057, '2026-06-18', 'Completed');
