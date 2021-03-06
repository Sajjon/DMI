<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ts" uri="/rights"%>
<%@ taglib uri="/tags/lf" prefix="lf"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html lang="en">

<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css"/>
	<!-- jsp文件头和头部 -->
	<%@ include file="../../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css"/>
</head>

<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
						
						<!-- 检索  -->
						<form action="record/totalList.do" method="post" name="form1" id="form1">
							
							<table style="margin-top:5px;">
								<tr>
									<td>
										<div class="nav-search">
											<span class="input-icon">
												<input class="nav-search-input" style="width:200px;" autocomplete="off" id="nav-search-input" type="text" name="keywords" value="${keywords}" placeholder="请输入机构名称或医院名称"/>
												<i class="ace-icon fa fa-search nav-search-icon"></i>
											</span>
										</div>
									</td>
								
									<td style="padding-left:5px;">
										<input class="span10 date-picker" name="final_date_start" id="final_date_start" value="${final_date_start}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:100px;" placeholder="结算开始日期" title="结算开始日期"/>
									</td>
									<td style="padding-left:5px;">
										<input class="span10 date-picker" name="final_date_end" id="final_date_end" value="${final_date_end}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:100px;" placeholder="结算结束日期" title="结算结束日期"/>
									</td>
								
									<td style="vertical-align:top;padding-left:5px;">
										<a class="btn btn-light btn-xs" onclick="searchs();" title="检索">
											<i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i>
										</a>
									</td>
									
									<td style="vertical-align:top;padding-left:5px;">
										<ts:rights code="record/exporExcel">
											<a class="btn btn-light btn-xs" onclick="exporExcel();" title="导出到EXCEL">
												<i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i>
											</a>
										</ts:rights>
									</td>
								</tr>
							</table>
						
							<!-- 列表  -->
							<table id="simple-table" width="100%" class="table table-striped table-bordered table-hover" style="margin-top:10px;">
								<thead>
									<tr>
										<th width="5%" class="center">序号</th>
										<th width="14%" class="center">机构名称</th>
										<th width="14%" class="center">医院名称</th>
										<th width="14%" class="center">结算日期</th>
										<th width="8%" class="center">费用总额</th>
										<th width="8%" class="center">自费总额(非医保)</th>
										<th width="8%" class="center">药品乙类自负</th>
										<th width="8%" class="center">医保费用</th>
										<th width="8%" class="center">合计报销金额</th>
										<th width="13%" class="center">操作</th>
									</tr>
								</thead>
								
								<tbody>
								<!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty varList}">
											<c:forEach items="${varList}" var="totalRecord" varStatus="vs">
												<tr>
													<td width="5%" class='center'>${vs.index+1}</td>
													<td width="14%" class="center">${totalRecord.GROUP_NAME}</td>
													<td width="14%" class="center">${totalRecord.hosp_name}</td>
													
													<td width="14%" class="center">
<%-- 														<lf:utilTool value="" parttern="datetime"/> --%>
														<fmt:formatDate value="${totalRecord.FINAL_DATE}" pattern="yyyy-MM-dd HH:mm:ss"/>
													</td>
													<td width="8%" class="center">
														<fmt:formatNumber type="number" value="${totalRecord.TOTAL_FEE}" pattern="0.00" maxFractionDigits="2"/>
													</td>
													<td width="8%" class="center">
<%-- 														<lf:utilTool value="" parttern="number"/> --%>
														<fmt:formatNumber type="number" value="${totalRecord.SELF_PAY}" pattern="0.00" maxFractionDigits="2"/>
													</td>
													<td width="8%" class="center">
