package com.ntels.avocado.service.atom.management.trace;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ntels.avocado.dao.atom.management.trace.TraceDetailMapper;
import com.ntels.avocado.domain.atom.management.trace.Condition;


@Service
public class TraceDetailService {
	
	@Autowired
	private TraceDetailMapper traceDetailMapper;
	
	private Long[] tot = new Long[4];
	private boolean processTot = false;

	// FT:전송, FB:Raw
	public List<Map<String, String>> listUDR(Condition condition) {
		condition.setStart( ((condition.getPage() - 1) * condition.getPerPage()) );
		condition.setEnd(condition.getPerPage());
		
		processTot = false;
		List<Map<String, String>> list = 
				setResData(traceDetailMapper.listUDR(condition, condition.getStart(), condition.getEnd(), "FT"), "FT", "UDR", condition);
		
		return list;
	}

	public List<Map<String, String>> listCDR(Condition condition) {
		condition.setStart( ((condition.getPage() - 1) * condition.getPerPage()) );
		condition.setEnd(condition.getPerPage());
		
		processTot = false;
		List<Map<String, String>> list = 
				setResData(traceDetailMapper.listCDR(condition, condition.getStart(), condition.getEnd(), "FT"), "FT", "CDR", condition);
		
		return list;
	}

	public List<Map<String, String>> listRawUDR(Condition condition) {
		condition.setStart( ((condition.getPage() - 1) * condition.getPerPage()) );
		condition.setEnd(condition.getPerPage());
		
		processTot = false;
		List<Map<String, String>> list = 
				setResData(traceDetailMapper.listUDR(condition, condition.getStart(), condition.getEnd(), "FB"), "FB", "UDR", condition);
		
		return list;
	}

	public List<Map<String, String>> listRawCDR(Condition condition) {
		condition.setStart( ((condition.getPage() - 1) * condition.getPerPage()) );
		condition.setEnd(condition.getPerPage());
		
		processTot = false;
		List<Map<String, String>> list = 
				setResData(traceDetailMapper.listCDR(condition, condition.getStart(), condition.getEnd(), "FB"), "FB", "CDR", condition);
		
		return list;
	}

	public int countUDR(Condition condition) {
		return traceDetailMapper.countUDR(condition, "FT");
	}

	public int countCDR(Condition condition) {
		return traceDetailMapper.countCDR(condition, "FT");
	}

	public int countRawUDR(Condition condition) {
		return traceDetailMapper.countUDR(condition, "FB");
	}

	public int countRawCDR(Condition condition) {
		return traceDetailMapper.countCDR(condition, "FB");
	}
	
	public Long[] getAnalysis(Condition condition, String type) {
		for(int i = 0; i < tot.length; i++) tot[i] = 0L;
		
		List<Map<String, String>> list = null;
				
		processTot = true;
		if("UDR".equals(type)){
			list = setResData(traceDetailMapper.listCDR(condition, 0, 0, "FT"), "FT", "CDR", condition);
		} 
		else if("RAW_UDR".equals(type)){
			list = setResData(traceDetailMapper.listCDR(condition, 0, 0, "FB"), "FB", "CDR", condition);
		}
		
		return tot;
	}
	
	private List<Map<String, String>> setResData(List<Map<String, String>> listResData, String result_type, String res_type, Condition condition) {
		List<Map<Integer, String>> listDataFormat = traceDetailMapper.listDataFormat(condition, result_type, res_type);
		List<Map<String, String>> rows = new ArrayList<Map<String, String>>();
		
		int cntDataFormat = listDataFormat.size();
		
		String[] resData;
		String detailResData = null;
		
//		System.err.println("listResData=>" + listResData);
//		System.err.println("listDataFormat=>" + listDataFormat);

		for(Map<String, String> tmpRes: listResData) {
			resData = tmpRes.get("RES_DATA").split("\\|");
			Map<String, String> row = new HashMap<String, String>();
			
			detailResData = "";
			
			for(int i = 0; i < resData.length && i < cntDataFormat ; i++) {
				if(!processTot) {
					row.put(listDataFormat.get(i).get("NAME"), resData[i]);
					detailResData += listDataFormat.get(i).get("NAME") + " : " + resData[i] + "|";
				} else {
//					if("acct_input_octets".equals(listDataFormat.get(i).get("NAME"))) {// UDR UpSize
//						tot[0] += Long.parseLong(resData[i]);
//					}
//					else if("acct_output_octets".equals(listDataFormat.get(i).get("NAME"))) {// UDR DownSize
//						tot[1] += Long.parseLong(resData[i]);
//					}
//					else 
					if("total_up_packet_size".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
						tot[0] += Long.parseLong(resData[i].trim());
					} else 
					if("total_down_packet_size".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Down
						tot[1] += Long.parseLong(resData[i].trim());
					} else 
					if("real_up_packet_size".equals(listDataFormat.get(i).get("NAME"))) {// CDR Real Up
						tot[2] += Long.parseLong(resData[i].trim());
					} else 
					if("real_down_packet_size".equals(listDataFormat.get(i).get("NAME"))) {// CDR Real Down
						tot[3] += Long.parseLong(resData[i].trim());
					}
				}
			}
			
			if(!processTot) {
				row.put("detailResData", detailResData); // 상세 데이터
				row.put("result_udr_id", String.valueOf(tmpRes.get("RESULT_UDR_ID")));
				row.put("udr_id", String.valueOf(tmpRes.get("UDR_ID")));
				
//				System.err.println(row);
				
				rows.add(row);
			}
		}
		
		return rows;
	}
	
