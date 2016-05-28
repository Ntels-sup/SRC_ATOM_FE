
//	---------------------------------------------------------------------------
//	jWebSocket Enterprise BPMN Client Plug-In
//	(C) Copyright 2012-2013 Innotrade GmbH, Herzogenrath Germany
//	Author: Alexander Schulze
//	---------------------------------------------------------------------------
jws.BPMNPlugIn={NS:jws.NS_BASE+".plugins.bpmn",aK:function(){return{ns:jws.BPMNPlugIn.NS};},bO:function(au,be,J){var aa=
this.checkConnected();if(0===aa.code){var G=this.aK();G.aX=be;G.alias=au;G.type='loadFile';this.sendToken(G,J);}return aa;},aq:
function(J){var aa=this.checkConnected();if(0===aa.code){var G=this.aK();G.type='getAvailableProcesses';this.sendToken(G,J);}
return aa;},am:function(bM,aS,J){var aa=this.checkConnected();if(0===aa.code){var G=this.aK();G.type='startProcessInstance';G.ak=aS;
G.key=bM;this.sendToken(G,J);}return aa;},bS:function(bM,J){var aa=this.checkConnected();if(0===aa.code){var G=this.aK();G.type=
'suspendProcess';G.key=bM;this.sendToken(G,J);}return aa;},bF:function(bM,J){var aa=this.checkConnected();if(0===aa.code){var G=
this.aK();G.type='getExecutionProcesses';G.key=bM;this.sendToken(G,J);}return aa;},bv:function(bM,J){var aa=this.checkConnected();
if(0===aa.code){var G=this.aK();G.type='getTasksByProcessInstance';G.key=bM;this.sendToken(G,J);}return aa;},bf:function(aj,ap,J){
var aa=this.checkConnected();if(0===aa.code){var G=this.aK();G.type='completeTask';G.ar=aj;G.bJ=ap;this.sendToken(G,J);}return aa;}}
;jws.oop.addPlugIn(jws.jWebSocketTokenClient,jws.BPMNPlugIn); 