\# Enterprise Azure Storage Security, Backup \& BCDR Framework



An automated, Infrastructure-as-Code (IaC) storage architecture and business continuity framework for Microsoft Azure, enforcing zero-trust data protection, automated tiering, WORM immutability, and centralized KQL monitoring at \*\*$0 compute cost\*\*.



\## 📌 Architecture Highlights

\- \*\*Zero-Trust Secure Storage\*\*: Public network access disabled, enforced TLS 1.2+, and disabled shared access keys to mandate Microsoft Entra ID RBAC.

\- \*\*Automated Lifecycle Management\*\*: Cost-optimization rules transitioning blobs from \*\*Hot -> Cool (30d) -> Archive (90d) -> Expired (365d)\*\*.

\- \*\*WORM Immutability Policies\*\*: Time-based tamper-proof retention protecting backup containers against ransomware and unauthorized deletion.

\- \*\*Business Continuity \& Disaster Recovery (BCDR)\*\*: Centralized \*\*Recovery Services Vault (RSV)\*\* with automated backup policies, soft-delete, and cross-region restore (CRR) readiness.

\- \*\*Centralized Observability (KQL)\*\*: Azure Monitor Log Analytics workspace with production-grade Kusto queries detecting unauthorized access attempts and operational alerts.



\## 📂 Repository Layout

```text

├── main.bicep                      # Master deployment orchestrator

├── modules/

│   ├── storage/                   # Storage Account, Lifecycle, \& Immutability (Bicep)

│   │   └── secure-storage.bicep

│   ├── backup-recovery/           # Recovery Services Vault \& Backup policies (Bicep)

│   │   └── recovery-services-vault.bicep

│   └── observability/             # Log Analytics \& KQL security rules (Bicep/KQL)

│       ├── log-analytics.bicep

│       └── kql-security-queries.kql

├── tests/

│   └── validate-storage-bcdr.ps1  # Automated validation test suite

└── docs/

&#x20;   ├── storage-security-guide.md  # Auth models, redundancy, and network ACLs

&#x20;   ├── bcdr-backup-guide.md       # Vault replication, soft delete, and instant restore

&#x20;   └── kql-monitoring-guide.md    # Metrics vs logs, syntax rules, and alert design

