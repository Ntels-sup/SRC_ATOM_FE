<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page import="com.ntels.avocado.domain.common.definitions.CodeDefinitions" %>
<script src="/scripts/draw2d/shifty.js"></script>
<script src="/scripts/draw2d/raphael.js"></script>
<script src="/scripts/draw2d/jquery.autoresize.js"></script>
<script src="/scripts/draw2d/jquery-touch_punch.js"></script>
<script src="/scripts/draw2d/jquery.contextmenu.js"></script>
<script src="/scripts/draw2d/rgbcolor.js"></script>
<script src="/scripts/draw2d/canvg.js"></script>
<script src="/scripts/draw2d/Class.js"></script>
<script src="/scripts/draw2d/json2.js"></script>
<script src="/scripts/draw2d/pathfinding-browser.min.js"></script>
<script src="/scripts/draw2d/draw2d.js"></script>
<style>
#_atomLoadingDiv{z-index:6;opacity:1;position:relative;overflow:auto;width:100%;height:100%;margin:0px;padding:0px;border:none;text-align:left;}
#_atomFlowDesignDivWrapper{opacity:0;position:relative;overflow:auto;width:100%;height:100%;margin:0px;padding:0px;border:none;text-align:left;min-width:300px;min-height:100px;}
#_atomMinimapDivWrapper{position: absolute;left:calc(100% - 221px);top:calc(100% - 171px);width:200px;height:150px;margin:0px;padding:0px;border:1px solid rgb(0, 0, 0);overflow: hidden;text-align:left;}
#_atomMinimapDivWrapper.on{left:calc(100% - 531px);transition-duration:0.4s;}
#_atomMinimapDivWrapper.off{display:none !important;transition-duration:0.4s;}
#linkedNodeListDiv > div > span{width:44px;}
.main_content{margin-top:0px;margin:0px 0px 0px 0px;width:100%;}
.list .tbl_update td{overflow:hidden;text-overflow:ellipsis;}
.draw .properties #color6 + label:before {background:#a1a1a1;}
.draw .properties #color7 + label:before {background:#8ebf7c;}
.draw .properties #color8 + label:before {background:#74bed7;}
.draw .properties #color9 + label:before {background:#74a5d6;}
.draw .properties #color10 + label:before {background:#8f8fbf;}
.draw .properties #color11 + label:before {background:#8dbd13;}
.draw .properties #color12 + label:before {background:#3fba13;}
.draw .properties #color13 + label:before {background:#09b8b2;}
.draw .properties #color14 + label:before {background:#00a8f0;}
.draw .properties #color15 + label:before {background:#668cff;}
.draw .properties #color16 + label:before {background:#637599;}
.draw .properties #color17 + label:before {background:#7474a6;}
.draw .properties #color18 + label:before {background:#836b99;}
.draw .properties #color19 + label:before {background:#8c7377;}
.draw .properties #color20 + label:before {background:#7a756e;}
.draw .properties #icon1 + label:before {background-image:url('/images/icon/node_ap.svg');}
.draw .properties #icon2 + label:before {background-image:url('/images/icon/node_lb.svg');}
.draw .properties #icon3 + label:before {background-image:url('/images/icon/node_ocs.svg');}
.draw .properties #icon4 + label:before {background-image:url('/images/icon/node_ofcs.svg');}
.draw .properties #icon5 + label:before {background-image:url('/images/icon/node_tm.svg');}
.draw .properties #icon6 + label:before {background-color:#aaaaaa;background-image:url('/images/icon/link_bss.svg');}
.draw .properties #icon7 + label:before {background-color:#aaaaaa;background-image:url('/images/icon/link_cscf.svg');}
.draw .properties #icon8 + label:before {background-color:#aaaaaa;background-image:url('/images/icon/link_pgw.svg');}
.draw .properties #icon9 + label:before {background-color:#aaaaaa;background-image:url('/images/icon/link_tas.svg');}
.draw .properties #icon10 + label:before {background-color:#aaaaaa;background-image:url('/images/icon/link_ums.svg');}
.draw .properties #icon11 + label:before {background-image:url('/images/icon/p_agg.svg');}
.draw .properties #icon12 + label:before {background-image:url('/images/icon/p_ass.svg');}
.draw .properties #icon13 + label:before {background-image:url('/images/icon/p_cnv.svg');}
.draw .properties #icon14 + label:before {background-image:url('/images/icon/p_crr.svg');}
.draw .properties #icon15 + label:before {background-image:url('/images/icon/p_crt.svg');}
.draw .properties #icon16 + label:before {background-image:url('/images/icon/p_dco.svg');}
.draw .properties #icon17 + label:before {background-image:url('/images/icon/p_ddp.svg');}
.draw .properties #icon18 + label:before {background-image:url('/images/icon/p_dlb.svg');}
.draw .properties #icon19 + label:before {background-image:url('/images/icon/p_ftt.svg');}
.draw .properties #icon20 + label:before {background-image:url('/images/icon/p_gco.svg');}
.draw .properties #icon21 + label:before {background-image:url('/images/icon/p_glb.svg');}
.draw .properties #icon22 + label:before {background-image:url('/images/icon/p_nma.svg');}
.draw .properties #icon23 + label:before {background-image:url('/images/icon/p_nrd.svg');}
.draw .properties #icon24 + label:before {background-image:url('/images/icon/p_nwt.svg');}
.draw .properties #icon25 + label:before {background-image:url('/images/icon/p_par.svg');}
.draw .properties #icon26 + label:before {background-image:url('/images/icon/p_rtr.svg');}
.draw .properties #icon27 + label:before {background-image:url('/images/icon/p_spl.svg');}
</style>
<!-- svg 필터 (shadow 효과) -->
<svg height="140" width="140" style="position:absolute;left:-1000px;">
	<defs>
		<filter id="AtomPkgFilter">
			<feOffset in="SourceAlpha" dx="0" dy="1" result="AtomPkgOffset" />
			<feGaussianBlur in="AtomPkgOffset" stdDeviation="2"  result="AtomPkgBlur"/>
			<feColorMatrix in="AtomPkgBlur" type="matrix" values="0 0 0 0   0
				0 0 0 0   0 
				0 0 0 0   0 
				0 0 0 .3 0" result="AtomPkgColorMatrix"/>
			<feMerge>
				<feMergeNode in="AtomPkgColorMatrix" />
				<feMergeNode in="SourceGraphic" />
			</feMerge>
		</filter>
		<filter id="AtomNodeFilter" x="-10" y="-10" width="70" height="70">
			<feOffset in="SourceAlpha" dx="0" dy="4" result="AtomNodeOffset" />
			<feGaussianBlur in="AtomNodeOffset" stdDeviation="5"  result="AtomNodeBlur"/>
			<feColorMatrix in="AtomNodeBlur" type="matrix" values="0 0 0 0   0
				0 0 0 0   0 
				0 0 0 0   0 
				0 0 0 .2 0" result="AtomNodeColorMatrix"/>
			<feMerge>
				<feMergeNode in="AtomNodeColorMatrix" />
				<feMergeNode in="SourceGraphic" />
			</feMerge>
		</filter>
		<filter id="AtomCountFilter">
			<feOffset in="SourceAlpha" dx="0" dy="2" result="AtomCountOffset" />
			<feGaussianBlur in="AtomCountOffset" stdDeviation="3"  result="AtomCountBlur"/>
			<feColorMatrix in="AtomCountBlur" type="matrix" values="0 0 0 0   0
				0 0 0 0   0 
				0 0 0 0   0 
				0 0 0 .2 0" result="AtomCountColorMatrix"/>
			<feMerge>
				<feMergeNode in="AtomCountColorMatrix" />
				<feMergeNode in="SourceGraphic" />
			</feMerge>
		</filter>
	</defs>
</svg> 
<script>
// 전역변수 선언
var g_canvas = null; // 캔버스 draw2d 오브젝트를 저장하는 변수
var g_minimap = null; // 미니맵 draw2d 오브젝트를 저장하는 변수
var g_data = null; // DB 조회후 결과값을 저장하는 변수
var g_bMinimapClick = false; // 미니맵을 클릭했을 때 사용되는 변수(미니맵 클릭시 화면이 스크롤 되는데 이 때 onScroll 이벤트를 또 호출하지 않기 위함)
var g_bLoaded = false; // 로딩이 완료되었는지 판단하는 변수
var g_param = null; // DB 조회시 파라미터를 저장하는 변수
var g_bResizeProc = true; // resize 이벤트를 실행할지 안할지 판단하기 위한 변수 (모니터링 화면에서 사용됨)
var g_bChanged = false; // 변경 내역이 있는지 체크하기 위한 변수

// Common Code Variables
var LINE_OBJECT_TYPE_PACKAGE = "<%= CodeDefinitions.LINE_OBJECT_TYPE_PACKAGE %>";
var LINE_OBJECT_TYPE_NODE = "<%= CodeDefinitions.LINE_OBJECT_TYPE_NODE %>";
var LINE_OBJECT_TYPE_PROCESS = "<%= CodeDefinitions.LINE_OBJECT_TYPE_PROCESS %>";
var LINE_OBJECT_TYPE_BATCHJOB = "<%= CodeDefinitions.LINE_OBJECT_TYPE_BATCHJOB %>";

var LINE_TYPE_NETWORK = "<%= CodeDefinitions.LINE_TYPE_NETWORK %>";
var LINE_TYPE_PROCESS = "<%= CodeDefinitions.LINE_TYPE_PROCESS %>";
var LINE_TYPE_BATCHJOB = "<%= CodeDefinitions.LINE_TYPE_BATCHJOB %>";

// draw2d 캔버스를 JSON 문자열로 추출한다.
function getDraw2dJson() {
	var sRet = "";
	var writer = new draw2d.io.json.Writer();
	writer.marshal(g_canvas, function(json) {
		sRet = JSON.stringify(json, null, 2);
	});
	return sRet;
}

// Port(연결점)
var AtomPort = draw2d.HybridPort.extend({
	NAME: "AtomPort",
	init: function(attr, setter, getter) {
		this._super(attr, setter, getter);
		if (attr != null) {
			this.setName(attr.name);
		}
		if (g_data.readonly) {
			// 모니터링 화면에서는 안보이게 처리
			this.setAlpha(0);
		} else {
			// 편집 화면에서는 반투명 처리
			// 마우스오버시 선명해졌다가(onMouseEnter) 마우스아웃시 다시 반투명해짐(onMouseLeave)
			this.setAlpha(0.5);
		}
		this.setWidth(3);
		this.setStroke(1);
		this.setColor(new draw2d.util.Color(31, 30, 52));
		this.setBackgroundColor("#ffffff");
		this.useGradient = false;
	},
	onConnect: function(connection) {
		this._super(connection);
		var canvas = this.getCanvas();
		if (g_bLoaded && canvas != null && canvas.canvasId == g_canvas.canvasId) {
			g_bChanged = true;
		}
	},
	onMouseEnter: function() {
		if (!g_data.readonly) {
			this.setAlpha(1);
		}
	},
	onMouseLeave: function() {
		if (!g_data.readonly) {
			this.setAlpha(0.5);
		}
	},
	onDrop: function(dropTarget, x, y, shiftKey, ctrlKey) {
		if (!(dropTarget instanceof draw2d.Port)) {
    		return;
    	}
 
    	var request = new draw2d.command.CommandType(draw2d.command.CommandType.CONNECT);
        request.canvas = this.parent.getCanvas();
        request.source = dropTarget;
        request.target = this;
        var command = this.createCommand(request);
        
        if(command!==null) {
           // this.parent.getCanvas().getCommandStack().execute(command);
           command.execute();
        }
        this.setGlow(false);
	}
});

// Locator: draw2d 오브젝트에 자식 오브젝트를 추가할 때 자식 오브젝트의 위치를 지정해주는 오브젝트
// 패키지명 배치를 위한 Locator
var AtomPkgLocator = draw2d.layout.locator.Locator.extend({
	NAME: "AtomPkgLocator",
	init: function() {
		this._super();
	},
	relocate: function(index, target) {
		var parent = target.getParent();
		var boundingBox = parent.getBoundingBox();
		target.setPosition(5, 5);
	}
});

// draw2d 에서 Text 출력을 위한 오브젝트
var AtomLabel = draw2d.shape.basic.Label.extend({
	NAME: "AtomLabel",
	init: function(attr, setter, getter) {
		this._super(attr, setter, getter);
		this.setSelectable(false);
		this.setStroke(0);
		var fontSize = 12;
		if (attr != null) {
			fontSize = attr.fontSize;
			if (fontSize == null) {
				fontSize = 12;
			}
		}
		this.setFontSize(fontSize);
	},
	onDoubleClick: function() {
		this.parent.onDoubleClick();
	},
	onContextMenu: function() {
		this.parent.onContextMenu();
	}
});

// 윈형 오브젝트
var AtomCircle = draw2d.shape.basic.Circle.extend({
	NAME: "AtomCircle",
	init: function(attr, setter, getter) {
		this._super(attr, setter, getter);
	},
	getPersistentAttributes: function() {
		var memento = this._super();

		memento.labels = [];
		memento.ports = [];

		this.getPorts().each(function(i, port) {
			memento.ports.push({
				name: port.getName(),
				port: port.NAME,
				locator: port.getLocator().NAME
			});
		});

		this.children.each(function(i, e) {
			if (e instanceof AtomLabel) {
				memento.labels.push({
					id: e.figure.getId(),
					label: e.figure.getText(),
					locator: e.locator.NAME
				});
			}
		});
		return memento;
	},
	setPersistentAttributes: function(memento) {
		this._super(memento);
		this.setUserData(memento.userData);

		return this;
	},
	onContextMenu: function() {
		this.parent.onContextMenu();
	},
	onDoubleClick: function() {
		this.parent.onDoubleClick();
	}
});

// Port 를 4개 가지고있는 원형 오브젝트
var AtomCircleWP = AtomCircle.extend({
	NAME: "AtomCircleWP",
	init: function(attr, setter, getter) {
		this._super(attr, setter, getter);
		var topPort = new AtomPort({
			name: 0
		});
		this.addPort(topPort, new draw2d.layout.locator.TopLocator());

		var leftPort = new AtomPort({
			name: 1
		});
		this.addPort(leftPort, new draw2d.layout.locator.LeftLocator());

		var bottomPort = new AtomPort({
			name: 2
		});
		this.addPort(bottomPort, new draw2d.layout.locator.BottomLocator());

		var rightPort = new AtomPort({
			name: 3
		});
		this.addPort(rightPort, new draw2d.layout.locator.RightLocator());
	}
});

// 사각형 오브젝트
var AtomRectangle = draw2d.shape.basic.Rectangle.extend({
	NAME: "AtomRectangle",
	init: function(attr, setter, getter) {
		this._super(attr, setter, getter);
	},
	getPersistentAttributes: function() {
		var memento = this._super();

		memento.labels = [];
		memento.ports = [];

		this.getPorts().each(function(i, port) {
			memento.ports.push({
				name: port.getName(),
				port: port.NAME,
				locator: port.getLocator().NAME
			});
		});

		this.children.each(function(i, e) {
			if (e instanceof AtomLabel) {
				memento.labels.push({
					id: e.figure.getId(),
					label: e.figure.getText(),
					locator: e.locator.NAME
				});
			}
		});
		return memento;
	},
	setPersistentAttributes: function(memento) {
		this._super(memento);
		this.setUserData(memento.userData);

		return this;
	},
	onContextMenu: function() {
		// this.parent.onContextMenu();
	},
	onDoubleClick: function() {
		// this.parent.onDoubleClick();
	}
});

// 포트를 4개 가지고 있는 사각형 오브젝트
var AtomRectangleWP = AtomRectangle.extend({
	NAME: "AtomRectangleWP",
	init: function(attr, setter, getter) {
		this._super(attr, setter, getter);

		var topPort = new AtomPort({
			name: 0
		});
		this.addPort(topPort, new draw2d.layout.locator.TopLocator());

		var leftPort = new AtomPort({
			name: 1
		});
		this.addPort(leftPort, new draw2d.layout.locator.LeftLocator());

		var bottomPort = new AtomPort({
			name: 2
		});
		this.addPort(bottomPort, new draw2d.layout.locator.BottomLocator());

		var rightPort = new AtomPort({
			name: 3
		});
		this.addPort(rightPort, new draw2d.layout.locator.RightLocator());
	}
});

