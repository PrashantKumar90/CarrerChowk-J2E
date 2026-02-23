package com.Major.Entity;

import java.util.Date;


public class JobEntity {
    private int id;
    private int adminId;
    private String jobTitle;
    private String companyName;
    private String jobLocation;
    private String jobType;
    private String experienceRequired;
    private String salleryRange; 
    private String skillRequired;
    private String qualification; 
    private Date lastDate; 
    private int noOfOpening;
    private String description;
    private String publishDate;
    
    
    
    //for job application
    
    private int jobId;
    private String Name;
    private String Email;
    private String Portfolio;
    private String Coverletter;
    private byte[] ResumeBytes;
    
    public int getJobId() {
		return jobId;
	}
	public void setJobId(int jobId) {
		this.jobId = jobId;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getPortfolio() {
		return Portfolio;
	}
	public void setPortfolio(String portfolio) {
		Portfolio = portfolio;
	}
	public String getCoverletter() {
		return Coverletter;
	}
	public void setCoverletter(String coverletter) {
		Coverletter = coverletter;
	}
	public byte[] getResumeBytes() {
		return ResumeBytes;
	}
	public void setResumeBytes(byte[] resumeBytes) {
		ResumeBytes = resumeBytes;
	}
	//Upper side pdf work
	public String getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(String publishDate) {
		this.publishDate = publishDate;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getAdminId() {
		return adminId;
	}
	public void setAdminId(int adminId) {
		this.adminId = adminId;
	}
	public String getJobTitle() {
		return jobTitle;
	}
	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getJobLocation() {
		return jobLocation;
	}
	public void setJobLocation(String jobLocation) {
		this.jobLocation = jobLocation;
	}
	public String getJobType() {
		return jobType;
	}
	public void setJobType(String jobType) {
		this.jobType = jobType;
	}
	public String getExperienceRequired() {
		return experienceRequired;
	}
	public void setExperienceRequired(String experienceRequired) {
		this.experienceRequired = experienceRequired;
	}
	public String getSalleryRange() {
		return salleryRange;
	}
	public void setSalleryRange(String salleryRange) {
		this.salleryRange = salleryRange;
	}
	public String getSkillRequired() {
		return skillRequired;
	}
	public void setSkillRequired(String skillRequired) {
		this.skillRequired = skillRequired;
	}
	public String getQualification() {
		return qualification;
	}
	public void setQualification(String qualification) {
		this.qualification = qualification;
	}
	public Date getLastDate() {
		return lastDate;
	}
	public void setLastDate(Date lastDate) {
		this.lastDate = lastDate;
	}
	public int getNoOfOpening() {
		return noOfOpening;
	}
	public void setNoOfOpening(int noOfOpening) {
		this.noOfOpening = noOfOpening;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
 
}
