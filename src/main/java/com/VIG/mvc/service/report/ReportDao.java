package com.VIG.mvc.service.report;

import java.util.List;

import com.VIG.mvc.service.domain.Report;
import com.VIG.mvc.service.domain.Search;

public interface ReportDao {
	
	public void addReport(Report report) throws Exception;
	
	public List<Report> getReportList(Search search) throws Exception;
	
	public List<Report> getReportListFromUser(Search search) throws Exception;
	
	public int getCountReportList (Search search) throws Exception;
	
	public int getCountReportListFromUser (Search search) throws Exception;

	public void updateBanState(Report report) throws Exception;
	
	public void updateState(Report report) throws Exception;

}
