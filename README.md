# ☁️ Cloud Data Warehouse & Analytics Solution on Google Cloud

A cloud-native data analytics project showcasing the deployment of a serverless data warehouse pipeline using Google Cloud BigQuery, Cloud Run, and Looker Studio.  
This project demonstrates how to integrate scalable storage, analytics, visualization, and serverless computing into a unified cloud solution.

---

## 🎯 Objectives

- Build a scalable data warehouse using BigQuery for high-performance analytics
- Develop custom SQL queries to extract actionable business insights
- Create interactive dashboards for visualization and decision-making
- Deploy a serverless web interface using Cloud Run to dynamically query and display results
- Ensure the solution is modular, automated, and cost-efficient

---

## 🧩 Core Components

| Component | Description |
|-----------|-------------|
| **BigQuery Data Warehouse** | Acts as the central analytics engine for querying large datasets |
| **SQL Queries** | Custom analytical queries designed to extract regional and operational insights |
| **Cloud Run Web Application** | Flask-based Python web app that executes SQL queries and returns results dynamically |
| **Looker Studio Dashboards** | Interactive dashboards visualizing query results and KPIs |
| **Docker & Requirements Files** | Define the environment for containerized, serverless deployment |

---

## ⚙️ Tech Stack

| Area | Tools |
|------|-------|
| **Cloud Platform** | Google Cloud Platform (GCP) |
| **Data Warehouse** | BigQuery |
| **Web Framework** | Flask (Python) |
| **Containerization** | Docker |
| **Deployment** | Cloud Run |
| **Visualization** | Looker Studio / Google Data Studio |
| **Query Language** | SQL |

---

## 💡 Features

- **Scalable Analytics** – Query large datasets in seconds using BigQuery  
- **Serverless Application** – Containerized Flask app deployed via Cloud Run  
- **Interactive Dashboards** – Visualize performance metrics and insights in real time  
- **Automated Deployment** – Fully Dockerized for quick setup and portability  
- **Cross-Platform Potential** – Architecture adaptable for AWS or Azure equivalents  

---

## 📊 SQL Queries

**regional_business_insights.sql**  
- Extracts and aggregates business performance metrics by region  
- Highlights geographical trends and regional KPIs  

**weekly_operational_metrics.sql**  
- Summarizes weekly operational data  
- Tracks performance and identifies optimization opportunities  

---

## 🖥️ Web Application

The Cloud Run web app provides a simple user interface for querying the BigQuery dataset.  
Built using Flask, it allows users to:

- Select and execute predefined SQL queries  
- Display query results on the web page dynamically  
- Run seamlessly on Google Cloud Run in a fully serverless manner  

---

## 📸 Dashboards Preview

- **Query 1 – Regional Insights:** Displays performance trends by region based on `regional_business_insights.sql`.  
- **Query 2 – Weekly Operational Metrics:** Visualizes key weekly metrics for monitoring and reporting based on `weekly_operational_metrics.sql`. 

---

## 👩‍💻 Author

Ishwari Niphade | Data Scientist & Cloud Enthusiast | https://www.linkedin.com/in/ishwari-niphade/ | https://github.com/ishwari215
