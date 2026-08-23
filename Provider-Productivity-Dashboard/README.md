# Provider Productivity Dashboard

## Project Overview

This project analyzes fictional healthcare visit data to evaluate provider productivity, appointment volume, and visit completion rates. The analysis uses SQL to connect provider and visit-level data and identify patterns in provider workload and appointment completion.

The project was designed to demonstrate practical SQL skills applicable to healthcare analytics, operational reporting, and performance analysis.

## Business Questions

This analysis answers the following questions:

1. How many visits are associated with each provider?
2. What is the average number of visits per provider?
3. Are there providers with zero recorded visits?
4. How does appointment volume change by month?
5. What percentage of each provider's visits were completed?

## Skills Demonstrated

- LEFT JOIN
- GROUP BY
- COUNT and COUNT(DISTINCT)
- HAVING
- CASE statements
- Conditional aggregation
- Date functions
- NULL handling with NULLIF
- Aggregate calculations
- Data filtering and sorting

## Dataset

This project uses a fictional healthcare dataset created specifically for portfolio analysis. It contains two relational tables:

- **Providers** — 11 fictional healthcare providers with provider ID, name, specialty, and clinic location.
- **Visits** — 80 fictional patient visit records containing visit ID, provider ID, patient ID, visit date, and visit status.

The tables are connected through `provider_id`. One provider was intentionally assigned no visit records to demonstrate how LEFT JOIN and HAVING can be used to identify providers with zero activity.

All names, patient IDs, providers, clinics, and visit records in this project are fictional and do not represent real patients or healthcare organizations.

## Results & Key Findings

### Provider Visit Volume

Provider visit volume varied across the dataset. Dr. Mark Brown recorded the highest number of visits with 12, followed by Dr. Emily Brown with 11 and Dr. Sarah Chen with 10. Across all 11 providers, the average visit volume was approximately 7.27 visits per provider.

### Providers with Zero Visits

Dr. Michael Scott had zero recorded visits. Using a LEFT JOIN ensured that providers without matching records in the Visits table remained in the analysis, while HAVING was used to isolate providers with a visit count of zero.

### Monthly Appointment Volume

Appointment volume decreased over the six-month period:

| Month | Total Appointments |
|---|---:|
| January | 15 |
| February | 15 |
| March | 14 |
| April | 13 |
| May | 12 |
| June | 11 |

Appointment volume was highest in January and February with 15 visits each and gradually declined to 11 visits in June.

### Provider Completion Rates

Completion rates varied across providers with recorded visits. Dr. Mark Brown had the highest completion rate at 83.33%, followed by Dr. Emily Brown at 81.82%. Several providers had completion rates of 66.67%, representing the lowest rate among providers with recorded visits.

The provider with zero visits returned a NULL completion rate because a completion percentage cannot be calculated when no visits are recorded.

## SQL Techniques Used

This analysis demonstrates the use of SQL joins, aggregation, conditional logic, and date functions to answer healthcare operational questions. LEFT JOIN was used to preserve providers without visit records, while GROUP BY and aggregate functions were used to calculate provider- and month-level metrics. CASE statements and conditional aggregation were used to calculate completed visits and provider completion rates. NULLIF was used to safely handle providers with zero visits when calculating percentages.

## Project Files

- `sample_data.sql` — Creates the Providers and Visits tables and inserts the fictional dataset used for the analysis.
- `provider_productivity.sql` — Contains the SQL queries used to analyze provider productivity, appointment volume, and visit completion rates.
- `README.md` — Documents the project objectives, SQL techniques, dataset, and key findings.