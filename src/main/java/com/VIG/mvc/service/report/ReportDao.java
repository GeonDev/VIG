package com.VIG.mvc.service.report;

import java.util.Map;

import com.VIG.mvc.service.domain.Report;
import com.VIG.mvc.service.domain.Search;

public interface ReportDao {
	
	public void addReport(Report report) throws Exception;
	
	public Map<String,Object> getReportList(Search search) throws Exception;

	public void updateBanState(Report report) throws Exception;
	
	public void updateState(Report report) throws Exception;

}
