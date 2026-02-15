-- =====================================================
-- DHL LOGISTICS OPTIMIZATION – SQL ANALYSIS PROJECT
-- =====================================================

-- Data imported from CSV files into MySQL
-- Resolved UTF-8 BOM encoding issue in imported CSV headers

CREATE DATABASE IF NOT EXISTS dhl_logistics;
USE dhl_logistics;



-- =====================================================
-- 1. DATA CLEANING & STANDARDIZATION
-- =====================================================

-- Fixing encoding issues in column names

ALTER TABLE delivery_agents
CHANGE COLUMN `ï»¿Agent_ID` Agent_ID VARCHAR(10);

ALTER TABLE dhl_orders
CHANGE COLUMN `ï»¿Order_ID` Order_ID VARCHAR(10);

ALTER TABLE shipments
CHANGE COLUMN `ï»¿Shipment_ID` Shipment_ID VARCHAR(10);

ALTER TABLE warehouses
CHANGE COLUMN `ï»¿Warehouse_ID` Warehouse_ID VARCHAR(10);


-- Checking duplicate Order IDs
SELECT Order_ID, COUNT(*) AS duplicate_count
FROM orders
GROUP BY Order_ID
HAVING COUNT(*) > 1;

-- Checking duplicate Shipment IDs
SELECT Shipment_ID, COUNT(*) AS duplicate_count
FROM shipments
GROUP BY Shipment_ID
HAVING COUNT(*) > 1;

-- Checking NULL delay values
SELECT COUNT(*) AS null_delay_records
FROM shipments
WHERE Delay_Hours IS NULL;



-- =====================================================
-- 2. ROUTE PERFORMANCE ANALYSIS
-- =====================================================

-- Total shipments per route
SELECT 
    r.Route_ID,
    COUNT(s.Shipment_ID) AS total_shipments
FROM shipments s
JOIN routes r 
    ON s.Route_ID = r.Route_ID
GROUP BY r.Route_ID
ORDER BY total_shipments DESC;


-- Average delivery delay per route
SELECT
    Route_ID,
    ROUND(AVG(Delay_Hours), 2) AS avg_delay_hours
FROM shipments
GROUP BY Route_ID
ORDER BY avg_delay_hours DESC;



-- =====================================================
-- 3. DELIVERY DELAY ANALYSIS
-- =====================================================

-- Shipments delayed more than 2 hours
SELECT
    Shipment_ID,
    Delay_Hours
FROM shipments
WHERE Delay_Hours > 2
ORDER BY Delay_Hours DESC;

-- Delayed shipment count per route
SELECT
    Route_ID,
    COUNT(*) AS delayed_shipments
FROM shipments
WHERE Delay_Hours > 0
GROUP BY Route_ID
ORDER BY delayed_shipments DESC;



-- =====================================================
-- 4. AGENT PERFORMANCE EVALUATION
-- =====================================================

-- Average delay per agent
SELECT
    a.Agent_ID,
    ROUND(AVG(s.Delay_Hours), 2) AS avg_delay_hours
FROM shipments s
JOIN delivery_agents a
    ON s.Agent_ID = a.Agent_ID
GROUP BY a.Agent_ID
ORDER BY avg_delay_hours ASC;

-- Shipments handled per agent
SELECT
    Agent_ID,
    COUNT(*) AS total_shipments
FROM shipments
GROUP BY Agent_ID
ORDER BY total_shipments DESC;



-- =====================================================
-- 5. WAREHOUSE PERFORMANCE ANALYSIS
-- =====================================================

-- Total shipments processed per warehouse
SELECT
    w.Warehouse_ID,
    COUNT(s.Shipment_ID) AS total_shipments
FROM warehouses w
LEFT JOIN shipments s
    ON w.Warehouse_ID = s.Warehouse_ID
GROUP BY w.Warehouse_ID
ORDER BY total_shipments DESC;

-- Average delay per warehouse
SELECT
    w.Warehouse_ID,
    ROUND(AVG(s.Delay_Hours), 2) AS avg_delay_hours
FROM warehouses w
LEFT JOIN shipments s
    ON w.Warehouse_ID = s.Warehouse_ID
GROUP BY w.Warehouse_ID
ORDER BY avg_delay_hours DESC;



-- =====================================================
-- 6. OPERATIONAL INSIGHTS
-- =====================================================

-- Worst-performing routes
SELECT
    Route_ID,
    COUNT(*) AS total_delays,
    ROUND(AVG(Delay_Hours), 2) AS avg_delay_hours
FROM shipments
WHERE Delay_Hours > 0
GROUP BY Route_ID
ORDER BY avg_delay_hours DESC;

-- Top-performing agents (lowest average delay)
SELECT
    Agent_ID,
    COUNT(*) AS total_shipments,
    ROUND(AVG(Delay_Hours), 2) AS avg_delay_hours
FROM shipments
GROUP BY Agent_ID
ORDER BY avg_delay_hours ASC;



-- =====================================================
-- 7. ADVANCED KPI REPORTING
-- =====================================================

-- Average delivery delay per source country
SELECT
    r.Source_Country,
    ROUND(AVG(s.Delay_Hours), 2) AS avg_delay_hours
FROM shipments s
JOIN routes r 
    ON s.Route_ID = r.Route_ID
GROUP BY r.Source_Country
ORDER BY avg_delay_hours DESC;


-- On-time delivery percentage
SELECT
    COUNT(*) AS total_deliveries,
    SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) AS on_time_deliveries,
    ROUND(
        (SUM(CASE WHEN Delay_Hours = 0 THEN 1 ELSE 0 END) / COUNT(*)) * 100,
        2
    ) AS on_time_delivery_percent
FROM shipments;


-- Warehouse utilization percentage
SELECT
    w.Warehouse_ID,
    COUNT(s.Shipment_ID) AS shipments_handled,
    w.Capacity_per_day,
    ROUND(
        (COUNT(s.Shipment_ID) / w.Capacity_per_day) * 100,
        2
    ) AS utilization_percent
FROM warehouses w
LEFT JOIN shipments s
    ON w.Warehouse_ID = s.Warehouse_ID
GROUP BY w.Warehouse_ID, w.Capacity_per_day
ORDER BY utilization_percent DESC;