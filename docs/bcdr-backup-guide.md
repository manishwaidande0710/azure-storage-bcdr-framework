# Azure Backup & Disaster Recovery (BCDR) Guide (AZ-104)

## 1. Vault Storage Replication Options
| Replication Type | Description | Exam Takeaway |
| :--- | :--- | :--- |
| **Locally Redundant (LRS)** | 3 copies in a single datacenter. | Cost-effective for dev/test. |
| **Geo-Redundant (GRS)** | 3 copies locally + 3 copies in paired region. | Default enterprise standard. |
| **Cross-Region Restore (CRR)** | Allows restores into secondary region at will. | Requires GRS vault tier. |

> **Critical Rule**: You cannot alter a vault's storage redundancy once items have been backed up.

---

## 2. Backup Retention & Tiering Mechanics
- **Instant Restore Snapshot Tier**: Retained locally with VM disks for 1–5 days for fast recovery times (RTO).
- **Vault Standard Tier**: Compressed and deduped backup copies stored in the vault for long-term compliance (up to 99 years).

---

## 3. Anti-Ransomware Safeguards
- **Soft Delete**: Retains deleted backup data for **14 additional days** with no deletion allowed during this grace period.
- **Multi-User Authorization (MUA / Resource Guard)**: Requires a separate administrator (security team) to authorize disabling soft delete or modifying retention policies.