// 패키지 오브젝트(Network Manager)
var AtomPkg = AtomRectangle.extend({
	NAME: "AtomPkg",
	type: "<spring:message code="label.configuration.networkmanager.package.text"/>",
	init: function(attr, setter, getter) {
		this._super(attr, setter, getter);
		this.setResizeable(true);
		this.setAlpha(0.2);
		this.setColor(this.getBackgroundColor().darker(0.3).hash());
		this.setRadius(5);
		this.setStroke(2);

		if (attr != null) {
			var atomLabel = new AtomLabel({
				text: attr.label,
				bold: true,
				fontSize: 13,
				fontColor: "#2a3139"
			});
			this.add(atomLabel, new AtomPkgLocator(this));
			this.atomLabel = atomLabel;
		}
	},
	setIconPath: function(path) {
		this.atomIcon.setPath(path);
	},
	setPersistentAttributes: function(memento) {
		this._super(memento);
		this.setUserData(memento.userData);

		var atomLabel = new AtomLabel({
			text: memento.label,
			bold: true,
			fontSize: 13,
			fontColor: "#2a3139"
		});
		this.add(atomLabel, new AtomPkgLocator(this));
		this.atomLabel = atomLabel;
	},
	getPersistentAttributes: function() {
		var memento = this._super();
		memento.label = this.atomLabel.getText();
		return memento;
	},
	onDoubleClick: function() {
		g_canvas.setCurrentSelection(this);
		var userData = this.userData;
		var pkg = userData;
		pkg.image_x = this.getX();
		pkg.image_y = this.getY();
		pkg.image_width = this.getWidth();
		pkg.image_height = this.getHeight();
		pkg.image_bgcolor = this.getBackgroundColor().hashString;
		openPkgModal(pkg, false);
	},
	onContextMenu: function() {
		showContextMenu(this);
	},
	onDragStart: function() {
		var ret = this._super();
		this.startX = this.getX();
		this.startY = this.getY();
		return ret;
	},
	onDrag: function(dx, dy, dx2, dy2) {
		var ret = this._super(dx, dy, dx2, dy2);
		onDragProc(this);
		return ret;
	},
	onDragEnd: function() {
		// 패키지 클릭시 우측에 해당 패키지 외의 다른 오브젝트의 속성창이 떠있을 경우 속성창을 닫는다.
		var ret = this._super();
		var bClose = true;
		if ($("#pkgModalDiv.on").length > 0) {
			var pkg = $("#pkgModalDiv.on").data("pkg");
			if (pkg.pkg_name == this.userData.pkg_name) {
				bClose = false;
			}
		}
		if (bClose) {
			hideDetailDiv();
		}
		
		onDragEndProc(this);
		
		return ret;
	}
});

// draw2d 오브젝트를 드래그 종료시 호출된다.
// Undo, Redo 를 위해 드래그하기 전위 좌표와 드래그 종료후의 좌표를 commandStack 에 추가한다.
// CommandStack: draw2d 에서 Undo, Redo 를 위한 오브젝트
function onDragEndProc(figure) {
	var mFigure = g_minimap.getFigure(figure.id);
	var mCommandMove = new draw2d.command.CommandMove(mFigure);
	mCommandMove.setStartPosition(figure.startX, figure.startY);
	mCommandMove.setPosition(figure.x, figure.y);
	g_minimap.commandStack.execute(mCommandMove);
}

// draw2d 오브젝트를 드래그시 호출된다.
// 캔버스의 오브젝트를 드래그시 미니맵에서 같은 오브젝트를 찾아 위치를 변경한다.
function onDragProc(figure) {
	if (figure.getX() < 0) {
		figure.setX(0);
	}
	if (figure.getY() < 0) {
		figure.setY(0);
	}
	if (figure.getX() > g_canvas.getWidth() - figure.getWidth()) {
		figure.setX(g_canvas.getWidth() - figure.getWidth());
	}
	if (figure.getY() > g_canvas.getHeight() - figure.getHeight()) {
		figure.setY(g_canvas.getHeight() - figure.getHeight());
	}
	var atomObj = g_minimap.getFigure(figure.id);
	atomObj.setX(figure.getX());
	atomObj.setY(figure.getY());
	g_bChanged = true;
}

// 이미지 오브젝트
var AtomImage = draw2d.shape.basic.Image.extend({
	NAME: "AtomImage",
	init: function(attr, setter, getter) {
		this._super(attr, setter, getter);
		this.setResizeable(false);
	},
	getPersistentAttributes: function() {
		var memento = this._super();

		memento.labels = [];
		memento.ports = [];

		this.getPorts().each(function(i, port) {
			memento.ports.push({
				name: port.getName(),
				port: port.NAME,
				locator: port.getLocator().NAME
			});
		});

		this.children.each(function(i, e) {
			memento.labels.push({
				id: e.figure.getId(),
				label: e.figure.getText(),
				locator: e.locator.NAME
			});
		});
		return memento;
	},
	setPersistentAttributes: function(memento) {
		this._super(memento);
		this.setUserData(memento.userData);

		return this;
	}
});

// 아이콘 오브젝트
var AtomIcon = AtomImage.extend({
	NAME: "AtomIcon",
	init: function(attr, setter, getter) {
		this._super(attr, setter, getter);
		this.setResizeable(false);
		this.setSelectable(false);
	},
	onDoubleClick: function() {
		this.parent.onDoubleClick();
	},
	onContextMenu: function() {
		this.parent.onContextMenu();
	}
});

// 포트를 4개 가지고 있는 이미지 오브젝트
var AtomImageWP = AtomImage.extend({
	NAME: "AtomImageWP",
	init: function(attr, setter, getter) {
		this._super(attr, setter, getter);

		var topPort = new AtomPort({
			name: 0
		});
		this.addPort(topPort, new draw2d.layout.locator.TopLocator());

		var leftPort = new AtomPort({
			name: 1
		});
		this.addPort(leftPort, new draw2d.layout.locator.LeftLocator());

		var bottomPort = new AtomPort({
			name: 2
		});
		this.addPort(bottomPort, new draw2d.layout.locator.BottomLocator());

		var rightPort = new AtomPort({
			name: 3
		});
		this.addPort(rightPort, new draw2d.layout.locator.RightLocator());

		if (attr != null) {
			var atomLabel = new AtomLabel({
				text: attr.label
			});
			this.add(atomLabel, new draw2d.layout.locator.CenterLocator(this));
		}
	}
});

// 프로세스 오브젝트(Process Manager)
var AtomProc = AtomCircleWP.extend({
	NAME: "AtomProc",
	WIDTH: 55,
	HEIGHT: 55,
	type: "<spring:message code="label.configuration.processmanager.process.text"/>",
	init: function(attr, setter, getter) {
		this._super(attr, setter, getter);
		this.setWidth(this.WIDTH);
		this.setStroke(0);
		this.setResizeable(false);

		if (attr == null) {
			attr = new Object();
		}
		var userData = attr.userData;
		if (userData == null) {
			userData = new Object();
		}
		var image_uuid = userData.image_uuid;
		if (image_uuid != null && image_uuid != "") {
			this.setId(image_uuid);
		} else {
			userData.image_uuid = this.id;
		}

		var atomLabel = new AtomLabel({
			text: attr.label
		});
		this.add(atomLabel, new draw2d.layout.locator.BottomLocator(this));
		this.atomLabel = atomLabel;

		var atomIcon = new AtomIcon({
			width: 31.5,
			height: 31.5,
			path: attr.path
		});
		this.add(atomIcon, new draw2d.layout.locator.CenterLocator(this));
		this.atomIcon = atomIcon;
	},
	setPersistentAttributes: function(memento) {
		this._super(memento);
		this.setUserData(memento.userData);
		
		var atomLabel = new AtomLabel({
			text: memento.label
		});
		this.add(atomLabel, new draw2d.layout.locator.BottomLocator(this));
		this.atomLabel = atomLabel;
		
		var atomIcon = new AtomIcon({
			width: 31.5,
			height: 31.5,
			path: memento.icon_path
		});
		this.add(atomIcon, new draw2d.layout.locator.CenterLocator(this));
		this.atomIcon = atomIcon;
		return this;
	},
	getPersistentAttributes: function() {
		var memento = this._super();
		memento.label = this.atomLabel.getText();
		memento.icon_path = this.atomIcon.getPath();
		return memento;
	},
	onDoubleClick: function() {
		g_canvas.setCurrentSelection(this);
		var userData = this.userData;
		var proc = userData;
		proc.image_x = this.getX();
		proc.image_y = this.getY();
		openProcModal(proc, false);
	},
	onContextMenu: function() {
		showContextMenu(this);
	},
	onDragStart: function() {
		this._super();
		this.startX = this.getX();
		this.startY = this.getY();
		return true;
	},
	onDrag: function(dx, dy, dx2, dy2) {
		var ret = this._super(dx, dy, dx2, dy2);
		onDragProc(this);
		return ret;
	},
	onDragEnd: function() {
		// 프로세스 클릭시 우측에 해당 프로세스 외의 다른 오브젝트의 속성창이 떠있을 경우 속성창을 닫는다.
		var ret = this._super();
		var bClose = true;
		if ($("#procModalDiv.on").length > 0) {
			var proc = $("#procModalDiv.on").data("proc");
			if (proc.proc_name == this.userData.proc_name) {
				bClose = false;
			}
		}
		if (bClose) {
			hideDetailDiv();
		}
		
		onDragEndProc(this);
		
		return ret;
	}
});

// draw2d 오브젝트에 마우스 우클릭시 호출된다.
function showContextMenu(figure) {
	var bContext = false;
	var bNode = false;
	if (g_data.readonly) {
		if (figure instanceof AtomNode) {
			bNode = true;
		}
	} else {
		bContext = true;
	}
	if (!bContext && !bNode) {
		return;
	}
	g_canvas.setCurrentSelection(figure);
	$("#_atomDroppableDiv").css("background", "");
	$("#_atomDroppableDiv").show();
	var left = event.layerX - 20;
	var top = event.layerY - 20;
	var sHtml = "";
	sHtml += "<ul id=\"_atomContextMenuDiv\" class=\"context-menu-list context-menu-root\" style=\"display:none;left:"+left+"px;top:"+top+"px;\">";
	if (bNode) {
		var userData = figure.userData;
		if (userData.internal_yn == "Y" && userData.scale_yn == "Y") {
			for (var i=0;i<g_data.allNodeList.length;i++) {
				var node = g_data.allNodeList[i];
				if (node.pkg_name == userData.pkg_name && node.node_type == userData.node_type) {
					sHtml += "	<li class=\"context-menu-item context-menu-visible\" onclick=\"javascript:showProcessDiagram('"+node.pkg_name+"', '"+node.node_type+"', '"+node.node_no+"');\"><span><spring:message code="label.configuration.networkmanager.nodemonitoring.text"/> ("+node.node_name+")</span></li>";
				}
			}
		} else {
			for (var i=0;i<g_data.allNodeList.length;i++) {
				var node = g_data.allNodeList[i];
				if (node.pkg_name == userData.pkg_name && node.node_type == userData.node_type && node.node_name == userData.node_name) {
					sHtml += "	<li class=\"context-menu-item context-menu-visible\" onclick=\"javascript:showProcessDiagram('"+node.pkg_name+"', '"+node.node_type+"', '"+node.node_no+"');\"><span><spring:message code="label.configuration.networkmanager.nodemonitoring.text"/> ("+userData.node_name+")</span></li>";
				}
			}
		}
		sHtml += "	<li class=\"context-menu-item context-menu-visible\" onclick=\"hideContextMenu();\"><span><spring:message code="label.configuration.networkmanager.takeover.text"/></span></li>";
		sHtml += "	<li class=\"context-menu-item context-menu-visible\" onclick=\"hideContextMenu();\"><span><spring:message code="label.common.cancel"/></span></li>";
	}
	if (bContext) {
		sHtml += "	<li id=\"modifyButton\" class=\"context-menu-item context-menu-visible\"><span><spring:message code="label.common.modify"/></span></li>";
		sHtml += "	<li id=\"deleteButton\" class=\"context-menu-item context-menu-visible\"><span><spring:message code="label.common.delete"/></span></li>";
	}
	sHtml += "</ul>";
	$("#_atomDroppableDiv").append(sHtml);
	$("#_atomContextMenuDiv").slideDown();
	$("#_atomContextMenuDiv").mouseleave(function() {
		hideContextMenu();
	});
	if (bContext) {
		$("#_atomContextMenuDiv #modifyButton").click(function(e) {
			var functionName = "open" + figure.NAME.replace("Atom", "") + "Modal(figure.userData)";
			eval(functionName);
		});
		$("#_atomContextMenuDiv #deleteButton").click(function() {
			confirmDeleteFigure(figure);
			hideContextMenu();
		});
	}
}

// draw2d 오브젝트 삭제시 호출된다.
function confirmDeleteFigure(figure) {
	var message = "";
	message += "<spring:message code="msg.configuration.networkmanager.deletefigure.front"/> "+figure.type;
	if (figure.atomLabel != null) {
		message += " \""+figure.atomLabel.text+"\"";
	}
	message += "<spring:message code="msg.configuration.networkmanager.deletefigure.back"/>";
	openConfirmModal("<spring:message code="msg.configuration.networkmanager.warning.text"/>", message, function() {deleteFigure(figure);});
}

// draw2d 오브젝트를 삭제한다.
function deleteFigure(figure) {
	var id = figure.id;
	hideDetailDiv();
	var commandDelete = new draw2d.command.CommandDelete(figure);
	g_canvas.commandStack.execute(commandDelete);
	
	var mFigure = g_minimap.getFigure(id);
	var mCommandDelete = new draw2d.command.CommandDelete(mFigure);
	g_minimap.commandStack.execute(mCommandDelete);
	
	resetDraggableElementsAttr();
	updateUndoRedoButton();
	g_bChanged = true;
}

// 마우스 우클릭 메뉴를 삭제한다.
function hideContextMenu() {
	$("#_atomContextMenuDiv").remove();
	$("#_atomDroppableDiv").hide();
	$("#_atomDroppableDiv").css("background", "rgba(255,255,255,0.5)");
}

// 노드 카운터 오브젝트를 배치하기 위한 Locator
var AtomCountLocator = draw2d.layout.locator.Locator.extend({
	NAME: "AtomCountLocator",
	init: function(top) {
		this._super();
		this.top = top;
	},
	relocate: function(index, target) {
		var parent = target.getParent();
		var boundingBox = parent.getBoundingBox();

		var targetBoundingBox = target.getBoundingBox();
		var x = boundingBox.w - targetBoundingBox.w;
		var y = 0;
		target.setPosition(x, y);
	}
});

// 노드 카운터 오브젝트
// 모니터링 화면에서 노드의 
// INTERNAL_YN = 'Y'
// SCALE_YN = 'Y'
// 일 경우 노드의 갯수가 표시된다.
var AtomCount = AtomCircle.extend({
	NAME: "AtomCount",
	WIDTH: 24,
	HEIGHT: 24,
	init: function(attr, setter, getter) {
		this._super(attr, setter, getter);
		this.setWidth(this.WIDTH);
		this.setResizeable(false);
		this.setStroke(0);
		if (attr == null) {
			attr = new Object();
		}
		var atomLabel = new AtomLabel({
			text: attr.label,
			fontSize: 14,
			bold: true
		});
		this.add(atomLabel, new draw2d.layout.locator.CenterLocator(this));
		this.atomLabel = atomLabel;
	},
	setPersistentAttributes: function(memento) {
		this._super(memento);
		var atomLabel = new AtomLabel({
			text: memento.label,
			fontSize: 14,
			bold: true
		});
		this.add(atomLabel, new draw2d.layout.locator.CenterLocator(this));
		this.atomLabel = atomLabel;
	},
	getPersistentAttributes: function(memento) {
		var memento = this._super();
		memento.label = this.atomLabel.getText();
		return memento;
	}
});

