package com.vig.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.vig.domain.Report;
import com.vig.domain.Search;


@Mapper
public interface ReportMapper {
	
	public void addReport(Report report) throws Exception;
	
	public List<Report> getReportList(Search search) throws Exception;
	
	public List<Report> getReportListFromUser(Search search) throws Exception;
	
	public int getCountReportList (Search search) throws Exception;
	
	public int getCountReportListFromUser (Search search) throws Exception;

	public void updateBanState(Report report) throws Exception;
	
	

}
