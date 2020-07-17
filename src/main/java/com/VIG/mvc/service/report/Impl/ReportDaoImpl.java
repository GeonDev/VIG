package com.VIG.mvc.service.report.Impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.VIG.mvc.service.domain.Report;
import com.VIG.mvc.service.domain.Search;
import com.VIG.mvc.service.report.ReportDao;

@Repository("reportDaoImpl")
public class ReportDaoImpl implements ReportDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public ReportDaoImpl() {
		// TODO Auto-generated constructor stub
	}
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void addReport(Report report) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("ReportMapper.addReport", report);
	}

	@Override
	public List<Report> getReportList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ReportMapper.getReportList", search);
	}

	@Override
	public void updateBanState(Report report) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("ReportMapper.updateBanState", report);

	}

	@Override
	public void updateState(Report report) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("ReportMapper.updateState", report);

	}

	@Override
	public int getCountReportList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ReportMapper.getCountReportList", search);
	}

	@Override
	public List<Report> getReportListFromUser(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("ReportMapper.getReortListFromUser", search);
	}

	@Override
	public int getCountReportListFromUser(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ReportMapper.getCountReportListFromUser", search);
	}	


}
