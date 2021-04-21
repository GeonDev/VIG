package com.vig.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vig.domain.Report;
import com.vig.domain.Search;
import com.vig.repository.ReportMapper;


@Service
public class ReportService  {
	
	@Autowired	  
	private ReportMapper reportMapper;

	public ReportService() {
		// TODO Auto-generated constructor stub
	}


	public void addReport(Report report) throws Exception {
		// TODO Auto-generated method stub
		reportMapper.addReport(report);

	}

	
	public List<Report> getReportList(Search search) throws Exception {
		
		return reportMapper.getReportList(search);
	}


	public void updateBanState(Report report) throws Exception {
		// TODO Auto-generated method stub
		reportMapper.updateBanState(report);
	}



	public int getCountReportList(Search search) throws Exception {
		return reportMapper.getCountReportList(search);
	}

	
	public List<Report> getReportListFromUser(Search search) throws Exception {
		// TODO Auto-generated method stub
		return reportMapper.getReportListFromUser(search);
	}


	public int getCountReportListFromUser(Search search) throws Exception {
		// TODO Auto-generated method stub
		return reportMapper.getCountReportListFromUser(search);
	}

}
