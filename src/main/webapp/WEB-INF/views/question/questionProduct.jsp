<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/frameset.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../com/easyui.jsp"%>
<html>
<head>
<TITLE>Student Register</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="<c:url value='/resources/css/main.css' />" rel="stylesheet"
	type="text/css" media="screen" />
<script type="text/javascript"
	src="<c:url value='/resources/js/selectAll.js' />"></script>

<script type="text/javascript"
	src="<c:url value='/resources/js/dialog.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/resources/js/dateFormat.js'/>"></script>

<title>问题产生</title>
<script type="text/javascript">
	//处理问题类型
	var multiplechoice = "";
	var factoid = "";
	var deeper = "";
	var original = "";
	var multiplechoiceStartTime="";
	var multiplechoiceEndTime="";
	var factoidStartTime="";
	var factoidEndTime="";
	var deeperStartTime="";
	var deeperEndTime="";
	var originalStartTime="";
	var originalEndTime="";
	$(function() {
		$("#multiplechoiceShowQuestion").hide();
		$("#factoidShowQuestion").hide();
		$("#deeperShowQuestion").hide();
		$("#originalShowQuestion").hide();
		$("#multiplechoiceNextId").hide();
		$("#factoidNextId").hide();
		$("#deeperNextId").hide();
		$("#submitClick").hide();
		var type = "${types}";
		console.log(type);
		var types = type.split("-");//factohibernate.cfg.xmlid deeper original
		for (var i = 0; i < types.length; i++) {
			if (types[i] == "multiplechoice") {
				multiplechoice = "multiplechoice";
			}
			if (types[i] == "factoid") {
				factoid = "factoid";
			}
			if (types[i] == "deeper") {
				deeper = "deeper";
			}
			if (types[i] == "original") {
				original = "original";
			}
		}

		//控制初始显示的数据
		if (multiplechoice != "") {
			showMultiplechoice();
			multiplechoiceStartTime=new Date().format("yyyy-MM-dd hh:mm:ss");
		} else if (factoid != "") {
			showFactiod();
			 factoidStartTime=new Date().format("yyyy-MM-dd hh:mm:ss");
		} else if (deeper != "") {
			deeperStartTime=new Date().format("yyyy-MM-dd hh:mm:ss");
			showDeeper();
		} else if (original != "") {
			originalStartTime=new Date().format("yyyy-MM-dd hh:mm:ss");
			showOriginal();
			$('#loading').hide();
			$('#infor').html('请添加问题！点击【发布作业】进行作业布置');
		}

	})
	function multiplechoiceNext() {
		multiplechoiceEndTime = new Date().format("yyyy-MM-dd hh:mm:ss");
		if (factoid != "") {
			factoidStartTime = new Date().format("yyyy-MM-dd hh:mm:ss");
			showFactoid();
		} else if (deeper != "") {
			deeperStartTime = new Date().format("yyyy-MM-dd hh:mm:ss");
			showDeeper();
		} else if (original != "") {
			originalStartTime = new Date().format("yyyy-MM-dd hh:mm:ss");
			showOriginal();
		}
	}
	function factoidNext() {
		factoidEndTime = new Date().format("yyyy-MM-dd hh:mm:ss");
		if (deeper != "") {
			deeperStartTime = new Date().format("yyyy-MM-dd hh:mm:ss");
			showDeeper();
		} else if (original != "") {
			originalStartTime = new Date().format("yyyy-MM-dd hh:mm:ss");
			showOriginal();
		}
	}
	function deeperNext() {
		deeperEndTime = new Date().format("yyyy-MM-dd hh:mm:ss");
		if (original != "") {
			originalStartTime=new Date().format("yyyy-MM-dd hh:mm:ss");
			showOriginal();
		}
	}
	function showMultiplechoice() {
		$("#multiplechoiceShowQuestion").show();
		if (factoid != "" || deeper != "" || original != "") {
			$("#multiplechoiceNextId").show();
		} else {
			$("#submitClick").show();
		}
	}
	function showFactoid() {
		$("#factoidShowQuestion").show();
		if (deeper != "" || original != "") {
			$("#factoidNextId").show();
		} else {
			$("#submitClick").show();
		}
	}
	function showDeeper() {
		$("#deeperShowQuestion").show();
		if (original != "") {
			$("#deeperNextId").show();
		} else {
			$("#submitClick").show();
		}
	}
	function showOriginal(sec) {
		$("#originalShowQuestion").show();
		$("#submitClick").show();
	}
	/* 处理问题类型结束 */
	
	/* 产生问题开始 */
	$(function() {
		/*调用问题产生的算法 产生问题 开始*/
		var contentText = "${content}";
		var content = [];
		content[0] = "${tittle}";
		content[1] = contentText;
		if(multiplechoice != ""){
			pasteQuestion();
		}
		if(factoid !=""||deeper!=""){
			analyze(content);
		}
		/*调用问题产生的算法 产生问题 结束*/
	});
	/* 产生问题结束 */
	
	/* 发布作业 */
	function linkText() {
		location.href = "/question/text/queryText/1";
	}
	function addQuestion(ck) {
		if(originalStartTime!=""){
			originalEndTime=new Date().format("yyyy-MM-dd hh:mm:ss");
		}else if(deeperStartTime!=""){
			deeperEndTime = new Date().format("yyyy-MM-dd hh:mm:ss");
		}else if(factoidStartTime !=""){
			factoidEndTime = new Date().format("yyyy-MM-dd hh:mm:ss");
		}else if(multiplechoiceStartTime !=""){
			multiplechoiceEndTime = new Date().format("yyyy-MM-dd hh:mm:ss");
		}
		var str3 = "[{'multiplechoiceStartTime':'" + multiplechoiceStartTime + "','multiplechoiceEndTime':'" + multiplechoiceEndTime
		+ "','factoidStartTime':'" + factoidStartTime + "','factoidEndTime':'" + factoidEndTime 
		+ "','deeperStartTime':'" + deeperStartTime + "','deeperEndTime':'" + deeperEndTime 
		+ "','originalStartTime':'" + originalStartTime + "','originalEndTime':'" + originalEndTime+ "'}]";
		
		if(!add1(ck)){
			return false;
		}
		var cks = document.getElementsByClassName(ck);
		var checkId = 0;
		var count = 0;
		var textId = $("input[name='textId']").val();
		var assTime = $("select[name='assTime']").val();
		var startDate = $("input[name='startDate']").val();
		var str1 = "[{'textId':'" + textId + "','assTime':'" + assTime
				+ "','startDate':'" + startDate + "'}]";
		var str2 = "";
		str2 = "[";
		for (var i = 0; i < cks.length; i++) {
			if(cks[i].checked){
				if (cks[i].getAttribute("name")=="multiplechoice") {
					count++;
					var sentence = $("td#sentence" + cks[i].value).text();
					var question = $("td#question" + cks[i].value).text();
					var answer = $("td#answer" + cks[i].value).text();
					/* alert(sentence+":"+question+":"+answer+":"+label); */
					var disp = document.getElementsByName("multiplechoice"+i);
					if (count == 1) {
						str2 += "{'sentence':'" + sentence + "','question':'"
								+ question + "','answer':'" + answer
								+  "','questiontype':'选择题','distracter':[";
						for(var n = 0; n < disp.length; n++){
							if(n==0)
								str2 += "'"+disp[n].value + "'";
							else
								str2 += ",'"+disp[n].value + "'";
						}
						str2 += "]}";
					} else {
						str2 += ",{'sentence':'" + sentence + "','question':'"
								+ question + "','answer':'" + answer
								+ "','questiontype':'multiplechoice','distracter':[";
						for(var n = 0; n < disp.length; n++){
							if(n==0)
								str2 += "'"+disp[n].value + "'";
							else
								str2 += ",'"+disp[n].value + "'";
							
						}
						str2 += "]}";
					}
				} else {
					count++;
					var sentence = $("td#sentence" + cks[i].value).text();
					var question = $(
							"textarea.question[name='" + cks[i].value + "']").val();
					var answer = $("textarea.answer[name='" + cks[i].value + "']")
							.val();
					var label = $("td#label" + cks[i].value).text();
					/* alert(sentence+":"+question+":"+answer+":"+label); */
					if (count == 1) {
						str2 += "{'sentence':'" + sentence + "','question':'"
								+ question + "','answer':'" + answer
								+ "','questiontype':'" + label + "'}";
					} else {
						str2 += ",{'sentence':'" + sentence + "','question':'"
								+ question + "','answer':'" + answer
								+ "','questiontype':'" + label + "'}";
					}
				}
			}
		}
		str2 += "]";
		console.log(str1+str2+str3);
		var json = {};
		json.content = eval("(" + str2 + ")");//转换为json对象 
		json.ass = eval("(" + str1 + ")");
		json.log= eval("(" + str3 + ")");
		var post = {
			data : JSON.stringify(json)
		};//JSON.stringify(json)把json转化成字符串
		var url = "/question/assignment/addAssignment";
		$.post(url, post, function(data) {
			//return "redirect:";fail
			if (data == "success") {
				location.href = "/question/assignment/queryAssignment/1";
			} else {
				$.messager.alert('消息反馈', '本次布置作业失败！');
			}
		});
	}
	
	/* 添加问题 */
	var count =1;
	function addOriginal(){
			
			
			var question = $("textarea.question[name='add" +count+ "']").val();
			var answer = $("textarea.answer[name='add" +count+ "']").val();
			if(question==""){
				$.messager.alert('提示', '请输入问题');
				return ;
			}
			if(answer==""){
				$.messager.alert('提示', '请输入参考答案');
				return ;
			}
			count++;
			var id = "add"+count;
			var original = $("#originalShowQuestion");
			var html="<tr>" +
			"<td style='display: none'><input type='checkbox' class='questionNum' name='ck' checked='checked' value='"+id+"'></td>" +
			"<td style='display: none' id='sentence"+id+"'></td>" +
			"<td align=center colspan=2><textarea rows='3' cols='80%' class='question' name='"+id+"'></textarea></td>" +
			"<td align=center><textarea rows='3' cols='50%' class='answer' name='"+id+"' ></textarea></td>" +
			"<td style='display: none' id='label"+id+"'>原始问题</td>" +
			"</tr>";
			original.append(html);
	}
