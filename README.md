# DHL Logistics Optimization – SQL Analysis Project

## 📌 Project Overview

This project analyzes DHL logistics and shipment data to identify delivery delays, route inefficiencies, warehouse utilization gaps, and agent performance issues.

The objective is to generate actionable business insights that improve operational efficiency and reduce delivery delays.

---

## 🛠 Tools & Technologies

- MySQL  
- SQL (JOIN, GROUP BY, CASE, Aggregations, KPI Calculations)  
- CSV data imported into MySQL  

---

## 🗂 Dataset Description

The dataset consists of the following CSV files stored in the `data/` folder:

- dhl_shipments.csv  
- dhl_routes.csv  
- dhl_delivery_agents.csv  
- dhl_warehouses.csv  
- dhl_orders.csv  

After importing into MySQL, tables were renamed to simplified schema names (`shipments`, `routes`, `delivery_agents`, `warehouses`, `orders`) for improved readability and structured querying.

During import, UTF-8 BOM encoding issues in ID columns were identified and resolved using SQL.

---

## 🔎 Key Analysis Performed

### 1️⃣ Data Cleaning & Validation
- Resolved UTF-8 encoding issues in column headers  
- Checked duplicate Order and Shipment IDs  
- Validated NULL values in delay metrics  

### 2️⃣ Route Performance Analysis
- Calculated total shipments per route  
- Measured average delay per route  
- Identified high-delay routes  

### 3️⃣ Delivery Delay Analysis
- Detected shipments delayed beyond threshold  
- Analyzed delay frequency by route  

### 4️⃣ Agent Performance Evaluation
- Calculated average delivery delay per agent  
- Measured total shipments handled per agent  
- Identified top-performing agents  

### 5️⃣ Warehouse Performance Analysis
- Total shipments processed per warehouse  
- Average delay per warehouse  
- Calculated warehouse utilization percentage  

### 6️⃣ Advanced KPI Reporting
- On-time delivery percentage  
- Average delay by source country  
- Route-level delay comparison  
- Warehouse capacity utilization %  

---

## 📊 Key Business Insights

- Identified routes contributing to maximum delivery delays  
- Measured operational efficiency using On-Time Delivery %  
- Detected warehouse bottlenecks using utilization metrics  
- Evaluated agent efficiency using delay-based KPIs  
- Highlighted geographic sources with higher delay patterns  

---

## 🚀 Business Impact

The analysis provides insights that can help:

- Optimize route planning  
- Improve warehouse capacity allocation  
- Reduce delivery delays  
- Improve agent performance monitoring  
- Increase overall logistics efficiency  

---

## 📂 Project Structure

```
SQL-Logistics-Optimization-DHL/
│
├── logistics_analysis.sql
├── data/
│   ├── dhl_shipments.csv
│   ├── dhl_routes.csv
│   ├── dhl_delivery_agents.csv
│   ├── dhl_warehouses.csv
│   └── dhl_orders.csv
│
└── README.md
```

---

## 📌 Conclusion

This project demonstrates practical SQL skills including data cleaning, multi-table joins, KPI calculation, aggregation, and business-focused analytical thinking applied to logistics optimization.
