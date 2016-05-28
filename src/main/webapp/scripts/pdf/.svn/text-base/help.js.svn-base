function help(){
	$.post('/atom/commonCode/helpBody', '', function(data) {
		if(data==null || data==undefined|| data=='' || data=='/help/null.pdf' || data=='/help/.pdf')return;
		openFullWindow(data, "_help_");
	});
}