function openModal(selector, option) {
	if (option == null) {
		option = new Object();
	}
	$(selector).modal(option);
	$("#simplemodal-container").draggable({
		handle: "h2"
	});
}

function closeModal() {
    $.modal.close();
}

/*
 * openConfirmModal("Message", "Description", function() {console.log("ok");}, function() {console.log("cancel")}, "OK", "Cancel");
 */
function openConfirmModal(sMessage, sDescription, fnOK, fnCancel, sOK, sCancel) {
	if (sMessage == null) {
		sMessage = "";
	}
	if (sDescription == null) {
		sDescription = "";
	}
	if (sOK == null) {
		sOK = "OK";
	}
	if (sCancel == null) {
		sCancel = "Cancel";
	}
	$("#confirmModalDiv").remove();
	var sHtml = "";
	sHtml += "<div id=\"confirmModalDiv\" style=\"display:none;\">\n";
	sHtml += "	<div class=\"popup alert\">\n";
	sHtml += "			<h4>"+sMessage+"</h4>\n";
	sHtml += "			<div class=\"pop_cont\">\n";
	sHtml += "				"+sDescription+"\n";
	sHtml += "			</div>\n";
	sHtml += "	        <div class=\"btn_area\">\n";
	sHtml += "	            <a href=\"#\"><button id=\"confirmModal_okButton\" type=\"button\" class=\"major\">"+sOK+"</button></a>\n";
	sHtml += "	            <a href=\"#\"><button id=\"confirmModal_cancelButton\" type=\"button\" >"+sCancel+"</button></a>\n";
	sHtml += "	        </div>\n";
	sHtml += "	</div>\n";
	sHtml += "</div>\n";
	$("body").append(sHtml);
	$("#confirmModal_cancelButton").click(function() {
		closeModal();
		if (fnCancel != null) {
			fnCancel.call();
		}
	});
	$("#confirmModal_okButton").click(function() {
		closeModal();
		if (fnOK != null) {
			fnOK.call();
		}
	});
	openModal("#confirmModalDiv");
}

/*
 * openAlertModal("Message", "Description", function() {console.log("ok");}, "OK");
 */
function openAlertModal(sMessage, sDescription, fnOK, sOK) {
	if (sMessage == null) {
		sMessage = "";
	}
	if (sDescription == null) {
		sDescription = "";
	}
	if (sOK == null) {
		sOK = "OK";
	}
	$("#alertModalDiv").remove();
	var sHtml = "";
	sHtml += "<div id=\"alertModalDiv\" style=\"display:none;\">\n";
	sHtml += "	<div class=\"popup alert\">\n";
	sHtml += "			<h4>"+sMessage+"</h4>\n";
	sHtml += "			<div class=\"pop_cont\">\n";
	sHtml += "				"+sDescription+"\n";
	sHtml += "			</div>\n";
	sHtml += "	        <div class=\"btn_area\">\n";
	sHtml += "	            <a href=\"#\"><button id=\"alertModal_okButton\" type=\"button\" class=\"major\">"+sOK+"</button></a>\n";
	sHtml += "	        </div>\n";
	sHtml += "	</div>\n";
	sHtml += "</div>\n";
	$("body").append(sHtml);
	$("#alertModal_okButton").click(function() {
		closeModal();
		if (fnOK != null) {
			fnOK.call();
		}
	});
	openModal("#alertModalDiv");
}