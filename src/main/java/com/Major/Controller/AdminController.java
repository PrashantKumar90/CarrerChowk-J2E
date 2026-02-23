package com.Major.Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.Major.DAO.UserDAO;
import com.Major.Entity.UserEntity;

@WebServlet(urlPatterns = {"/Addscheme", "/Schemes", "/Viewmore", "/SchemeList", "/Terminate",
		"/Members", "/Remove", "/Approve"})

public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getServletPath();
		
		switch (path) {
		case "/Addscheme": {
			UserDAO userDAO = new UserDAO();
			String title = request.getParameter("title");
			String state = request.getParameter("state");
			String start_date = request.getParameter("start_date");
			String end_date = request.getParameter("end_date");
			String author_name = request.getParameter("author_name");
			String url = request.getParameter("url");
			int adminID = Integer.parseInt(request.getParameter("adminID"));
			String description = request.getParameter("description").replace("\n", "<br>");


			UserEntity schemes = new UserEntity();
			schemes.setTitle(title);
			schemes.setState(state);
			schemes.setStart_date(start_date);
			schemes.setEnd_date(end_date);
			schemes.setAuthor(author_name);
			schemes.setUrl(url);
			schemes.setAdminId(adminID);
			schemes.setDescription(description);

			try {
				if (userDAO.AddScheme(schemes)) {
					response.sendRedirect("success.jsp");
				} else {
					response.sendRedirect("404.jsp");
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
		}
		case "/Schemes": {

			int adminID = Integer.parseInt(request.getParameter("adminID"));
			request.setAttribute("adminId", adminID);
			
			RequestDispatcher rd;
			rd = request.getRequestDispatcher("SchemeList.jsp");
			rd.forward(request, response);
			break;

		}
		case "/Viewmore": {
			request.getRequestDispatcher("ViewMore.jsp").forward(request, response);
			break;
		}
		case "/SchemeList": {
			request.getRequestDispatcher("filterScheme.jsp").forward(request, response);
			break;
		}
		case "/Terminate": {
			UserDAO dao = new UserDAO();
			String id = request.getParameter("schemeId");
			String name = request.getParameter("name");
			if(name!=null) {
				if (dao.terminateScheme(id)) {
					response.sendRedirect("Success");
				}
			}else {
				response.sendRedirect("404.jsp");
			}
			break;
		}
		case "/Members": {
			UserDAO dao = new UserDAO();
			request.getRequestDispatcher("MemberList.jsp").forward(request, response);
			break;
		}
		case "/Approve": {
			UserDAO dao = new UserDAO();
			String id = request.getParameter("id");
			if (dao.updateUser(id)) {
				response.sendRedirect("success.jsp");
			}
			break;
		}
		case "/Remove": {
			UserDAO dao = new UserDAO();
			String id = request.getParameter("id");
			if (dao.terminateUser(id)) {
				response.sendRedirect("success.jsp");
			}
			break;
		}
		// new case insert;
		}

	}

}