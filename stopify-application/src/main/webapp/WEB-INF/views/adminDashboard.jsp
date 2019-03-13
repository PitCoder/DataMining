<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Admin dashboard</title>
		<link type="text/css" rel="stylesheet" href="webjars/bootstrap/4.1.1/dist/css/bootstrap.min.css">
		<link type="text/css" rel="stylesheet" href="stylesheets/popup.css">
		<link type="text/css" rel="stylesheet" href="webjars/datatables/1.10.16/css/dataTables.bootstrap4.min.css">
		<link type ="text/css" rel="stylesheet" href="stylesheets/mystyles.css">
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
		<script type="text/javascript" src="webjars/bootstrap/4.1.1/dist/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="webjars/jquery/3.1.1/jquery.min.js"></script>
		<script type="text/javascript" src="webjars/popper.js/1.14.3/dist/umd/popper.min.js"></script>
		<script type="text/javascript" src="webjars/datatables/1.10.16/js/dataTables.bootstrap4.min.js"></script>
		<script type="text/javascript" src="webjars/datatables/1.10.16/js/jquery.dataTables.min.js"></script>
	</head>
	<body class="mockaroo">
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark navbar-fixed-top">
	      <div class="collapse navbar-collapse justify-content-md-center">
	        <ul class="navbar-nav">
	          <li class="nav-item active">
	            <a class="navbar-brand" href="/adminDashboard.do"><i class="fa fa-home"></i>Home</a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link" href="/id3Generator.do">ID3 Generator</a>
	          </li>
	          <li class="nav-item">
	            <a class="nav-link" href="/multiDDB.do">Multidimensional DB Generator</a>
	          </li>
	        </ul>
	      </div>
	    </nav>
		<div class="breadcrumbs-bar-spacer"></div>
		<div class="container-fluid" style="overflow:auto;">
			<div class="row">
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
				<div class="col-xl-8 col-md-8 col-sm-8">
					<h1>Welcome Admin: ${userName}</h1>
				</div>
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
			</div>
			<div class="row">
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
				<div class="col-xl-8 col-md-8 col-sm-8">
					<h4>To create a ID3 decision tree or a multidimensional database model click on one of the options above</h4>
				</div>
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
			</div>
			<br></br>
			<footer class="footer">
		      <div class="container">
		        <span class="text-muted">@Copyright Eric Alejandro López Ayala 2018.</span>
		      </div>
		    </footer>
		</div>
	</body>
</html>