// 노드 오브젝트(Network Manager)
var AtomNode = AtomCircleWP.extend({
	NAME: "AtomNode",
	WIDTH: 60,
	HEIGHT: 60,
	type: "<spring:message code="label.configuration.networkmanager.node.text"/>",
	init: function(attr, setter, getter) {
		this._super(attr, setter, getter);
		
		this.setWidth(this.WIDTH);
		this.setStroke(3);
		this.setColor("#ffffff");
		this.setResizeable(false);

		if (attr == null) {
			attr = new Object();
		}
		var userData = attr.userData;
		if (userData == null) {
			userData = new Object();
		}
		var image_uuid = userData.image_uuid;
		if (image_uuid != null && image_uuid != "") {
			this.setId(image_uuid);
		}
		this.setBackgroundColor(attr.bgColor);
		
		var atomLabel = new AtomLabel({
			text: attr.label,
			fontSize: 13,
			fontColor: "#1f1e34"
		});
		this.add(atomLabel, new draw2d.layout.locator.BottomLocator(this));
		this.atomLabel = atomLabel;

		if (g_data.readonly) {
			if (userData.scale_yn == "Y") {
				var atomCount = new AtomCount({
					label: userData.node_count,
					bold: true,
					bgColor: "#ffffff"
				});
				this.add(atomCount, new AtomCountLocator(this));
				this.atomCount = atomCount;
			}
		}
		
		var atomIcon = new AtomIcon({
			width: 32,
			height: 32,
			path: attr.path
		});
		this.add(atomIcon, new draw2d.layout.locator.CenterLocator(this));
		this.atomIcon = atomIcon;

		if (userData.use_yn == "Y") {
			this.setColor("#ffffff");
			this.setAlpha(1);
			this.atomIcon.setAlpha(1);
		} else {
			this.setColor(new draw2d.util.Color(32, 31, 51));
			this.setAlpha(0.7);
			this.atomIcon.setAlpha(0.7);
		}
	},
	setPersistentAttributes: function(memento) {
		this._super(memento);
		this.setUserData(memento.userData);
		
		var atomLabel = new AtomLabel({
			text: memento.label,
			fontSize: 13,
			fontColor: "#1f1e34"
		});
		this.add(atomLabel, new draw2d.layout.locator.BottomLocator(this));
		this.atomLabel = atomLabel;
		
		var atomIcon = new AtomIcon({
			width: 32,
			height: 32,
			path: memento.icon_path
		});
		this.add(atomIcon, new draw2d.layout.locator.CenterLocator(this));
		this.atomIcon = atomIcon;

		if (memento.userData.use_yn == "Y") {
			this.setColor("#ffffff");
			this.setAlpha(1);
			this.atomIcon.setAlpha(1);
		} else {
			this.setColor(new draw2d.util.Color(32, 31, 51));
			this.setAlpha(0.7);
			this.atomIcon.setAlpha(0.7);
		}

		return this;
	},
	getPersistentAttributes: function() {
		var memento = this._super();
		memento.label = this.atomLabel.getText();
		memento.bgColor = this.getBackgroundColor();
		memento.icon_path = this.atomIcon.getPath();
		return memento;
	},
	onDoubleClick: function() {
		g_canvas.setCurrentSelection(this);
		var userData = this.userData;
		var node = userData;
		node.image_x = this.getX();
		node.image_y = this.getY();
		openNodeModal(node, false);
	},
	onContextMenu: function() {
		showContextMenu(this);
	},
	onDragStart: function() {
		this._super();
		this.startX = this.getX();
		this.startY = this.getY();
		
		// this.toFront();
		
		return true;
	},
	onDrag: function(dx, dy, dx2, dy2) {
		var ret = this._super(dx, dy, dx2, dy2);
		onDragProc(this);
		return ret;
	},
	onDragEnd: function() {
		// 노드 클릭시 우측에 해당 노드 외의 다른 오브젝트의 속성창이 떠있을 경우 속성창을 닫는다.
		var ret = this._super();
		var bClose = true;
		if ($("#nodeModalDiv.on").length > 0) {
			var node = $("#nodeModalDiv.on").data("node");
			if (node.node_name == this.userData.node_name) {
				bClose = false;
			}
		}
		if (bClose) {
			hideDetailDiv();
		}
		
		onDragEndProc(this);
		
		return ret;
	}
});

var AtomBatchJob = AtomRectangleWP.extend({
	NAME: "AtomBatchJob",
	WIDTH: 140,
	HEIGHT: 42,
	type: "<spring:message code="label.general.batch.batchjobmanager.batchjob.text"/>",
	init: function(attr, setter, getter) {
		this._super(attr, setter, getter);
		this.setWidth(this.WIDTH);
		this.setHeight(this.HEIGHT);
		// this.setStroke(2);
		this.setResizeable(false);
		this.setRadius(5);

		if (attr == null) {
			attr = new Object();
		}
		var userData = attr.userData;
		if (userData == null) {
			userData = new Object();
		}
		var image_uuid = userData.image_uuid;
		if (image_uuid != null && image_uuid != "") {
			this.setId(image_uuid);
		}
		
		this.setColor(attr.bgColor);
		this.setBackgroundColor(attr.bgColor);
		
		var atomLabel = new AtomLabel({
			text: attr.label,
			fontSize: 15,
			bold: true,
			fontColor: "#ffffff"
		});
		this.add(atomLabel, new draw2d.layout.locator.CenterLocator(this));
		this.atomLabel = atomLabel;
	},
	setPersistentAttributes: function(memento) {
		this._super(memento);
		this.setUserData(memento.userData);
		
		var atomLabel = new AtomLabel({
			text: memento.label,
			fontSize: 15,
			bold: true,
			fontColor: "#ffffff"
		});
		this.add(atomLabel, new draw2d.layout.locator.CenterLocator(this));
		this.atomLabel = atomLabel;
		
		this.setColor(memento.bgColor);
		this.setBackgroundColor(memento.bgColor);
		
		return this;
	},
	getPersistentAttributes: function() {
		var memento = this._super();
		memento.label = this.atomLabel.getText();
		memento.bgColor = this.getBackgroundColor();
		return memento;
	},
	onDoubleClick: function() {
		g_canvas.setCurrentSelection(this);
		var userData = this.userData;
		var batchJob = userData;
		batchJob.image_x = this.getX();
		batchJob.image_y = this.getY();
		openBatchJobModal(batchJob, false);
	},
	onContextMenu: function() {
		showContextMenu(this);
	},
	onDragStart: function() {
		this._super();
		this.startX = this.getX();
		this.startY = this.getY();
		return true;
	},
	onDrag: function(dx, dy, dx2, dy2) {
		var ret = this._super(dx, dy, dx2, dy2);
		onDragProc(this);
		return ret;
	},
	onDragEnd: function() {
		// 배치잡 클릭시 우측에 해당 배치잡 외의 다른 오브젝트의 속성창이 떠있을 경우 속성창을 닫는다.
		var ret = this._super();
		var bClose = true;
		if ($("#batchJobModalDiv.on").length > 0) {
			var batchJob = $("#batchJobModalDiv.on").data("batchJob");
			if (batchJob.job_name == this.userData.job_name) {
				bClose = false;
			}
		}
		if (bClose) {
			hideDetailDiv();
		}
		
		onDragEndProc(this);

		return ret;
	}
});

// 연결노드 오브젝트
var AtomLinkedNode = AtomRectangleWP.extend({
	NAME: "AtomLinkedNode",
	WIDTH: 42,
	HEIGHT: 42,
	type: "<spring:message code="label.configuration.networkmanager.linkednode.text"/>",
	init: function(attr, setter, getter) {
		this._super(attr, setter, getter);
		this.setWidth(this.WIDTH);
		this.setHeight(this.HEIGHT);
		this.setStroke(0);
		this.setRadius(5);
		this.setResizeable(false);

		if (attr == null) {
			attr = new Object();
		}
		var userData = attr.userData;
		if (userData == null) {
			userData = new Object();
		}
		var image_uuid = userData.image_uuid;
		if (image_uuid != null && image_uuid != "") {
			this.setId(image_uuid);
		}
		
		this.setBackgroundColor(userData.image_bgcolor);
		
		var atomLabel = new AtomLabel({
			text: attr.label,
			fontSize: 12,
			fontColor: "#6c7380"
		});
		this.add(atomLabel, new draw2d.layout.locator.BottomLocator(this));
		this.atomLabel = atomLabel;

		var atomIcon = new AtomIcon({
			width: 28,
			height: 28,
			path: attr.path
		});
		this.add(atomIcon, new draw2d.layout.locator.CenterLocator(this));
		this.atomIcon = atomIcon;
	},
	setPersistentAttributes: function(memento) {
		this._super(memento);
		this.setUserData(memento.userData);
		
		var atomLabel = new AtomLabel({
			text: memento.label,
			fontSize: 12,
			fontColor: "#6c7380"
		});
		this.add(atomLabel, new draw2d.layout.locator.BottomLocator(this));
		this.atomLabel = atomLabel;
		
		var atomIcon = new AtomIcon({
			width: 28,
			height: 28,
			path: memento.icon_path
		});
		this.add(atomIcon, new draw2d.layout.locator.CenterLocator(this));
		this.atomIcon = atomIcon;

		return this;
	},
	getPersistentAttributes: function() {
		var memento = this._super();
		memento.label = this.atomLabel.getText();
		memento.icon_path = this.atomIcon.getPath();
		return memento;
	},
	onDoubleClick: function() {
		g_canvas.setCurrentSelection(this);
		var userData = this.userData;
		var node = userData;
		node.image_x = this.getX();
		node.image_y = this.getY();
		openNodeModal(node, false);
	},
	onContextMenu: function() {
		showContextMenu(this);
	},
	onDragStart: function() {
		this._super();
		this.startX = this.getX();
		this.startY = this.getY();
		return true;
	},
	onDrag: function(dx, dy, dx2, dy2) {
		var ret = this._super(dx, dy, dx2, dy2);
		onDragProc(this);
		return ret;
	},
	onDragEnd: function() {
		// 연결노드 클릭시 우측에 해당 연결노드 외의 다른 오브젝트의 속성창이 떠있을 경우 속성창을 닫는다.
		var ret = this._super();
		var bClose = true;
		if ($("#nodeModalDiv.on").length > 0) {
			var node = $("#nodeModalDiv.on").data("node");
			if (node.node_name == this.userData.node_name) {
				bClose = false;
			}
		}
		if (bClose) {
			hideDetailDiv();
		}
		
		onDragEndProc(this);

		return ret;
	}
});

// DB 조회 후 캔버스 사이즈를 계산한다.
function calculateCanvasSize() {
	$("#_atomMinimapDivWrapper").css("transition-duration", "0s");
	var maxRight = 0;
	var maxBottom = 0;
	if (g_data.type == LINE_TYPE_NETWORK) {
		var pkgList = g_data.pkgList;
		for (var i=0;i<pkgList.length;i++) {
			var pkg = pkgList[i];
			var right = parseInt(pkg.image_x) + parseInt(pkg.image_width);
			var bottom = parseInt(pkg.image_y) + parseInt(pkg.image_height);
			if (right > maxRight) {
				maxRight = right;
			}
			if (bottom > maxBottom) {
				maxBottom = bottom;
			}
		}
		var nodeList = g_data.nodeList;
		for (var i=0;i<nodeList.length;i++) {
			var node = nodeList[i];
			var right = parseInt(node.image_x) + 62;
			var bottom = parseInt(node.image_y) + 62;
			if (right > maxRight) {
				maxRight = right;
			}
			if (bottom > maxBottom) {
				maxBottom = bottom;
			}
		}
	} else if (g_data.type == LINE_TYPE_PROCESS) {
		var procList = g_data.procList;
		if (procList != null) {
			for (var i=0;i<procList.length;i++) {
				var proc = procList[i];
				if (proc.svc_no == g_data.svc.svc_no) {
					var right = parseInt(proc.image_x) + 62;
					var bottom = parseInt(proc.image_y) + 62;
					if (right > maxRight) {
						maxRight = right;
					}
					if (bottom > maxBottom) {
						maxBottom = bottom;
					}
				}
			}
		}
	} else if (g_data.type == LINE_TYPE_BATCHJOB) {
		var batchJobList = g_data.batchJobList;
		if (batchJobList != null) {
			for (var i=0;i<batchJobList.length;i++) {
				var batchJob = batchJobList[i];
				var right = parseInt(batchJob.image_x) + AtomBatchJob.prototype.WIDTH;
				var bottom = parseInt(batchJob.image_y) + AtomBatchJob.prototype.HEIGHT;
				if (right > maxRight) {
					maxRight = right;
				}
				if (bottom > maxBottom) {
					maxBottom = bottom;
				}
			}
		}
	}
	if (maxRight == 0 && maxBottom == 0) {
		maxRight = 800;
		maxBottom = 600;
	} else {
		maxRight += 100;
		maxBottom += 100;
	}
	if (!g_data.readonly) {
		if (maxRight < 800) {
			maxRight = 800;
		}
		if (maxBottom < 600) {
			maxBottom = 600;
		}
	}
	resizeElements(maxRight, maxBottom);
	$("#_atomMinimapDivWrapper").css("transition-duration", "0.4s");
}

// 비율을 계산한다.
function getRate() {
	var canvasWidth = g_canvas.getWidth();
	var canvasHeight = g_canvas.getHeight();
	
	var svgWidth = parseInt($("#_atomFlowDesignDiv>svg").attr("width"));
	var svgHeight = parseInt($("#_atomFlowDesignDiv>svg").attr("height"));
	
	var xRate = canvasWidth / svgWidth;
	var yRate = canvasHeight / svgHeight;
	
	var rate = xRate;
	if (yRate < rate) {
		rate = yRate;
	}
	return rate;
}

// X, Y 좌표에 해당하는 노드를 리턴한다.
function getNodeByPosition(x, y) {
	var rate = getRate();
	var figures = g_canvas.figures.data;
	for (var i=0;i<figures.length;i++) {
		var figure = figures[i];
		var left = figure.getX() * rate;
		var right = (figure.getX() + figure.getWidth()) * rate;
		var top = figure.getY() * rate;
		var bottom = (figure.getY() + figure.getHeight()) * rate;
		if ((figure instanceof AtomNode || figure instanceof AtomLinkedNode) && x > left && x < right && y > top && y < bottom) {
			return figure;
		}
	}
	return null;
}

// 모니터링 화면에서의 정책 오브젝트
var AtomMonitoringPolicy = draw2d.policy.canvas.ReadOnlySelectionPolicy.extend({
	NAME: "AtomMonitoringPolicy",
	onClick: function(figure, mouseX, mouseY, shiftKey, ctrlKey)
    {
		hideNodeInformation();
		var node = getNodeByPosition(mouseX, mouseY);
		if (node != null) {
			showNodeInformation(node, mouseX, mouseY);
		}
    }
});

