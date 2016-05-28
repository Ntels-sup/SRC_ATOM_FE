<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="/WEB-INF/tag/ntels.tld" prefix="ntels"%>

<link rel="stylesheet" href="/styles/tree/ui.dynatree.css" type="text/css">

<!-- dynatree -->
<script type="text/javascript" src="/scripts/tree/jquery.dynatree.js" charset="utf-8"></script>


<script type="text/javascript">
$(document).ready(function(){
	// Tree Setting
	var tree = $("#prc_tree");

	$(tree).dynatree({
		selectMode: 1,
		clickFolderMode: 3,
		minExpandLevel: 4,
		
		initAjax: {
			url: "/ofcs/monitor/systemTree.json"
			//data: {depth: treeDepth}
		},
		onClick: function(node, event) {
			var key = node.data.key;
			var title = node.data.title;
			var level = node.getLevel();
			
			var package_id = "";
			var package_name = "";
			var system_id = "";
			var system_name = "";
			var service_id = "";
			var service_name = "";
			var component_type = "";
			var component_name = "";
			var process_id = "";
			var process_name = "";
			var input_level ='';
			var tr = "";
			var keyArr = "";
			
			if (level == '1') {
				tr = $("<tr>");
				tr.append("<td style=\"font:12px Arial; height:20px; font-weight: bold; width:10%\">Destination :</td>");
				tr.append("<td style=\"font:12px Arial; height:20px; color:white; font-weight: bold; background-color:#F58D3A; text-align:center; width:30%\">Charging Gateway System</td>");
				tr.append("<td style=\"width:60%\"></td>");
				tr.append("</tr>");
      	 		$('#target_title').html(tr);
      
			} else if (level == '2') {  
				package_id = key;
				package_name = title;
				input_level = level;
				
				tr = $("<tr>");
				tr.append("<td style=\"font:12px Arial; height:20px; font-weight: bold; width:10%\">Destination :</td>");
				tr.append("<td style=\"font:12px Arial; height:20px; color:white; font-weight: bold; background-color:#F58D3A; text-align:center; width:15%\">"+package_name+"</td>");
				tr.append("<td style=\"width:75%\"></td>");
				tr.append("</tr>");
				
				$('#target_title').html(tr);
				//alert("level :2 \n system_id:"+system_id);
			} else if (level == '3') {  
				keyArr = key.split(":");
				package_id = keyArr[0];
				package_name = node.parent.data.title;
				system_id = keyArr[1];
				system_name = title;
				input_level = level;
				
/* 				system_id = node.parent.data.key;
				package_id = key;
				input_level = level; */
				
				//console.log("level="+level);
				
				tr = $("<tr>");
				tr.append("<td style=\"font:12px Arial; height:20px; font-weight: bold; width:10%\">Destination :</td>");
				tr.append("<td style=\"font:12px Arial; height:20px; color:white; font-weight: bold; background-color:#F58D3A; text-align:center; width:15%\">"+package_name+"</td>");
				tr.append("<td style=\"width:2%\"></td>");
				tr.append("<td style=\"font:12px Arial; height:20px; color:white; font-weight: bold; background-color:#F58D3A; text-align:center; width:15%\">"+system_name+"</td>");
				tr.append("<td style=\"width:58%\"></td>");
				tr.append("</tr>");
				
				$('#target_title').html(tr);
				//alert("level :3 \n system_id:"+system_id+"\n package_id:"+package_id);
			} else if (level == '4') { 
				keyArr = key.split(":");
				package_id = keyArr[0];
				package_name = node.parent.parent.data.title;
				system_id = keyArr[1];
				system_name = node.parent.data.title;
				service_id = keyArr[2];
				service_name = title;
				input_level = level;
				
/* 				system_id = node.parent.parent.data.key;
				package_id = node.parent.data.key;
				service_id = key;
				input_level = level; */
				
				//console.log("level="+level);
				
				tr = $("<tr>");
				tr.append("<td style=\"font:12px Arial; height:20px; font-weight: bold; width:10%\">Destination :</td>");
				tr.append("<td style=\"font:12px Arial; height:20px; color:white; font-weight: bold; background-color:#F58D3A; text-align:center; width:15%\">"+package_name+"</td>");
				tr.append("<td style=\"width:2%\"></td>");
				tr.append("<td style=\"font:12px Arial; height:20px; color:white; font-weight: bold; background-color:#F58D3A; text-align:center; width:15%\">"+system_name+"</td>");
				tr.append("<td style=\"width:2%\"></td>");
				tr.append("<td style=\"font:12px Arial; height:20px; color:white; font-weight: bold; background-color:#F58D3A; text-align:center; width:15%\">"+service_name+"</td>");
				tr.append("<td style=\"width:41%\"></td>");
				tr.append("</tr>");
				
				$('#target_title').html(tr);
				//alert("level :4 \n system_id:"+system_id+"\n package_id:"+package_id+"\n service_id:"+service_id);
			} else if (level == '5') {
				keyArr = key.split(":");
				package_id = keyArr[0];
				package_name = node.parent.parent.parent.data.title;
				system_id = keyArr[1];
				system_name = node.parent.parent.data.title;
				service_id = keyArr[2];
				service_name = node.parent.data.title;
				component_type = keyArr[3];
				component_name = title;
				input_level = level;
				
/* 				system_id = node.parent.parent.parent.data.key;
				package_id = node.parent.parent.data.key;
				service_id = node.parent.data.key;
				component_type = key;
				input_level = level; */
				
				tr = $("<tr>");
				tr.append("<td style=\"font:12px Arial; height:20px; font-weight: bold; width:10%\">Destination :</td>");
				tr.append("<td style=\"font:12px Arial; height:20px; color:white; font-weight: bold; background-color:#F58D3A; text-align:center; width:15%\">"+package_name+"</td>");
				tr.append("<td style=\"width:2%\"></td>");
				tr.append("<td style=\"font:12px Arial; height:20px; color:white; font-weight: bold; background-color:#F58D3A; text-align:center; width:15%\">"+system_name+"</td>");
				tr.append("<td style=\"width:2%\"></td>");
				tr.append("<td style=\"font:12px Arial; height:20px; color:white; font-weight: bold; background-color:#F58D3A; text-align:center; width:15%\">"+service_name+"</td>");
				tr.append("<td style=\"width:2%\"></td>");
				tr.append("<td style=\"font:12px Arial; height:20px; color:white; font-weight: bold; background-color:#F58D3A; text-align:center; width:15%\">"+component_name+"</td>");
				tr.append("<td style=\"width:24%\"></td>");
				tr.append("</tr>");
				
				//$('#target_title').html("선택 대상 : "+node.parent.parent.parent.data.title+":"+node.parent.parent.data.title+":"+node.parent.data.title+":"+title);
				$('#target_title').html(tr);
				//alert("level :5 \n system_id:"+system_id+"\n package_id:"+package_id+"\n service_id:"+service_id+"\n component_type:"+component_type);
			} else if (level == '6') { 
				keyArr = key.split(":");
				package_id = keyArr[0];
				package_name = node.parent.parent.parent.parent.data.title;
				system_id = keyArr[1];
				system_name = node.parent.parent.parent.data.title;
				service_id = keyArr[2];
				service_name = node.parent.parent.data.title;
				component_type = keyArr[3];
				component_name = node.parent.data.title;
				process_id = keyArr[4];
				process_name = title;
				input_level = level;
				
/* 				system_id = node.parent.parent.parent.parent.data.key;
				package_id = node.parent.parent.parent.data.key;
				service_id = node.parent.parent.data.key;
				component_type = node.parent.data.key;
				var temp_array = key.split(":");
				process_id = temp_array[1];
				input_level = level; */
				
				tr = $("<tr>");
				tr.append("<td style=\"font:12px Arial; height:20px; font-weight: bold; width:10%\">Destination :</td>");
				tr.append("<td style=\"font:12px Arial; height:20px; color:white; font-weight: bold; background-color:#F58D3A; text-align:center; width:15%\">"+package_name+"</td>");
				tr.append("<td style=\"width:2%\"></td>");
				tr.append("<td style=\"font:12px Arial; height:20px; color:white; font-weight: bold; background-color:#F58D3A; text-align:center; width:15%\">"+system_name+"</td>");
				tr.append("<td style=\"width:2%\"></td>");
				tr.append("<td style=\"font:12px Arial; height:20px; color:white; font-weight: bold; background-color:#F58D3A; text-align:center; width:15%\">"+service_name+"</td>");
				tr.append("<td style=\"width:2%\"></td>");
				tr.append("<td style=\"font:12px Arial; height:20px; color:white; font-weight: bold; background-color:#F58D3A; text-align:center; width:15%\">"+component_name+"</td>");
				tr.append("<td style=\"width:2%\"></td>");
				tr.append("<td style=\"font:12px Arial; height:20px; color:white; font-weight: bold; background-color:#F58D3A; text-align:center; width:15%\">"+process_name+"</td>");
				tr.append("<td style=\"width:7%\"></td>");
				tr.append("</tr>");
				
				$('#target_title').html(tr);
				//alert("level :6 \n system_id:"+system_id+"\n package_id:"+package_id+"\n service_id:"+service_id+"\n component_type:"+component_type+"\n process_id:"+process_id);
			}
			
/* 			console.log("=====> Onclick <=========");
			console.log("system_id="+system_id);
			console.log("package_id="+package_id);
			console.log("service_id="+service_id); */
			
			$("#package_id").val(package_id);
			$("#package_name").val(package_name);
			$("#system_id").val(system_id);
			$("#system_name").val(system_name);
			$("#service_id").val(service_id);
			$("#service_name").val(service_name);
			$("#component_type").val(component_type);
			$("#component_name").val(component_name);
			$("#process_id").val(process_id);
			$("#process_name").val(process_name);
			$("#input_level").val(input_level);
			$("#command").val("");
			$("#argument").val("");
			//clickTreeHandler(node, event);
		},
		onDblClick: function(node) {
			//if(node.data.isFolder) {
				//node.toggleExpand();
			//}
		}
	});
	// Tree Expand Button
	$("#btnCollapseAll").click(function(){
		$(tree).dynatree("getRoot").visit(function(node){
			node.expand(false);
		});
		return false;
	});
	$("#btnExpandAll").click(function(){
		$(tree).dynatree("getRoot").visit(function(node){
			node.expand(true);
		});
		return false;
	});

});


</script>

<%-- <jsp:include page="./tree_script.jsp" flush="true"/> --%>

                  <div class="udbs_tree">
                     <div class="udbsOpt">
                        <ul class="treeCon">
                           <!-- <li><a id="btnExpandAll" class="full" href="#" title="펼침"></a></li>
                           <li><a id="btnCollapseAll" class="close" href="#" title="접힘"></a></li> -->
                        </ul>
                        <!-- <div class="exemtree" style="position:absolute; left:260px; top:5px; z-index:10"></div> -->
                     </div>               
                     <div id="prc_tree"></div>
                  </div>
