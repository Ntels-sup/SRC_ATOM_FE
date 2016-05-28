// check ip address
function isValidIpAddress(str) {
	return /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/.test(str);
}

//check ip bandwidth
function isValidIpBandWidth(str) {
	return /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|\*)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|\*)$/.test(str);
}

//check email
function isValidEmail(str){
	return /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i.test(str);
}

//check alpha or number
function isValidAlphaOrNum(str){
	return /^[A-Za-z0-9]+$/.test(str);
}

//check number or hyphen(-)
function isValidNumOrHyphen(str){
	return /^[0-9]{1}[0-9-]+$/.test(str);
}

// 알파벳 : a-z, A-Z
// 숫자 : 0 - 9
// 특수문자 : 언더바(_) 하이픈(-) 슬래쉬(/) 파이프(|)
function isValidName(str) {
	return /^[A-Za-z0-9\_\-\/\|]+$/.test(str);
}

// check natural number
// isValidNaturalNumber("111") -> true
// isValidNaturalNumber("011") -> false
// isValidNaturalNumber("abc") -> false
function isValidNaturalNumber(str) {
	return /^([0-9]|[1-9][0-9]*)$/.test(str);
}

function isValidNumber(str) {
	return /^[0-9]+$/.test(str);
}

// check color code
// ex) #ffffff
function isValidColorCode(str) {
	return /^\#[0-9a-fA-F]{6}$/.test(str);
}

function isEmpty(str) {
	var bRet = false;
	if (str == null || str == "") {
		bRet = true;
	}
	return bRet;
}

function nullCheck(str, replace) {
	if (replace == null) {
		replace = "";
	}
	if (isEmpty(str)) {
		return replace;
	}
	return str;
}

function getImagePath(str) {
	str = str.replace("url(\"", "").replace("\")", "");
	var idx = str.indexOf("/images/");
	str = str.substring(idx, str.length);
	return str;
}

function rgbToHexColor(colorval) {
	var parts = colorval.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
	delete(parts[0]);
	for (var i=1;i<=3;++i) {
		parts[i] = parseInt(parts[i]).toString(16);
		if (parts[i].length == 1) {
			parts[i] = '0' + parts[i];
		}
	}
	color = '#' + parts.join('');
	return color;
}

//숫자 타입에서 쓸 수 있도록 format() 함수 추가
Number.prototype.format = function() {
	if (this==0) return 0;
	var reg = /(^[+-]?\d+)(\d{3})/;
	var n = (this + '');
	while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
	return n;
};
 
// 문자열 타입에서 쓸 수 있도록 format() 함수 추가
String.prototype.format = function(){
	var num = parseFloat(this);
	if (isNaN(num)) return "0";
	return num.format();
};