// 모니터링 화면에서 노드 클릭시 노드 정보를 표시한다.
// 노드, 연결노드, 스케일노드(INTERNAL_YN='Y' && SCALE_YN = 'Y') 마다 표시되는 정보가 다르다.
function showNodeInformation(figure, x, y) {
	var rate = getRate();
	var left = (x - 20) / g_canvas.zoomFactor;
	var top = (y - 20) / g_canvas.zoomFactor;
	var userData = figure.getUserData();
	var sHtml = "";
	sHtml += "<div id=\"_atomNodeInformationDiv\" class=\"popup_detail type1\" style=\"position:absolute;top:"+top+"px;left:"+left+"px;\">";
	sHtml += "	<div class=\"info\">";
	sHtml += "		<a class=\"close\" href=\"javascript:hideNodeInformation();\">×</a>";
	sHtml += "		<header>";
	sHtml += "			<div class=\"icon\" style=\"background-image:url("+userData.image_name+");\"></div>";
	sHtml += "			<h3>"+userData.node_name+"</h3>";
	sHtml += "		</header>";
	sHtml += "		<div class=\"cont\">";
	if (figure instanceof AtomLinkedNode) {
		sHtml += "      <table>";
		sHtml += "        <colgroup>";
		sHtml += "          <col width=\"61px\">";
		sHtml += "          <col width=\"110px\">";
		sHtml += "        </colgroup>";
		sHtml += "        <tbody>";
		sHtml += "          <tr>";
		sHtml += "            <th><spring:message code="label.configuration.networkmanager.ip.text"/></th>";
		sHtml += "            <td>"+userData.ip+"</td>";
		sHtml += "          </tr>";
		sHtml += "        </tbody>";
		sHtml += "      </table>";
	} else {
		if (userData.scale_yn == "Y") {
			sHtml += "	<ul>";
			for (var i=0;i<g_data.allNodeList.length;i++) {
				var node = g_data.allNodeList[i];
				if (node.pkg_name == userData.pkg_name && node.node_type == userData.node_type) {
					sHtml += "        <li>";
					sHtml += "          <p>"+node.node_name+"</p>";
					sHtml += "          <button type=\"button\" title=\"<spring:message code="label.monitor.detail"/>\" class=\"more\" onclick=\"javascript:showProcessDiagram('"+node.pkg_name+"', '"+node.node_type+"', '"+node.node_no+"');\"><spring:message code="label.monitor.detail"/></button>";
					var alarmStatus = getNodeAlarmStatus(node);
					sHtml += "          <div class=\"count\">";
					sHtml += "            <span class=\"count1\">"+alarmStatus.critical+"</span>";
					sHtml += "            <span class=\"count2\">"+alarmStatus.major+"</span>";
					sHtml += "            <span class=\"count3\">"+alarmStatus.minor+"</span>";
					sHtml += "            <span class=\"count4\">"+alarmStatus.warning+"</span>";
					sHtml += "          </div>";
					sHtml += "        </li>";
				}
			}
			sHtml += "    </ul>";
		} else {
			for (var i=0;i<g_data.allNodeList.length;i++) {
				var node = g_data.allNodeList[i];
				if (node.pkg_name == userData.pkg_name && node.node_type == userData.node_type && node.node_name == userData.node_name) {
					sHtml += "			<table>";
					sHtml += "				<colgroup>";
					sHtml += "					<col width=\"135px\">";
					sHtml += "					<col width=\"180px\">";
					sHtml += "				</colgroup>";
					sHtml += "				<tbody>";
					sHtml += "					<tr>";
					sHtml += "						<th><spring:message code="label.common.package.name"/></th>";
					sHtml += "						<td>"+userData.pkg_name+"</td>";
					sHtml += "					</tr>";
					sHtml += "					<tr>";
					sHtml += "						<th><spring:message code="label.configuration.networkmanager.numberofprocess.text"/></th>";
					sHtml += "						<td>"+userData.proc_count+"</td>";
					sHtml += "					</tr>";
					sHtml += "					<tr>";
					sHtml += "						<th><spring:message code="label.configuration.networkmanager.numberofservice.text"/></th>";
					sHtml += "						<td>"+userData.svc_count+"</td>";
					sHtml += "					</tr>";
					sHtml += "					<tr>";
					sHtml += "						<th><spring:message code="label.configuration.networkmanager.numberoflinkednode.text"/></th>";
					sHtml += "						<td>"+userData.linked_count+"</td>";
					sHtml += "					</tr>";
					sHtml += "					<tr>";
					sHtml += "						<th><spring:message code="label.configuration.networkmanager.alarmstatus.text"/></th>";
					sHtml += "						<td>";
					sHtml += "							<div class=\"count\">";
					var alarmStatus = getNodeAlarmStatus(userData);
					sHtml += "								<span class=\"count1\">"+alarmStatus.critical+"</span>";
					sHtml += "								<span class=\"count2\">"+alarmStatus.major+"</span>";
					sHtml += "								<span class=\"count3\">"+alarmStatus.minor+"</span>";
					sHtml += "								<span class=\"count4\">"+alarmStatus.warning+"</span>";
					sHtml += "						 </div>";
					sHtml += "						</td>";
					sHtml += "					</tr>";
					sHtml += "					<tr>";
					sHtml += "						<th><spring:message code="label.configuration.networkmanager.lastupdatedtime.text"/></th>";
					sHtml += "						<td>"+userData.update_date+"</td>";
					sHtml += "					</tr>";
					sHtml += "				</tbody>";
					sHtml += "			</table>";
					sHtml += "			<button type=\"button\" title=\"<spring:message code="label.monitor.detail"/>\" class=\"more\" onclick=\"javascript:showProcessDiagram('"+node.pkg_name+"', '"+node.node_type+"', '"+node.node_no+"');\"><spring:message code="label.monitor.detail"/></button>";
				}
			}
		}
		sHtml += "		</div>";
		sHtml += "	</div>";
		sHtml += "</div>";
	}
	
	$("#_atomDroppableDiv").css("background", "");
	$("#_atomDroppableDiv").show();
	$("#_atomDroppableDiv").append(sHtml);
	$("#_atomNodeInformationDiv").slideDown();
	$("#_atomNodeInformationDiv").mouseleave(function() {
		hideNodeInformation();
	});
}

// 노드 상세화면을 불러온다.
function showProcessDiagram(pkg_name, node_type, node_no) {
	// parent.console.log("pkg_name="+pkg_name+", node_type="+node_type+", node_no="+node_no);
	hideNodeInformation();
	parent.loadProcessDiagram(pkg_name, node_type);
	parent.requestNodeResourceInfo(node_no);
}

// 모니터링 화면에서 노드의 알람 건수를 계산한다.
function getNodeAlarmStatus(node) {
	var alarmStatus = new Object();
	alarmStatus.critical = 0;
	alarmStatus.major = 0;
	alarmStatus.minor = 0;
	alarmStatus.warning = 0;
	parent.$("#alarmList tr").each(function() {
		if ($(this).find("#tr_node_name").text() == node.node_name) {
			if ($(this).find("#tr_severity_name").hasClass("cr")) {
				alarmStatus.critical ++;
			} else if ($(this).find("#tr_severity_name").hasClass("ma")) {
				alarmStatus.major ++;
			} else if ($(this).find("#tr_severity_name").hasClass("mi")) {
				alarmStatus.minor ++;
			} else if ($(this).find("#tr_severity_name").hasClass("wa")) {
				alarmStatus.warning ++;
			}
		}
	});
	return alarmStatus;
}

// 모니터링 화면에서 노드 클릭시 나타나는 노드 정보를 제거한다.
function hideNodeInformation() {
	$("#_atomNodeInformationDiv").remove();
	$("#_atomDroppableDiv").hide();
	$("#_atomDroppableDiv").css("background", "rgba(255,255,255,0.5)");
}

// 편집 화면에서의 정책 오브젝트
var AtomBoundingboxSelectionPolicy = draw2d.policy.canvas.BoundingboxSelectionPolicy.extend({
	NAME: "AtomBoundingboxSelectionPolicy",
	onClick: function(figure, mouseX, mouseY, shiftKey, ctrlKey) {
		// draw2d 오브젝트 클릭시 클릭된 오브젝트를 앞으로 가져온다.
		// 단, 패키지 오브젝트는패키지 외의 다른 오브젝트들보다는 뒤에 위치한다.
		if (figure != null) {
			if (figure instanceof AtomPkg) {
				var figures = g_canvas.figures.data;
				for (var i=0;i<figures.length;i++) {
					var f = figures[i];
					if (f instanceof AtomPkg && f.id != figure.id) {
						figure.toFront(f);
					}
				}
			} else if (figure instanceof AtomNode || figure instanceof AtomLinkedNode || figure instanceof AtomProc || figure instanceof AtomBatchJob || figure instanceof AtomLine) {
				figure.toFront();
			} else if (figure instanceof AtomLabel || figure instanceof AtomIcon || figure instanceof AtomCircle) {
				figure.parent.toFront();
			}
		}
	},
	onMouseUp: function(canvas, x, y, shiftKey, ctrlKey) {
		// 패키지 오브젝트를 리사이즈할 때, Undo, Redo를 위해 미니맵의 commandStack 에 빈 command 를 추가한다.
		g_minimap.commandStack.startTransaction();
		
		if (this.mouseDownElement != null && this.mouseDownElement.isResizeHandle) {
			var mFigure = g_minimap.getFigure(this.mouseDownElement.owner.id);
			var mCommandResize = new draw2d.command.CommandAttr(mFigure, {});
			g_minimap.commandStack.execute(mCommandResize);
		}
		
		this._super(canvas, x, y, shiftKey, ctrlKey);
		
		g_minimap.commandStack.commitTransaction();
		updateUndoRedoButton();
	}
});

// 캔버스를 초기화한다.
function initCanvas(id) {
	$("#"+id).unbind();
	$("#"+id+">svg").remove();
	if (g_canvas != null) {
		g_canvas.clear();
		g_canvas.destroy();
	}
	g_canvas = new draw2d.Canvas(id);

	if (g_data.readonly) {
		g_canvas.installEditPolicy(new AtomMonitoringPolicy());
	} else {
		g_canvas.installEditPolicy(new AtomBoundingboxSelectionPolicy());
		$("#"+id+">svg").css({
			"background-image": "url(/images/flowdesign_bg.png)",
			"border-bottom": "2px solid #c2c5cc",
			"border-right": "2px solid #c2c5cc"
		});
	}
	
	$(".line>button:first").trigger("click");
}

// 미니맵을 초기화한다.
function initMinimap(id) {
	$("#"+id+">svg").remove();
	g_minimap = new draw2d.Canvas(id);
	g_minimap.installEditPolicy(new draw2d.policy.canvas.ReadOnlySelectionPolicy());
}

// Undo, Redo 버튼 상태를 업데이트한다. 
function updateUndoRedoButton() {
	setTimeout(function() {
		var commandStack = g_canvas.getCommandStack();
		if (commandStack.canUndo()) {
			$("#_atomUndoButton").css("opacity", 1);
			$("#_atomUndoButton").prop("disabled", false);
		} else {
			$("#_atomUndoButton").css("opacity", 0.2);
			$("#_atomUndoButton").prop("disabled", true);
		}
		if (commandStack.canRedo()) {
			$("#_atomRedoButton").css("opacity", 1);
			$("#_atomRedoButton").prop("disabled", false);
		} else {
			$("#_atomRedoButton").css("opacity", 0.2);
			$("#_atomRedoButton").prop("disabled", true);
		}
	}, 0);
}

// 미니맵을 새로고침한다.
function refreshMinimap() {
	// console.log("refreshMinimap");
	if ($("#_atomMinimapDivWrapper:visible").length > 0) {
		g_minimap.clear();
		var writer = new draw2d.io.json.Writer();
		writer.marshal(g_canvas, function(json) {
			var reader = new draw2d.io.json.Reader();
			reader.unmarshal(g_minimap, json);
			var zoom = getMinimapZoom();
			$("#_atomMinimapDiv>svg").css({
				width: $("#_atomMinimapDivWrapper").width(),
				height: $("#_atomMinimapDivWrapper").height(),
			});
			g_minimap.zoomFactor = zoom;
			setLabelsVisible(g_minimap, false);
		});
	}
}

var g_updateLine = false; // 라인 팝업창에서 라인연결을 명령했는지 여부를 판단하는 변수

// 라인 연결시 호출된다.
// 로딩이 완료되지 않았거나, 라인 팝업창에서 연결 명령 시 라인을 연결하고
// 그 외의 경우에는 라인 팝업창을 연다.
draw2d.Configuration.factory.createConnection = function(sourcePort, targetPort) {
	if (!g_bLoaded) {
		var atomLine = new AtomLine();
		return atomLine;
	} else {
		if (g_updateLine) {
			var atomLine = new AtomLine();
			return atomLine;
		} else {
			var line = new Object();
			var source = sourcePort.parent;
			var target = targetPort.parent;
			var sourceUserData = source.userData;
			var targetUserData = target.userData;
			var lineType;
			var keyName;
			if (g_data.type == LINE_TYPE_NETWORK) {
				lineType = LINE_OBJECT_TYPE_NODE;
				keyName = "node_name_old";
			} else if (g_data.type == LINE_TYPE_PROCESS) {
				lineType = LINE_OBJECT_TYPE_PROCESS;
				keyName = "image_uuid";
			} else if (g_data.type == LINE_TYPE_BATCHJOB) {
				lineType = LINE_OBJECT_TYPE_BATCHJOB;
				keyName = "image_uuid";
			}
			line.source_type = lineType;
			line.source_id = sourceUserData[keyName];
			line.source_port = sourcePort.name;
			line.target_type = lineType;
			line.target_id = targetUserData[keyName];
			line.target_port = targetPort.name;
			
			var lines = g_canvas.lines.data;
			for (var i=0;i<lines.length;i++) {
				var existLine = lines[i];
				var compareSource = existLine.sourcePort.parent;
				var compareTarget = existLine.targetPort.parent;
				
				if ((source.id == compareSource.id && target.id == compareTarget.id) || target.id == compareSource.id && source.id == compareTarget.id) {
					openAlertModal("<spring:message code="msg.configuration.networkmanager.connection.exist"/>");
					return;
				}
			}
			
			openLineModal(line, true);
		}
	}
};

// 라인의 텍스트 위치 지정을 위한 Locator
var AtomConnectionLocator = draw2d.layout.locator.ManhattanMidpointLocator.extend({
	NAME: "AtomConnectionLocator",
	relocate: function(index, target) {
		var conn = target.getParent();
		var points = conn.getVertices();
		
		var segmentIndex = Math.floor((points.getSize() -2) / 2);
		if (points.getSize() <= segmentIndex+1)
			return; 
		
		var p1 = points.get(segmentIndex);
		var p2 = points.get(segmentIndex + 1);
		
		var x = ((p2.x - p1.x) / 2 + p1.x - target.getWidth()/2)|0;
		var y = (((p2.y - p1.y) / 2 + p1.y - target.getHeight()/2)|0) - 10;
		
		target.setPosition(x,y);
    }
});

