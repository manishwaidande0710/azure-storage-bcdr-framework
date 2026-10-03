# Azure Monitor & KQL Deep-Dive (AZ-104)

## 1. Metrics vs. Logs
| Dimension | Azure Monitor Metrics | Azure Monitor Logs (Log Analytics) |
| :--- | :--- | :--- |
| **Data Structure** | Numerical time-series data only. | Structured text, events, and records. |
| **Storage & Cost** | Lightweight, stored for 93 days free. | Stored in Log Analytics workspaces. |
| **Analysis** | Fast metric charts, threshold alerts. | Complex queries using Kusto Query Language (KQL). |

---

## 2. KQL Core Syntax Rules
- **Case Sensitive**: Table names and column names are case-sensitive (\AzureActivity\ is valid; \zureactivity\ will fail).
- **Pipelining**: Operations execute sequentially from top to bottom separated by \|\.
- **Time Window**: Always scope queries using \go()\ (e.g., \where TimeGenerated > ago(24h)\) to optimize performance and prevent scanning excessive data.

---

## 3. Azure Alert Types
- **Metric Alerts**: Evaluate at regular intervals (e.g., CPU > 80% for 5 minutes). Very fast response times.
- **Log Search Alerts**: Run a KQL query on a schedule (e.g., count of failed logins > 5 in 15 minutes).
- **Action Groups**: Reusable notification channels (Email, SMS, Push notification, Webhook, Automation Runbook).
