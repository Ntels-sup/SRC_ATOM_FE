	var eKeepAlive = null;
	var lWSC = null;
	var lURL;
		
	/* 웹소켓 초기화 */
	function initPage(url, type_name) {
		this.lURL=url;
		this.typeName = type_name;
		
		// 웹소켓 지원여부 
		if (window.WebSocket) {
			lWSC = new jws.jWebSocketJSONClient();
			
			connect();

		} else {
			var lMsg = jws.MSG_WS_NOT_SUPPORTED;
			console.log(lMsg);
		}
	}

	function connect() {
		
		if (lWSC.isConnected()) {
			console.log("Already connected.");
			return;
		}
		
		try {
			var lRes = lWSC.logon(lURL, jws.GUEST_USER_LOGINNAME, jws.GUEST_USER_PASSWORD, {
				// OnOpen callback
				OnOpen: function(aEvent) {},
				
				OnWelcome: function(aEvent)  {
					console.log("Server : " + lURL + " Connected...");
					//checkKeepAlive();
					login();
					return;
				},
				// OnReconnecting callback
				OnReconnecting: function(aEvent) {
					console.log("Re-establishing jWebSocket connection...");
				},
				// OnMessage callback
				OnMessage: function(aEvent, packet) {
					
					if (packet.type == "userlogin") {
						console.log("################");
						console.log(packet);
						console.log("################");
					} else if (packet.type != "welcome") {
						//console.log(aEvent);
						//console.log(packet);
						//console.log(packet.connect);
						//console.log(packet.messages);
						if (packet.PacketType == "NM_Stop") {
							fnDisconnectSocket("nm_stop"); 
						} else if (packet.PacketType == "NM_Run") {
							fnNMConnectOk();
						} else {							
							fnCommonMessage(packet.command, packet.messages);							
						}						
					}
					
				},
				// OnClose callback
				OnClose: function(aEvent) {
					//console.log("OnClose");
					fnDisconnectSocket("client_close"); 
					//reconnect(); //재연결한다.
				}

			});
		} catch (ex) {
			console.log("Exception: " + ex.message);
		}
	}

	/**
	 * 현재 사용 안함
	 */
	function fnWebSocketKeepAlive() {
		console.log("websocketKeepAlive");
		lWSC.startKeepAlive({interval: 30000}); //30초마다
	}

	var sequenceId = null;

	function login(){

		if(lWSC.isConnected()) {
			var lToken = {	ns: "com.ntels.application"
			              , type: "userlogin"
						 };
			lWSC.sendToken(lToken, {
				OnResponse: function(aToken) {
					//console.log(aToken);
					if (aToken.code == 0) {
						sequenceId = aToken.sequenceId;
						try {
							fnPreparedSocket();
						} catch (e) {
							console.log(e.message);
						}						
					}
				}
			});
		} else {
			console.log("function login() : Not connected.");
		}
	}
	
	/**
	 * 
	 * @param command 
	 * @param destinationNodeId  (null 인경우 atom 노드를 이용한다)
	 * @param destinationProcessId
	 * @param JSON_data
	 */
	function CommandREQ(command, destinationNodeId, destinationProcessId, JSON_data) {
		var param = new Object();
		param.type = "commandREQ";
		param.ns = "com.ntels.application";
		param.command = command;
		param.destinationNodeId = destinationNodeId;		
		param.destinationProcessId = destinationProcessId;
		param.messages = JSON_data;
		param.sequenceId = sequenceId;
		
		//console.log("요청 "+command);
		//console.log(param);
		
		if(lWSC.isConnected()) lWSC.sendToken(param);
	}
	