// 라인 오브젝트
var AtomLine = draw2d.Connection.extend({
	NAME: "AtomLine",
	type: "Line",
	init: function(attr, setter, getter) {
		this._super(attr, setter, getter);
		this.setStroke(2);
		this.setColor("#1f1e34");
		this.setTargetDecorator(new draw2d.decoration.connection.ArrowDecorator(10, 6).setBackgroundColor("#1f1e34"));

		var atomLabel = new AtomLabel({
			fontSize: 12,
			fontColor: "#797980"
		});
		this.add(atomLabel, new AtomConnectionLocator(this));
		this.atomLabel = atomLabel;
	},
	setPersistentAttributes: function(memento) {
		this._super(memento);
		this.setTargetDecorator(new draw2d.decoration.connection.ArrowDecorator(10, 6).setBackgroundColor("#1f1e34"));
		this.setUserData(memento.userData);
	},
	getPersistentAttributes: function() {
		var memento = this._super();
		memento.userData = this.userData;
		return memento;
	},
	setUserData: function(object) {
		this._super(object);
		if (this.sourcePort != null && this.targetPort != null) {
			var source = this.sourcePort.parent;
			var target = this.targetPort.parent;
			
			if (source instanceof AtomLinkedNode || target instanceof AtomLinkedNode) {
				this.setSourceDecorator(null);
				this.setTargetDecorator(null);
			}
			
			if (g_data.readonly && g_data.type == LINE_TYPE_NETWORK) {
				// Monitoring Network Line Color
				// 모니터링 화면에서 라인의 색상을 변경한다.
				// TAT_CONNECT 테이블에 STATUS_CCD가 SUCCESS 이고 CNT > 0 인 경우 Running
				// TAT_CONNECT 테이블에 STATUS_CCD가 SUCCESS 이고 CNT = 0 인 경우 Stopped
				// TAT_CONNECT 테이블에 STATUS_CCD가 FAIL 인 경우 Abnormal
				// 그 외의 경우에는 색상 표시 안함(검정)
				var sourceUserData = source.userData;
				var sourceNodeNoList = new Array();
				var targetNodeList = new Array();
				if (sourceUserData.scale_yn == "Y" && sourceUserData.internal_yn == "Y") {
					sourceNodeNoList = getInternalNodeNo(sourceUserData);
				} else {
					sourceNodeNoList = getExternalNodeNo(sourceUserData);
				}
				
				var targetUserData = target.userData;
				var targetNodeNoList = new Array();
				if (targetUserData.scale_yn == "Y" && targetUserData.internal_yn == "Y") {
					targetNodeNoList = getInternalNodeNo(targetUserData);
				} else {
					targetNodeNoList = getExternalNodeNo(targetUserData);
				}
				
				for (var i=0;i<sourceNodeNoList.length;i++) {
					for (var j=0;j<targetNodeNoList.length;j++) {
						var connection = getConnection(sourceNodeNoList[i], targetNodeNoList[j]);
						// console.log(sourceNodeNoList[i], targetNodeNoList[j]);
						// console.log(connection);
						var color = null;
						var level = 0;
						if (connection != null) {
							if (connection.status_ccd == "SUCCESS") {
								if (parseInt(connection.cnt) > 0) {
									level = 1;
								} else {
									level = 2;
								}
							} else if (connection.status_ccd == "FAIL") {
								level = 3;
							}
						}
						// console.log("level1="+level);
						if (this.level == null || level > this.level) {
							this.level = level;
							if (level > 0) {
								switch(level) {
								case 3:
									// Abnormal
									color = "#f04343";
									break;
								case 2:
									// Stop
									color = "#f2b230";
									break;
								case 1:
									// Running
									color = "#00a8eb";
									break;
								}
							}
							// console.log("level2="+level);
							// console.log("color2="+color);
							if (color != null) {
								this.setColor(color);
								var targetDecorator = this.getTargetDecorator();
								if (targetDecorator != null) {
									this.setTargetDecorator(new draw2d.decoration.connection.ArrowDecorator(10, 6).setBackgroundColor(color));
								}
								var sourceDecorator = this.getSourceDecorator();
								if (sourceDecorator != null) {
									this.setSourceDecorator(new draw2d.decoration.connection.ArrowDecorator(10, 6).setBackgroundColor(color));
								}
							}
						}
					}
				}
			}
		}
		if (object != null) {
			var router = eval("new "+object.router+"()");
			this.setRouter(router);
			if (object.full_duplex == "Y") {
				this.setSourceDecorator(new draw2d.decoration.connection.ArrowDecorator(10, 6).setBackgroundColor("#1f1e34"));
			} else {
				this.setSourceDecorator(null);
			}
			object.image_uuid = this.id;
			
			this.atomLabel.setText(nullCheck(object.line_desc));
		}
	},
	onDoubleClick: function() {
		g_canvas.setCurrentSelection(this);
		var userData = this.userData;
		userData.image_uuid = this.id;
		openLineModal(userData, false);
	},
	onContextMenu: function() {
		showContextMenu(this);
	},
	onDragStart: function() {
		this._super();
		this.sourceId = this.sourcePort.parent.id;
		this.targetId = this.targetPort.parent.id;
		return true;
	},
	onDragEnd: function() {
		// 라인 클릭시 우측에 해당 라인 외의 다른 오브젝트의 속성창이 떠있을 경우 속성창을 닫는다.
		var ret = this._super();
		var bClose = true;
		if ($("#lineModalDiv.on").length > 0) {
			var line = $("#lineModalDiv.on").data("line");
			if (line.image_uuid == this.id) {
				bClose = false;
			}
		}
		if (bClose) {
			hideDetailDiv();
		}
		return ret;
	},
	setSource: function(port) {
		// 소스 오브젝트 설정시 미니맵 라인의 소스 오브젝트도 같이 변경한다.
		this._super(port);
		var canvas = this.getCanvas();
		if (g_bLoaded && canvas != null && canvas.canvasId == g_canvas.canvasId) {
			var mSource = g_minimap.getFigure(this.sourcePort.parent.id);
			var mPort = mSource.getHybridPort(this.sourcePort.name);
			var mAtomLine = g_minimap.getLine(this.id);
			mAtomLine.setSource(mPort);
		}
	},
	setTarget: function(port) {
		// 타겟 오브젝트 설정시 미니맵 라인의 타겟 오브젝트도 같이 변경한다.
		this._super(port);
		var canvas = this.getCanvas();
		if (g_bLoaded && canvas != null && canvas.canvasId == g_canvas.canvasId) {
			var mTarget = g_minimap.getFigure(this.targetPort.parent.id);
			var mPort = mTarget.getHybridPort(this.targetPort.name);
			var mAtomLine = g_minimap.getLine(this.id);
			mAtomLine.setTarget(mPort);
		}
	}
});

// 소스와 타겟의 NODE_NO 로 라인을 찾아 리턴한다.
function getConnection(sourceNodeNo, targetNodeNo) {
	for (var i=0;i<g_data.connectionList.length;i++) {
		var connection = g_data.connectionList[i];
		if (connection.my_node_no == sourceNodeNo && connection.peer_node_no == targetNodeNo) {
			return connection;
		}
	}
	return null;
}

// 내부노드(INTERNAL_YN = 'Y')의 NODE_NO Array 를 리턴한다.
function getInternalNodeNo(userData) {
	var ret = new Array();
	for (var i=0;i<g_data.allNodeList.length;i++) {
		var node = g_data.allNodeList[i];
		if (node.pkg_name == userData.pkg_name && node.node_type == userData.node_type) {
			ret.push(node.node_no);
		}
	}
	return ret;
}

// 연결노드(INTERNAL_YN = 'N')의 NODE_NO Array 를 리턴한다.
function getExternalNodeNo(userData) {
	var ret = new Array();
	for (var i=0;i<g_data.allNodeList.length;i++) {
		var node = g_data.allNodeList[i];
		if (node.pkg_name == userData.pkg_name && node.node_type == userData.node_type && node.node_name == userData.node_name) {
			ret.push(node.node_no);
			return ret;
		}
	}
	return ret;
}

// 캔버스 영역 및 미니맵 영역을 리사이즈한다.
function resizeElements(width, height) {
	width = parseInt(width);
	height = parseInt(height);
	$("#_atomFlowDesignDiv, #_atomMinimapDiv").css({
		width: width,
		height: height
	});

	var maxWidth = $("#_atomFlowDesignDivWrapper").width() - 331;
	var maxHeight = $("#_atomFlowDesignDivWrapper").height();

	var minimapWidth = 100;
	var minimapHeight = minimapWidth * height / width;
	if (width > height) {
		var minimapHeight = 100;
		var minimapWidth = minimapHeight * width / height;
	}
	if (minimapWidth > maxWidth) {
		var rate = minimapWidth / maxWidth;
		minimapWidth = maxWidth;
		minimapHeight /= rate;
	}
	if (minimapHeight > maxHeight) {
		var rate = minimapHeight / maxHeight;
		minimapHeight = maxHeight;
		minimapWidth /= rate;
	}
	
	minimapWidth += 2; // border
	minimapHeight += 2; // border
	
	$("style").append("#_atomMinimapDivWrapper{left:calc(100% - "+(minimapWidth+21)+"px);top:calc(100% - "+(minimapHeight+21)+"px);width:"+minimapWidth+"px;height:"+minimapHeight+"px;}");
	$("style").append("#_atomMinimapDivWrapper.on{left:calc(100% - "+(310+minimapWidth+21)+"px);}");
}

// 캔버스를 리사이즈한다.
function resizeCanvas() {
	if ($("#resizeModalDiv #canvas_width").val() == "") {
		$("#resizeModalDiv #errorSpan").text("<spring:message code="msg.configuration.networkmanager.canvaswidth.empty"/>");
		$("#resizeModalDiv #errorSpan").attr("class", "show");
		$("#resizeModalDiv #canvas_width").focus();
		return;
	}
	if (!isValidNaturalNumber($("#resizeModalDiv #canvas_width").val())) {
		$("#resizeModalDiv #errorSpan").text("<spring:message code="msg.configuration.networkmanager.canvaswidth.invalid"/>");
		$("#resizeModalDiv #errorSpan").attr("class", "show");
		$("#resizeModalDiv #canvas_width").focus();
		return;
	}
	if ($("#resizeModalDiv #canvas_height").val() == "") {
		$("#resizeModalDiv #errorSpan").text("<spring:message code="msg.configuration.networkmanager.canvasheight.empty"/>");
		$("#resizeModalDiv #errorSpan").attr("class", "show");
		$("#resizeModalDiv #canvas_height").focus();
		return;
	}
	if (!isValidNaturalNumber($("#resizeModalDiv #canvas_height").val())) {
		$("#resizeModalDiv #errorSpan").text("<spring:message code="msg.configuration.networkmanager.canvasheight.invalid"/>");
		$("#resizeModalDiv #errorSpan").attr("class", "show");
		$("#resizeModalDiv #canvas_height").focus();
		return;
	}
	
	// 최소사이즈 체크
	var maxRight = 0;
	var maxBottom = 0;
	var figures = g_canvas.figures.data;
	for (var i=0;i<figures.length;i++) {
		var figure = figures[i];
		var x = figure.x + figure.width + 100;
		var y = figure.y + figure.height + 100;
		if (x > maxRight) {
			maxRight = x;
		}
		if (y > maxBottom) {
			maxBottom = y;
		}
	}
	if (parseInt($("#resizeModalDiv #canvas_width").val()) < maxRight) {
		$("#resizeModalDiv #errorSpan").text("<spring:message code="msg.configuration.networkmanager.canvaswidth.small"/> "+maxRight);
		$("#resizeModalDiv #errorSpan").attr("class", "show");
		$("#resizeModalDiv #canvas_width").focus();
		return;
	}
	if (parseInt($("#resizeModalDiv #canvas_height").val()) < maxBottom) {
		$("#resizeModalDiv #errorSpan").text("<spring:message code="msg.configuration.networkmanager.canvasheight.small"/> "+maxBottom);
		$("#resizeModalDiv #errorSpan").attr("class", "show");
		$("#resizeModalDiv #canvas_height").focus();
		return;
	}

	var writer = new draw2d.io.json.Writer();
	writer.marshal(g_canvas, function(json) {
		g_canvas.destroy();
		g_minimap.destroy();
		
		var width = $("#resizeModalDiv #canvas_width").val();
		var height = $("#resizeModalDiv #canvas_height").val();

		resizeElements(width, height);
		
		prepareDrawCanvas();
		
		var reader = new draw2d.io.json.Reader();
		reader.unmarshal(g_canvas, json);
		
		finishDrawCanvas();
		closeModal();
	});
}

// 캔버스 영역을 스크롤할 때 호출된다.
// 미니맵 영역의 위치를 스크롤 영역에 맞게 조절한다.
function onScrollDivWrapper() {
	if (g_bMinimapClick) {
		return;
	}
	var scrollLeft = $("#_atomFlowDesignDivWrapper").prop("scrollLeft");
	var scrollTop = $("#_atomFlowDesignDivWrapper").prop("scrollTop");
	var zoom = g_canvas.zoomFactor;
	var minimapZoom = getMinimapZoom();
	var left = scrollLeft / minimapZoom * zoom;
	var top = scrollTop / minimapZoom * zoom;
	if (left < 0) {
		left = 0;
	}
	if (top < 0) {
		top = 0;
	}
	$("#_atomMinimapAreaDiv").css({
		left: left,
		top: top
	});
}

// draw2d 오브젝트들의 라벨을 숨기거나 보여준다.
function setLabelsVisible(canvas, visible) {
	var figures = canvas.figures.data;
	var lines = canvas.lines.data;
	
	var objects = figures.concat(lines);
	for (var i=0;i<objects.length;i++) {
		var object = objects[i];
		var children = object.children.data;
		for (var j = 0; j < children.length; j++) {
			var child = children[j].figure;
			if (child instanceof AtomLabel) {
				child.setVisible(visible);
			}
		}
	}
}

// 캔버스 영역을 줌 인/아웃 한다.
function updateZoom(zoom, bAnimate) {
	if (bAnimate == null) {
		bAnimate = true;
	}
	hideContextMenu();
	var len = 1;
	if (zoom > 1) {
		len = 2;
	}
	zoom = parseFloat(zoom.toPrecision(len));
	if (zoom < 0.2 || zoom > 4) {
		return;
	}
	if (zoom > 1.5) {
		setLabelsVisible(g_canvas, false);
	} else {
		setLabelsVisible(g_canvas, true);
	}
	g_canvas.zoomFactor = zoom;
	
	onScrollDivWrapper();

	var param = {
		width: g_canvas.getWidth() / zoom,
		height: g_canvas.getHeight() / zoom,
		backgroundSize: 25 / zoom
	};
	var minimapZoom = getMinimapZoom();
	var mParam = {
		width: $("#_atomFlowDesignDivWrapper").width() / minimapZoom * zoom - 2,
		height: $("#_atomFlowDesignDivWrapper").height() / minimapZoom * zoom - 2
	};
	if (bAnimate) {
		$("#_atomFlowDesignDiv>svg, #_atomDroppableDiv").animate(param, 200);
		$("#_atomMinimapAreaDiv").animate(mParam, 200);
	} else {
		$("#_atomFlowDesignDiv>svg, #_atomDroppableDiv").css(param);
		$("#_atomMinimapAreaDiv").css(mParam);
	}
}

// 미니맵 영역을 드래그할 때 호출된다.
// 캔버스 영역의 스크롤 위치를 조절한다.
function onMinimapDrag() {
	g_bMinimapClick = true;
	var zoom = g_canvas.zoomFactor;
	var pos = $("#_atomMinimapAreaDiv").position();
	var left = pos.left;
	var top = pos.top;
	
	var minimapZoom = getMinimapZoom();
	$("#_atomFlowDesignDivWrapper").animate({
		scrollLeft: left * minimapZoom / zoom,
		scrollTop: top * minimapZoom / zoom
	}, 0);
	g_bMinimapClick = false;
}

// 미니맵 클릭시 호출된다.
// 미니맵 영역의 위치에 맞게 캔버스의 스크롤 위치를 조절한다.
function onMinimapClick() {
	g_bMinimapClick = true;
	var zoom = g_canvas.zoomFactor;
	var left = event.offsetX - 20 * zoom;
	var top = event.offsetY - 20 * zoom;
	if (left < 0) {
		left = 0;
	}
	if (top < 0) {
		top = 0;
	}
	var width = $("#_atomMinimapAreaDiv").width();
	var height = $("#_atomMinimapAreaDiv").height();
	var maxWidth = $("#_atomMinimapDivWrapper").width();
	var maxHeight = $("#_atomMinimapDivWrapper").height();
	if (left + width > maxWidth) {
		left = maxWidth - width;
	}
	if (top + height > maxHeight) {
		top = maxHeight - height;
	}
	$("#_atomMinimapAreaDiv").animate({
		left: left,
		top: top
	}, 200);
	var minimapZoom = getMinimapZoom();
	$("#_atomFlowDesignDivWrapper").animate({
		scrollLeft: left * minimapZoom / zoom,
		scrollTop: top * minimapZoom / zoom
	}, 200, function() {
		setTimeout(function() {
			g_bMinimapClick = false;
		}, 50);
	});
}

// 미니맵의 줌 값을 리턴한다.
function getMinimapZoom() {
	var canvasWidth = g_canvas.getWidth();
	var minimapWidth = $("#_atomMinimapDivWrapper").width();
	var zoom = canvasWidth / minimapWidth;
	return zoom;
}

