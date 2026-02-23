package com.Major.config;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class MailSender {
    private static final String admin = "supriyaupreti5390@gmail.com";  // Change this
    private static final String password = "tyol dfvy jeij ruhm";    // Gmail App Password

    public static void sendEmail(String to, String subject, String body) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(admin, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(admin));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setText(body);

        Transport.send(message);
    }
    
    
    public static void recruiterAndSeekerMail(String seekerMail, String seekerName, String jobTitle, String recruiterEmail) throws MessagingException {
    	
         //Mail to recruiter
    	 String recruiterSubject = "New Job Application for " + jobTitle;
         String recruiterBody = "Hello,\n\n" + seekerName + " has applied for " + jobTitle + ".\nPlease check the portal for details.";
         
         // Mail to user
         String userSubject = "Application Received for " + jobTitle;
         String userBody = "Dear " + seekerName + ",\n\nThank you for applying for " + jobTitle + ". We will get back to you soon.\n\nRegards,\nJob Portal Team";
         
         sendEmail(recruiterEmail, recruiterSubject, recruiterBody);
         sendEmail(seekerMail, userSubject, userBody);
    }
    
}