	public List<Map<String, String>> listExcel(Condition condition, String res_type){
		if("UDR".equals(res_type)) {
			return setUDRExcel(traceDetailMapper.listUDRExcel(condition, "FT"), "FT", "UDR", condition);
		}
		else 
		if("RAW_UDR".equals(res_type)) {
			return setRawUDRExcel(traceDetailMapper.listUDRExcel(condition, "FB"), "FB", "UDR", condition);
		} 
		else
		if("CDR".equals(res_type)) {
			return setCDRExcel(traceDetailMapper.listCDRExcel(condition, "FT"), "FT", "CDR", condition);
		} else {//RAW_CDR
			return setCDRExcel(traceDetailMapper.listCDRExcel(condition, "FB"), "FB", "CDR", condition);
		}
	}
	
	private List<Map<String, String>> setUDRExcel(
			List<Map<String, String>> listResData, 
			String result_type, 
			String res_type, Condition condition) {
		List<Map<Integer, String>> listDataFormat = traceDetailMapper.listDataFormat(condition, result_type, res_type);
		List<Map<String, String>> rows = new ArrayList<Map<String, String>>();
		
		int cntDataFormat = listDataFormat.size();
		
		String[] resData;

		for(Map<String, String> tmpRes: listResData) {
			resData = tmpRes.get("RES_DATA").split("\\|");
			Map<String, String> row = new HashMap<String, String>();
			
			for(int i = 0; i < resData.length && i < cntDataFormat ; i++) {
				if("msid".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("MSID", resData[i]);
				} else 
				if("ip_address".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("Framed IP", resData[i]);
				} else 
				if("acct_session_id".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("Session ID", resData[i]);
				} else 
				if("event_time".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("Event Time", resData[i]);
				} else 
				if("acct_input_octets".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("UP Size", resData[i]);
				} else 
				if("acct_output_octets".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("DOWN Size", resData[i]);
				} 
			}
			
			rows.add(row);
		}
		
		return rows;
	}
	
	private List<Map<String, String>> setRawUDRExcel(
			List<Map<String, String>> listResData, 
			String result_type, 
			String res_type, Condition condition) {
		List<Map<Integer, String>> listDataFormat = traceDetailMapper.listDataFormat(condition, result_type, res_type);
		List<Map<String, String>> rows = new ArrayList<Map<String, String>>();
		
		int cntDataFormat = listDataFormat.size();
		
		String[] resData;

		for(Map<String, String> tmpRes: listResData) {
			resData = tmpRes.get("RES_DATA").split("\\|");
			Map<String, String> row = new HashMap<String, String>();
			
			for(int i = 0; i < resData.length && i < cntDataFormat ; i++) {
				if("udr_type".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("UDR Type", resData[i]);
				} else
				if("msid".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("MSID", resData[i]);
				} else
				if("ip_address".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("Framed IP", resData[i]);
				} else 
				if("acct_session_id".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("Session ID", resData[i]);
				} else 
				if("event_time".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("Event Time", resData[i]);
				} else 
				if("acct_input_octets".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("UP Size", resData[i]);
				} else 
				if("acct_output_octets".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("DOWN Size", resData[i]);
				} 
			}
			
			rows.add(row);
		}
		
		return rows;
	}
	
	private List<Map<String, String>> setCDRExcel(
			List<Map<String, String>> listResData, 
			String result_type, 
			String res_type, Condition condition) {
		List<Map<Integer, String>> listDataFormat = traceDetailMapper.listDataFormat(condition, result_type, res_type);
		List<Map<String, String>> rows = new ArrayList<Map<String, String>>();
		
		int cntDataFormat = listDataFormat.size();
		
		String[] resData;

		for(Map<String, String> tmpRes: listResData) {
			resData = tmpRes.get("RES_DATA").split("\\|");
			Map<String, String> row = new HashMap<String, String>();
			
			for(int i = 0; i < resData.length && i < cntDataFormat ; i++) {
				if("service_type".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("Service Type", resData[i]);
				} else
				if("destination_ip".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("Destination IP", resData[i]);
				} else 
				if("start_time".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("Start Time", resData[i]);
				} else 
				if("end_time".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("End Time", resData[i]);
				} else 
				if("url".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("URL", resData[i]);
				} else 
				if("total_up_packet_size".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("Total UP", resData[i]);
				} else 
				if("total_down_packet_size".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("Total Down", resData[i]);
				} else 
				if("real_up_packet_size".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("Real UP", resData[i]);
				} else 
				if("real_down_packet_size".equals(listDataFormat.get(i).get("NAME"))) {// CDR Total Up
					row.put("Real Down", resData[i]);
				} 
			}
			
			rows.add(row);
		}
		
		return rows;
	}
}