// 캔버스 영역에 로딩 이미지를 출력한다.
function showLoading(opacity) {
	if (opacity == null) {
		opacity = 1;
	}
	var width = $("#_atomFlowDesignDivWrapper").width();
	var height = $("#_atomFlowDesignDivWrapper").height();
	var sHtml = "<div id=\"_atomLoadingDiv\" style=\"position:absolute;width:"+width+"px;height:"+height+"px;background-color:#f3f3f3;text-align:left;opacity:"+opacity+";\"><div class=\"loading\"><span class=\"loading-inner\"></span></div></div>";
	$("#_atomFlowDesignDivWrapper").before(sHtml);
}

// 로딩 이미지를 제거한다.
function hideLoading() {
	$("#_atomLoadingDiv").remove();
}

// 변경 내역이 있는지 체크하고 검색을 실행 또는 취소한다.
function searchFlowDesign(bFirst, param) {
	if (g_bChanged) {
		openConfirmModal("<spring:message code="msg.configuration.networkmanager.warning.text"/>", "<spring:message code="msg.configuration.networkmanager.leave.confirm"/>", function() {
			searchFlowDesignProc(bFirst, param);
		}, function() {
			cancelSearchFlowDesign();
		});
	} else {
		searchFlowDesignProc(bFirst, param);
	}
}

// 변경 내역이 있을 때 검색을 취소하면 실행된다.
// Override 하여 사용한다.
function cancelSearchFlowDesign() {
}

// 그리기 위한 데이터를 DB 에서 조회한다.
function searchFlowDesignProc(bFirst, param) {
	g_bChanged = false;
	g_bLoaded = false;
	$("#_atomFlowDesignDivWrapper").parent("div").css("overflow", "hidden");
	hideDetailDiv();
	showLoading();
	if (param == null) {
		param = new Object();
	}
	g_param = param;
	$.ajax({
		url: "searchFlowDesign",
		data: param,
		type: 'POST',
		dataType: 'json',
		success: function(data) {
			g_data = data;
			calculateCanvasSize();
			afterSearchFlowDesign();
		},
		error: function(e) {
			var error = JSON.parse(e.responseText);
			openAlertModal(error.errorMsg.cause.localizedMessage);
			hideLoading();
		},
		complete: function() {
		}
	});
}

// 캔버스 영역을 새로고침한다.
function refreshCanvas() {
	var writer = new draw2d.io.json.Writer();
	writer.marshal(g_canvas, function(json) {
		prepareDrawCanvas();
		var reader = new draw2d.io.json.Reader();
		reader.unmarshal(g_canvas, json);
		finishDrawCanvas();
	});
}

// 캔버스 영역을 그리기 전에 실행된다.
function prepareDrawCanvas() {
	g_bLoaded = false;
	$(".properties").remove();
	initCanvas("_atomFlowDesignDiv");
	initMinimap("_atomMinimapDiv");
	g_canvas.clear();
	g_minimap.clear();
}

// 캔버스 영역을 그린 후에 실행된다.
function finishDrawCanvas() {
	resetDraggableElementsAttr();
	$("#routerListDiv td:eq(0)").trigger("click");
	$(".properties").remove();
	var bMinimap = false;
	if ($("#_atomToggleMinimapButton").length > 0) {
		if ($("#_atomToggleMinimapButton").hasClass("on")) {
			bMinimap = true;
		}
	}
	if (bMinimap) {
		setTimeout(function() {
			$("#_atomMinimapDivWrapper").show();
			if (g_data.readonly) {
				calculateZoom();
				alignFigures();
			} else {
				refreshMinimap();
				updateUndoRedoButton();
				updateZoom(1, false);
			}
			$("#_atomFlowDesignDivWrapper").css("opacity", 1);
			$("#_atomFlowDesignDivWrapper").parent("div").css("overflow", "auto");
			hideLoading();
		}, 400);
	} else {
		if (g_data.readonly) {
			calculateZoom();
			alignFigures();
		}
		$("#_atomFlowDesignDivWrapper").css("opacity", 1);
		$("#_atomFlowDesignDivWrapper").parent("div").css("overflow", "auto");
		hideLoading();
	}
	var _onRightMouseDown = draw2d.Canvas.prototype.onRightMouseDown;
	draw2d.Canvas.prototype.onRightMouseDown = function(x, y, shiftKey, ctrlKey) {
		if (g_data.readonly) {
			var rate = getRate();
			x /= rate;
			y /= rate;
		}
		_onRightMouseDown.call(this, x, y, shiftKey, ctrlKey);
	}
	g_bLoaded = true;
}

// DB 조회 후에 실행된다.
function afterSearchFlowDesign() {
	prepareDrawCanvas();
	loadPkg(g_data.pkgList);
	loadNode(g_data.nodeList);
	loadNodeType(g_data.nodeTypeList);
	loadSvc(g_data.svcList);
	loadProcBase(g_data.procBaseList);
	loadProc(g_data.procList);
	loadBatchGroup(g_data.batchGroupList);
	loadBatchJob(g_data.batchJobList);
	loadLine(g_data.lineList);
	finishDrawCanvas();
}

// 모니터링 화면에서 draw2d 오브젝트들을 화면의 가운데 위치하도록 위치를 조정한다.
function alignFigures() {
	var canvasWidth = g_canvas.getWidth();
	var canvasHeight = g_canvas.getHeight();
	
	var svgWidth = parseInt($("#_atomFlowDesignDiv>svg").attr("width"));
	var svgHeight = parseInt($("#_atomFlowDesignDiv>svg").attr("height"));
	
	var xRate = canvasWidth / svgWidth;
	var yRate = canvasHeight / svgHeight;
	
	var rate = xRate;
	if (yRate < rate) {
		rate = yRate;
	}
	
	var minX = 9999;
	var maxX = 0;
	var minY = 9999;
	var maxY = 0;
	
	var figures = g_canvas.figures.data;
	for (var i=0;i<figures.length;i++) {
		var figure = figures[i];
		var left = figure.x;
		var right = figure.x + figure.width;
		var top = figure.y;
		var bottom = figure.y + figure.height;
		if (left < minX) {
			minX = left;
		}
		if (right > maxX) {
			maxX = right;
		}
		if (top < minY) {
			minY = top;
		}
		if (bottom > maxY) {
			maxY = bottom;
		}
	}
	
	minX *= rate;
	maxX *= rate;
	minY *= rate;
	maxY *= rate;

	var mX = ((canvasWidth - (maxX - minX)) / 2) / rate - minX / rate;
	var mY = ((canvasHeight - (maxY - minY)) / 2) / rate - minY / rate;
	
	var figures = g_canvas.figures.data;
	for (var i=0;i<figures.length;i++) {
		var figure = figures[i];
		figure.setX(figure.x + mX);
		figure.setY(figure.y + mY);
	}
	
	refreshMinimap();
}

// DB 조회 후 호출된다.
// Override 하여 사용한다.
function loadPkg(pkgList) {}
function loadNode(nodeList) {}
function loadNodeType(nodeTypeList) {}
function loadSvc(svcList) {}
function loadProcBase(procBaseList) {}
function loadProc(procList) {}
function loadBatchGroup(batchGroupList) {}
function loadBatchJob(batchJobList) {}

// 리사이즈 팝업창을 호출한다.
function openResizeModal() {
	hideDetailDiv();
	$("#resizeModalDiv").remove();
	var sHtml = "";
	sHtml += "<div id=\"resizeModalDiv\" style=\"display:none;\">\n";
	sHtml += "	<div class=\"popup pw\">\n";
	sHtml += "		<h2 id=\"lineModalTitle\"><spring:message code="label.configuration.networkmanager.resizecanvas.text"/></h2>\n";
	sHtml += "		<a class=\"close\" href=\"javascript:closeModal();\">&times;</a>\n";
	sHtml += "		<div class=\"pop_cont\">\n";
	sHtml += "			<div class=\"insert\">\n";
	sHtml += "				<label><spring:message code="label.configuration.networkmanager.canvaswidth.text"/><em>*</em></label>\n";
	sHtml += "				<input type=\"text\" id=\"canvas_width\" name=\"canvas_width\" placeholder=\"<spring:message code="label.configuration.networkmanager.canvaswidth.text"/>\" maxlength=\"4\"/>\n";
	sHtml += "				<label><spring:message code="label.configuration.networkmanager.canvasheight.text"/><em>*</em></label>\n";
	sHtml += "				<input type=\"text\" id=\"canvas_height\" name=\"canvas_height\" placeholder=\"<spring:message code="label.configuration.networkmanager.canvasheight.text"/>\" maxlength=\"4\"/>\n";
	sHtml += "				<span id=\"errorSpan\" class=\"hide\"></span>\n";
	sHtml += "			</div>\n";
	sHtml += "		</div>\n";
	sHtml += "		<div class=\"btn_area\">\n";
	sHtml += "		<a href=\"javascript:closeModal();\"><button type=\"button\"><spring:message code="label.common.cancel"/></button></a>\n";
	sHtml += "		<a href=\"javascript:resizeCanvas();\"><button type=\"button\" class=\"major\"><spring:message code="label.common.ok"/></button></a>\n";
	sHtml += "		</div>\n";
	sHtml += "	</div>\n";
	sHtml += "</div>\n";
	$("body").append(sHtml);

	$("#resizeModalDiv #canvas_width").numeric();
	$("#resizeModalDiv #canvas_height").numeric();

	$("#resizeModalDiv #canvas_width").val(g_canvas.getWidth());
	$("#resizeModalDiv #canvas_height").val(g_canvas.getHeight());
	openModal("#resizeModalDiv");
}

// 패키지 draw2d 오브젝트를 추가한다.
function addPkgFigure(pkg) {
	var label = pkg.pkg_name;
	var width = pkg.image_width;
	var height = pkg.image_height;
	var bgColor = pkg.image_bgcolor;
	var userData = pkg;
	var left = pkg.image_x;
	var top = pkg.image_y;
	var path = pkg.image_name;
	var atomPkg = null;
	if (width != null && height != null && left != null && top != null) {
		atomPkg = new AtomPkg({
			label: label,
			width: width,
			height: height,
			userData: userData,
			x: left,
			y: top,
			bgColor: bgColor,
			path: path
		});
		
		if (g_bLoaded) {
			var commandAdd = new draw2d.command.CommandAdd(g_canvas, atomPkg, parseInt(left), parseInt(top));
			g_canvas.commandStack.execute(commandAdd);
		} else {
			g_canvas.add(atomPkg);
		}
		
		atomPkg.toBack();
		$(atomPkg.shape[0]).attr("filter", "url(#AtomPkgFilter)");
		atomPkg.on("resize", function() {
			var mAtomPkg = g_minimap.getFigure(atomPkg.id);
			mAtomPkg.setWidth(atomPkg.getWidth());
			mAtomPkg.setHeight(atomPkg.getHeight());
			// updateUndoRedoButton();
		});
	}
	return atomPkg;
}

// 프로세스 draw2d 오브젝트를 추가한다.
function addProcFigure(proc) {
	var path = proc.image_name;
	var label = proc.proc_name;
	var userData = proc;
	var left = proc.image_x;
	var top = proc.image_y;
	var bgColor = proc.image_bgcolor;
	var atomProc = null;
	if (left != null && top != null) {
		atomProc = new AtomProc({
			path: path,
			label: label,
			width: 62,
			height: 62,
			userData: userData,
			x: left,
			y: top,
			bgColor: bgColor
		});
		if (g_bLoaded) {
			var commandAdd = new draw2d.command.CommandAdd(g_canvas, atomProc, parseInt(left), parseInt(top));
			g_canvas.commandStack.execute(commandAdd);
		} else {
			g_canvas.addFigure(atomProc);
			afterAddProcFigure(atomProc);
		}
	}
	return atomProc;
}

// 프로세스를 추가한 후 실행한다.
function afterAddProcFigure(atomProc) {
	atomProc.toFront();
	$(atomProc.shape[0]).attr("filter", "url(#AtomNodeFilter)");
}

// 노드 draw2d 오브젝틀 추가한다.
function addNodeFigure(node) {
	var path = node.image_name;
	var label = node.node_name;
	var userData = node;
	var left = node.image_x;
	var top = node.image_y;
	var bgColor = node.image_bgcolor;
	var atomNode = null;
	if (left != null && top != null) {
		if (node.internal_yn == "Y") {
			atomNode = new AtomNode({
				path: path,
				label: label,
				width: 62,
				height: 62,
				userData: userData,
				x: left,
				y: top,
				bgColor: bgColor
			});
		} else {
			atomNode = new AtomLinkedNode({
				path: path,
				label: label,
				width: 62,
				height: 62,
				userData: userData,
				x: left,
				y: top
			});
		}
		
		if (g_bLoaded) {
			var commandAdd = new draw2d.command.CommandAdd(g_canvas, atomNode, parseInt(left), parseInt(top));
			g_canvas.commandStack.execute(commandAdd);
		} else {
			g_canvas.addFigure(atomNode);
			atomNode.toFront();
			afterAddNodeFigure(atomNode);
		}
	}
	return atomNode;
}

// 노드 draw2d 오브젝트를 추가한 뒤 실행한다.
function afterAddNodeFigure(atomNode) {
	if (atomNode.userData.node_name_old == "") {
		atomNode.userData.node_name_old = atomNode.id;
	}
	
	$(atomNode.shape[0]).attr("filter", "url(#AtomNodeFilter)");
	if (atomNode.atomCount != null) {
		$(atomNode.atomCount.shape[0]).attr("filter", "url(#AtomCountFilter)");
	}
}

// draw2d 오브젝트를 리턴한다.
function getAtomFigure(type, id) {
	var ret = null;
	var figures = g_canvas.figures.data;
	for (var i=0;i<figures.length;i++) {
		var figure = figures[i];
		var userData = figure.userData;
		if (type == LINE_OBJECT_TYPE_PACKAGE && figure instanceof AtomPkg && userData.pkg_name == id) {
			ret = figure;
			break;
		} else if (type == LINE_OBJECT_TYPE_NODE && (figure instanceof AtomNode || figure instanceof AtomLinkedNode) && userData.node_name_old == id) {
			ret = figure;
			break;
		} else if (type == LINE_OBJECT_TYPE_PROCESS && figure instanceof AtomProc && (userData.image_uuid == id || userData.proc_no == id)) {
			ret = figure;
			break;
		} else if (type == LINE_OBJECT_TYPE_BATCHJOB && figure instanceof AtomBatchJob && (userData.image_uuid == id)) {
			ret = figure;
			break;
		}
	}
	return ret;
}

// 라인을 생성한다.
function createLine(line) {
	var source = getAtomFigure(line.source_type, line.source_id);
	var target = getAtomFigure(line.target_type, line.target_id);
	
	var atomLine;
	if (source != null && target != null) {
		if (g_data.type == LINE_TYPE_PROCESS || g_data.type == LINE_TYPE_BATCHJOB) {
			line.source_id = source.id;
			line.target_id = target.id;
		}
		var sourcePort = source.getHybridPort(parseInt(line.source_port));
		var targetPort = target.getHybridPort(parseInt(line.target_port));

		if (sourcePort != null && targetPort != null) {
			var cc = new draw2d.command.CommandConnect(g_canvas, sourcePort, targetPort);
			if (g_bLoaded) {
				g_canvas.commandStack.execute(cc);
			} else {
				var ret = cc.execute();
			}
			atomLine = cc.connection;
			atomLine.setUserData(line);
		}
		
		var mSource = g_minimap.getFigure(source.id);
		var mTarget =  g_minimap.getFigure(target.id);
		
		if (mSource != null && mTarget != null) {
			if (g_data.type == LINE_TYPE_PROCESS || g_data.type == LINE_TYPE_BATCHJOB) {
				line.source_id = mSource.id;
				line.target_id = mTarget.id;
			}
			var mSourcePort = mSource.getHybridPort(parseInt(line.source_port));
			var mTargetPort = mTarget.getHybridPort(parseInt(line.target_port));

			if (mSourcePort != null && mTargetPort != null) {
				var cc = new draw2d.command.CommandConnect(g_minimap, mSourcePort, mTargetPort);
				if (g_bLoaded) {
					g_minimap.commandStack.execute(cc);
				} else {
					var ret = cc.execute();
				}
				var mAtomLine = cc.connection;
				// line.line_desc = "";
				mAtomLine.setUserData(line);
				mAtomLine.id = atomLine.id;
			}
		}
		
		if (g_bLoaded) {
			updateUndoRedoButton();
		}
	}
}

