package com.Major.Controller;

import com.Major.DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.MessageDigest;

import com.Major.Entity.UserEntity;

@WebServlet("/loginsignup")
public class Credential extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		switch (action) {

		// Registration
		case "registration": {
			
			String role =  request.getParameter("usertype");
			
			UserDAO userDAO = new UserDAO();
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String passcode = request.getParameter("passcode");

			try {
				passcode = encryptPasscode(passcode);
			} catch (Exception e) {
				e.printStackTrace();
			}
			String phone = request.getParameter("phone");
			String state = request.getParameter("state");
			
			

			UserEntity user = new UserEntity();
			user.setName(name);
			user.setEmail(email);
			user.setPasscode(passcode);
			user.setPhone(phone);
			user.setState(state);
		
			
			try {
				if (userDAO.registration(user, role)) {
					response.sendRedirect("success.jsp");
				} else {
					response.sendRedirect("404.jsp");
				}
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			break;
		}

		case "login": {
			UserDAO userdao = new UserDAO();
			HttpSession session = request.getSession();
			String email = request.getParameter("email");
			String passcode = request.getParameter("passcode");
			try {
				passcode = encryptPasscode(passcode);
			} catch (Exception e) {
				e.printStackTrace();
			}
			UserEntity user = userdao.validateUser(email, passcode);
			
			if (user != null && user.getStatus() == 2) {
				
				session.setAttribute("user", user);
				response.sendRedirect("AdminDash");
			} else if (user != null && user.getStatus() == 1) {
				
				session.setAttribute("user", user);
				response.sendRedirect("Dashboard");
			}
			 else if (user != null && user.getStatus() == 3) {
				 	
					session.setAttribute("user", user);
					response.sendRedirect("index.jsp");
				}
			else if (user != null && user.getStatus() == 0) {

				response.sendRedirect("404.jsp");
			}

			else {
				response.sendRedirect("404.jsp");
			}
			break;
		}

		}
	}

	// LogOut Function
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate(); // Invalidate session to log out the user
		}
		// Forward to home after logout
		response.sendRedirect(request.getContextPath()+"/");
  
	}

	private String encryptPasscode(String password) throws Exception {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		byte[] hashBytes = md.digest(password.getBytes());

		// Convert to hex format
		StringBuilder hexString = new StringBuilder();
		for (byte b : hashBytes) {
			hexString.append(String.format("%02x", b));
		}
		return hexString.toString();
	}

}
