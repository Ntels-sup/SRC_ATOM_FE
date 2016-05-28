<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script id="temperatureTmpl" type="text/x-tmpl">
{{each(key,item) msg}}
	{{if item.NAME=="CPU TEMP"}}
		{{each(k,v) item}}
		{{if k!="NAME" && k!="LIST"}}
		<tr>
        	<td>\${k}</td>
        	<td class="t_r">\${v.avg}</td>
        	<td class="t_r">\${v.max}</td>
	    	<td class="t_r">\${v.min}</td>
		</tr>
		{{/if}}
		{{/each}}
	{{/if}}
{{/each}}
</script>

<script id="cpuTmpl" type="text/x-tmpl">
{{each(key,item) msg}}
	{{if item.NAME=="CPU"}}
		{{each(k,v) item}}
		{{if k!="NAME" && k!="LIST"}}
		<tr>
        	<td>\${k}</td>
        	<td class="t_r">\${v.usage}</td>
        	<td class="t_r">\${v.user}</td>
	    	<td class="t_r">\${v.sys}</td>
    		<td class="t_r">\${v.idle}</td>
    		<td class="t_r">\${v.wait}</td>
		</tr>
		{{/if}}
		{{/each}}
	{{/if}}
{{/each}}				
</script>

<script id="diskTmpl" type="text/x-tmpl">
{{each(key,item) msg}}
	{{if item.NAME=="DISK"}}
		{{each(k,v) item}}
		{{if k!="NAME" && k!="LIST"}}
		<tr>
        	<td>\${k}</td>
        	<td class="t_r">\${v.usage}</td>
        	<td class="t_r">\${tmplNumberFormat(v.total)}</td>
	    	<td class="t_r">\${tmplNumberFormat(v.used)}</td>
    		<td class="t_r">\${tmplNumberFormat(v.free)}</td>
		</tr>
		{{/if}}
		{{/each}}
	{{/if}}
{{/each}}        
</script>

<script id="memoryTmpl" type="text/x-tmpl">
{{each(key,item) msg}}
	{{if item.NAME=="Memory"}}
		{{each(k,v) item}}
		{{if k!="NAME" && k!="LIST"}}
		<tr>
        	<td>\${k}</td>
        	<td class="t_r">\${v.usage}</td>
        	<td class="t_r">\${tmplNumberFormat(v.total)}</td>
	    	<td class="t_r">\${tmplNumberFormat(v.used)}</td>
    		<td class="t_r">\${tmplNumberFormat(v.free)}</td>
		</tr>
		{{/if}}
		{{/each}}
	{{/if}}
{{/each}}
</script>

<script id="queueTmpl" type="text/x-tmpl">
{{each(key,item) msg}}
	{{if item.NAME=="QUEUE"}}
		{{each(k,v) item}}
		{{if k!="NAME" && k!="LIST"}}
		<tr>
        	<td>\${k}</td>
        	<td class="t_r">\${v.usage}</td>
		</tr>
		{{/if}}
		{{/each}}
	{{/if}}
{{/each}}   
</script>

<script id="tablespaceTmpl" type="text/x-tmpl">
{{each(key,item) msg}}
	{{if item.NAME=="DB Table Space"}}
		{{each(k,v) item}}
		{{if k!="NAME" && k!="LIST"}}
		<tr>
        	<td>\${k}</td>
        	<td class="t_r">\${v.usage}</td>
        	<td class="t_r">\${tmplNumberFormat(v.total)}</td>
	    	<td class="t_r">\${tmplNumberFormat(v.used)}</td>
    		<td class="t_r">\${tmplNumberFormat(v.free)}</td>
		</tr>
		{{/if}}
		{{/each}}
	{{/if}}
{{/each}}  
</script>

<script id="nicTmpl" type="text/x-tmpl">
{{each(key,item) msg}}
	{{if item.NAME=="NIC"}}
		{{each(k,v) item}}
		{{if k!="NAME" && k!="LIST"}}
		<tr>
        	<td>\${k}</td>
        	<td>\${v.status}</td>
        	<td class="t_r">\${tmplNumberFormat(v.TX)}</td>
	    	<td class="t_r">\${tmplNumberFormat(v.RX)}</td>
		</tr>
		{{/if}}
		{{/each}}
	{{/if}}
{{/each}}       
</script>

<script type="text/javascript">
function tmplDateFormat( date ) {
// 	console.log( "[mirinae.maru] date : " + date );
// 	console.log( "[mirinae.maru] date : " + date );
// 	console.log( "[mirinae.maru] date : " + date );
// 	console.log( "[mirinae.maru] date : " + date );
// 	console.log( "[mirinae.maru] date : " + date );

	var patternDate = '${sessionUser.patternDate}'.replace("yyyy","yy");

// 	console.log( "[mirinae.maru] time pattern type : " + patternDate );
	
	var formatted = $.datepicker.formatDate( patternDate, new Date(date))
		+ date.substring(10, date.length);

// 	console.log( "[mirinae.maru] patternDate : " + patternDate );
	
// 	console.log( "[mirinae.maru] formatted date : " + formatted );
// 	console.log( "[mirinae.maru] formatted date : " + formatted );
// 	console.log( "[mirinae.maru] formatted date : " + formatted );
	
	return formatted;
}

function tmplNumberFormat( num ) {
	//console.log( "[mirinae.maru] num : " + num );
	return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
</script>

