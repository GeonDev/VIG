package com.mvc.vig.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.mvc.vig.domain.Feed;
import com.mvc.vig.domain.Image;
import com.mvc.vig.domain.ImageColor;
import com.mvc.vig.domain.ImageKeyword;
import com.mvc.vig.domain.Search;


public class CommonUtil {
	
	///Field
	
	///Constructor
	
	///Method
	public static String null2str(String org, String converted) {
		if (org == null || org.trim().length() == 0)
			return converted;
		else
			return org.trim();
	}

	public static String null2str(String org) {
		return CommonUtil.null2str(org, "");
	}

	public static String null2str(Object org) {
		if (org != null && org instanceof java.math.BigDecimal) {
			return CommonUtil.null2str((java.math.BigDecimal) org, "");
		} else {
			return CommonUtil.null2str((String) org, "");
		}
	}

	public static String null2str(java.math.BigDecimal org, String converted) {
		if (org == null)
			return converted;
		else
			return org.toString();
	}

	public static String null2str(java.math.BigDecimal org) {
		return CommonUtil.null2str(org, "");
	}

	public static String toDateStr(String dateStr) {
		if (dateStr == null)
			return "";
		else if (dateStr.length() != 8)
			return dateStr;
		else
			return dateStr.substring(0, 4) + "/" + dateStr.substring(4, 6)
					+ "/" + dateStr.substring(6, 8);
	}

	public static String toDateStr(Timestamp date) {
		if (date == null)
			return "";
		else {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			return sdf.format(new Date(date.getTime()));
		}
	}
	
	public static String toDateStr(Date date) {
		if (date == null)
			return "";
		else {
			SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-DD");
			return sdf.format(new Date(date.getTime()));
		}
	}
	
	
	

	public static String toSsnStr(String ssnStr) {
		if (ssnStr == null)
			return "";
		else if (ssnStr.length() != 13)
			return ssnStr;
		else
			return ssnStr.substring(0, 6) + "-" + ssnStr.substring(6, 13);
	}

	public static String toAmountStr(String amountStr) {
		String returnValue = "";
		if (amountStr == null)
			return returnValue;
		else {
			int strLength = amountStr.length();

			if (strLength <= 3)
				return amountStr;
			else {
				String s1 = "";
				String s2 = "";
				for (int i = strLength - 1; i >= 0; i--)
					s1 += amountStr.charAt(i);

				for (int i = strLength - 1; i >= 0; i--) {
					s2 += s1.charAt(i);
					if (i % 3 == 0 && i != 0)
						s2 += ",";
				}

				return s2;
			}
		}
	}

	public static String toAmountStr(java.math.BigDecimal amount) {
		if (amount == null) {
			return "";
		} else {
			return toAmountStr(amount.toString());
		}
	}
	
	public static boolean checkNumber(String str) {
		
		if(str.equals("") || str==null) {
			
			return false;
		}		
		
		
		for(int i =0; i<str.length();i++) {
			char c = str.charAt(i);
			if(c<48 || c>59) {
				return false;
			}
		}		
		
		return true;
		
	}
	
	
	public static String checkOvperlap(String csv ,String src, String str) {
		
		String [] list =  src.split(csv);
		String result = new String();
		
		for(String s : list) {
			if (!(s.equals(str))) {
				result += (s+csv);
			}
		}
		
		return result;
	}
	
