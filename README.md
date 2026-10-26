# 📋 Draft

### Smart Citizen Information Collection App

Draft is a Flutter-based mobile application designed to collect and organize essential information through a simple, step-by-step questionnaire.

It brings personal details, contact information, addresses, identity documents, family information, education, employment, banking, and supporting documents together in one structured workflow.

## ✨ Features

- 🧑 Personal information collection
- 📞 Contact details and emergency contacts
- 🏠 Current and permanent addresses
- 🪪 Government identity document details
- 👨‍👩‍👧 Family and dependent information
- 🎓 Education details and qualifications
- 💼 Employment and income information
- 🏦 Banking information
- 🧾 Financial and tax details
- 📷 Photograph and signature collection
- 🔀 Conditional questions
- 📋 Information review before export
- 📄 PDF document generation

## 🧠 Smart Questionnaire

Draft uses conditional questions to make the information collection process simpler and more relevant.

For example, if a user selects **Yes** when asked whether they have a passport, the app displays the passport details section. If they select **No**, the section is skipped.

This approach reduces unnecessary questions and creates a smoother form-filling experience.

## 📋 Information Collected

| Category | Information |
|---|---|
| Personal | Name, date of birth, gender, nationality, and marital status |
| Identity | Aadhaar, PAN, Voter ID, passport, driving licence, and other ID details |
| Address | Current and permanent address, district, state, and PIN code |
| Contact | Mobile number, email, and emergency contact |
| Family | Parents, spouse, children, and dependents |
| Education | Qualifications, institution, course, grades, and certificates |
| Employment | Occupation, employer, designation, experience, and income |
| Banking | Account holder, bank, account details, IFSC, and account type |
| Financial | Income sources, tax information, and applicable GSTIN |
| Documents | Photograph, signature, identity proof, address proof, and certificates |

## 🔄 Application Workflow

1. Enter personal details.
2. Provide contact information.
3. Add current and permanent addresses.
4. Enter identity document details.
5. Complete family information.
6. Add education and employment details.
7. Provide banking and financial information.
8. Attach supporting document details.
9. Review the collected information.
10. Export the information as a PDF.

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Mobile application framework |
| Dart | Programming language |
| Material Design | User interface |
| Local Storage | Data persistence |
| PDF Generation | Document export |

## 🚀 Getting Started

### Prerequisites

Install the following tools:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Dart SDK
- Android Studio or Visual Studio Code
- Android Emulator or a physical Android device

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/yourusername/draft.git
```

**2. Navigate to the project directory**

```bash
cd draft
```

**3. Install dependencies**

```bash
flutter pub get
```

**4. Run the application**

```bash
flutter run
```

Replace `yourusername/draft` with the actual GitHub repository URL before using these commands.

## 🔐 Privacy and Security

Draft is designed to handle information that may include sensitive identity and financial details. Such data must be handled carefully.

Before using the application with real citizen information, implement and verify appropriate safeguards:

- 🔒 Encryption for sensitive data
- 🔐 Secure authentication
- 🗄️ Protected local storage
- 🛡️ Access control
- 🧹 Secure data deletion
- 📄 Protection for exported PDF files
- 🚫 Minimal collection of sensitive information

**Important:** Do not use real Aadhaar numbers, PAN details, bank account information, or other sensitive personal data during development, testing, or demonstrations.

Collect only the information necessary for the intended purpose, obtain appropriate consent, and follow applicable privacy and data protection requirements.

## 🗺️ Future Improvements

- Secure authentication
- Encrypted local storage
- Secure cloud backup
- Multiple user profiles
- OCR-based document scanning
- Automatic form filling
- Document expiry reminders
- Tamil language support
- Additional Indian languages
- Dark mode
- Biometric authentication

## 🤝 Contributing

Contributions and suggestions are welcome.

1. Fork the repository.
2. Create a feature branch:

   ```bash
   git checkout -b feature/your-feature
   ```

3. Make your changes.
4. Commit your changes:

   ```bash
   git add .
   git commit -m "Add your feature"
   ```

5. Push your branch:

   ```bash
   git push origin feature/your-feature
   ```

6. Open a Pull Request.

## 📄 License

This project is intended for educational and development purposes. A formal open-source license has not yet been specified.

## 👨‍💻 Developer

**Bhuvanesh**

Built with Flutter and Dart.

---

*Draft: Collect information. Organize everything. Export it as a PDF.* 📋
