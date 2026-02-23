package com.Major.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Major.Entity.JobEntity;

import com.Major.config.Databaseconfig;

public class JobDAO {

	public boolean addJob(JobEntity job) {
		String sql = "INSERT INTO job_postings (admin_id, job_title, company_name, location, job_type, experience_required, salary_range, skills_required, educational_qualifications, application_deadline, number_of_openings, job_description) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try (Connection con = Databaseconfig.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, job.getAdminId());
			ps.setString(2, job.getJobTitle());
			ps.setString(3, job.getCompanyName());
			ps.setString(4, job.getJobLocation());
			ps.setString(5, job.getJobType());
			ps.setString(6, job.getExperienceRequired());
			ps.setString(7, job.getSalleryRange());
			ps.setString(8, job.getSkillRequired());
			ps.setString(9, job.getQualification());
			ps.setDate(10, new java.sql.Date(job.getLastDate().getTime()));
			ps.setInt(11, job.getNoOfOpening());
			ps.setString(12, job.getDescription());

			return ps.executeUpdate() == 1;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	// for job listing in public

	public List<JobEntity> getJobsByType(String jobType) {
		List<JobEntity> jobList = new ArrayList<>();

		String sql = "SELECT * FROM job_postings where job_type = ?";

		try (Connection conn = Databaseconfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, jobType);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				JobEntity job = new JobEntity();
				job.setId(rs.getInt("id"));
				job.setAdminId(rs.getInt("admin_id"));
				job.setJobTitle(rs.getString("job_title"));
				job.setCompanyName(rs.getString("company_name"));
				job.setJobLocation(rs.getString("location"));
				job.setJobType(rs.getString("job_type"));
				job.setExperienceRequired(rs.getString("experience_required"));
				job.setSalleryRange(rs.getString("salary_range"));
				job.setSkillRequired(rs.getString("skills_required"));
				job.setQualification(rs.getString("educational_qualifications"));
				job.setLastDate(rs.getDate("application_deadline"));
				job.setNoOfOpening(rs.getInt("number_of_openings"));
				job.setDescription(rs.getString("job_description"));

				jobList.add(job);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return jobList;
	}

	public List<JobEntity> getJobs() {
		List<JobEntity> jobList = new ArrayList<>();

		String sql = "SELECT * FROM job_postings";

		try (Connection conn = Databaseconfig.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql);

				ResultSet rs = stmt.executeQuery()) {

			while (rs.next()) {
				JobEntity job = new JobEntity();
				job.setId(rs.getInt("id"));
				job.setAdminId(rs.getInt("admin_id"));
				job.setJobTitle(rs.getString("job_title"));
				job.setCompanyName(rs.getString("company_name"));
				job.setJobLocation(rs.getString("location"));
				job.setJobType(rs.getString("job_type"));
				job.setExperienceRequired(rs.getString("experience_required"));
				job.setSalleryRange(rs.getString("salary_range"));
				job.setSkillRequired(rs.getString("skills_required"));
				job.setQualification(rs.getString("educational_qualifications"));
				job.setLastDate(rs.getDate("application_deadline"));
				job.setNoOfOpening(rs.getInt("number_of_openings"));
				job.setDescription(rs.getString("job_description"));

				jobList.add(job);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return jobList;
	}

	// get Job BY ID

	public JobEntity getJobByID(int id) {
		JobEntity job = null;

		String sql = "SELECT * FROM job_postings WHERE id = ?";

		try (Connection conn = Databaseconfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				job = new JobEntity();
				job.setId(rs.getInt("id"));
				job.setAdminId(rs.getInt("admin_id"));
				job.setJobTitle(rs.getString("job_title"));
				job.setCompanyName(rs.getString("company_name"));
				job.setJobLocation(rs.getString("location"));
				job.setJobType(rs.getString("job_type"));
				job.setExperienceRequired(rs.getString("experience_required"));
				job.setSalleryRange(rs.getString("salary_range"));
				job.setSkillRequired(rs.getString("skills_required"));
				job.setQualification(rs.getString("educational_qualifications"));
				job.setLastDate(rs.getDate("application_deadline"));
				job.setNoOfOpening(rs.getInt("number_of_openings"));
				job.setDescription(rs.getString("job_description"));
				job.setPublishDate(rs.getString("posted_at"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return job;
	}

	// Job Detail for Mail Service - :

	public  JobEntity getMailDetail(int job_id) {
		JobEntity job = null;

		try (Connection conn = Databaseconfig.getConnection();
				PreparedStatement stmt = conn.prepareStatement(
						"SELECT jp.job_title, a.email FROM job_postings jp JOIN admin a ON jp.admin_id = a.id WHERE jp.id = ?")) {

			stmt.setInt(1, job_id);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				job = new JobEntity();
				job.setJobTitle(rs.getString("job_title"));
				job.setEmail(rs.getString("email")); 
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return job;
	}

}
