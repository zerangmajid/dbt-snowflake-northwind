 

# 🧊 dbt + Snowflake + Northwind Demo  
A complete end-to-end ELT project using **dbt**, **Snowflake**, and **Dockerized SQL Server** with the classic **Northwind** dataset.

This project demonstrates:
- Loading Northwind data from SQL Server into Snowflake  
- Building a modern ELT pipeline using dbt  
- Creating SCD Type 2 dimensions using dbt snapshots  
- Building lineage graphs, documentation, and tests  
- Using Docker + Python + dbt together in a reproducible environment  

---

# 🚀 Getting Started

## 1️⃣ **Install Requirements**

### Python
```bash
pip install dbt-core dbt-snowflake snowflake-connector-python pandas pyodbc
```

### Fix VSCode Python warnings (optional)
```bash
pip install pyodbc pandas snowflake-connector-python dbt-snowflake
```

## 2️⃣ Run SQL Server + Northwind (Docker)
### This project includes a Docker SQL Server container with auto-loading Northwind data.
```bash
docker-compose up -d
```
## 3️⃣ Load Northwind Data → Snowflake
```bash
load_northwind_to_snowflake.py
```
### Run the loader:
```bash

python load_northwind_to_snowflake.py
```

## 4️⃣ Configure dbt Profile for Snowflake

Edit your `profiles.yml` to configure Snowflake:

```yaml
dev_snowflake:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: <your_account>
      user: <your_user>
      password: <your_password>
      role: ACCOUNTADMIN
      warehouse: COMPUTE_WH
      database: RAW
      schema: PUBLIC
      threads: 4
```

### Test the connection:
```yaml

dbt debug --target dev_snowflake
```

## 5️⃣ Run dbt Transformations

**▶️ Run all models**
```bash
dbt run --target dev_snowflake
```

### Run specific folders
```bash
dbt run --select staging
dbt run --select marts
```

### Run Tests
```bash

dbt test --target dev_snowflake
```

## 7️⃣ Snapshots (SCD Type 2)
### ▶️ Execute snapshot to capture historical changes
```bash

dbt snapshot --target dev_snowflake
```

## 8️⃣ Build Documentation + Lineage Graph
### ▶️ Generate documentation
```bash

dbt docs generate --target dev_snowflake
```
## ▶️ Serve documentation UI
```bash

dbt docs serve --port 8081 --target dev_snowflake
```

### Access documentation in browser: