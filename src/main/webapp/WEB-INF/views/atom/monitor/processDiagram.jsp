<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<link rel="stylesheet" href="/styles/style.css">
<script src="/scripts/jquery.1.11.2.min.js"></script>
<script src="/scripts/stringUtil.js"></script>
<script src="/scripts/modal.js"></script>
<script src="/scripts/jquery.alphanumeric.js"></script>
<script src="/scripts/jquery-ui.min.js"></script>
<jsp:include page="../config/networkmanager/flowdesign.jsp"/>
<script>
$(document).ready(function () {
	$(this).contextmenu(function() {
		return false;
	});
	initFlowDesign("#flowdesignDiv");
	var param = new Object();
	param.pkg_name = "${svc.pkg_name}";
	param.node_type = "${svc.node_type}";
	param.svc_no = "${svc.svc_no}";
	searchFlowDesign(true, param);
	g_data = {"readonly": true};
});

function loadProc(procList) {
	if (procList == null) {
		return;
	}
	for (var i=0;i<procList.length;i++) {
		var proc = procList[i];
		if (!isEmpty(proc.image_x) && !isEmpty(proc.image_y) && proc.svc_no == g_data.svc.svc_no) {
			var atomProc = new AtomProc ({
				path: proc.image_name,
				label: proc.proc_name,
				width: 62,
				height: 62,
				userData: proc,
				x: proc.image_x,
				y: proc.image_y,
				bgColor: proc.image_bgcolor
			});
			g_canvas.addFigure(atomProc);
			atomProc.toFront();
			$(atomProc.shape[0]).attr("filter", "url(#AtomNodeFilter)")
		}
	}
}
</script>
<div class="draw">
	<div id="flowdesignDiv" style="width:100%;height:100%;"></div>
</div>