</script>
</head>
<body>
	<div class="div3">
		<font size="4"><label>课文标题：</label>${tittle}</font>
		<div style="float: right">
			<font size="4">课程名：${courseName}&nbsp;</font>
		</div>
	</div>
	<div style="width: 98%; padding-left: 20px">
		<font size="3"> <c:forEach var="sentence" items="${sentences}">
				&nbsp;&nbsp;
				${sentence}<br>
			</c:forEach>
		</font>
	</div>

	<div class="div3">
		<font size="4"><label id="infor"></label></font> <img id="loading"
			width="20px" src="<c:url value='/resources/images/loading.gif'/>">
	</div>
	<div class="div4">
		<form action="#" method="post">
			<input type="hidden" id="textId" name="textId" value="${textId}"> <input
				type="hidden" name="startDate" value="${startDate}">
			<table border="1" class="editTab" id="multiplechoiceShowQuestion">
				<tr>
					<th colspan="5" align="left">选择题
					</th>
				</tr>
				<tr>
					<th width="3%"><input type="checkbox" id="selectAllMultipleChoice"
						onclick="checkEvent('multiplechoice','selectAllMultipleChoice')" /></th>
					<th width="35%">句子</th>
					<th width="35%">问题</th>
					<th width="22%">候选项</th>
					<th width="8%">答案</th>
				</tr>
			</table>
			<script src="<c:url value='/resources/question/js/multiple-choice/question-generator.js'/>"></script>
			<p id="multiplechoiceNextId" align="center">
				<input type="button" onclick="multiplechoiceNext()" class="btnPaleGreen"
					style="width: 100px" value="下一题">
				<!-- <input type="button" id="deeperLastId" onclick="deeperLast()" class="btnGray" style="width: 100px" value="上一题"> -->
			</p>
			<table border="1" class="editTab" id="factoidShowQuestion">
				<tr>
					<th colspan="5" align="left">事实类问题
					</th>
				</tr>
				<tr>
					<th width="3%"><input type="checkbox" id="selectAll"
						onclick="checkEvent('ck','selectAll')" /></th>
					<th width="42%">句子</th>
					<th width="35%">问题</th>
					<th width="12%">参考答案</th>
					<th width="8%">问题类别</th>
				</tr>
			</table>
			<p id="factoidNextId" align="center">
				<input type="button" onclick="factoidNext()" class="btnPaleGreen"
					style="width: 100px" value="下一题">
				<!-- <input type="button" id="deeperLastId" onclick="deeperLast()" class="btnGray" style="width: 100px" value="上一题"> -->
			</p>
			<table border="1" class="editTab" id="deeperShowQuestion">
				<tr>
					<th colspan="5" align="left">深层次问题
					</th>
				<tr>
					<th width="3%"><input type="checkbox" id="selectAll"
						onclick="checkEvent('ck','selectAll')" /></th>
					<th width="42%">句子</th>
					<th width="35%">问题</th>
					<th width="12%">参考答案</th>
					<th width="8%">问题类别</th>
				</tr>
			</table>
			<p id="deeperNextId" align="center">
				<input type="button" onclick="deeperNext()" class="btnPaleGreen"
					style="width: 100px" value="下一题">
			</p>
			<table border="1" class="editTab" id="originalShowQuestion">
				<tr>
					<th colspan="3" align="left">手动添加问题</th>
				<tr>
					<th  width="10%"><input type="button" onclick="addOriginal()" class="btnGray"
					style="width: 80px" value="添加"></th>
					<th width="50%">问题</th>
					<th width="40%">参考答案</th>
				</tr>
				
				
			</table>

			<p id="submitClick" align="center">
				设置作业限时：<select class="text" name="assTime">
					<option value="10">10分钟</option>
					<option value="6">5分钟</option>
					<option value="15">15分钟</option>
					<option value="20">20分钟</option>
					<option value="30">25分钟</option>
					<option value="30">30分钟</option>
				</select> <input type="button" onclick="return addQuestion('questionNum')"
					class="btnPaleGreen" name="submit" value="布置作业"
					style="width: 100px"> <input type="button"
					onclick="linkText()" class="btnGray" value="返回课文"
					style="width: 100px"> <br> <br>
			</p>
		</form>
	</div>
</body>
<script src="<c:url value='/resources/question/js/common.js'/>"></script>
<script src="<c:url value='/resources/question/js/pos.js'/>"></script>
<script src="<c:url value='/resources/question/js/srl.js'/>"></script>
<script src="<c:url value='/resources/question/js/last.js'/>"></script>
<script src="<c:url value='/resources/question/js/mq.js'/>"></script>
<script
	src="<c:url value='/resources/question/js/wipeNeedlessComponent.js'/>"></script>
<script
	src="<c:url value='/resources/question/js/questionGenerator.js'/>"></script>
<script src="<c:url value='/resources/question/js/causeResult.js'/>"></script>
<script src="<c:url value='/resources/question/js/how.js'/>"></script>

</html>