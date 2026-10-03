# Azure Storage Security & Lifecycle Management Guide (AZ-104)

## 1. Storage Authentication Methods
| Method | Description | Exam Recommendation |
| :--- | :--- | :--- |
| **Account Access Keys** | Unrestricted root admin access (Key1/Key2). | Avoid; disable \llowSharedKeyAccess\. |
| **Shared Access Signatures (SAS)** | Delegated URI token with expiry, IP bounds, and specific permissions. | Use for granular temporary external access. |
| **Entra ID RBAC** | Identity-based role assignments (*Storage Blob Data Contributor/Reader*). | **Best practice** enterprise standard. |

---

## 2. Redundancy Models
- **LRS (Locally Redundant)**: 3 copies within a single datacenter in one region (99.999999999% / 11 9's durability).
- **ZRS (Zone-Redundant)**: 3 copies across 3 distinct Availability Zones in one region (12 9's durability).
- **GRS (Geo-Redundant)**: 3 copies locally + 3 copies asynchronously replicated to a secondary paired region hundreds of miles away (16 9's durability).
- **GZRS (Geo-Zone-Redundant)**: 3 copies across availability zones locally + 3 copies in secondary region.

---

## 3. Storage Account Firewall & Zero-Trust
- \publicNetworkAccess = 'Disabled'\: Blocks all public internet access.
- **Private Endpoints**: Grants the storage account a private IP address from your VNet.
- **Exceptions (Bypass)**: Allows trusted Microsoft services (e.g. Azure Backup, Azure Monitor) to connect securely.
