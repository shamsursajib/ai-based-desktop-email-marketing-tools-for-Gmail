# AI Based Email Marketing Tools
### Version 1.0.0

---

## 🚀 Quick Start

### Option A — Run directly (no build needed)
1. Install Python from https://python.org
2. Double-click **RUN.bat**

### Option B — Build a real Windows EXE
1. Install Python from https://python.org
2. Double-click **BUILD_EXE.bat**
3. Wait 2–3 minutes
4. Your EXE is in the `dist\` folder
5. Copy the EXE anywhere and run it — no Python needed

---

## 📋 Features

| Feature | Details |
|---|---|
| Dashboard | Stats by day / week / month / all-time with bar charts |
| Compose & Send | Load CSV or paste emails, CC/BCC/Reply-To, rich text editor |
| Rich Text Editor | Bold, Italic, Underline, H1/H2, Lists, Color, Align, HTML source |
| Attachments | Up to 10 MB per file |
| Email Validation | Format check + SMTP verify |
| Send Activity Log | Separate log page with filter by status |
| Validation Log | Separate log page with valid/invalid stats |
| Dark / Light Mode | Toggle button in sidebar |

---

## 📧 Gmail App Password Setup

For each Gmail account:
1. Go to **myaccount.google.com → Security**
2. Enable **2-Step Verification**
3. Go to **Security → App Passwords**
4. Generate one for **Mail**
5. Copy the 16-character password into the app

---

## 📁 File Structure

```
mainfolder/
├── main.py              ← entry point
├── RUN.bat              ← run without building
├── BUILD_EXE.bat        ← build Windows EXE
├── app/
│   ├── app.py           ← main application
│   ├── theme.py         ← colors & fonts
│   ├── data.py          ← stats & logging
│   └── emailutils.py    ← send & validate
└── data/                ← auto-created on first run
    ├── accounts.json
    ├── send_log.csv
    ├── validation_log.csv
    └── stats.json
```

---

## ⚠️ Tips

- Keep delay at **5+ seconds** between emails
- Only send to **opted-in subscribers**
- Gmail allows ~500 emails/day per account
