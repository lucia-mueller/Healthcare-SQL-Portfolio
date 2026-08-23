-- =============================================
-- Provider Productivity Dashboard
-- SQL Analysis
-- Analysis of fictional healthcare visit data
-- =============================================

-- 1. Visits per Provider
-- Calculates the total number of visits associated with each provider.
SELECT 
    p.provider_name, 
    COUNT(v.visit_id) AS total_visits
FROM Providers AS p
LEFT JOIN Visits AS v
    ON p.provider_id = v.provider_id
GROUP BY p.provider_name
ORDER BY total_visits DESC;

-- 2. Average Visits per Provider
-- Calculates the average number of visits across all providers.
SELECT 
    COUNT(v.visit_id) / COUNT(DISTINCT p.provider_id) AS avg_visits_per_provider
FROM Providers AS p
LEFT JOIN Visits AS v
    ON p.provider_id = v.provider_id;

-- 3. Providers with Zero Visits
-- Identifies providers with no associated patient visits.
SELECT 
    p.provider_name,
    COUNT(v.visit_id) AS total_visits
FROM Providers AS p
LEFT JOIN Visits AS v
    ON p.provider_id = v.provider_id
GROUP BY p.provider_name
HAVING COUNT(v.visit_id) = 0;

-- 4. Monthly Appointment Totals
-- Calculates the total number of appointments recorded each month.
SELECT 
    MONTH(v.visit_date) AS visit_month,
    COUNT(v.visit_id) AS total_appointments
FROM Visits AS v
GROUP BY MONTH(v.visit_date)
ORDER BY MONTH(v.visit_date) ASC;

-- 5. Provider Completion Rate
-- Calculates the percentage of completed visits for each provider.
SELECT
    p.provider_name,
    COUNT(v.visit_id) AS total_visits,
    SUM(
        CASE
            WHEN v.visit_status = 'Completed' THEN 1
            ELSE 0
        END
    ) AS completed_visits,
    ROUND(
        SUM(
            CASE
                WHEN v.visit_status = 'Completed' THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(v.visit_id), 0) * 100,
        2
    ) AS completion_rate_pct
FROM Providers AS p
LEFT JOIN Visits AS v
    ON p.provider_id = v.provider_id
GROUP BY p.provider_name;