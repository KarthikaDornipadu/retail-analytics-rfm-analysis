# 🛍️ Consumer360 – Customer Segmentation & CLV Engine

## 📌 Project Overview

Consumer360 is an end-to-end retail analytics project designed to help e-commerce businesses understand customer behavior, improve marketing strategies, and increase revenue.

The system segments customers using RFM analysis, predicts Customer Lifetime Value (CLV), and provides actionable insights through data visualization.

---

## 🎯 Business Problem

A mid-sized e-commerce company struggles with:

* Generic marketing campaigns
* Poor customer retention
* Lack of insight into high-value customers

### ✅ Solution

Consumer360 provides:

* Customer segmentation (RFM)
* Churn risk identification
* CLV prediction
* Data-driven decision support

---

## 🏗️ Project Architecture

```
Raw Data (CSV)
        ↓
SQL (Data Cleaning & Transformation)
        ↓
Python (RFM + CLV + Analytics)
        ↓
Power BI (Visualization)
```

---

## 📊 Features

### 🔹RFM Segmentation

* Recency: Days since last purchase
* Frequency: Number of transactions
* Monetary: Total spending

Customers are scored (1–5) and segmented into:

* Champions
* Loyal Customers
* Potential Loyalists
* Recent Users
* Promising
* Needs Attention
* About To Sleep
* At Risk
* Can't Lose Them
* Hibernating
* Lost
* Price Sensitive

---


---

## 🛠️ Tech Stack

| Tool                   | Purpose                    |
| ---------------------- | -------------------------- |
| SQL                    | Data extraction & cleaning |
| Python (Pandas, NumPy) | Data processing            |
| Lifetimes Library      | CLV modeling               |
| Power BI               | Dashboard & visualization  |
| Excel                  | Data export                |

---

## 📂 Project Structure

```
retail-analytics-rfm-analysis/
│
├── Data/
│   └── cleaned_data.csv
│
├── python/
│   └── Rfm.ipynb
│
├── SQL/
│   ├── SQLQuery.sql
│   └── star_scheme.sql
│
└── output/
    ├── rfm_output.xlsx
    └── clv_output.xlsx
```

---

## 🚀 How to Run

### 1️⃣ Install dependencies

```bash
pip install pandas numpy lifetimes openpyxl
```

### 2️⃣ Load dataset

```python
import pandas as pd

df = pd.read_csv("../Data/cleaned_data.csv")
df['Date'] = pd.to_datetime(df['Date'])
```

### 3️⃣ Run RFM Analysis

* Create Recency, Frequency, Monetary
* Apply scoring (1–5)
* Segment customers

### 4️⃣ Export Results

```python
rfm.to_excel("rfm_output.xlsx")
```

---

## 📊 Output

### RFM Output

* Customer segments
* Behavioral insights

---

## 💡 Key Insights

* Identify high-value customers (Champions)
* Detect churn risk (At Risk, Hibernating)
* Improve marketing targeting
* Increase customer retention

---

## 🎯 Use Cases

* Personalized marketing campaigns
* Customer retention strategies
* Product recommendation systems
* Revenue forecasting

---

## 📌 Future Enhancements

* Real-time data pipeline
* Automated dashboard refresh
* Integration with recommendation engine
* Deployment as web application

---

## 👨‍💻 Authors

* Manoj S V
* D Karthika Chaitrika
* Sharmila U
* Narayanababu M

---


## ⭐ Conclusion

This project demonstrates the application of data analytics and machine learning techniques to solve real-world business problems, enabling data-driven decision-making in retail.

