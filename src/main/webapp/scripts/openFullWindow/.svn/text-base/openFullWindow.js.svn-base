var openPopupArray = [];

// 팝업창 열기
function openFullWindow(url, target) {
	if(target == null) {
		target = 'popup';
	}
	
	var Width=screen.availWidth;
	var Height=screen.availHeight;
	
	Width=Width-16;
	Height=Height-64;
	
	var newwin=window.open('', target, 
	'toolbar=no,location=no,directories=no,status=no,menubar=no,'+
	'scrollbars=1,resizable=no,copyhistory=1,width='+Width+','+
	'height='+Height+',top=0,left=0','replace');

	if (window.focus) {
		newwin.focus();
		newwin.scrollbars=true;
	}
	openPopupArray.push(newwin);
	var openForm = document.createElement("form");
	console.log(target);
	openForm.setAttribute("target", target);
	openForm.setAttribute("action", url);
	openForm.setAttribute("method", "post");
	openForm.submit();
}

function closeFullWindow(url, target) {
	if(target == null) {
		target = 'popup';
	}
	
	var closeForm = document.createElement("form");
	
	closeForm.setAttribute("target", target);
	closeForm.setAttribute("action", url);
	closeForm.setAttribute("method", "post");
	closeForm.submit();
}
