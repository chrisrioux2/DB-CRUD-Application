<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>Employee Dashboard</title>
<meta name="description"
	content="This was generated by the Codeply editor and responsive design playground." />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="generator" content="Codeply">

<!-- Hosted Bootstrap 4 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.2/css/bootstrap.min.css" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.1/animate.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />

<!-- site specific styling -->
<link rel="stylesheet" href="./css/styles.css" />

<!-- font awesome -->
<link href="./font-awesome/css/font-awesome.min.css" rel="stylesheet"
	type="text/css">

<!-- jQuery DataTable -->
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.11/css/jquery.dataTables.min.css" />

</head>
<body class="bg-faded">

<nav id="topNav" class="navbar navbar-default navbar-fixed-top">
	<div class="container">
		<button class="navbar-toggler hidden-md-up pull-right" type="button"
			data-toggle="collapse" data-target="#collapsingNavbar">☰</button>

		<a class="navbar-brand page-scroll" href="GetEmployeeData.do">Employee Dashboard</a>

		<div class="collapse navbar-toggleable-sm" id="collapsingNavbar">
			<ul class="nav navbar-nav">
				<li class="nav-item"><a class="nav-link page-scroll" href="GoToAdd.do">Add</a>
				</li>
				<li class="nav-item"><a class="nav-link page-scroll" href="GoToEdit.do?id=${initialEmp.id}&firstName=${initialEmp.firstName}&lastName=${initialEmp.lastName}&gender=${initialEmp.gender}&salary=${initialEmp.salary}&city=${initialEmp.city}&state=${initialEmp.state}">Edit</a>
				</li>
			</ul>

			<ul class="nav navbar-nav pull-xs-right">
				<li class="nav-item"><a class="nav-link page-scroll"
					data-toggle="modal" href="#aboutModal">About</a></li>
			</ul>
		</div>
	</div><!-- .container --> 
</nav>

	<c:choose>
		<c:when test="${!empty empData}">

		<section id="two">
			<div class="container wow fadeInUp">
				<div class="row">
					<div class="col-lg-12">
						<table id="allData" class="display compact" cellspacing="0"
							width="100%">
							<thead>
								<tr>
									<c:forEach var="column" items="${empHeaders}">
										<th>${column}</th>
									</c:forEach>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${empData}">
									<tr>
										<c:forEach var="value" items="${row}">
											<c:choose>
												<c:when test="${value == (row[0])}">
													<td><a href="GoToEdit.do?id=${(row[0])}&firstName=${(row[1])}&lastName=${(row[2])}&gender=${(row[3])}&salary=${(row[4])}&city=${(row[7])}&state=${(row[8])}">${value}</a></td>
												</c:when>
												<c:otherwise>
													<td>${value}</td>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div><!-- /.container --> 
		</section><!-- /#two -->
		</c:when>
		<c:otherwise>
		<section id="one">
			<div class="container wow fadeInUp">
				<div class="row">
					<div class="col-lg-8">
						<form action="GetEmployeeData.do" method="POST">
							<div class="input-group input-group-lg">
								<span class="input-group-btn">
									<button class="btn btn-secondary" type="submit">Go!</button>
								</span> <input type="text" name="query" class="form-control"
									placeholder="Search by Employee Last Name"
									aria-describedby="sizing-addon1">
							</div>
						</form>
					</div>
					<!-- /.col-lg-8 -->
					<div class="col-lg-4">
						<form action="GetEmployeeData.do" method="POST">
							<div class="dropdown">
								<button name="employee"
									class="btn btn-secondary dropdown-toggle" type="button"
									id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="false">Employees</button>
								<div class="dropdown-menu" aria-labelledby="dropdownMenu1">
									<c:forEach items="${employees}" var="employee">
										<a class="dropdown-item"
											href="GetEmployeeData.do?query=${employee.lastName}">${employee.lastName},
											${employee.firstName}</a>
									</c:forEach>
								</div>
							</div>
						</form>
					</div><!-- /.col-lg-4 -->
				</div><!-- /.row -->

				<hr>

				<div class="col-lg-12" id="metrics">
						<div class="col-md-5">
							<h2>Total Employees: <small>${genderDemographics.genderCount.values().toArray()[0] + genderDemographics.genderCount.values().toArray()[1]}</small></h2>
						</div><!-- /.col-md-5 -->
				</div><!--  /.col-lg-12 -->

				<hr>
				<div class="col-lg-12">
					<div class="col-md-3">
						<canvas id="genderDoughnutChart" width="250" height="300"></canvas>
					</div>
					<div class="col-md-3">
						<canvas id="salaryBarChart" width="250" height="300"></canvas>
					</div>
					<div class="col-md-6">
						<canvas id="departmentBarChart" width="500" height="450"></canvas>
					</div>					
				</div><!--  /.col-lg-12 -->
								
			</div><!-- /.container wow fadeInUp --> 
		</section>
			<hr>
		</c:otherwise>
	</c:choose>

