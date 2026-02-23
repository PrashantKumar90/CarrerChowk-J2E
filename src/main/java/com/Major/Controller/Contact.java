package com.Major.Controller;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.Major.config.MailSender;

@WebServlet("/ContactUs")
public class Contact extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private final String adminMail = "supriyaupreti5390@gmail.com";

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String subject = request.getParameter("subject");
		String message = request.getParameter("message");

		// Mail to admin
		String adminSubject = "New Contact Form Submission: " + subject;
		String adminBody = "Name: " + name + "\nEmail: " + email + "\nSubject: " + subject + "\nMessage:\n" + message;

		// Mail to user
		String userSubject = "Thank you for contacting us";
		String userBody = "Dear " + name
				+ ",\n\nThank you for reaching out. We will get back to you within 24 hours.\n\nRegards,\nCarrer Chowk Team";

		try {
			MailSender.sendEmail(adminMail, adminSubject, adminBody);
			MailSender.sendEmail(email, userSubject, userBody);

			
			response.sendRedirect("contact.jsp?success=true");

		} catch (MessagingException e) {
			e.printStackTrace();
			response.sendRedirect("contact.jsp?error=true");
		}
	}
}
