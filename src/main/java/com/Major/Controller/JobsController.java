package com.Major.Controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.Major.DAO.JobDAO;
import com.Major.DAO.UserDAO;
import com.Major.Entity.JobEntity;
import com.Major.Entity.UserEntity;

@WebServlet(urlPatterns = { "/Jobs", "/JobList" })

public class JobsController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getServletPath();
				RequestDispatcher rd;
				rd = request.getRequestDispatcher("job-list.jsp");
				rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getServletPath();
		switch (path) {
		case "/Jobs": {
			try {
				int adminId = Integer.parseInt(request.getParameter("adminID")); // maybe from session
				String jobTitle = request.getParameter("jobTitle");
				String companyName = request.getParameter("companyName");
				String jobLocation = request.getParameter("jobLocation");
				String jobType = request.getParameter("jobType");
				String experienceRequired = request.getParameter("experienceRequired");
				String salleryRange = request.getParameter("salleryRange"); // spelling match your entity
				String skillRequired = request.getParameter("skillRequired");
				String qualification = request.getParameter("qualification");
				String lastDateStr = request.getParameter("lastDate");
				int noOfOpening = Integer.parseInt(request.getParameter("noOfOpening"));
				String description = request.getParameter("description");

				// Convert date
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date lastDate = sdf.parse(lastDateStr);

				// Populate entity
				JobEntity job = new JobEntity();
				job.setAdminId(adminId);
				job.setJobTitle(jobTitle);
				job.setCompanyName(companyName);
				job.setJobLocation(jobLocation);
				job.setJobType(jobType);
				job.setExperienceRequired(experienceRequired);
				job.setSalleryRange(salleryRange);
				job.setSkillRequired(skillRequired);
				job.setQualification(qualification);
				job.setLastDate(lastDate);
				job.setNoOfOpening(noOfOpening);
				job.setDescription(description);

				// Insert via DAO
				JobDAO dao = new JobDAO();
				boolean success = dao.addJob(job);

				if (success) {
					response.sendRedirect("success.jsp");
				} else {
					response.sendRedirect("404.jsp");
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

			break;
		}

		}
	}
}