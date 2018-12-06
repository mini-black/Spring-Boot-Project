<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>接口测试页</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
		$('#sysNumId').change(function(){
			$.post("<%=request.getContextPath()%>/apiTools/findApiNameListBySysNumId",{"sysNumId":$("#sysNumId").val()},
					function(result){
						var obj,i;
						if (result.isSuccess){
							obj=document.getElementById('apiname');
							obj.options.length=1;
							for (i=0;i<result.commonCallTableInfoBySysNumId.length;i++){
								obj.options.add(new Option(result.commonCallTableInfoBySysNumId[i].funcname,result.commonCallTableInfoBySysNumId[i].cmd));
							}
						} else {
							alert("通过所属系统获取失败!");
						}
						
			},"json")
		})
    });

   $(document).ready(function(){
		$('#apiname').change(function(){
			$.post("<%=request.getContextPath()%>/apiTools/findByCmd",{"cmd":$("#apiname").val()},
					function(result){
						if (result.isSuccess){
							$("#cmd").val(result.commonCallTableInfoByCmd.cmd);
							$("#method").val(result.commonCallTableInfoByCmd.funcname);
							$("#params").val(result.commonCallTableInfoByCmd.requestSample);
						} else {
							alert("通过CMD获取失败!");
						}
			},"json")
		})
	});
   
    $(document).ready(function(){   
	    $("#showButton").click(function(){
 		   	$.post("<%=request.getContextPath()%>/apiTools/queryApiNameByCmd",{"cmd":$("#cmd").val()},
				function(result){
					if (result.isSuccess){
						$("#params").val(result.commonCallTableInfoByCmd.requestSample);
						$("#method").val(result.commonCallTableInfoByCmd.funcname);
						$("#sysNumId").val(result.commonCallTableInfoByCmd.sysNumId);
					} else {
						alert("获取失败!");
					}
			},"json")
 	   });
  	}) 
  	
	$(document).ready(function(){   
	    $("#methodButton").click(function(){
 		   	$.post("<%=request.getContextPath()%>/apiTools/queryApiNameByFuncname",{"funcname":$("#method").val()},
				function(result){
					if (result.isSuccess){
						$("#params").val(result.commonCallTableInfoByFuncname.requestSample);
						$("#cmd").val(result.commonCallTableInfoByFuncname.cmd);
						$("#sysNumId").val(result.commonCallTableInfoByFuncname.sysNumId);
					} else {
						alert("获取失败!");
					}
			},"json")
 	   });
  	})
  	
  	$(document).ready(function(){   
	    $("#refreshButton").click(function(){
 		   	$.post("<%=request.getContextPath()%>/apiTools/refreshChache",
				function(result){
					if (result.isSuccess){
						alert("缓存刷新成功!");
					} else {
						alert("获取失败!");
					}
			},"json")
 	   });
  	})
    function checkForm(){
    	var convertFlag = 'N';
      if($("#isConvertFlag").is(':checked')==true){
      		convertFlag = 'Y';
      };
    	var method = $("#method").val();
    	var params = $("#params").val();
    	var appKey = $("#appKey").val();
       $.ajax({
                type:"POST",
                url: "<%=request.getContextPath()%>/apiTools/execute",
                data:{method:method,params:params,app_key:appKey,convert_flag:convertFlag},
                datatype:"json",
                success:function(data){
                 $("#resultShow").val(JSON.stringify(data));            
                },
                error: function(){
                   alert("访问出错");
                }         
             });
      }
      
      function generateDocParams(){
    		var cmd = $("#cmd").val();
      	var method = $("#method").val();
      	var params = $("#params").val();
      	var resultParams = $("#resultShow").val();
      	var appKey = $("#appKey").val();
      	var functionNumId = $("#functionNumId").val();
      	var is_cover = 0;
      	if($("#isCheckOver").attr("checked")==true){
      		is_cover = 1;
      	}
         $.ajax({
                  type:"POST",
                  url: "<%=request.getContextPath()%>/apiTools/createDocument",
                  data:{method:method,params:params,resultParams:resultParams,app_key:appKey,functionNumId:functionNumId,is_cover:is_cover,cmd:cmd},
                  datatype:"json",
                  success:function(data){
                   $("#resultParams").val(JSON.stringify(data));            
                  },
                  error: function(){
                     alert("访问出错");
                  }         
               });
        }
    function clearResult(){
   	 $("#resultShow").val("");
     }
    function clearDocParamsResult(){
      	 $("#resultParams").val("");
    }
 </script>