	public static void writeFile(MultipartFile multipartFile, String saveFileName, String SAVE_PATH) throws IOException{
		
		byte[] data = multipartFile.getBytes();
		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);
		fos.write(data);
		fos.close();
		
	}
	
	
		public static String getHttpConnection(String uri, String param) throws ServletException, IOException {
			URL url = new URL(uri);
			HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			try (OutputStream stream = conn.getOutputStream()) {
				try (BufferedWriter wd = new BufferedWriter(new OutputStreamWriter(stream))) {
					wd.write(param);
				}
			}
			int responseCode = conn.getResponseCode();
			System.out.println(responseCode);
			String line;
			StringBuffer buffer = new StringBuffer();
			try (InputStream stream = conn.getInputStream()) {
				try (BufferedReader rd = new BufferedReader(new InputStreamReader(stream))) {
					while ((line = rd.readLine()) != null) {
						buffer.append(line);
						buffer.append('\r');
					}
				}
			} catch (Throwable e) {
				e.printStackTrace();
			}
			return buffer.toString();
		}
		
		public static String getHttpConnection(String uri) throws ServletException, IOException {
			URL url = new URL(uri);
			HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			int responseCode = conn.getResponseCode();
			System.out.println(responseCode);
			String line;
			StringBuffer buffer = new StringBuffer();
			try (InputStream stream = conn.getInputStream()) {
				try (BufferedReader rd = new BufferedReader(new InputStreamReader(stream))) {
					while ((line = rd.readLine()) != null) {
						buffer.append(line);
						buffer.append('\r');
					}
				}
			} catch (Throwable e) {
				e.printStackTrace();
			}
			return buffer.toString();
		}
		
		
		
		public static Search getHaxtoRGB(Search search, int colorRange ) {
			
			ImageColor rgb = new ImageColor();			
		
			if(search.getKeyword().length() !=7) {
				return null;
			} 
						
			String hax = search.getKeyword();			
			
			rgb.setRed(cheackColorRange(getColorNumber(hax.substring(1, 3)),colorRange));
			rgb.setGreen(cheackColorRange(getColorNumber(hax.substring(3, 5)),colorRange));
			rgb.setBlue(cheackColorRange(getColorNumber(hax.substring(5)),colorRange));
						
			String haxCode ="#"; 
			haxCode += getHaxcode(rgb.getRed());
			haxCode += getHaxcode(rgb.getGreen());
			haxCode += getHaxcode(rgb.getBlue());
			
			rgb.setHaxcode(haxCode);
			
			search.setColor(rgb);			
			search.setKeyword(haxCode);
			
			return search;
		}
		
		
		public static int getColorNumber(String Code) {
			
			
			if(Code.length() !=2) {
				return -1;
			}		
			int num = Integer.parseInt(Code, 16);
			return num;	
		}
		
		public static int cheackColorRange(int num, int range) {			 							
			
			return (int)(num/range) * range;
		}
		
		
	
		public static String getUserIp(HttpServletRequest request) throws Exception {
			
	        String ip = null;
	
	        ip = request.getHeader("X-Forwarded-For");
	        
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	            ip = request.getHeader("Proxy-Client-IP"); 
	        } 
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	            ip = request.getHeader("WL-Proxy-Client-IP"); 
	        } 
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	            ip = request.getHeader("HTTP_CLIENT_IP"); 
	        } 
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	            ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
	        }
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	            ip = request.getHeader("X-Real-IP"); 
	        }
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	            ip = request.getHeader("X-RealIP"); 
	        }
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	            ip = request.getHeader("REMOTE_ADDR");
	        }
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	            ip = request.getRemoteAddr(); 
	        }
			
			return ip;
		}

		
		public static List<Feed> checkEqualFeed(List<Feed> checked){
			List<Feed> result = new ArrayList<Feed>();
			
			for(Feed f : checked) {
				Boolean isSame= false;
				
				for(Feed rf : result) {
					if(rf.getFeedId() == f.getFeedId()) {
						isSame = true;
						break;
					}					
				}
				
				if(!isSame) {
					result.add(f);
				}
			
			}			
			
			return result;
		}
		
		public static List<Image> checkEqualImage(List<Image> checked){
			List<Image> result = new ArrayList<Image>();
			
			for(Image f : checked) {
				if(!result.contains(f)) {			
					result.add(f);				
				}			
			}			
			
			return result;
		}
		
		
		
		public static List<ImageKeyword> checkEqualKeyword(List<ImageKeyword> checked){
			List<ImageKeyword> result = new ArrayList<ImageKeyword>();
			
			for(ImageKeyword k : checked) {
				boolean isSame = false;
				
				for(ImageKeyword rk : result) {
					if((rk.getKeywordEn()).equals(k.getKeywordEn())) {
						isSame = true;
						break;
					}					
				}
				
				if(!isSame) {
					result.add(k);
				}				
			}			
			
			return result;
		}
		
		
		public static void comb(List<ImageKeyword> target, boolean[] visited, int depth, int r, List<String> result) {
	        if (r == 0) {
	        	result.add(addComb(target, visited));
	            return;
	        }
	        
	        if (depth == target.size()) {
	            return;
	        }

	        visited[depth] = true;
	        comb(target, visited, depth + 1, r - 1, result);

	        visited[depth] = false;
	        comb(target, visited, depth + 1, r, result);
	    }
		
		
	    private static String addComb(List<ImageKeyword> target, boolean[] visited) {
	    	String result = "";
	    	
	        for (int i = 0; i < target.size(); i++) {
	            if (visited[i]) {            	
	            	result += target.get(i).getKeywordEn() +",";                
	            }
	        }
	        return result.substring(0, result.length()-1);
	    }
	    
	    
	    public static String getHaxcode(int num) {		
			
			String hax = Integer.toHexString(num);
			if(hax.length() == 1) {
				String temp = "0";
				temp += hax;
				hax = temp; 
			}
			
			return hax;
		}

	
}
