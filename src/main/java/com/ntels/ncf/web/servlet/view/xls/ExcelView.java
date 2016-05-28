package com.ntels.ncf.web.servlet.view.xls;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.ntels.ncf.utils.MessageUtil;

public class ExcelView extends AbstractExcelView{

	@SuppressWarnings({ "unchecked", "rawtypes"})
	protected void buildExcelDocument(Map model, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Map<String, Object>> list = (List<Map<String, Object>>) model.get("list");
		List<String> title = (List<String>) model.get("title");
		List<String> dataType = (List<String>) model.get("dataType");

		List<List<Map<String, Object>>> lists = (List<List<Map<String, Object>>>) model.get("lists");
		List<List<String>> titles = (List<List<String>>) model.get("titles");
		List<List<String>> dataTypes = (List<List<String>>) model.get("dataTypes");

		String filename = (String) model.get("filename");
		String filesubname = (String) model.get("filesubname");
		String NowdateTime  = (String) model.get("NowdateTime");  //현재시간을 DB에서 조회로 변경.

		String uri = request.getRequestURI();
		String tempUriName = uri.replaceAll(".+/([\\w]+)/([\\w]+)/export.+", "$1_$2");
		//System.err.println("---sdsd> "+list.toString());
		if(list != null) {
			if(StringUtils.isEmpty(filename)) {
				buildExcelSheet(workbook, list, title, tempUriName, dataType);
			} else {
				buildExcelSheet(workbook, list, title, filename, dataType);
			}
		} else {
			List<String> sheetNames = (ArrayList<String>) model.get("sheetNames");

			for(int i = 0; i < lists.size(); i++){
				if (dataTypes == null){
					if (sheetNames == null){
						buildExcelSheet(workbook, lists.get(i), titles.get(i), "sheet"+i, null);
					}else{
						buildExcelSheet(workbook, lists.get(i), titles.get(i), sheetNames.get(i), null);
					}
				} else {
					if (sheetNames == null){
						buildExcelSheet(workbook, lists.get(i), titles.get(i), "sheet"+i, dataTypes.get(i));
					}else{
						buildExcelSheet(workbook, lists.get(i), titles.get(i), sheetNames.get(i), dataTypes.get(i));
					}					
				}
			}
		}
		

		StringBuilder tempFilename = new StringBuilder();

		// add menu name for excel file name
		if(StringUtils.isEmpty(filename)) {
			tempFilename.append(tempUriName).append("_");
		} else {
			tempFilename.append(filename).append("_");
		}

		// add menu sub name for excel file name
		if(!StringUtils.isEmpty(filesubname)) { 
			tempFilename.append("(").append(filesubname).append(")").append("_");
		}

		// for multiple file download
		String multiDownload = request.getParameter("multiDownload");
		if(multiDownload != null && "true".equals(multiDownload)) {
			tempFilename.append(request.getParameter("type")).append("_");
		}
		
		tempFilename.append(NowdateTime).append(".xls");
		
		// filename attach 형태로 변환 앞쪽에 붙임
		tempFilename.insert(0, "attachment; filename=\"");
		tempFilename.append("\"");
		
		response.setHeader("Content-Disposition", tempFilename.toString());
	}

	private void buildExcelSheet(HSSFWorkbook workbook, List<Map<String, Object>> list, List<String> titleList, String sheetName, List<String> dataTypeList) {
		HSSFSheet sheet = workbook.createSheet(sheetName);

		CellStyle csTitle = workbook.createCellStyle();
		csTitle.setDataFormat(HSSFDataFormat.getBuiltinFormat("text"));
		csTitle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		csTitle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		csTitle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);

		CellStyle csString = workbook.createCellStyle();
		csString.setDataFormat(HSSFDataFormat.getBuiltinFormat("General"));
		//csString.setDataFormat(HSSFDataFormat.getBuiltinFormat("text"));
		csString.setAlignment(HSSFCellStyle.ALIGN_CENTER);

		CellStyle csNumber1 = workbook.createCellStyle();
		csNumber1.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
		csNumber1.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		
		CellStyle csNumber2 = workbook.createCellStyle();
		csNumber2.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0.00"));
		csNumber2.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		
		CellStyle csNumber3 = workbook.createCellStyle();
		csNumber2.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		
		CellStyle csNumber4 = workbook.createCellStyle();
		csNumber4.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00%"));
		csNumber4.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		
		int rowNum = 0;

		HSSFRow titleRow = sheet.createRow(rowNum++);
		writeTitle(titleRow, csTitle, titleList);

		HSSFRow valueRow = null;
		Cell valueCell = null;

		if(list == null || list.size() <= 0) {
			valueRow = sheet.createRow(rowNum++);

			valueCell = valueRow.createCell(0);
	        valueCell.setCellStyle(csString);
	        valueCell.setCellValue(MessageUtil.getMessage("label.empty.list"));
		} else {
			String dataType = null;
			Object value = null;
        	String valueStr = null;
        	String valueNumStr = null;
        	//System.err.println(list.toString());
        	//System.err.println(titleList.toString());
        	
        	String title;
        	
        	for (Map<String, Object> mapRow : list) {
				valueRow = sheet.createRow(rowNum++);
				
				for(int i = 0; i < titleList.size(); i++) {
					valueCell = valueRow.createCell(i);
					
					title = titleList.get(i);
					if (title.indexOf(".") > 0) title = title.replace(".", ""); //title에 콤마(.)있으면 제거하고 만들어야한다.
					//System.err.println("title-->"+title);
					value = mapRow.get(title);
		        	valueStr = String.valueOf(value);
		        	//System.err.println(titleList.get(i)+"/"+valueStr);
		        	
		        	if(valueStr.equals("null")) valueStr = "";

		        	if(dataTypeList == null) {
		        		dataType = "S";
		        	} else {
		        		dataType = dataTypeList.get(i);

		        		if(!dataType.equals("S") && !dataType.equals("N") && !dataType.equals("NN") && !dataType.equals("P") ) dataType = "S";
		        	}

					if(dataType.equals("S")) {
		        		valueCell.setCellStyle(csString);
				        valueCell.setCellValue(valueStr);
					} else {
			        	valueNumStr = valueStr.replace(",", "");
			        	
			        	if (dataType.equals("NN")) {
			        		valueCell.setCellStyle(csNumber3);
					        valueCell.setCellValue(Double.parseDouble(valueNumStr));
			        	}else if(dataType.equals("P")){
			        		valueCell.setCellStyle(csNumber4);
					        valueCell.setCellValue(Double.parseDouble(valueNumStr));
			        	}else {
				        	if(isNumeric(valueNumStr)) {
					        	if(valueNumStr.indexOf(".") < 0) {
							        valueCell.setCellStyle(csNumber1);
					        	} else {
					        		valueCell.setCellStyle(csNumber2);
					        	}
	
						        valueCell.setCellValue(Double.parseDouble(valueNumStr));
				        	} else {
				        		valueCell.setCellStyle(csString);
						        valueCell.setCellValue(valueStr);
				        	}
			        	}
					}
				}
			}	
		}
	}

	// 제목 세팅
	private void writeTitle(Row row, CellStyle cs, List<String> titleList) {
		Cell titleCell = null;

		for(int i = 0; i < titleList.size(); i++) {
			titleCell = row.createCell(i);

			titleCell.setCellStyle(cs);
			titleCell.setCellValue(titleList.get(i));
		}
	}
	
	public static boolean isNumeric(String s) {
		return s.matches("[-+]?\\d*\\.?\\d+");
	}
		
}
