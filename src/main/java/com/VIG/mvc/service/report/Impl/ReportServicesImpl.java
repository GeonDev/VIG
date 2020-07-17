package com.VIG.mvc.service.report.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.VIG.mvc.service.domain.Report;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.report.ReportDao;
import com.VIG.mvc.service.report.ReportServices;


@Service("reportServicesImpl")
public class ReportServicesImpl implements ReportServices {
	
	@Autowired	  
	@Qualifier("reportDaoImpl")
	private ReportDao reportDao;

	public ReportServicesImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addReport(Report report) throws Exception {
		// TODO Auto-generated method stub
		reportDao.addReport(report);

	}

	@Override
	public List<Report> getReportList(Search search) throws Exception {
		
		return reportDao.getReportList(search);
	}

	@Override
	public void updateBanState(Report report) throws Exception {
		// TODO Auto-generated method stub
		reportDao.updateBanState(report);
	}

	@Override
	public void updateState(Report report) throws Exception {
		// TODO Auto-generated method stub
		reportDao.updateState(report);
	}

	@Override
	public int getCountReportList(Search search) throws Exception {
		return reportDao.getCountReportList(search);
	}

}
