package com.vig.util;

import java.io.FileInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.openxml4j.util.ZipSecureFile;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellAddress;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.openxmlformats.schemas.spreadsheetml.x2006.main.CTSheetView;
import org.openxmlformats.schemas.spreadsheetml.x2006.main.CTSheetViews;
import org.openxmlformats.schemas.spreadsheetml.x2006.main.CTWorksheet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import com.vig.controller.FeedController;
import com.vig.domain.User;

/**
 * 
 * @author kada 
 * @content 뷰 취급된 클래스로 엑셀파일을 생성하고 다운로드 하게 해준다.
 *          static/excel 에 있는 엑셀파일을 이용하여 파일을 생성한다.
 * 
 * */

@Component
public class ExcelDownloader extends AbstractView{
	
	public static final Logger logger = LoggerFactory.getLogger(FeedController.class); 
	
	@Value("${excelPath}")
	String excelPath;
	
	@Value("${realExcelPath}")
	String realExcelPath;

	private static String OS = System.getProperty("os.name").toLowerCase();
	
	//전달할 콘텐츠 타입을 지정
	private static final String CONTENT_TYPE = "application/vnd.ms-excel";

	private String template = "template.xlsx";
	String filename = "";
	
	@Autowired
	private ServletContext context;		
	
	InputStream is = null;
	Workbook wb = null;	
	
	
    public void AdminExcelView() {
        setContentType(CONTENT_TYPE);
    }

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
				
        String path = context.getRealPath("/");  
        
        if(OS.contains("win")) {
        	//워크스페이스 경로를 받아온다.
            path = path.substring(0,path.indexOf("\\.metadata"));         
            path +=  excelPath; 
        }else {
        	//실제 톰켓 데이터가 저장되는 경로를 가리킨다.
        	path =  realExcelPath;
        }     
        
        template = path + template;
	
		
		filename = (String) model.get("fileName") + "_" + getDate();
		
		//엑셀파일 작성을 위한 임시데이터 저장용 기능
		//최소 압축 비율을 지정한다.
		ZipSecureFile.setMinInflateRatio(0);
		
		//엑셀파일을 생성한다.
		wb = generateUserExcel(model);
		
		response.setContentType("application/msexcel;charset=UTF-8");
		response.setHeader("Content-Disposition", "attachment; filename=" + filename + ".xlsx;");
		
		ServletOutputStream os = response.getOutputStream();
		wb.write(os);
		wb.close();
		is.close();
		os.close();
		
	}
	
	
	// 탬플릿 엑셀 파일에 리스트 값을 넣음
	public Workbook generateUserExcel(Map<String, Object> model) throws Exception{
		List<User> userlist = (List<User>) model.get("list");

			is = new FileInputStream(template);
			
			XSSFWorkbook xwb = new XSSFWorkbook(is);
			SXSSFWorkbook workbook = new SXSSFWorkbook(xwb);
			
			//엑셀의 시작열을 지정 0부터 카운트 한다.
			int startRow = 4;
			
			//탬플릿 파일에 template 시트의 서식을 불러온다.
			XSSFRow template = xwb.getSheet("template").getRow(startRow);
			List<CellStyle> styleList = new LinkedList<>();
			
			for(int i =1; i < template.getLastCellNum(); i++) {
				styleList.add(template.getCell(i).getCellStyle());
			}
			
			SXSSFSheet sheet = workbook.getSheetAt(0);
			
			logger.info("template excel READ Complite");
			
			//startRow++;
			for(User user : userlist) {
				SXSSFRow row = sheet.createRow(startRow);
				
				row.createCell(1).setCellValue(user.getUserId());
				row.createCell(2).setCellValue(user.getUserName());
				row.createCell(3).setCellValue(user.getRole());
				row.createCell(4).setCellValue(user.getState());
				row.createCell(5).setCellValue(user.getRegDate());
				row.createCell(6).setCellValue(user.getBanDate());
				row.createCell(7).setCellValue(user.getAccount());
				row.createCell(8).setCellValue(user.getPrimeCount());
				row.createCell(9).setCellValue(user.getEmail());
								
				for(int i =1; i < row.getLastCellNum(); i++) {
					sheet.getRow(startRow).getCell(i).setCellStyle(styleList.get(i-1));
				}
				startRow++;
			}
			workbook.removeSheetAt(1);
			
			// First step is to get at the CTWorksheet bean underlying the worksheet. 
			CTWorksheet ctWorksheet = xwb.getSheetAt(0).getCTWorksheet(); 
	        // From the CTWorksheet, get at the sheet views. 
			CTSheetViews ctSheetViews = ctWorksheet.getSheetViews(); 
	        // Grab a single sheet view from that array 
			CTSheetView ctSheetView = ctSheetViews.getSheetViewArray(ctSheetViews.sizeOfSheetViewArray() - 1); 
	        // Se the address of the top left hand cell. 
	        ctSheetView.setTopLeftCell("A1"); 
	        // Also, make sure that cell A1 is the active cell 
	        sheet.setActiveCell(new CellAddress("A1"));		
		
		
		return workbook;	
	}
	
	
	
	public String getDate() {
		Date d = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		
		return format.format(d);
	}
	
	public CellStyle getStyle(XSSFSheet sheet, int row, int cell) {
		return sheet.getRow(row).getCell(cell).getCellStyle();
	}

}