</head>

<body>
	<h3 align="center">API接口测试</h3>
	<table  style="padding-left:100px">
<tr>
<td  width="120" align="left" >CMD：</td>
<td><input name="cmd" id="cmd">
	<input id="showButton" type="button" value="查询" style="width:60px;height:24px;*padding-top:3px;border:#666666 1px solid;cursor:pointer">
</td>
</tr>

<tr>
<td  width="120" align="left" >服务方法：</td>
<td><input name="method" id="method" style="width:210px">
	<input id="methodButton" type="button" value="查询" style="width:60px;height:24px;*padding-top:3px;border:#666666 1px solid;cursor:pointer">
</td>
</tr>




<tr>
<td width="200" align="left">系统名称：</td>
<td>
	<select name="sysNumId" id="sysNumId" style="width:215px;">
			<option value="">--请选择服务--</option>
		<c:forEach items="${exArcSystemList}" var="exArcSystem">
			<option class="chooseLi" value="${exArcSystem.sysNumId}">${exArcSystem.sysName}</option>
		</c:forEach>
	</select>
</td>
</tr>
<tr>
<td width="160" align="left">方法全称：</td>
	<td>
			<select id="apiname" name="apiname" style="width:400px;">
				<option  value="">-----请选择-----</option>			
			</select>
	</td>
</tr>

<tr>
	<td width="200" align="left">appKey：</td>
	<td><input  name="appKey" id="appKey" value="1001"/><input name="isConvertFlag" type="checkbox" id="isConvertFlag" />T驼峰JSON
	<input id="refreshButton" type="button" value="刷新缓存" style="width:70px;height:24px;*padding-top:3px;border:#666666 1px solid;cursor:pointer;margin-left: 48px;"></td>	
</tr>

<tr>
<td>请求参数示例：</td>
<td><textarea name="params" id="params" cols="90" rows="10" ></textarea></td>
</tr>
<tr>
<td>返回结果：</td>
<td>
<textarea name="resultShow" id="resultShow" cols="90" rows="10" ></textarea>
</td>
</tr>

<tr>
	<td width="160">&nbsp;</td>
	<td width="340" align="left">
		<input id="apiTestButton" type="button" value="提交测试(Execute)" onclick="checkForm()" style="width:120px;height: 31px;*padding-top:3px;border:#666666 1px solid;cursor:pointer">
		<input type="button" value="清空结果" onclick="clearResult()" style="height: 30px; ">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</td>
</tr>	
<tr>
<td>输出参数示例：</td>
<td><textarea name="resultParams" id="resultParams" cols="90" rows="10" ></textarea></td>
</tr>									
<tr>
 <td>&nbsp;</td>
<td >
<input id="generatJsonButton" type="button" value="生成文档参数" onclick="generateDocParams()" style="width:120px;height: 31px;*padding-top:3px;border:#666666 1px solid;cursor:pointer">
&nbsp;&nbsp;&nbsp;<input type="button" value="清空文档参数结果" onclick="clearDocParamsResult()" style="height: 30px; ">
<input type="checkbox" id="isCheckOver" value=""  />是否覆盖<input  name="functionNumId" id="functionNumId" value=""/>接口编号</td>


</tr>
</table>
 
 
</body>
</html>