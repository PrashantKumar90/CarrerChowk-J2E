package com.Major.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Major.DAO.JobDAO;
import com.Major.Entity.JobEntity;
import com.Major.config.Databaseconfig;
import com.Major.config.MailSender;

@WebServlet("/ApplyJob")
@MultipartConfig
public class ApplyJob extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action"); // "apply" or "fetch"
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			conn = Databaseconfig.getConnection();
			List<JobEntity> applications = new ArrayList<>();

			switch (action) {
			case "apply": {
				// Application submission
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String portfolio = request.getParameter("portfolio");
				String coverletter = request.getParameter("coverletter");
				int userId = Integer.parseInt(request.getParameter("user_id"));
				int jobId = Integer.parseInt(request.getParameter("job_id"));

				InputStream resumeInputStream = null;
				Part filePart = request.getPart("resume");
				if (filePart != null && filePart.getSize() > 0) {
					resumeInputStream = filePart.getInputStream();
				}

				String sql = "INSERT INTO applications (user_id, job_id, name, email, portfolio, resume, coverletter) "
						+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, userId);
				stmt.setInt(2, jobId);
				stmt.setString(3, name);
				stmt.setString(4, email);
				stmt.setString(5, portfolio);
				stmt.setBlob(6, resumeInputStream);
				stmt.setString(7, coverletter);

				int row = stmt.executeUpdate();
				if (row > 0) {
					
					//fetch detail of job using job id
					// here call method where we take the job detail and forward to the mail sender
					// and go mail sender where create body for recruiter and seeker and send mail
					// to both
					// here has to send mail when user successfully apply the job
					JobDAO jobdao = new JobDAO();
					JobEntity mailDetail = jobdao.getMailDetail(jobId);
					response.sendRedirect("success.jsp");
					MailSender.recruiterAndSeekerMail(email, name, mailDetail.getJobTitle(), mailDetail.getEmail());
				} else {
					response.getWriter().println("Failed to submit application.");
				}
				break;
			}

			case "fetch": {
				String type = request.getParameter("type"); // "user" or "admin"
				switch (type) {
				case "user": {
					int userId = Integer.parseInt(request.getParameter("user_id"));
					String sql = "SELECT id, job_id, name, email, portfolio, coverletter, resume FROM applications WHERE user_id = ?";
					stmt = conn.prepareStatement(sql);
					stmt.setInt(1, userId);
					break;
				}
				case "admin": {
					int adminId = Integer.parseInt(request.getParameter("admin_id"));
					String sql = "SELECT a.id, a.job_id, a.name, a.email, a.portfolio, a.coverletter, a.resume "
							+ "FROM applications a JOIN job_postings j ON a.job_id = j.id " + "WHERE j.admin_id = ?";
					stmt = conn.prepareStatement(sql);
					stmt.setInt(1, adminId);
					break;
				}

				case "superadmin": {
					String sql = "SELECT id, job_id, name, email, portfolio, coverletter, resume FROM applications";
					stmt = conn.prepareStatement(sql);
					rs = stmt.executeQuery();
					break;
				}
				default:
					response.getWriter().println("Invalid type parameter.");
					return;
				}

				rs = stmt.executeQuery();
				while (rs.next()) {
					JobEntity app = new JobEntity();
					app.setId(rs.getInt("id"));
					app.setJobId(rs.getInt("job_id"));
					app.setName(rs.getString("name"));
					app.setEmail(rs.getString("email"));
					app.setPortfolio(rs.getString("portfolio"));
					app.setCoverletter(rs.getString("coverletter"));

					Blob resumeBlob = rs.getBlob("resume");
					if (resumeBlob != null) {
						byte[] resumeBytes = resumeBlob.getBytes(1, (int) resumeBlob.length());
						app.setResumeBytes(resumeBytes);
					}

					applications.add(app);
				}

				request.setAttribute("applications", applications);
				request.getRequestDispatcher("userApplications.jsp").forward(request, response);
				break;
			}

			default:
				response.getWriter().println("Invalid action parameter.");
				break;
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Error: " + e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
			}
			try {
				if (stmt != null)
					stmt.close();
			} catch (Exception e) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
	}

}