<footer>
	<div class="row">
		<div class="col-lg-12">
			<p class="text-xs-center">
				<a href="http://www.chrisriouxdevelopment.com" target="_blank">Chris Rioux Development</a> &copy; 2016
			</p>
		</div>
	</div>
	<div class="row">
		<div class="col-md-6 col-md-offset-3" style="text-align: center">
			<a href="https://twitter.com/chrisrioux_" target="_blank"><i
				class="fa fa-twitter fa-2x"></i></a>&nbsp;&nbsp; <a
				href="https://www.linkedin.com/in/chris-rioux-b500569a"
				target="_blank"><i class="fa fa-linkedin fa-2x"></i></a>&nbsp;&nbsp;
			<a href="https://github.com/chrisrioux2" target="_blank"><i
				class="fa fa-github fa-2x"></i></a></br>
		</div>
	</div>
</footer>

	<!-- Modals -->
	<div id="aboutModal" class="modal fade" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title text-xs-center">Full Stack Web Development</h4>
					<p class="text-xs-center">
						Check Out<a href="http://www.chrisriouxdevelopment.com"
							target="_blank"> ChrisRiouxDevelopment.com</a>
					</p>
					<div class="modal-body">
						<div class="row">
							<div class="col-xs-4 text-xs-center">
								<ul class="list-inline banner-social-buttons">
									<li id="topButton"><a href="https://twitter.com/chrisrioux_" target="_blank"
										class="btn btn-primary-outline"><i
										class="fa fa-twitter fa-fw"></i>&nbsp;&nbsp;Twitter</a></li><br> 
									<li><a href="https://github.com/chrisrioux2" target="_blank"
										class="btn btn-primary-outline"><i
										class="fa fa-github-alt fa-fw"></i>&nbsp;&nbsp;Github</a></li><br>
									<li><a href="https://www.linkedin.com/in/chris-rioux-b500569a"
										target="_blank" class="btn btn-primary-outline"><i
										class="fa fa-linkedin-square fa-fw"></i>&nbsp;&nbsp;Linkedin</a></li><br>								
								</ul>
							</div>
							<div class="col-xs-8">
								<img class="center-block" src="./img/smallestPic.jpg" alt="">
							</div>
						</div>
						<hr>
						<div class="modal-footer">
							<button class="btn btn-primary center-block" data-dismiss="modal"
								aria-hidden="true">OK</button>
						</div><!-- /.modal-footer -->
					</div><!-- /.modal-body -->
				</div><!-- /.modal-header -->
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /#aboutModal -->

	<!--scripts loaded here-->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.2.0/js/tether.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.2/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/wow/1.1.2/wow.js"></script>

	<script src="js/scripts.js"></script>

	<!-- jQuery DataTable -->
	<script
		src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>

	<script>
    	$(document).ready(function() {
        	$('#allData').DataTable();
    	} );
    </script>

	<!-- ChartJS -->
	<script src="js/Chart.js-master/Chart.js"></script>

	<script>
    // gender counts chart   
    var ctx = document.getElementById("genderDoughnutChart").getContext("2d");

	<c:set var="genderCount" value="${genderDemographics.genderCount}"/>
    var genderData = [
                {
                    value: "${genderCount.values().toArray()[0]}",
                    color: "rgba(251,187,205,0.7)",
                	highlight: "rgba(251,187,205,1)",
                    label: "${genderCount.keySet().toArray()[0]}"
                },
                {
                    value: "${genderCount.values().toArray()[1]}",
                    color: "rgba(151,187,205,0.7)",
                	highlight: "rgba(151,187,205,1)",
                    label: "${genderCount.keySet().toArray()[1]}"
                }
            ]
    
    var genderDoughnutChart = new Chart(ctx).Doughnut(genderData);
		
	// salary totals by gender chart
    var ctx = document.getElementById("salaryBarChart").getContext("2d");
		
    	<c:set var="salaryTotal" value="${salaryDemographics.salaryTotal}"/>
		var salaryBarData = {
    		labels: [<c:forEach var="gender" items="${salaryTotal.keySet()}">"${gender}", </c:forEach>],
    		datasets: [
     			{
       				label: "Salary Dataset",
       				fillColor: "rgba(61,121,76,.5)",
            		strokeColor: "rgba(61,121,76,0.8)",
            		highlightFill: "rgba(61,121,76,0.75)",
            		highlightStroke: "rgba(61,121,76,1)",
            		data: [<c:forEach var="salaryTotal" items="${salaryTotal.values()}">"${salaryTotal}", </c:forEach>]
        		}
    		]
		};
		
		var options = {
			tooltipTemplate: 
				function(label){return  '$' + label.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");},
			animation: false,
			scaleLabel:
				function(label){return  '$' + label.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");}
		};
		
		var salaryBarChart = new Chart(ctx).Bar(salaryBarData, options);
		
	// employee count by department chart
    var ctx = document.getElementById("departmentBarChart").getContext("2d");
		
		<c:set var="genderCntByDept" value="${departmentDemographics.genderCntByDept}"/>
		var departmentBarData = {
    		labels: [<c:forEach var="dept" items="${genderCntByDept.keySet()}">"${dept}", </c:forEach>],
    		datasets: [
     			{
       				label: "Department Dataset",
       				fillColor: "rgba(222,119,73,0.5)",
            		strokeColor: "rgba(222,119,73,0.8)",
            		highlightFill: "rgba(222,119,73,0.75)",
            		highlightStroke: "rgba(222,119,73,1)",
            		data: [<c:forEach var="deptCount" items="${genderCntByDept.values()}">"${deptCount}", </c:forEach>]
        		}
    		]
		};
		
		var departmentBarChart = new Chart(ctx).Bar(departmentBarData);
    </script>

</body>
</html>