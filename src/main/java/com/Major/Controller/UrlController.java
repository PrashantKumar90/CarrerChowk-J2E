package com.Major.Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = { "/Home", "/About", "/Contact", "/NewScheme", "/AdminDash", "/Dashboard", "/UserDashboard",
		"/Register", "/Success", "/schemes", "/JobDetail"})

public class UrlController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String path = request.getServletPath();

		switch (path) {
		case "/Home":

			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.forward(request, response);
			break;
		case "/About":

			rd = request.getRequestDispatcher("about.jsp");
			rd.forward(request, response);
			break;
		case "/Contact":
			rd = request.getRequestDispatcher("contact.jsp");
			rd.forward(request, response);
			break;
		case "/NewScheme":
			rd = request.getRequestDispatcher("AddScheme.jsp");
			rd.forward(request, response);
			break;
		case "/AdminDash":
			rd = request.getRequestDispatcher("AdminDash.jsp");
			rd.forward(request, response);
			break;
		case "/Dashboard":
			rd = request.getRequestDispatcher("Dashboard.jsp");
			rd.forward(request, response);
			break;

		case "/login":
			rd = request.getRequestDispatcher("UserDashboard.jsp");
			rd.forward(request, response);
			break;
		case "/Register":
			rd = request.getRequestDispatcher("signup.jsp");
			rd.forward(request, response);
			break;
		case "/Success":
			rd = request.getRequestDispatcher("success.jsp");
			rd.forward(request, response);
			break;
		
		case "/JobDetail":
			rd = request.getRequestDispatcher("job-detail.jsp");
			rd.forward(request, response);
			break;
		default:

			response.getWriter().println("404 - Page Not Found!");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