// DB 조회 후 라인을 추가한다.
function loadLine(lineList) {
	if (lineList == null) {
		return;
	}
	for (var i = 0; i < lineList.length; i++) {
		var line = lineList[i];
		createLine(line);
	}
}

// draw2d 오브젝트들을 DB 에 저장한다.
function saveFlowDesign() {
	// 라인 중복 체크
	var lines = g_canvas.lines.data;
	for (var i=0;i<lines.length;i++) {
		var line = lines[i];
		var source = line.sourcePort.parent;
		var target = line.targetPort.parent;
		
		for (var j=0;j<lines.length;j++) {
			var existLine = lines[j];
			var compareSource = existLine.sourcePort.parent;
			var compareTarget = existLine.targetPort.parent;
			if (line.id != existLine.id && (source.id == compareSource.id && target.id == compareTarget.id)) {
				openAlertModal("<spring:message code="msg.configuration.networkmanager.lineduplicate.empty"/>");
				return;
			}
		}
	}
	
	showLoading(0.5);
	hideDetailDiv();
	
	var figures = g_canvas.figures.data;
	var writer = new draw2d.io.json.Writer();
	writer.marshal(g_canvas, function(json) {
		var paramJson = new Object();
		if (g_data.type == LINE_TYPE_NETWORK) {
			// paramJson.pkg_name = $("#pkgSelect").val();
		} else if (g_data.type == LINE_TYPE_PROCESS) {
			paramJson.pkg_name = g_data.svc.pkg_name;
			paramJson.node_type = g_data.svc.node_type;
			paramJson.svc_no = parseInt(g_data.svc.svc_no);
		} else if (g_data.type == LINE_TYPE_BATCHJOB) {
			paramJson.pkg_name = g_data.schedulerGroup.pkg_name;
			paramJson.group_name = g_data.schedulerGroup.group_name;
		}
		paramJson.pkgList = new Array();
		paramJson.nodeList = new Array();
		paramJson.procList = new Array();
		paramJson.batchJobList = new Array();
		paramJson.lineList = new Array();

		$("#linkedNodeListDiv>div:gt(0)").each(function() {
			var node = $(this).data("node");
			node.image_name = null;
			node.image_x = null;
			node.image_y = null;
			paramJson.nodeList.push(node);
		});

		for (var i = 0; i < json.length; i++) {
			var obj = json[i];
			var type = obj.type;
			var id = obj.id;
			var userData = obj.userData;

			if (type == "AtomPkg") {
				var pkg = obj.userData;
				pkg.image_x = obj.x;
				pkg.image_y = obj.y;
				pkg.image_width = obj.width;
				pkg.image_height = obj.height;
				pkg.image_name = obj.icon_path;
				pkg.image_bgcolor = obj.bgColor;
				paramJson.pkgList.push(pkg);
			} else if (type == "AtomNode" || type == "AtomLinkedNode") {
				var node = obj.userData;
				node.image_uuid = obj.id;
				node.image_x = obj.x;
				node.image_y = obj.y;
				node.image_name = obj.icon_path;
				paramJson.nodeList.push(node);
			} else if (type == "AtomProc") {
				var proc = obj.userData;
				proc.image_x = obj.x;
				proc.image_y = obj.y;
				proc.image_width = obj.width;
				proc.image_height = obj.height;
				proc.image_name = obj.icon_path;
				proc.image_bgcolor = obj.bgColor;
				proc.image_uuid = obj.id;
				paramJson.procList.push(proc);
			} else if (type == "AtomBatchJob") {
				var batchJob = obj.userData;
				batchJob.image_x = obj.x;
				batchJob.image_y = obj.y;
				batchJob.image_width = obj.width;
				batchJob.image_height = obj.height;
				batchJob.image_name = obj.icon_path;
				batchJob.image_bgcolor = obj.bgColor.hashString;
				batchJob.image_uuid = obj.id;
				paramJson.batchJobList.push(batchJob);
			} else if (type == "AtomLine") {
				var line = new Object();
				var source = g_canvas.getFigure(obj.source.node);
				line.source_type = getObjectType(source);
				line.source_id = getObjectId(source);
				line.source_name = source.atomLabel.text;
				line.source_port = obj.source.port;
				var target = g_canvas.getFigure(obj.target.node);
				line.target_type = getObjectType(target);
				line.target_id = getObjectId(target);
				line.target_name = target.atomLabel.text;
				line.target_port = obj.target.port;
				line.router = obj.router;
				line.full_duplex = obj.userData.full_duplex;
				line.line_desc = obj.userData.line_desc;
				line.elem_cnt = obj.userData.elem_cnt;
				line.multi_type = obj.userData.multi_type;
				line.bi_dir_yn = obj.userData.bi_dir_yn;
				line.exit_cd = obj.userData.exit_cd;
				paramJson.lineList.push(line);
			}
		}

		var param = new Object();
		param.jsonStr = JSON.stringify(paramJson);
		$.ajax({
			url: "saveFlowDesign",
			data: param,
			type: 'POST',
			dataType: 'json',
			success: function(data) {
				var result = data.result;
				if (result == "succ") {
					openAlertModal("<spring:message code="msg.configuration.networkmanager.saveflowdesign.success"/>", "", function() {
						g_bChanged = false;
						searchFlowDesign(true, g_param);
					});
				} else {
					openAlertModal(result);
				}
			},
			error: function(e) {
				var error = JSON.parse(e.responseText);
				openAlertModal(error.errorMsg.cause.localizedMessage);
			},
			complete: function() {
				hideLoading();
			}
		});
	});
}

// draw2d 오브젝트 타입을 리턴한다.(TAT_COMMON_CODE 에 저장되어 있음. CodeDefinition.java 에 정의되어 있음.)
function getObjectType(figure) {
	var type = null;
	if (figure instanceof AtomPkg) {
		type = LINE_OBJECT_TYPE_PACKAGE;
	} else if (figure instanceof AtomNode || figure instanceof AtomLinkedNode) {
		type = LINE_OBJECT_TYPE_NODE;
	} else if (figure instanceof AtomProc) {
		type = LINE_OBJECT_TYPE_PROCESS;
	} else if (figure instanceof AtomBatchJob) {
		type = LINE_OBJECT_TYPE_BATCHJOB;
	}
	return type;
}

// 아이디를 리턴한다.
function getObjectId(figure) {
	var id = null;
	if (figure instanceof AtomPkg) {
		id = figure.userData.pkg_name;
	} else if (figure instanceof AtomNode) {
		id = figure.userData.node_name_old;
	} else {
		id = figure.id;
	}
	return id;
}

// 키보드 이벤트를 정의한다.
draw2d.policy.canvas.DefaultKeyboardPolicy = draw2d.policy.canvas.KeyboardPolicy.extend({
	NAME: "DefaultKeyboardPolicy",
	init: function() {
		this._super();
	},
	onKeyDown: function(canvas, keyCode, shiftKey, ctrlKey) {
		if (keyCode === 46 && canvas.getCurrentSelection() !== null) {
			confirmDelete();
		} else {
			this._super(canvas, keyCode, shiftKey, ctrlKey);
		}
	}
});

// 패키지 draw2d 오브젝트를 삭제한다.
function deletePkg(pkg) {
	var atomPkg = getAtomFigure("pkg", pkg.pkg_name);
	if (atomPkg != null) {
		deleteFigure(atomPkg);
	}
	closeModal();
}

// 노드 draw2d 오브젝트를 삭제한다.
function deleteNode(node) {
	var atomNode = getAtomFigure(LINE_OBJECT_TYPE_NODE, node.node_name_old);
	if (atomNode != null) {
		deleteFigure(atomNode);
	}
	closeModal();
}

// 프로세스 draw2d 오브젝트를 삭제한다.
function deleteProc(proc) {
	var atomProc = getAtomFigure(LINE_OBJECT_TYPE_PROCESS, proc.image_uuid);
	if (atomProc != null) {
		deleteFigure(atomProc);
	}
	closeModal();
}

// 삭제여부를 묻는 확인창을 보여준다.
function confirmDelete() {
	var selection = g_canvas.getSelection();
	if (selection.all.data.length > 0) {
		openConfirmModal("<spring:message code="msg.configuration.networkmanager.warning.text"/>", "<spring:message code="msg.configuration.networkmanager.deletefigures.confirm"/>", function() {deleteSelectedFigures();});
	} else {
		openAlertModal("<spring:message code="msg.configuration.networkmanager.deletefigures.invalid"/>");
	}
}

// 선택한 draw2d 오브젝트들을 삭제한다.
function deleteSelectedFigures() {
	g_canvas.getCommandStack().startTransaction();
	g_minimap.getCommandStack().startTransaction();
	g_canvas.getSelection().each(function(index, figure) {
		if (figure != null) {
			var figureId = figure.id;
			
			var cmd = figure.createCommand(new draw2d.command.CommandType(draw2d.command.CommandType.DELETE));
			if (cmd !== null) {
				g_canvas.getCommandStack().execute(cmd);
			}
			
			var mFigure = g_minimap.getFigure(figureId);
			if (mFigure != null) {
				var mCmd = mFigure.createCommand(new draw2d.command.CommandType(draw2d.command.CommandType.DELETE));
				if (mCmd !== null) {
					g_minimap.getCommandStack().execute(mCmd);
				}
			}
		}
	});
	g_canvas.getCommandStack().commitTransaction();
	g_minimap.getCommandStack().commitTransaction();
	resetDraggableElementsAttr();
	updateUndoRedoButton();
}

// 라인 모달창을 띄운다.
function openLineModal(line, bDropped) {
	if (g_bProperties) {
		return;
	}
	g_bProperties = true;
	$(".properties").remove();
	var param = line;
	param.dropped = bDropped;
	$.ajax({
		url: "detailLine",
        data: param,
        type: 'POST',
        success: function(data) {
        	$("div.draw").append(data);
        	$("#lineModalDiv").data("line", line);
        },
        error: function(e) {
			var error = JSON.parse(e.responseText);
			openAlertModal(error.errorMsg.cause.localizedMessage);
        },
        complete: function() {
        	g_bProperties = false;
        }
	});
}

// 모달창을 띄운다.
function showDetailDiv(detailDivId) {
	setTimeout(function() {
		$("#"+detailDivId).addClass("on");
		$(".tools").addClass("on");
		$(".draw_cont").addClass("on");
		$("#_atomMinimapDivWrapper").addClass("on");
	}, 0);
}

// 모달창을 숨긴다.
function hideDetailDiv() {
	$(".properties").removeClass("on");
	$(".tools").removeClass("on");
	$(".draw_cont").removeClass("on");
	$("#_atomMinimapDivWrapper").removeClass("on");
}

// draw2d 관련 오브젝트들을 초기화한다.
function initElements() {
	// 좌측 패키지, 노드, 연결노드, 프로세스 등 분류 버튼 클릭 시 드래그 오브젝트들을 토글한다.
	$(".accordion").click(function() {
		$(this).toggleClass("active");
		$(this).next("div").toggleClass("show");
	});
	
	// 저장 버튼
	$("#_atomSaveButton").click(function() {
		saveFlowDesign();
	});

	// 줌인 버튼
	$("#_atomZoomInButton").click(function() {
		var zoom = g_canvas.zoomFactor - 0.1;
		updateZoom(zoom);
	});

	// 줌아웃 버튼
	$("#_atomZoomOutButton").click(function() {
		var zoom = g_canvas.zoomFactor + 0.1;
		updateZoom(zoom);
	});

	// 원본크기 버튼
	$("#_atomResetZoomButton").click(function() {
		updateZoom(1);
	});

	// 미니맵 영역 클릭 이벤트
	// 캔버스 영역을 미니맵 영역에 맞게 스크롤한다.
	$("#_atomMinimapDivWrapper").click(function() {
		onMinimapClick();
	});
	
	// 미니맵 영역 드래그 이벤트
	// 캔버스 영역을 미니맵 영역에 맞게 스크롤한다.
	$("#_atomMinimapAreaDiv").draggable({
		helper: function(event) {
			var width = $("#_atomMinimapAreaDiv").width();
			var height = $("#_atomMinimapAreaDiv").height();
			var sHtml = "<div style=\"position:absolute;width:"+width+"px;height:"+height+"px;opacity:0;\"></div>";
			return sHtml;
		},
		drag: function(event, ui) {
			var maxRight = $("#_atomMinimapDivWrapper").width();
			var maxBottom = $("#_atomMinimapDivWrapper").height();
			var x = ui.position.left;
			var y = ui.position.top;
			var width = $("#_atomMinimapAreaDiv").width() + 2;
			var height = $("#_atomMinimapAreaDiv").height() + 2;
			if (x < 0) {
				x = 0;
			}
			if (y < 0) {
				y = 0;
			}
			if (x + width > maxRight) {
				x = maxRight - width;
			}
			if (y + height > maxBottom) {
				y = maxBottom - height;
			}
			$("#_atomMinimapAreaDiv").css({
				left: x,
				top: y
			});
			onMinimapDrag();
		}
	});

	// 캔버스영역 스크롤 이벤트
	// 미니맵 영역을 캔버스영역에 맞게 이동시킨다.
	$("#_atomFlowDesignDivWrapper").scroll(function() {
		onScrollDivWrapper();
	});

	// 삭제 버튼
	$("#_atomDeleteButton").click(function() {
		confirmDelete();
	});

	// Undo 버튼
	$("#_atomUndoButton").click(function() {
		hideDetailDiv();
		undoProc(g_canvas);
		undoProc(g_minimap);
		resetDraggableElementsAttr();
		updateUndoRedoButton();
	});

	// Redo 버튼
	$("#_atomRedoButton").click(function() {
		hideDetailDiv();
		redoProc(g_canvas);
		redoProc(g_minimap);
		resetDraggableElementsAttr();
		updateUndoRedoButton();
	});
	
	// 미니맵 토글 버튼
	$("#_atomToggleMinimapButton").click(function() {
		if ($("#_atomMinimapDivWrapper:visible").length > 0) {
			$("#_atomMinimapDivWrapper").addClass("off");
			$(this).removeClass("on");
		} else {
			refreshMinimap();
			$("#_atomMinimapDivWrapper").removeClass("off");
			$(this).addClass("on");
		}
	});

	// 리사이즈 버튼
	// 캔버스 영역의 사이즈를 조절하기 위한 모달창을 띄운다.
	$("#_atomResizeButton").click(function() {
		openResizeModal();
	});
	
	// 라인 모양 버튼
	initLineButtons();

	// 윈도우 리사이즈 이벤트
	$(window).resize(function() {
		onResizeWindow();
	});
}

// draw2d 오브젝트의 속성을 변경하는 커맨드 오브젝트
var AtomCommandAttr = draw2d.command.CommandAttr.extend({
	NAME: "AtomCommandAttr",
	init: function(figure, newAttributes) {
		this._super(figure, newAttributes);
		if (newAttributes.userData != null) {
			this.oldAttributes.userData =  $.extend({}, figure.userData);
		}
	},
	undo: function() {
		this._super();
		if (this.oldAttributes.userData != null) {
			this.figure.userData = this.oldAttributes.userData;
		}
	},
	redo: function() {
		this._super();
		if (this.newAttributes.userData != null) {
			this.figure.userData = this.newAttributes.userData;
		}
	}
});

// Undo 버튼 클릭시 호출된다.
function undoProc(canvas) {
	var commandStack = canvas.getCommandStack();
	commandStack.undo();
	commandStack = canvas.getCommandStack();
	var redoStack = commandStack.redostack;
	for (var i=0;i<redoStack.length;i++) {
		var stack = redoStack[i];
		if (stack.label == "Delete Shape") {
			undoDeleteShapeProc(stack.figure);
		} else if (stack.label == "Change Attributes") {
			undoChangeAttributesProc(stack.figure);
		}
		if (stack.commands != null) {
			var commands = stack.commands.data;
			for (var j=0;j<commands.length;j++) {
				var command = commands[j];
				if (command.label == "Delete Shape") {
					undoDeleteShapeProc(command.figure);
				} else if (command.label == "Change Attributes") {
					undoChangeAttributesProc(command.figure);
				}
			}
		}
	}
}

