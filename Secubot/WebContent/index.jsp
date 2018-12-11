<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page trimDirectiveWhitespaces="true"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="shortcut icon" href="img/SecuBot_logo.png">

<title>SECUBOT - Adaptive SIEM & Security Configuration
	Management</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-reset.css" rel="stylesheet">

<!-- animate CSS -->
<link href="css/animate.css" rel="stylesheet">

<!--Icon-fonts css-->
<link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href="assets/ionicon/css/ionicons.min.css" rel="stylesheet" />

<!-- Custom styles for this template -->
<link href="css/style.css?version=1" rel="stylesheet">
<link href="css/helper.css" rel="stylesheet">

<!-- myCSS -->
<link href="css/myCSS.css" rel="stylesheet">

<!-- d3 -->
<link href="css/d3.css?ver=1.234" rel="stylesheet">

<style>
h2:hover {
	transform: scale(1.05);
	-webkit-transform: scale(1.05);
	-moz-transform: scale(1.05);
	transition: all 0.3s ease-in-out;
}
li.notiActive {
	display: inline-block;
}
li.nonotiActive {
	display: none;
}
canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
</style>

</head>
<body>

	<%
		/* HttpSession httpSession = request.getSession(false);
		if (httpSession == null || httpSession.getAttribute("authUser") == null) {
			response.sendRedirect("/Secubot/login.do");
		} */
	%>

	<%@ include file="/WEB-INF/view/aside.jsp"%>

	<!-- Main Content Start -->
	<section class="content">
		<%@ include file="/WEB-INF/view/header.jsp"%>
		
		<!-- Page Content Start -->
		<!-- ================== -->
		<div class="wraper container-fluid">
			<div class="page-title">
				<h3 class="title"></h3>
			</div>
			<div class="row">
				<div class="col-lg-3 col-sm-6">
					<div class="widget-panel widget-style-2 white-bg">
						<i class="fa fa-shield text-pink"></i> 
						<h2 class="m-0 counter" style="cursor:pointer;">8956</h2>
						<div>Total responses</div>
					</div>
				</div>
				<div class="col-lg-3 col-sm-6">
					<div class="widget-panel widget-style-2 white-bg">
						<i class="ion-social-freebsd-devil text-purple"></i> 
						<h2 class="m-0 counter" style="cursor:pointer;">50</h2>
						<div>Today's responses</div>
					</div>
				</div>
				<div class="col-lg-3 col-sm-6">
					<div class="widget-panel widget-style-2 white-bg">
						<i class="ion-android-search text-info"></i> 
						<h2 class="m-0 counter" style="cursor:pointer;">126</h2>
						<div>Count of Process</div>
					</div>
				</div>
				<div class="col-lg-3 col-sm-6">
					<div class="widget-panel widget-style-2 white-bg">
						<i class="ion-ios7-compose text-success"></i> 
						<h2 class="m-0 counter" style="cursor:pointer;">145</h2>
						<div>Count of complain</div>
					</div>
				</div>
			</div> <!-- end row -->

			<div class="row">
				<div class="col-lg-12">
					<div class="portlet">
						<div class="portlet-heading">
							<h3 class="portlet-title text-dark"></h3>
						</div>
						<div class="portlet-body" id="visualization">
							<!-- <svg></svg> -->
							<div>
								<canvas id="canvas"></canvas>
							</div>
							<button id="randomizeData">random</button>
						</div>
					</div>
				</div>
				
				<!-- 
				<div class="col-lg-6">
					<div class="portlet">
						<div class="portlet-heading">
							<h3 class="portlet-title text-dark">누적 대응 건수</h3>
						</div>
						<div class="portlet-body" id="line"></div>
					</div>				
				</div>
				-->
			</div>
			<!-- end row -->

		</div>
		<!-- Page Content Ends -->
		<!-- ================== -->


		<!-- Footer Start -->
		<footer class="footer"> 2018 © SECUBOT - Adaptive SIEM &
			Security Configuration Management. </footer>
		<!-- Footer Ends -->
	</section>
	<!-- Main Content Ends -->

	<!-- modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">Details</div>
				<div class="modal-body"></div>
				<div class="modal-footer"></div>
			</div>
		</div>
	</div>

	<!-- js placed at the end of the document so the pages load faster -->
	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/modernizr.min.js"></script>
	<script src="js/pace.min.js"></script>
	<script src="js/wow.min.js"></script>
	<script src="js/jquery.nicescroll.js"></script>
	<script src="js/jquery.scrollTo.min.js"></script>

	<script src="js/jquery.app.js"></script>

	<!-- Dashboard -->
	<script src="js/jquery.dashboard.js"></script>
	
	<!-- d3.js -->
	<script src="js/d3.v3.min.js"></script>
	
	<!-- Chart.js -->
	<script src="js/Chart.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
	<script src="js/utils.js"></script>
	<script src="js/Chart.bundle.js"></script>
	
	<!-- ajax -->
	<script src="js/ajax.js?ver=6"></script>
	<script src="js/visualization.js?ver=2.4"></script>
	
	<script>
		var data = getProcessList();
		var parse = JSON.parse(data);
		var xScale = d3.scale.linear().domain([0, 2500000]).range([-100, 100]);
		var yScale = d3.scale.linear().domain([0, 2000]).range([-100, 100]);
		for (i in parse.ProcessList) {
			parse.ProcessList[i].x = xScale(parse.ProcessList[i].x);
			parse.ProcessList[i].y = yScale(parse.ProcessList[i].y);
		}
		
		/* Notification */
		checkMyNoti();
		
		/* Chart.js */
		function updateConfigAsNewObject(chart) {
			chart.options = {
					responsive: true,
					title: {
						display: true,
					},
					scales: {
						xAxes: [{
							display: true
						}],
						yAxes: [{
							display: true
						}]
					}
			}
			chart.update();
		}
		
		var color = Chart.helpers.color;
		var scatterChartData = {
			datasets: [{
				label: 'Process List',
				borderColor: window.chartColors.red,
				backgroundColor: color(window.chartColors.red).alpha(0.2).rgbString(),
				data: parse.ProcessList
			}]
		};

		window.onload = function() {
			var ctx = document.getElementById('canvas').getContext('2d');
			window.myScatter = Chart.Scatter(ctx, {
				data: scatterChartData,
				options: {
					title: {
						display: true,
						text: '보안 위협 시각화'
					},
					scales: {
						gridLines: {
							color: "black",
							lineWidth: 50
						},
						yAxes: [{
							display: true,
							ticks: {
								max: 100,
								min: -100
							}
						}],
						xAxes: [{
							display: true,
							ticks: {
								max: 100,
								min: -100
							}
						}]
					},
					events: ['click'],
					// TODO: 해당 Scatter 클릭 시 데이터 받아오는 작업.
					onClick: {
						clickFunc
					}
				}
			});
		};
		
		function clickFunc() {
			var popUrl = "/Secubot/popup.jsp?md5=" + parse.ProcessList[1].MD5 + "&imagename=" + parse.ProcessList[1].ImageName;
			var popOption = "width=700, height=400, scrollbars=no, status=no;";
			window.open(popUrl, popOption);
		}

		document.getElementById('randomizeData').addEventListener('click', function() {
			scatterChartData.datasets.forEach(function(dataset) {
				dataset.data = dataset.data.map(function() {
					return {
						x: randomScalingFactor(),
						y: randomScalingFactor()
					};
				});
			});
			window.myScatter.update();
		});
		
		
	</script>
	
</body>
</html>