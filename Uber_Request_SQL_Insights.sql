
-- =====================================================
-- Uber Request Data SQL Insights
-- Table Name: uber_requests
-- =====================================================

-- 1. Total Ride Requests
SELECT COUNT(*) AS total_requests
FROM uber_requests;

-- 2. Ride Status Distribution
SELECT Status, COUNT(*) AS total
FROM uber_requests
GROUP BY Status
ORDER BY total DESC;

-- 3. Completion Rate
SELECT ROUND(
100.0 * SUM(CASE WHEN Status='Trip Completed' THEN 1 ELSE 0 END)
/ COUNT(*),2) AS completion_rate
FROM uber_requests;

-- 4. Peak Demand Hours
SELECT Request_Hour, COUNT(*) AS requests
FROM uber_requests
GROUP BY Request_Hour
ORDER BY requests DESC;

-- 5. Pickup Point Performance
SELECT Pickup_point, COUNT(*) AS total_requests
FROM uber_requests
GROUP BY Pickup_point;

-- 6. Cancellation Analysis
SELECT Pickup_point, COUNT(*) AS cancelled
FROM uber_requests
WHERE Status='Cancelled'
GROUP BY Pickup_point;

-- 7. No Cars Available
SELECT Request_Hour, COUNT(*) AS shortage
FROM uber_requests
WHERE Status='No Cars Available'
GROUP BY Request_Hour
ORDER BY shortage DESC;

-- 8. Average Trip Duration
SELECT ROUND(AVG(Trip_Duration_Min),2)
AS avg_trip_duration
FROM uber_requests;

-- 9. Hour-wise Completion Trend
SELECT Request_Hour,
COUNT(*) completed
FROM uber_requests
WHERE Status='Trip Completed'
GROUP BY Request_Hour
ORDER BY Request_Hour;

-- 10. Driver Availability
SELECT
COUNT(Driver_id) AS assigned_drivers,
COUNT(*)-COUNT(Driver_id) AS missing_driver
FROM uber_requests;

-- 11. Top 5 Peak Hours
SELECT Request_Hour,
COUNT(*) requests
FROM uber_requests
GROUP BY Request_Hour
ORDER BY requests DESC
LIMIT 5;

-- 12. Demand Supply Gap
SELECT Status,
COUNT(*) total
FROM uber_requests
GROUP BY Status;

-- 13. Day-wise Requests
SELECT Request_Day,
COUNT(*) requests
FROM uber_requests
GROUP BY Request_Day
ORDER BY requests DESC;

-- 14. Trip Duration by Pickup Point
SELECT Pickup_point,
ROUND(AVG(Trip_Duration_Min),2)
AS avg_duration
FROM uber_requests
GROUP BY Pickup_point;

-- 15. Final KPI Query
SELECT
COUNT(*) Total_Requests,
SUM(CASE WHEN Status='Trip Completed' THEN 1 ELSE 0 END) Completed,
SUM(CASE WHEN Status='Cancelled' THEN 1 ELSE 0 END) Cancelled,
SUM(CASE WHEN Status='No Cars Available' THEN 1 ELSE 0 END) No_Cars
FROM uber_requests;