<%-- 														<lf:utilTool value="" parttern="number"/> --%>
														<fmt:formatNumber type="number" value="${totalRecord.SELF_NEG}" pattern="0.00" maxFractionDigits="2"/>
													</td>
													<td width="8%" class="center">
														<fmt:formatNumber type="number" value="${totalRecord.MED_FEE}" pattern="0.00" maxFractionDigits="2"/>
													</td>
													<td width="8%" class="center">
														<fmt:formatNumber type="number" value="${totalRecord.RETURN_FEE}" pattern="0.00" maxFractionDigits="2"/>
													</td>
													
													<td width="13%" class="center">
														<div class="btn-group">
															<ts:rights code="record/totalDetail">
																<a class="btn btn-xs btn-purple" title="查看明细" onclick="queryDetail('${totalRecord.ID}');">查看明细</a>
															</ts:rights>
															
															<ts:rights code="record/totalSituation1">
																<a class="btn btn-xs btn-purple" title="查看详情" onclick="querySituation('${totalRecord.ID}');">查看详情</a>
															</ts:rights>
														</div>
													</td>
												</tr>
											</c:forEach>
										</c:when>
									
										<c:otherwise>
											<tr class="main_info">
												<td colspan="100" class="center">没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
							
							<!-- 总计 -->
							<table width="100%" style="border: 1px solid #dddddd; padding-bottom: 10px; margin-bottom:10px;">
								<tr height="30">
									<td width="47%" class='center'>总计</td>
									<td style="border-left:1px solid;border-left-color:#dddddd;" width="8%" class='center'>${pd.fee_sum}</td>
									<td style="border-left:1px solid;border-left-color:#dddddd;" width="8%" class='center'>${pd.self_fee_sum}</td>
									<td style="border-left:1px solid;border-left-color:#dddddd;" width="8%" class='center'>${pd.drug_type_sum}</td>
									<td style="border-left:1px solid;border-left-color:#dddddd;" width="8%" class='center'>${pd.hosption_sum}</td>
									<td style="border-left:1px solid;border-left-color:#dddddd;" width="8%" class='center'>${pd.reimburse_sum}</td>
									<td style="border-left:1px solid;border-left-color:#dddddd;" width="13%" class='center'>&nbsp;</td>
								</tr>
							</table>
							
							<!-- 分页 -->
							<div class="page-header position-relative">
								<table style="width:100%;">
									<tr>
										<td style="vertical-align:top;">
											<div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
										</td>
									</tr>
								</table>
							</div>
							
						</form>
 						
 						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->
		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>
	</div>
	<!-- /.main-container -->
	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	
</body>
 	
<script type="text/javascript">
	$(top.hangge());
	
	$(function() {
		//提示框标签
		$("[data-toggle='tooltip']").tooltip();
		//日期框
		$('.date-picker').datepicker({autoclose: true,todayHighlight: true});			
	});
		
	//检索
	function searchs(){
		top.jzts();
		$("#form1").submit();
	}
	
	function queryDetail(id){
		top.jzts();
		var diag = new top.Dialog();
		diag.Drag = true;
		diag.Title = '查看明细';
		diag.URL = '<%=path%>/record/totalDetail.do?SUPER_ID='+id;
		diag.Width = 1400;
		diag.Height = 600;
		diag.CancelEvent = function(){ //关闭事件
			if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				if('${page.currentPage}' == '0'){
					top.jzts();
					setTimeout("self.location=self.location",100);
				}else{
					nextPage(${page.currentPage});
				}
			}
			diag.close();
		};
		diag.show();
		
		//window.showModalDialog("", null, "dialogWidth=1024;dialogHeight=800");
	}
	
	function exporExcel(){
		form1.action = "<%=basePath%>record/exporExcel.do";
		form1.submit();
		form1.action = "<%=basePath%>record/totalList.do";
	}
	
	function querySituation(id){
		top.jzts();
		var diag = new top.Dialog();
		diag.Drag = true;
		diag.Title = '查看详情';
		diag.URL = '<%=path%>/record/totalSituation1.do?id='+id;
		diag.Width = 900;
		diag.Height = 500;
		diag.CancelEvent = function(){ //关闭事件
			if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
				if('${page.currentPage}' == '0'){
					top.jzts();
					setTimeout("self.location=self.location",100);
				}else{
					nextPage(${page.currentPage});
				}
			}
			diag.close();
		};
		diag.show();
	}
</script>

</html>