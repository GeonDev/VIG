package com.vig.util;

import java.io.InputStream;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

/**
 * 
 * @author kada 
 * @content 뷰 취급된 클래스로 엑셀파일을 생성하고 다운로드 하게 해준다.
 * 
 * */

@Component
public class ExcelDownloader extends AbstractView{
	
	
	InputStream is = null;
	Workbook wb = null;
	String filename = "";

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		response.setContentType("application/msexcel;charset=EUC-KR");
		response.setHeader("Content-Disposition", "attachment; filename=" + filename + ".xlsx;");
		
		ServletOutputStream os = response.getOutputStream();
		wb.write(os);
		wb.close();
		is.close();
		os.close();
		
	}

}
