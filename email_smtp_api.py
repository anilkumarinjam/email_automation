import time
from flask import Flask, request, jsonify
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.application import MIMEApplication
import os

app = Flask(__name__)

# Gmail SMTP Settings
SMTP_SERVER = "smtp.gmail.com"
SMTP_PORT = 587
GMAIL_USER = "anilkumarch.228@gmail.com"
GMAIL_PASSWORD = "wtde xiww nxjx cqog"

# Path to your resume file
RESUME_PATH = "./Anil_resume.pdf"  # Update this with your resume file path

@app.route('/sendEmails', methods=['POST'])
def send_email():
    data = request.json
    email_to = data['email']
    subject = data['subject']
    body = data['body']

    try:
        msg = MIMEMultipart()
        msg['From'] = GMAIL_USER
        msg['To'] = email_to
        msg['Subject'] = subject
        
        # Attach the HTML body
        msg.attach(MIMEText(body, 'html'))
        
        # Attach the resume file
        # with open(RESUME_PATH, "rb") as f:
        #     resume_attachment = MIMEApplication(f.read(), _subtype="pdf")
        #     resume_attachment.add_header('Content-Disposition', 'attachment', filename=os.path.basename(RESUME_PATH))
        #     msg.attach(resume_attachment)

        server = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
        server.starttls()
        server.login(GMAIL_USER, GMAIL_PASSWORD)
        server.sendmail(GMAIL_USER, email_to, msg.as_string())
        server.quit()
        time.sleep(2)

        return jsonify({"status": "success", "message": "Email sent successfully with resume attachment"})

    except Exception as e:
        return jsonify({"status": "error", "message": str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=7000)