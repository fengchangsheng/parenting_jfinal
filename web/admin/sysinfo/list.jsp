<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${basePath }/include/js/highcharts/highcharts.js"></script>
<title></title>
<script type="text/javascript">
	var jsonData;
	$(function () {
		getData();
		setInterval("getData()",5000);
	});
	
	function getData(){
		$.ajax({
			cache: true,
			type: "POST",
			url:"${basePath}/admin/sysinfo/ifm/listSystemInfo",
			data: {nodeGrade:"0",parentNode:"0"},
			async: false,
		    error: function(request) {
		        alert("数据加载失败,请刷新页面!");
		    },
		    success: function(data) {
		    	jsonData=eval("(" + data + ")");
		    }
		});
		
		for(var x=0;x<jsonData.listCpu.length;x++){
			var index=x+"";
			$("#container"+index).highcharts({
		        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: null,
		            plotShadow: false
		        },
		        credits: {  
		        	enabled: false
		        },
		        title: {
		            text: 'CPU'+index
		        },
		        tooltip: {
		    	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
		        },
		        plotOptions: {
		            pie: {
		                allowPointSelect: true,
		                cursor: 'pointer',
		                dataLabels: {
		                    enabled: true,
		                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
		                    style: {
		                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
		                    }
		                }
		            }
		        },
		        series: [{
		            type: 'pie',
		            name: 'Browser share',
		            animation: false,
		            data: [
		                ['用户使用', jsonData.listCpu[x].userUsed],
		                {
		                    name: '系统使用',
		                    y: jsonData.listCpu[x].sysUsed,
		                    sliced: true,
		                    selected: true
		                },
		                ['空闲',jsonData.listCpu[x].free]
		            ]
		        }]
		    });
		}
		
		$('#container').highcharts({
            title: {
                text: '内存使用情况 (5秒刷新)',
                x: -20 //center
            },
            subtitle: {
                text: '',
                x: -20
            },
            credits: {  
	        	enabled: false
	        },
            xAxis: {
                categories: jsonData.listMemTime
            },
            yAxis: {
                title: {
                    text: '单位（M）'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                valueSuffix: 'M'
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0
            },
            series: [{
                name: '已用内存',
                animation: false,
                data: jsonData.listMemUsed
    
            }]
        });
	}

</script>
</head>
<body>
<div id="infos" class="easyui-tabs" fit=true border=false data-options="" >
	<div title="硬件信息" style="padding:10px">
		<div style="overflow-y:auto;width:100%;height:100%;">
			<div style="overflow-y:auto;padding-top:20px;padding-left:30px">
				<table>
					<tr>
						<td height="30px" width="120px">总内存</td>
						<td>${memTotal }</td>
					</tr>
					<tr>
						<td height="30px">空闲内存</td>
						<td>${memLeft }</td>
					</tr>
					<tr>
						<td height="30px">JDK版本</td>
						<td>${JDKVersion }</td>
					</tr>
					<tr>
						<td height="30px">tomcat版本</td>
						<td>${tomcatVersion }</td>
					</tr>
					<tr>
						<td height="30px">操作系统</td>
						<td>${OSName }</td>
					</tr>
					<tr>
						<td height="30px">系统架构</td>
						<td>${OSArch }</td>
					</tr>
					<tr>
						<td height="30px">系统版本</td>
						<td>${OSVersion }</td>
					</tr>
					<tr>
						<td height="30px">计算机名</td>
						<td>${computerName }</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div title="CPU" style="padding:10px">
		<div style="overflow-y:auto;width:100%;height:100%;">
			<div id="container0" style="min-width: 400px; height: 300px; max-width: 400px; margin: 0 auto; float: left;"></div>
			<div id="container1" style="min-width: 400px; height: 300px; max-width: 400px; margin: 0 auto; float: right"></div>
			<div id="container2" style="min-width: 400px; height: 300px; max-width: 400px; margin: 0 auto; float: left"></div>
			<div id="container3" style="min-width: 400px; height: 300px; max-width: 400px; margin: 0 auto; float: right"></div>
		</div>
	</div>
	<div title="内存" style="padding:10px">
		<div style="overflow-y:auto;width:100%;height:100%;">
			<div id="container" style="min-width: 850px; height: 450px; max-width: 850px; margin: 0 auto; float: left"></div>
		</div>
	</div>
</div>
</body>
</html>