// Redo 버튼 클릭시 호출된다.
function redoProc(canvas) {
	var commandStack = canvas.getCommandStack();
	commandStack.redo();
	commandStack = canvas.getCommandStack();
	var undoStack = commandStack.undostack;
	for (var i=0;i<undoStack.length;i++) {
		var stack = undoStack[i];
		if (stack.label == "Delete Shape") {
		} else if (stack.label == "Change Attributes") {
			undoChangeAttributesProc(stack.figure);
		}
		if (stack.commands != null) {
			var commands = stack.commands.data;
			for (var j=0;j<commands.length;j++) {
				var command = commands[j];
				if (command.label == "Delete Shape") {
				} else if (command.label == "Change Attributes") {
					undoChangeAttributesProc(command.figure);
				}
			}
		}
	}
}

// Undo 버튼 클릭시 배치잡 draw2d 오브젝트 길이를 다시 셋팅한다. (텍스트 사이즈에 맞춰야 하기 때문)
function undoChangeAttributesProc(figure) {
	if (figure != null) {
		if (figure instanceof AtomBatchJob) {
			var width = figure.atomLabel.getBoundingBox().w + 40;
			if (figure.getCanvas().canvasId == g_minimap.canvasId) {
				width = g_canvas.getFigure(figure.id).getBoundingBox().w + 40;
			} 
			figure.setWidth(width);
		}
	}
}

// Undo 버튼 클릭 시 오브젝트들의 앞뒤 순서가 뒤죽박죽 되는 경우가 있어 아래 function 을 실행한다.
function undoDeleteShapeProc(figure) {
	if (figure != null) {
		if (figure instanceof AtomPkg) {
			figure.toBack();
		}
		if (figure.atomIcon != null) {
			figure.atomIcon.toFront();
		}
		if (figure.atomLabel != null) {
			// figure.atomLabel.toFront();
		}
		
		// undo 시 라벨의 위치가 틀어지는 버그가 있어서 다시 그려야 함.
		var children = figure.children.data;
		for (var i=0;i<children.length;i++) {
			var child = children[i];
			var childFigure = child.figure;
			var locator = child.locator;
			if (childFigure instanceof AtomLabel) {
				var text = "";
				if (figure.getCanvas().canvasId == g_canvas.canvasId) {
					text = childFigure.text;
				}
				var fontSize = childFigure.fontSize;
				var fontColor = childFigure.fontColor;
				var bold = childFigure.bold;
				
				var commandDelete = new draw2d.command.CommandDelete(childFigure);
				commandDelete.execute();
				
				var atomLabel = new AtomLabel({
					text: text,
					fontSize: fontSize,
					fontColor: fontColor,
					bold: bold
				});
				figure.add(atomLabel, new locator.constructor(figure));
				figure.atomLabel = atomLabel;
			}
		}
	}
}

// 윈도우 사이즈가 변경될 때 호출된다.
function onResizeWindow() {
	if (!g_bResizeProc) {
		return;
	}
	if (g_data.readonly) {
		calculateZoom();
		alignFigures();
	} else {
		resetMinimapPosition();
	}
}

// 줌 사이즈를 계산한다.
function calculateZoom() {
	var width = $("#_atomFlowDesignDivWrapper").width() - 10;
	var height = $("#_atomFlowDesignDivWrapper").height() - 10;
	
	$("#_atomFlowDesignDiv, #_atomFlowDesignDiv>svg").css({
		width: width,
		height: height
	});
	$("#_atomMinimapDivWrapper").css("transition-duration", "0s");
	resetMinimapPosition();
	refreshMinimap();
	updateZoom(1, false);
	$("#_atomMinimapDivWrapper").css("transition-duration", "0.4s");
}

// 미니맵 위치와 크기를 조정한다.
function resetMinimapPosition() {
	var width = $("#_atomFlowDesignDiv").width();
	var height = $("#_atomFlowDesignDiv").height();
	resizeElements(width, height);
}

// 라인 종류 버튼 클릭시 호출된다.
function initLineButtons() {
	$(".line>button").click(function () {
		$(".line>button").removeClass("on");
		$(this).addClass("on");
		var id = $(this).attr("id");
		var router = eval("new draw2d.layout.connection." + id + "()");
		draw2d.shape.basic.PolyLine.DEFAULT_ROUTER = router;
		var selection = g_canvas.getSelection().all.data;
		if (selection.length > 0) {
			g_canvas.commandStack.startTransaction();
			g_minimap.commandStack.startTransaction();
			for (var i = 0; i < selection.length; i++) {
				var figure = selection[i];
				if (figure instanceof draw2d.Connection) {
					
					var newAttributes = new Object();
					newAttributes.router = router;
					
					var commandAattr = new draw2d.command.CommandAttr(figure, newAttributes);
					g_canvas.commandStack.execute(commandAattr);
					
					var mFigure = g_minimap.getLine(figure.id);
					var mCommandAattr = new draw2d.command.CommandAttr(mFigure, newAttributes);
					g_minimap.commandStack.execute(mCommandAattr);
				}
			}
			g_canvas.commandStack.commitTransaction();
			g_minimap.commandStack.commitTransaction();
			updateUndoRedoButton();
		}
		return false;
	});
}

// 캔버스 영역에 드래그한 오브젝트를 드롭시 호출된다.
function dropObjectProc(ui) {
	var backgroundImage = $(ui.helper).css("background-image");
	var path = backgroundImage.replace("url(\"", "").replace("\")", "");
	var idx = path.indexOf("/images");
	path = path.substring(idx, path.length);
	var id = $(ui.helper).attr("id");
	var label = $(ui.helper).find("td").text();
	var canvasOffset = $("#_atomFlowDesignDiv").offset();
	var offset = ui.offset;
	var zoom = g_canvas.zoomFactor;
	var top = Math.round((offset.top - canvasOffset.top) * zoom);
	var left = Math.round((offset.left - canvasOffset.left) * zoom);
	var userData;
	if (id.indexOf("pkg_") == 0) {
		userData = $("#" + id).data("pkg");
		var pkg = userData;
		pkg.image_x = left;
		pkg.image_y = top;
		openPkgModal(pkg, true);
	} else if (id.indexOf("node_") == 0) {
		userData = $("#" + id).data("node");
		if (userData.node_name_old == "emptyNode" || userData.node_name_old == "emptyLinkedNode") {
			userData = $.extend({}, userData);
			userData.node_name_old = "";
			userData.node_name = "";
		}
		userData.image_x = left;
		userData.image_y = top;
		openNodeModal(userData, true);
	} else if (id.indexOf("procBase_") == 0) {
		userData = $("#"+id).data("procBase");
		var proc = $.extend({}, userData);
		proc.image_x = left;
		proc.image_y = top;
		proc.node_name_old = g_data.svc.node_name_old;
		proc.svc_id = g_data.svc.svc_id;
		openProcModal(proc, true);
	} else if (id.indexOf("proc_") == 0) {
		userData = $("#"+id).data("proc");
		var batchJob = new Object();
		batchJob.pkg_name = g_data.schedulerGroup.pkg_name;
		batchJob.group_name = g_data.schedulerGroup.group_name;
		batchJob.proc_no = userData.proc_no;
		batchJob.proc_name = userData.proc_name;
		batchJob.node_type = userData.node_type;
		batchJob.image_x = left;
		batchJob.image_y = top;
		openBatchJobModal(batchJob, true);
	}
}

// 패키지 모달창을 보여준다.
function openPkgModal(pkg, bDropped) {
	$(".properties").remove();
	var param = pkg;
	pkg.dropped = bDropped;
	$.ajax({
        url: "detailPkg",
        data: param,
        type: 'POST',
        success: function(data) {
        	$("div.draw").append(data);
        	$("#pkgModalDiv").data("pkg", pkg);
        },
        error: function(e) {
			var error = JSON.parse(e.responseText);
			openAlertModal(error.errorMsg.cause.localizedMessage);
        },
        complete: function() {
        }
	});
}

// 연결노드 모달창을 보여준다.
function openLinkedNodeModal(node, bDropped) {
	openNodeModal(node, bDropped);
}

// 노드 모달창을 보여준다.
function openNodeModal(node, bDropped) {
	$(".properties").remove();
	var param = node;
	param.dropped = bDropped;
	$.ajax({
        url: "detailNode",
        data: param,
        type: 'POST',
        async: false,
        success: function(data) {
           $("div.draw").append(data);
           $("#nodeModalDiv").data("node", node);
        },
        error: function(e) {
			var error = JSON.parse(e.responseText);
			openAlertModal(error.errorMsg.cause.localizedMessage);
        },
        complete: function() {
			
        }
	});
}

// Network Manager 의 좌측 패키지, 노드, 연결노드의 drag 를 enable, diable 한다.
// 이미 추가된 패키지, 노드, 연결노드의 drag 를 diable
// 추가되지 않은 패키지, 노드, 연결노드의 drag 를 enable
function resetDraggableElementsAttr() {
	if (g_data.type != LINE_TYPE_NETWORK || g_data.readonly) {
		return;
	}
	$("#pkgListDiv>div, #nodeListDiv>div, #linkedNodeListDiv>div").css("opacity", 1);
	$("#pkgListDiv>div, #nodeListDiv>div, #linkedNodeListDiv>div").draggable({
		disabled: false
	});
	$("#pkgListDiv>div, #nodeListDiv>div, #linkedNodeListDiv>div").css("cursor", "move");
	var figures = g_canvas.figures.data;
	for (var i=0;i<figures.length;i++) {
		var figure = figures[i];
		var userData = figure.userData;
		var elementId;
		if (figure instanceof AtomPkg) {
			elementId = "pkg_" + userData.pkg_name.replace(/ /g, "_");
		} else if (figure instanceof AtomNode || figure instanceof AtomLinkedNode) {
			elementId = "node_" + userData.node_name_old.replace(/ /g, "_");
		}
		$("#"+elementId).css("opacity", 0.2);
		$("#"+elementId).draggable({
			disabled: true
		});
		$("#"+elementId).css("cursor", "default");
	}
}

// 라인을 삭제한다.
function deleteLine(line) {
	var atomLine = g_canvas.getLine(line.image_uuid);
	if (atomLine != null) {
		deleteFigure(atomLine);
	}
	closeModal();
}

// draw2d 캔버스 영역을 초기화한다.
function initFlowDesign(selector) {
	var width = $(selector).width();
	var height = $(selector).height();
	var sHtml = "";
	sHtml += "<div id=\"_atomFlowDesignDivWrapper\">\n";
	sHtml += "	<div id=\"_atomDroppableDiv\" style=\"z-index:98;width:800px;height:600px;position:absolute;background:rgba(255,255,255,0.5);display:none;\"></div>\n";
	sHtml += "	<div id=\"_atomFlowDesignDiv\" style=\"width:800px;height:600px;\"></div>\n";
	sHtml += "</div>\n";
	sHtml += "<div id=\"_atomMinimapDivWrapper\" style=\"display:none;border:1px solid #9598a6;\">\n";
	sHtml += "	<div id=\"_atomMinimapDiv\" style=\"position:absolute;width:800px;height:600px;background-color:#e3e4e6;\"></div>\n";
	sHtml += "	<div id=\"_atomMinimapAreaDiv\" style=\"position:absolute;width:200px;height:150px;background-color:rgba(255,255,255,0.25);border:solid 1px #f24444;\"></div>\n";
	sHtml += "</div>\n";
	$(selector).append(sHtml);

	$("#_atomDroppableDiv").droppable({
		drop: function(event, ui) {
			dropObjectProc(ui);
		}
	});
	
	initLeavePageActions();
	initElements();
}

// 프로세스 모달창을 보여준다.
var g_bProperties = false;
function openProcModal(proc, bDropped) {
	if (g_bProperties) {
		return;
	}
	g_bProperties = true;
	$(".properties").remove();
	var param = proc;
	param.dropped = bDropped;
	$.ajax({
        url: "detailProc",
        data: param,
        type: 'POST',
        success: function(data) {
        	$("div.draw").append(data);
        	$("#procModalDiv").data("proc", proc);
        },
        error: function(e) {
			var error = JSON.parse(e.responseText);
			openAlertModal(error.errorMsg.cause.localizedMessage);
        },
        complete: function() {
        	g_bProperties = false;
        }
	});
}

// 배치잡 모달창을 보여준다.
function openBatchJobModal(batchJob, bDropped) {
	if (g_bProperties) {
		return;
	}
	g_bProperties = true;
	$(".properties").remove();
	var param = batchJob;
	param.dropped = bDropped;
	$.ajax({
        url: "detailBatchJob",
        data: param,
        type: 'POST',
        success: function(data) {
        	$("div.draw").append(data);
        	$("#batchJobModalDiv").data("batchJob", batchJob);
        },
        error: function(e) {
			var error = JSON.parse(e.responseText);
			openAlertModal(error.errorMsg.cause.localizedMessage);
        },
        complete: function() {
        	g_bProperties = false;
        }
	});
}

// draw2d 오브젝트의 포지션을 체크한다.
function isValidPosition(x, y, width, height) {
	var canvasWidth = g_canvas.getWidth();
	var canvasHeight = g_canvas.getHeight();
	if ((x >= 0) && (x + width <=  canvasWidth) && (y >= 0) && (y + height <= canvasHeight)) {
		return true;
	}
	return false;
}

// 페이지를 나가는 액션을 취할때 저장하지 않고 나가면 변경 사항을 잃게 된다는 알람 메시지 출력
function initLeavePageActions() {
	// Top Menu
	$(".nav li>a").each(function() {
		var href = $(this).attr("href");
		if (href != "#" && href.indexOf("javascript:") != 0) {
			var sScript = "";
			sScript += "javascript:if (g_bChanged) {";
			sScript += "openConfirmModal(\"<spring:message code="msg.configuration.networkmanager.warning.text"/>\", \"<spring:message code="msg.configuration.networkmanager.leave.confirm"/>\", function() {";
			sScript += "movePage(\""+href+"\");";
			sScript += "});";
			sScript += "} else {";
			sScript += "movePage(\""+href+"\");";
			sScript += "}";
			$(this).attr("href", sScript);
		}
	});
	
	// Top My Info, Recent Page
	$(".nav_info li>a, .page_title li>a").each(function() {
		var href = $(this).attr("href");
		if (href != "#") {
			var sScript = "";
			sScript += "javascript:if (g_bChanged) {";
			sScript += "openConfirmModal(\"<spring:message code="msg.configuration.networkmanager.warning.text"/>\", \"<spring:message code="msg.configuration.networkmanager.leave.confirm"/>\", function() {";
			sScript += href;
			sScript += "});";
			sScript += "} else {";
			sScript += href;
			sScript += "}";
			$(this).attr("href", sScript);
		}
	});
	
	// Left Menu
	$("#ml-menu li>a").each(function() {
		var href = $(this).attr("href");
		if (href != "#") {
			var sScript = "";
			sScript += "javascript:if (g_bChanged) {";
			sScript += "openConfirmModal(\"<spring:message code="msg.configuration.networkmanager.warning.text"/>\", \"<spring:message code="msg.configuration.networkmanager.leave.confirm"/>\", function() {";
			sScript += "movePage(\""+href+"\");";
			sScript += "});";
			sScript += "} else {";
			sScript += "movePage(\""+href+"\");";
			sScript += "}";
			$(this).attr("href", sScript);
		}
	});
}

// 페이지를 이동한다.
function movePage(sUrl) {
	$("#_atomTempForm").remove();
	var sHtml = "";
	sHtml += "<form id=\"_atomTempForm\" action=\""+sUrl+"\" method=\"post\">";
	sHtml += "</form>";
	$("body").append(sHtml);
	$("#_atomTempForm").submit();
}
</script>