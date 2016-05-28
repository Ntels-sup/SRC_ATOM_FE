package com.ntels.ncf.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import com.ntels.ncf.utils.MessageUtil;

public class PerPageControlTag extends BodyTagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6762304057183908836L;

	//private Logger logger = Logger.getLogger(this.getClass());

	private String page;
	private String perPage;
	private Integer totalCount;
	
	private final static String HEADER 
		= "  	<script type=\"text/javascript\">"
		+ "		$(document).ready(function() {"
		+ "			$(\"#page\").blur(function(){"
		+ "				var maxpage = Math.ceil(@totalCount@ / $(\"#perPage\").val()); "
	 	+ "         	if($(\"#page\").val() == null || $(\"#page\").val() == \"\") { "
//	 	+ "            		alert(\"Please enter a page number.\");"
	 	+ "					$(\"#page\").val(@page@); "	
		+ "         	}"
		+ "				if($(\"#page\").val() > maxpage){ "
		+ "						$(\"#page\").val(maxpage); "
		+ "				} "	
		+ "			});"
		+ "		});"
	    + "       function _fnIsNumeric(loc) { "
	    + "         if(loc.value != \"\" && !$.isNumeric(loc.value)) { "
		+ "            alert(\"Please enter only numbers.\");"
		+ "            loc.value = \"1\";"
		+ "            loc.focus();"
		+ "         }"
		+ "       } "
		+ "		  function _fnpressed(e, loc,totalCount)"
		+ "		  { "		
		+ "   		if(e.keyCode == 13) "
		+ "  		{"
	    + "         	if(loc.value == \"\" || !$.isNumeric(loc.value)) { "
//		+ "            alert(\"Please enter a page number.\");"
		+ "					$(\"#page\").val(@page@); "	
		+ "         	}"
		+ "				else { "
		+ "					var maxpage = Math.ceil(totalCount / $(\"#perPage\").val()); "
		+ "					if($(\"#page\").val() > maxpage){ "
		+ "						$(\"#page\").val(maxpage); "
		+ "					} "
		+ "					goSearch();"
		+ "				}"
		+ "   		} "
		+ "		  }"
	 	+ "       function _fnIsNull(totalCount) { "
	 	+ "         if($(\"#page\").val() == null || $(\"#page\").val() == \"\") { "
		+ "					$(\"#page\").val(@page@); "	
		+ "         }"
		+ "			else { "
		+ "					var maxpage = Math.ceil(totalCount / $(\"#perPage\").val()); "
		+ "					if($(\"#page\").val() > maxpage){ "
		+ "						$(\"#page\").val(maxpage); "
		+ "					} "		
		+ "				goSearch();"
		+ "			}"	
		+ "       } "
		+ "     </script>"
		+ "  	<div class=\"util\"><span><em>@totalCount@</em>row(s)</span> "
		+ "			<input type=\"hidden\" id=\"perPage\" name=\"perPage\" value=\"@perPage@\"/>"
		+ "			<p>"
		+ "				<select class=\"bottom\" id=\"selectPerPage\">";
	
	private final static String FOOTER 	
		= "				</select>"
		+ "		    </p>"
		+ "		</div>";
	
	public int doEndTag() throws JspException {
		
		//<spring:message code="label.common.perpage.text" />
		
		
		try {
			String line=MessageUtil.getMessage("label.common.perpage.text");
			String body = "";
			body = HEADER;
			body = body.replaceAll("@page@",page );
			body = body.replaceAll("@perPage@",perPage );
			body = body.replaceAll("@totalCount@",String.valueOf((totalCount < 0) ? 0: new java.text.DecimalFormat("#,###").format(totalCount)  ));
			body = body.replaceAll("@line@",line );
			
	    	BodyContent bodyContent = getBodyContent();
	    	String listString="";
	    	if(bodyContent!=null){
	    		String[] list = bodyContent.getString().split(",");
	    		for(int i=0;i<list.length;i++){
	    			if(list[i].trim().equals(perPage)){listString+=" <option value=\""+list[i].trim()+"\"Selected >"+list[i].trim()+" "+line+"</option>";}
	    			else{ listString+="					<option value=\""+list[i].trim()+"\">"+list[i].trim()+" "+line+"</option>";}
	    		}
	    	}
	    	body+=listString;
			body+=FOOTER;
			
//			logger.debug("PerPageControlTag ======>"+body);
			pageContext.getOut().print(body);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return SKIP_BODY;
	}

	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getPerPage() {
		return perPage;
	}
	public void setPerPage(String perPage) {
		this.perPage = perPage;
	}

	public Integer getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}
}
