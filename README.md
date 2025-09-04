# 🔐 OT-LogBridge: Automated Log Forwarding and Archival System  

⚡ **OT-LogBridge** is a lightweight automation script designed for **Operational Technology (OT) environments**.  
It ensures that critical logs are:  
- 📝 **Processed** → Updates timestamps for accuracy.  
- 📡 **Transferred** → Securely forwarded to the history server.  
- 🗂️ **Archived** → Only the latest logs are sent to the Data Management (DM) Server.  

---

## ✨ Features
- ⏱️ Trigger-based execution (runs only when a new log file is updated). 
- 🔄 Real-time log processing & timestamp updates.  
- 📤 FTP-based log transfer to history server.  
- 🧹 Automated cleanup of daily log archives.
- ⚒️ Dual delivery mechanism (continuous history + daily summary).
- 🔧 No manual intervention needed.  
- 🛡️ Lightweight, designed for OT/ICS systems.
- ✅ Easier for OT engineers/auditors to check history without looking at console. 

---

## 📂 Workflow
1. **Industrial Component** → Generates/updates `Sensor_Log.txt`  
2. **Script** → Detects file updates everytime, processes with current timestamps of the system & uploads to **History Server**  
3. **History Server** → Maintains archive of all logs generate in the day.
4. **DM Server** → Receives only the latest log at the end of the day.   

---

## 🎯 Use Case
Ideal for **OT environments** where log integrity, availability, and archival are critical for:  
- 🏭 Industrial Control Systems (ICS).  
- 🔌 Energy & Utilities.  
- 🚦 SCADA/PLC Monitoring.  

---

## 🚀 Future Enhancements
- 🔒 SFTP/FTPS support.  
- 📊 Dashboard for log visualization.  
- 🧾 Compliance-ready log retention policies.
- 🌍 Push logs to SIEM (Splunk, ELK, QRadar) for more usability
- 🔎 Add checksum validation for file integrity.  
