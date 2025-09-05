# 🔐 OT-LogBridge: Automated Log Forwarding and Archival System  

⚡ **OT-LogBridge** is a lightweight automation script designed for **Operational Technology (OT) environments**.  
It ensures that critical logs are:  
- 📝 **Processed** → Updates timestamps for accuracy.  
- 📡 **Transferred** → Securely forwarded to the history server.  
- 🗂️ **Archived** → Only the latest logs are sent to the Data Management (DM) Server.
- 🤖 The script is available in 2 langauges (**Powershell and Python**)

**Note:** _It is recommended to use Powershell script for Windows-based OT systems, as it is the safer and easier choice. Choose Python if you’re building a cross-platform solution (Linux + Windows). If you want to integrate with advanced analytics (machine learning, dashboards) and if you’re prototyping outside OT (lab setup)_. 

---
## 📂 **Project Flow**   
   
<img width="1491" height="566" alt="image" src="https://github.com/user-attachments/assets/121b12ba-dc9c-4e1f-a177-8d910e65ec23" />


---

## ✨ **Features**
- ⏱️ Trigger-based execution (runs only when a new log file is updated). 
- 🔄 Real-time log processing & timestamp updates.  
- 📤 FTP-based log transfer to history server.  
- 🧹 Automated cleanup of daily log archives.
- ⚒️ Dual delivery mechanism (continuous history + daily summary).
- 🔧 No manual intervention needed.  
- 🛡️ Lightweight, designed for OT/ICS systems.
- ✅ Easier for OT engineers/auditors to check history without looking at console. 

---

## 📂 **Workflow**
1. **Industrial Component** → Generates/updates `Sensor_Log.txt`  
2. **Script** → Detects file updates everytime, processes with current timestamps of the system & uploads to **History Server**  
3. **History Server** → Maintains archive of all logs generate in the day.
4. **Data Management(DM) Server** → Receives only the latest log at the end of the day.   

---

## 🎯 **Use Case**
Ideal for **OT environments** where log integrity, availability, and archival are critical for:  
- 🏭 Industrial Control Systems (ICS).  
- 🔌 Energy & Utilities.  
- 🚦 SCADA/PLC Monitoring.  

---

## 💻 **Usage**

(1) Change the path of Log file generated and ftp server ip & credentials

(2) Clone the repo for ruuning Python Script:

    - git clone https://github.com/rohitburke/ChronoLog.git
    - cd ChronoLog
    - python ChronoLog.py
    
OR

(3) Clone the repo for ruuning Powershell Script:

    - git clone https://github.com/rohitburke/ChronoLog.git
    - cd ChronoLog
    - powershell -ExecutionPolicy Bypass -File .\ChronoLog.ps1 -InstallService
    - Start-Service ChronoLog



==> The script will:
- Watch for changes in Sensor_log.txt
- Process and upload logs automatically
- Log all activities in Logs/FileOutScript.log
  
---

## 🚀 **Future Enhancements**
- 🔒 SFTP/FTPS support.  
- 📊 Dashboard for log visualization.  
- 🧾 Compliance-ready log retention policies.
- 🌍 Push logs to SIEM (Splunk, ELK, QRadar) for more usability
- 🔎 Add checksum validation for file integrity.  
