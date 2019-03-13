<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>MultiDDBM Generator</title>
		<link type="text/css" rel="stylesheet" href="webjars/bootstrap/4.1.1/dist/css/bootstrap.min.css">
		<link type="text/css" rel="stylesheet" href="stylesheets/popup.css">
		<link type="text/css" rel="stylesheet" href="webjars/datatables/1.10.16/css/dataTables.bootstrap4.min.css">
		<link type ="text/css" rel="stylesheet" href="stylesheets/mystyles.css">
		<script type="text/javascript" src="webjars/bootstrap/4.1.1/dist/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="webjars/jquery/3.1.1/jquery.min.js"></script>
		<script type="text/javascript" src="webjars/popper.js/1.14.3/dist/umd/popper.min.js"></script>
		<script type="text/javascript" src="webjars/datatables/1.10.16/js/dataTables.bootstrap4.min.js"></script>
		<script type="text/javascript" src="webjars/datatables/1.10.16/js/jquery.dataTables.min.js"></script>
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
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
					<h1>Multidimensional Database Model Generator</h1>
				</div>
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
			</div>
			<br></br>
			<div class="row">
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
				<div class="col-xl-8 col-md-8 col-sm-8">
					<h3>Step 1: Generate DB Dimensions: </h3>
					<h4>For this, please first select a database and then a table</h4>
				</div>
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
			</div>
			<div class="row">
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
				<div class="col-xl-4 col-md-4 col-sm-4">
					<p>Please select a database</p>
					<form action="">
						<select id="dbSelect" name="databases" onclick="showDatabases()" onchange="enableTables(this.value)">
						<option value="" class="text-muted">Select a database:</option>
						</select>
					</form>
				</div>
				<div class="col-xl-4 col-md-4 col-sm-4">
					<p>Please select a table</p>
					<form action="">
						<select disabled="true" id="tableSelect" name="tables" onclick="showTables()" onchange="displayMetadata(this.value)">
						<option value="" class="text-muted">Select a table:</option>
						</select>
					</form>
				</div>
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
			</div>
			<br></br>
			<div class="row">
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
				<div class="col-xl-8 col-md-8 col-sm-8">
					<h4>Please add the attributes that will compose your dimension</h4>
				</div>
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
			</div>
			<div class="row">
				<div class="col-xl-1 col-md-1 col-sm-1"></div>
				<div class="col-xl-10 col-md-10 col-sm-10">
					<div class="row">
						<div class="scrollingTable" id="tableMetadata">
							<table id="metaTable" class="table table-striped table-bordered dataTable" style="width: 100%;" role="grid" aria-describedby="metadata_info"></table>
						</div>
					</div>
				</div>
				<div class="col-xl-1 col-md-1 col-sm-1"></div>
			</div>
			<br></br>
			<div class="row">
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
				<div class="col-xl-8 col-md-8 col-sm-8">
					<h4>Then select one of the attributes, this will be your Pk</h4>
				</div>
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
			</div>
			<div class="row">
				<div class="col-xl-1 col-md-1 col-sm-1"></div>
				<div class="col-xl-10 col-md-10 col-sm-10">
					<div class="row">
						<div class="scrollingTable" id="tableAttributes">
							<table id="attrTable" class="table table-striped table-bordered dataTable" style="width: 100%;" role="grid" aria-describedby="attribute_info"></table>
						</div>
					</div>
				</div>
				<div class="col-xl-1 col-md-1 col-sm-1"></div>
			</div>
			<div class="row">
				<div class="col-xl-1 col-md-1 col-sm-1"></div>
				<div class="col-xl-10 col-md-10 col-sm-10">
					<div class="row">
						<div class="scrollingTable" id="previewsTable">
							<table id="previewTable" class="table table-striped table-bordered dataTable" style="width: 100%;" role="grid" aria-describedby="preview_info"></table>
						</div>
					</div>
				</div>
				<div class="col-xl-1 col-md-1 col-sm-1"></div>
			</div>
			<br></br>
			<div class="row">
				<div class="col-xl-1 col-md-1 col-sm-1"></div>
				<div class="col-xl-10 col-md-10 col-sm-10">
					<div class="row">
						<div class="scrollingTable" id="previewsDimensionTable">
							<table id="previewDimensionTable" class="table table-striped table-bordered dataTable" style="width: 100%;" role="grid" aria-describedby="preview_info"></table>
						</div>
					</div>
				</div>
				<div class="col-xl-1 col-md-1 col-sm-1"></div>
			</div>
			<div class="container-fluid">
				<div class="row">
					<div class="col-xl-2 col-md-2 col-sm-2"></div>
					<div class="col-xl-8 col-md-8 col-sm-8">
						<h3>Step 2: Select Fact Table measures: </h3>
						<h4>For this, please first select a database and then a table</h4>
					</div>
					<div class="col-xl-2 col-md-2 col-sm-2"></div>
				</div>
				<div class="row">
					<div class="col-xl-2 col-md-2 col-sm-2"></div>
					<div class="col-xl-4 col-md-4 col-sm-4">
						<p>Please select a database</p>
						<form action="">
							<select id="dbSelect2" name="databases2" onclick="showDatabases2()" onchange="enableTables2(this.value)">
							<option value="" class="text-muted">Select a database:</option>
							</select>
						</form>
					</div>
					<div class="col-xl-4 col-md-4 col-sm-4">
						<p>Please select a table</p>
						<form action="">
							<select disabled="true" id="tableSelect2" name="tables2" onclick="showTables2()" onchange="displayMetadata2(this.value)">
							<option value="" class="text-muted">Select a table:</option>
							</select>
						</form>
					</div>
					<div class="col-xl-2 col-md-2 col-sm-2"></div>
				</div>
				<br></br>
				<div class="row">
					<div class="col-xl-2 col-md-2 col-sm-2"></div>
					<div class="col-xl-8 col-md-8 col-sm-8">
						<h4>Please add the attributes that will compose your dimension</h4>
					</div>
					<div class="col-xl-2 col-md-2 col-sm-2"></div>
				</div>
				<div class="row">
					<div class="col-xl-1 col-md-1 col-sm-1"></div>
					<div class="col-xl-10 col-md-10 col-sm-10">
						<div class="row">
							<div class="scrollingTable" id="tableMetadata2">
								<table id="metaTable2" class="table table-striped table-bordered dataTable" style="width: 100%;" role="grid" aria-describedby="metadata_info"></table>
							</div>
						</div>
					</div>
					<div class="col-xl-1 col-md-1 col-sm-1"></div>
				</div>
				<br></br>
				<div class="row">
					<div class="col-xl-2 col-md-2 col-sm-2"></div>
					<div class="col-xl-8 col-md-8 col-sm-8">
						<h4>Then select one of the attributes, this will be your Pk</h4>
					</div>
					<div class="col-xl-2 col-md-2 col-sm-2"></div>
				</div>
				<div class="row">
					<div class="col-xl-1 col-md-1 col-sm-1"></div>
					<div class="col-xl-10 col-md-10 col-sm-10">
						<div class="row">
							<div class="scrollingTable" id="tableAttributes2">
								<table id="attrTable2" class="table table-striped table-bordered dataTable" style="width: 100%;" role="grid" aria-describedby="attribute_info"></table>
							</div>
						</div>
					</div>
					<div class="col-xl-1 col-md-1 col-sm-1"></div>
				</div>
				<div class="row">
					<div class="col-xl-1 col-md-1 col-sm-1"></div>
					<div class="col-xl-10 col-md-10 col-sm-10">
						<div class="row">
							<div class="scrollingTable" id="previewsFactTable">
								<table id="previewFactTable" class="table table-striped table-bordered dataTable" style="width: 100%;" role="grid" aria-describedby="preview_info"></table>
							</div>
						</div>
					</div>
					<div class="col-xl-1 col-md-1 col-sm-1"></div>
				</div>
				<div class="row">
					<div class="col-xl-8 col-md-8 col-sm-8"></div>
					<div class="col-xl-2 col-md-2 col-sm-2">
					</div>
					<div class="col-xl-2 col-md-2 col-sm-2">
						<button id="submitModel" class="btn btn-success apply" style="display: none;" onclick="createModel()" disabled="true">create MDDB Model</button>
					</div>
				</div>
			</div>
			<br></br>
			<div class="row">
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
				<div class="col-xl-8 col-md-8 col-sm-8">
					<div id="myDiagramDiv" style="background-color: white; border: solid 1px black; width: 100%; height: 500px; overflow:auto;"></div>
					  <p>
					  Este es el diagrama de decisiones correspondiente para los attributos seleccionados
					  </p>
				</div>
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
			</div>
			<div class="row">
				<div class="col-xl-8 col-md-8 col-sm-8"></div>
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
				<div id="divReport" class="col-xl-2 col-md-2 col-sm-2"></div>
			</div>
			<div class="row">
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
				<div class="col-xl-8 col-md-8 col-sm-8">
					<div id="myReportDiv"></div>
					<p>
					  Este es el reporte generado
					</p>
				</div>
				<div class="col-xl-2 col-md-2 col-sm-2"></div>
			</div>
			<footer class="footer">
		      <div class="container">
		        <span class="text-muted">@Copyright Eric Alejandro López Ayala 2018.</span>
		      </div>
		    </footer>
		</div>
		
		<script>
			function showDatabases() {
				var dbSelect = document.getElementById("dbSelect");
				var length = dbSelect.children.length;
				//var dbOption = dbSelect.getElemenstByTagName("option");
				
				console.log(length)
				if(length == 1){
					var xhttp;
					xhttp = new XMLHttpRequest();
					xhttp.onreadystatechange = function(){
						if(this.readyState == 4 && this.status == 200){
							var databases = JSON.parse(this.responseText);
							console.log(databases);
							for(var i in databases){
								var option = document.createElement("option");
								console.log(databases[i]);
								option.text = databases[i];
								option.value = databases[i];
								dbSelect.add(option);
							}
						}
					};
					xhttp.open("GET", "/GetDatabasesServlet", true);
					xhttp.send();	
				}
			}
			
			function showDatabases2() {
				var dbSelect = document.getElementById("dbSelect2");
				var length = dbSelect.children.length;
				//var dbOption = dbSelect.getElemenstByTagName("option");
				
				console.log(length)
				if(length == 1){
					var xhttp;
					xhttp = new XMLHttpRequest();
					xhttp.onreadystatechange = function(){
						if(this.readyState == 4 && this.status == 200){
							var databases = JSON.parse(this.responseText);
							console.log(databases);
							for(var i in databases){
								var option = document.createElement("option");
								console.log(databases[i]);
								option.text = databases[i];
								option.value = databases[i];
								dbSelect.add(option);
							}
						}
					};
					xhttp.open("GET", "/GetDatabasesServlet", true);
					xhttp.send();	
				}
			}
			
			function enableTables(str){
				if(str==""){
					console.log(str);
					document.getElementById("tableSelect").disabled = true;
					document.getElementById("dbSelect").innerHTML = "<option value=\'\'>Select a database:</option>";
					resetTable();
				}
				else{
					console.log(str);
					document.getElementById("tableSelect").disabled = false;
					resetTable();
				}
			}
			
			function enableTables2(str){
				if(str==""){
					console.log(str);
					document.getElementById("tableSelect2").disabled = true;
					document.getElementById("dbSelect2").innerHTML = "<option value=\'\'>Select a database:</option>";
					resetTable2();
				}
				else{
					console.log(str);
					document.getElementById("tableSelect2").disabled = false;
					resetTable2();
				}
			}
			
			function resetTable(){
				document.getElementById("metaTable").innerHTML = "";
				document.getElementById("attrTable").innerHTML = "";
				document.getElementById("tableSelect").innerHTML = "<option value=\'\'>Select a table:</option>"
			}
			
			function resetTable2(){
				document.getElementById("metaTable2").innerHTML = "";
				document.getElementById("attrTable2").innerHTML = "";
				document.getElementById("tableSelect2").innerHTML = "<option value=\'\'>Select a table:</option>"
			}
			
			function showTables(){
				var	dbSelect = document.getElementById("dbSelect");
				var tableSelect = document.getElementById("tableSelect");
				var currentSelectedDatabase = dbSelect.options[dbSelect.selectedIndex].value;	
				var length = tableSelect.children.length;
				if(length == 1){
					var xhttp;
					xhttp = new XMLHttpRequest();
					xhttp.onreadystatechange = function(){
						if(this.readyState == 4 && this.status == 200){
							var tables = JSON.parse(this.responseText);
							console.log(tables);
							for(var i in tables){
								var option = document.createElement("option");
								option.text = tables[i];
								option.value = tables[i];
								tableSelect.add(option);
							}
						}
					};
					xhttp.open("GET", "/GetTablesServlet?dbName=" + currentSelectedDatabase, true);
					xhttp.send();	
				}
			}
			
			function showTables2(){
				var	dbSelect = document.getElementById("dbSelect2");
				var tableSelect = document.getElementById("tableSelect2");
				var currentSelectedDatabase = dbSelect.options[dbSelect.selectedIndex].value;	
				var length = tableSelect.children.length;
				if(length == 1){
					var xhttp;
					xhttp = new XMLHttpRequest();
					xhttp.onreadystatechange = function(){
						if(this.readyState == 4 && this.status == 200){
							var tables = JSON.parse(this.responseText);
							console.log(tables);
							for(var i in tables){
								var option = document.createElement("option");
								option.text = tables[i];
								option.value = tables[i];
								tableSelect.add(option);
							}
						}
					};
					xhttp.open("GET", "/GetTablesServlet?dbName=" + currentSelectedDatabase, true);
					xhttp.send();	
				}
			}
			
			function displayMetadata(str){
				if(str = ""){
					document.getElementById("metaTable").innerHTML = "";
				}
				else{
					document.getElementById("metaTable").innerHTML = "";
					var	dbSelect = document.getElementById("dbSelect");
					var tableSelect = document.getElementById("tableSelect");
					var currentSelectedDatabase = dbSelect.options[dbSelect.selectedIndex].value;
					var currentSelectedTable = tableSelect.options[tableSelect.selectedIndex].value;
					var xhttp;
					xhttp = new XMLHttpRequest();
					xhttp.onreadystatechange = function(){
						if(this.readyState == 4 && this.status == 200){
							var tableContent = JSON.parse(this.responseText);
							var tableResponse = "";
							
							var tab, thead, tbody, tr, th, td, tn, a, button, i;
							var row, column;
							tab = document.getElementById("metaTable");
							var flag = true;
							
							for (row = 0; row < tableContent.length; row++){
								tr = document.createElement("tr");
								tr.id = "rowId_" + row;
								
								for(column=0; column < tableContent[row].length; column++){
									if(flag == true){
										th = document.createElement("th");
										th.setAttribute("scope","column");
										tn = document.createTextNode(tableContent[row][column]);
										th.appendChild(tn);
										tr.appendChild(th);
									}
									else if(column == 0){
										th = document.createElement("th");
										th.setAttribute("scope","row");
										tn = document.createTextNode(tableContent[row][column]);
										th.appendChild(tn);
										tr.appendChild(th)
									}
									else{
										td = document.createElement("td");
										tn = document.createTextNode(tableContent[row][column]);
										td.appendChild(tn);
										tr.appendChild(td);
									}
								}
								
								
								if(row == 0){
									th = document.createElement("th");
									tn = document.createTextNode("");
									th.appendChild(tn);
									tr.appendChild(th);
									
									thead = document.createElement("thead");
									thead.setAttribute("class","thead-dark");
									tbody = document.createElement("tbody");
									
									thead.appendChild(tr);
									flag = false;
								}
								else{
									td =  document.createElement("td");
									i = document.createElement("i");
									i.setAttribute("class", "fas fa-plus");
									
									button = document.createElement("button");
				    				button.setAttribute("type", "button");
				    				button.setAttribute("class", "btn btn-success");
				    				button.setAttribute("onclick", "addAttribute(" + row +")");
				    				button.appendChild(i);
									
									td.appendChild(button);
									tr.appendChild(td);
									tbody.appendChild(tr);
								}
							}
							
							tab.appendChild(thead);
							tab.appendChild(tbody);
							makeTableScroll("metaTable");
						}
					};
					xhttp.open("GET", "/GetTableContentServlet?dbName=" + currentSelectedDatabase + "&tableName=" + currentSelectedTable, true);
					xhttp.send();
				}
			}
			
			function displayMetadata2(str){
				if(str = ""){
					document.getElementById("metaTable2").innerHTML = "";
				}
				else{
					document.getElementById("metaTable2").innerHTML = "";
					var	dbSelect = document.getElementById("dbSelect2");
					var tableSelect = document.getElementById("tableSelect2");
					var currentSelectedDatabase = dbSelect.options[dbSelect.selectedIndex].value;
					var currentSelectedTable = tableSelect.options[tableSelect.selectedIndex].value;
					var xhttp;
					xhttp = new XMLHttpRequest();
					xhttp.onreadystatechange = function(){
						if(this.readyState == 4 && this.status == 200){
							var tableContent = JSON.parse(this.responseText);
							var tableResponse = "";
							
							var tab, thead, tbody, tr, th, td, tn, a, button, i;
							var row, column;
							tab = document.getElementById("metaTable2");
							var flag = true;
							
							for (row = 0; row < tableContent.length; row++){
								tr = document.createElement("tr");
								tr.id = "rowId2_" + row;
								
								for(column=0; column < tableContent[row].length; column++){
									if(flag == true){
										th = document.createElement("th");
										th.setAttribute("scope","column");
										tn = document.createTextNode(tableContent[row][column]);
										th.appendChild(tn);
										tr.appendChild(th);
									}
									else if(column == 0){
										th = document.createElement("th");
										th.setAttribute("scope","row");
										tn = document.createTextNode(tableContent[row][column]);
										th.appendChild(tn);
										tr.appendChild(th)
									}
									else{
										td = document.createElement("td");
										tn = document.createTextNode(tableContent[row][column]);
										td.appendChild(tn);
										tr.appendChild(td);
									}
								}
								
								
								if(row == 0){
									th = document.createElement("th");
									tn = document.createTextNode("");
									th.appendChild(tn);
									tr.appendChild(th);
									
									thead = document.createElement("thead");
									thead.setAttribute("class","thead-dark");
									tbody = document.createElement("tbody");
									
									thead.appendChild(tr);
									flag = false;
								}
								else{
									td =  document.createElement("td");
									i = document.createElement("i");
									i.setAttribute("class", "fas fa-plus");
									
									button = document.createElement("button");
				    				button.setAttribute("type", "button");
				    				button.setAttribute("class", "btn btn-success");
				    				button.setAttribute("onclick", "addAttribute2(" + row +")");
				    				button.appendChild(i);
									
									td.appendChild(button);
									tr.appendChild(td);
									tbody.appendChild(tr);
								}
							}
							
							tab.appendChild(thead);
							tab.appendChild(tbody);
							makeTableScroll("metaTable");
						}
					};
					xhttp.open("GET", "/GetTableContentServlet?dbName=" + currentSelectedDatabase + "&tableName=" + currentSelectedTable, true);
					xhttp.send();
				}
			}
		</script>
		
		<script type="text/javascript">
        	function makeTableScroll(tableId) {
            	// Constant retrieved from server-side via JSP
            	var maxRows = 8;
            	var table = document.getElementById(tableId);
            	var wrapper = table.parentNode;
            	var rowsInTable = table.rows.length;
            	var height = 0;
            	if (rowsInTable > maxRows) {
                for (var i = 0; i < maxRows; i++) {
                    height += table.rows[i].clientHeight;
                }
                wrapper.style.height = height + "px";
            }
        }
    	</script>
    	
    	<script type="text/javascript">
	    	function deleteRow(Id)  {
	    		console.log(Id.innerHTML);
	    	    var row = Id;//document.getElementById(Id);
	    	    var table = row.parentNode;
	    	    while ( table && table.tagName != 'TABLE' )
	    	        table = table.parentNode;
	    	    if ( !table )
	    	        return;
	    	    
	    	    var button, checked, button2;
	    	    button = document.getElementById("addDimension");
	    	    checked = row.children[5].firstChild;
	    	    console.log(checked);
	    	    
	    	    if(verifyChecked(checked)){
	    	    	button.setAttribute("disabled",true);
	    	    }
	    	    
	    	    table.deleteRow(row.rowIndex);
	    	    var tbody = table.children[1];
	    	    
	    	    if(tbody.children.length == 0){
	    	    	var div = document.getElementById("tableAttributes");
	    	    	table.innerHTML = "";
	    	    	button.setAttribute("style","display: none;");
	    	    	button.setAttribute("disabled",true);
	    	    	var element = div.getElementsByTagName("form"), index;
	    	    	for (index = element.length - 1; index >= 0; index--) {
	    	    	    element[index].parentNode.removeChild(element[index]);
	    	    	}
	    	    }
	    	}

    		function addAttribute(row) {
    			var div,table, thead, tbody, th, tr, tn, selectedRow, dbSelect, tableSelect;
    			table = document.getElementById("attrTable");
    			div = document.getElementById("tableAttributes");
    			
    			if(table.children.length == 0){
    				tr = document.createElement("tr");
    				th = document.createElement("th");
    				th.setAttribute("scope","column");
					tn = document.createTextNode("Database");
					th.appendChild(tn);
					tr.appendChild(th);
					
					th = document.createElement("th");
    				th.setAttribute("scope","column");
					tn = document.createTextNode("Relation");
					th.appendChild(tn);
					tr.appendChild(th);
					
					th = document.createElement("th");
    				th.setAttribute("scope","column");
					tn = document.createTextNode("Attribute");
					th.appendChild(tn);
					tr.appendChild(th);
					
					th = document.createElement("th");
    				th.setAttribute("scope","column");
					tn = document.createTextNode("Data Type");
					th.appendChild(tn);
					tr.appendChild(th);
					
					th = document.createElement("th");
    				th.setAttribute("scope","column");
					tn = document.createTextNode("Delete");
					th.appendChild(tn);
					tr.appendChild(th);
					
					th = document.createElement("th");
    				th.setAttribute("scope","column");
					tn = document.createTextNode("Primary Key");
					th.appendChild(tn);
					tr.appendChild(th);
					
					thead = document.createElement("thead");
    				thead.setAttribute("class","thead-dark");
    				thead.appendChild(tr);
    				tbody = document.createElement("tbody");
					
    				table.appendChild(thead);
    				table.appendChild(tbody);
    				makeTableScroll("attrTable");
    				
    				var form = document.createElement("form");
    				form.id = "dimensionFrom";
    				form.setAttribute("class","form-inline");
    				
    				var innerdiv, label, button, input;
    				
    				innerdiv = document.createElement("div");
    				innerdiv.setAttribute("class","form-group mb-2");
    				label = document.createElement("label");
    				label.setAttribute("for","addDimension");
    				label.setAttribute("class","sr-only");
    				label.innerHTML = "Dimension";
    				input = document.createElement("input");
    				input.setAttribute("type","text");
    				input.setAttribute("class","form-control-plaintext");
    				input.setAttribute("value","Insert Dimension Name:");
    				innerdiv.append(label);
    				innerdiv.append(input);
    				form.append(innerdiv);
    				
    				innerdiv = document.createElement("div");
    				innerdiv.setAttribute("class","form-group mx-sm-3 mb-2");
    				label = document.createElement("label");
    				label.setAttribute("for","dimensionName");
    				label.setAttribute("class","sr-only");
    				label.innerHTML = "Dimension name";
    				input = document.createElement("input");
    				input.setAttribute("type","text");
    				input.setAttribute("class","form-control");
    				input.setAttribute("placeholder","dimension");
    				input.id = "dimensionID";
    				innerdiv.append(label);
    				innerdiv.append(input);
    				form.append(innerdiv);
    				
    				button = document.createElement("button");
    				button.setAttribute("type","button");
    				button.setAttribute("class","btn btn-primary mb-2");
    				button.setAttribute("disabled","true");
    				button.setAttribute("onclick","addRowDimension()");
    				button.innerHTML = "Add";
    				button.id = "addDimension";
    				form.append(button);
    				
    				div.append(form);
    			}
    			
    			tbody = table.children[1];
    			selectedRow = document.getElementById("rowId_" + row);
    			
    			var parameters = [];
    			var dbName, relationName, attributeName, dataType;
    			
    			dbSelect = document.getElementById("dbSelect");
    			dbName = dbSelect.options[dbSelect.selectedIndex].value;
    			
    			tableSelect = document.getElementById("tableSelect");
    			relationName = tableSelect.options[tableSelect.selectedIndex].value;
    			
    			attributeName = selectedRow.children[0].innerHTML;
    			dataType = selectedRow.childNodes[1].innerHTML;
    			
    			parameters.push(dbName);
    			parameters.push(relationName);
    			parameters.push(attributeName);
    			tr = document.createElement("tr");
    			rowId = dbName + relationName + attributeName;
    			tr.id = rowId;
    			
    			if(checkDuplicity(parameters, "attrTable") == false){
    				var button, i, label, div, p;
    				
    				td =  document.createElement("td");
    				tn = document.createTextNode(dbName);
    				td.appendChild(tn);
    				tr.appendChild(td);
    		
    				td =  document.createElement("td");
    				tn = document.createTextNode(relationName);
    				td.appendChild(tn);
    				tr.appendChild(td);
    				
    				td =  document.createElement("td");
    				tn = document.createTextNode(attributeName);
    				td.appendChild(tn);
    				tr.appendChild(td);
    				
    				td =  document.createElement("td");
    				tn = document.createTextNode(dataType);
    				td.appendChild(tn);
    				tr.appendChild(td);
    				
    				i = document.createElement("i");
    				i.setAttribute("class", "fas fa-minus");
    				
    				button = document.createElement("button");
    				button.setAttribute("type", "button");
    				button.setAttribute("class", "btn btn-danger");
    				button.setAttribute("onclick", "deleteRow(" + rowId + ")");
    				button.appendChild(i);
    				
    				td =  document.createElement("td");
    				td.appendChild(button);
    				tr.appendChild(td);
    				
    				input = document.createElement("input");
    				input.setAttribute("type", "radio");
    				input.setAttribute("class", "form-check-input");
    				input.setAttribute("name", "optdecision");
    				input.setAttribute("onclick", "verifyChecked(this)");
    				
    				td =  document.createElement("td");
    				td.appendChild(input);
    				tr.appendChild(td);   				
    				tbody.appendChild(tr);
    			}
    		}
    		
    		function addAttribute2(row) {
    			var div,table, thead, tbody, th, tr, tn, selectedRow, dbSelect, tableSelect;
    			table = document.getElementById("attrTable2");
    			div = document.getElementById("tableAttributes2");
    			
    			if(table.children.length == 0){
    				tr = document.createElement("tr");
    				th = document.createElement("th");
    				th.setAttribute("scope","column");
					tn = document.createTextNode("Database");
					th.appendChild(tn);
					tr.appendChild(th);
					
					th = document.createElement("th");
    				th.setAttribute("scope","column");
					tn = document.createTextNode("Relation");
					th.appendChild(tn);
					tr.appendChild(th);
					
					th = document.createElement("th");
    				th.setAttribute("scope","column");
					tn = document.createTextNode("Attribute");
					th.appendChild(tn);
					tr.appendChild(th);
					
					th = document.createElement("th");
    				th.setAttribute("scope","column");
					tn = document.createTextNode("Data Type");
					th.appendChild(tn);
					tr.appendChild(th);
					
					thead = document.createElement("thead");
    				thead.setAttribute("class","thead-dark");
    				thead.appendChild(tr);
    				tbody = document.createElement("tbody");
					
    				table.appendChild(thead);
    				table.appendChild(tbody);
    				makeTableScroll("attrTable2");
    				
    				var form = document.createElement("form");
    				form.id = "measureForm";
    				form.setAttribute("class","form-inline");
    				
    				var innerdiv, label, button, input;
    				
    				innerdiv = document.createElement("div");
    				innerdiv.setAttribute("class","form-group mb-2");
    				label = document.createElement("label");
    				label.setAttribute("for","addFactable");
    				label.setAttribute("class","sr-only");
    				label.innerHTML = "Fact";
    				input = document.createElement("input");
    				input.setAttribute("type","text");
    				input.setAttribute("class","form-control-plaintext");
    				input.setAttribute("value","Insert Fact Table Name:");
    				innerdiv.append(label);
    				innerdiv.append(input);
    				form.append(innerdiv);
    				
    				innerdiv = document.createElement("div");
    				innerdiv.setAttribute("class","form-group mx-sm-3 mb-2");
    				label = document.createElement("label");
    				label.setAttribute("for","factTableName");
    				label.setAttribute("class","sr-only");
    				label.innerHTML = "Fact Table name";
    				input = document.createElement("input");
    				input.setAttribute("type","text");
    				input.setAttribute("class","form-control");
    				input.setAttribute("placeholder","factTable");
    				input.id = "factTableID";
    				innerdiv.append(label);
    				innerdiv.append(input);
    				form.append(innerdiv);
    				
    				button = document.createElement("button");
    				button.setAttribute("type","button");
    				button.setAttribute("class","btn btn-primary mb-2");
    				button.setAttribute("onclick","addModelMeasures()");
    				button.innerHTML = "Add";
    				button.id = "addMeasures";
    				form.append(button);
    				
    				div.append(form);
    			}
    			
    			tbody = table.children[1];
    			selectedRow = document.getElementById("rowId2_" + row);
    			
    			var dbName, relationName, attributeName, dataType;
    			
    			dbSelect = document.getElementById("dbSelect2");
    			dbName = dbSelect.options[dbSelect.selectedIndex].value;
    			
    			tableSelect = document.getElementById("tableSelect2");
    			relationName = tableSelect.options[tableSelect.selectedIndex].value;
    			
    			attributeName = selectedRow.children[0].innerHTML;
    			dataType = selectedRow.childNodes[1].innerHTML;
    			
    			tr = document.createElement("tr");
    			rowId = dbName + relationName + attributeName;
    			tr.id = rowId;
    			
    				var button, i, label, div, p;
    				
    				td =  document.createElement("td");
    				tn = document.createTextNode(dbName);
    				td.appendChild(tn);
    				tr.appendChild(td);
    		
    				td =  document.createElement("td");
    				tn = document.createTextNode(relationName);
    				td.appendChild(tn);
    				tr.appendChild(td);
    				
    				td =  document.createElement("td");
    				tn = document.createTextNode(attributeName);
    				td.appendChild(tn);
    				tr.appendChild(td);
    				
    				td =  document.createElement("td");
    				tn = document.createTextNode(dataType);
    				td.appendChild(tn);
    				tr.appendChild(td);
    				tbody.appendChild(tr);
    		}
    		
    		function checkDuplicity(parameters, tableId){
      		  var table, tr, tds, td, values;
      		  table = document.getElementById(tableId);
      		  tr = table.getElementsByTagName("tr");
      		  values = [];
      		
      		  for (i = 1; i < tr.length; i++) {
      			values = [];
    			tds = tr[i].getElementsByTagName("td");
    			for (j = 0; j < 3; j++){
    				values.push(tds[j].innerHTML);
    			}
    			console.log(parameters);
    			if(values.equals(parameters) == true){
    				return true;
    			}
      		  }
    			return false;
      		}
    		
    		// Warn if overriding existing method
    		if(Array.prototype.equals)
    		    console.warn("Overriding existing Array.prototype.equals. Possible causes: New API defines the method, there's a framework conflict or you've got double inclusions in your code.");
    		// attach the .equals method to Array's prototype to call it on any array
    		Array.prototype.equals = function (array) {
    		    // if the other array is a falsy value, return
    		    if (!array)
    		        return false;

    		    // compare lengths - can save a lot of time 
    		    if (this.length != array.length)
    		        return false;

    		    for (var i = 0, l=this.length; i < l; i++) {
    		        // Check if we have nested arrays
    		        if (this[i] instanceof Array && array[i] instanceof Array) {
    		            // recurse into the nested arrays
    		            if (!this[i].equals(array[i]))
    		                return false;       
    		        }           
    		        else if (this[i] != array[i]) { 
    		            // Warning - two different object instances will never be equal: {x:20} != {x:20}
    		            return false;   
    		        }           
    		    }       
    		    return true;
    		}
    		// Hide method from for-in loops
    		Object.defineProperty(Array.prototype, "equals", {enumerable: false});
    	</script>
    	
    	<script>
    		var attrId = "";
    		
    		function defineFormula(rowId){
    			attrId = rowId;
    			var div;
    			div = document.getElementById("advanced_formula_dialog");
    			div.setAttribute("class" ,"modal fade in");
    			div.setAttribute("style" ,"display: block;");
    			div.setAttribute("aria-hidden" ,"false");
    			console.log(rowId);
    		}
    		
    		function dismiss(){
    			attrId = "";
    			var div;
    			div = document.getElementById("advanced_formula_dialog");
    			div.setAttribute("class" ,"modal fade");
    			div.setAttribute("style" ,"display: none;");
    			div.setAttribute("aria-hidden" ,"true");
    		}
    		
    		function applyFormula(){
    			var formula, numExpr, exprForm, expressions, composition, list, temp, i, j;
    			console.log("Creando Concatenacion");
    			
    			var formula = "{\n  \"numExpr\":";
    			var numExpr = $("#expressions").val();
    			
    			console.log("Number of expresions: " + numExpr);
    			formula += numExpr + ",";
    			
    			formula += "\n  \"formula\": [\n";
    			
    			var exprForm = document.getElementById("exprForm");
    			var expressions = document.getElementsByClassName("form-row");
    			var composition;
    			var temp;
    			composition = expressions[0];
    			
    			for(i = 0; i < expressions.length; i++){
    				composition = expressions[i];
    				list = composition.childNodes;
    				formula += "    { \"id\":" + i + ", \"expr\":[ ";
    				for(j = 0; j < list.length; j++){
    	    			temp = list[j];
    	    			temp = temp.childNodes;
    	    			temp = temp[0];
    	    			temp = temp.childNodes;
    	    			temp = temp[1].value;
    	    			
    	    			if(j < list.length-1){
    	    				formula += "\"" + temp + "\","; 
    	    			}
    	    			else{
    	    				formula += "\"" + temp + "\" "; 
    	    			}
    				}
    				if(i < expressions.length-1){
	    				formula += "] },\n"; 
	    			}
	    			else{
	    				formula += "] }";
	    			}
    			}
    			
    			formula += "\n  ]\n}";
    			console.log(formula);
    			
    			var temp = attrId.childNodes;
    			temp = temp[temp.length-1];
    			var p = document.createElement("p");
    			p.setAttribute("hidden","");
    			p.innerHTML = formula;
    			temp.appendChild(p);
    		}
    		
    		$("#expressions").on("change", function(){
    		    console.log("event detected");
    			var value = $("#expressions").val();
    			if(value > 0){
    		    	console.log(value);
    		    	var form, label, select, option, div, div_inner, input;
    				form = document.getElementById("exprForm");
    				form.innerHTML = "";
    				
    				for(var i = 0; i < value; i++){
        				div = document.createElement("div");
            			div.setAttribute("class", "form-row");
            			
            			div_inner = document.createElement("div");
            			div_inner.setAttribute("class","col-auto");
            			label = document.createElement("label");
            			label.setAttribute("class", "sr-only");
            			label.setAttribute("class", "inlineFormInput");
            			label.innerHTML = "Comparation Value";
            			input = document.createElement("input");
            			input.setAttribute("type","text");
            			input.setAttribute("class","form-control mb-2");
            			input.setAttribute("placeholder","Insert Value");
            			label.appendChild(input);
            			div_inner.appendChild(label);
            			div.append(div_inner);
            			
            			div_inner = document.createElement("div");
            			div_inner.setAttribute("class","col-auto");
            			label = document.createElement("label");
            			label.setAttribute("for", "selectCondition");
            			label.innerHTML = "Select one of the following conditions:";
            			
            			select = document.createElement("select");
            			select.setAttribute("class", "form-control");
            			select.setAttribute("name", "conditions");
            			
            			option = document.createElement("option");
            			option.setAttribute("value", "equals");
            			option.innerHTML = "equals";
            			select.appendChild(option);
            			
            			option = document.createElement("option");
            			option.setAttribute("value", "like");
            			option.innerHTML = "like";
            			select.appendChild(option);
            			
            			option = document.createElement("option");
            			option.setAttribute("value", "not");
            			option.innerHTML = "not";
            			select.appendChild(option);
            			
            			option = document.createElement("option");
            			option.setAttribute("value", ">");
            			option.innerHTML = ">";
            			select.appendChild(option);
            			
            			option = document.createElement("option");
            			option.setAttribute("value", "<");
            			option.innerHTML = "<";
            			select.appendChild(option);
            			
            			option = document.createElement("option");
            			option.setAttribute("value", ">=");
            			option.innerHTML = ">=";
            			select.appendChild(option);
            			
            			option = document.createElement("option");
            			option.setAttribute("value", "<=");
            			option.innerHTML = "<=";
            			select.appendChild(option);
            			label.appendChild(select);
            			div_inner.appendChild(label);
            			div.append(div_inner);
            			
            			div_inner = document.createElement("div");
            			div_inner.setAttribute("class","col-auto");
            			label = document.createElement("label");
            			label.setAttribute("class", "sr-only");
            			label.setAttribute("class", "inlineFormInput");
            			label.innerHTML = "Output Value";
            			input = document.createElement("input");
            			input.setAttribute("type","text");
            			input.setAttribute("class","form-control mb-2");
            			input.setAttribute("placeholder","Insert Value");
            			label.appendChild(input);
            			div_inner.appendChild(label);
            			div.append(div_inner);
            			
            			form.appendChild(document.createElement("br"));
            			form.appendChild(div);
    				}
    			}	
    		});
    	</script>
    	
    	<script>
    		function verifyChecked(button){
    			if(button.checked == true){
    				var button = document.getElementById("addDimension");
	    	    	button.removeAttribute("disabled");
	    	    	console.log("checked");
    				return true;    				
    			}
    			else{
    				console.log("not checked");
    				return false;	
    			}
    		}
    		
    		var dimensions = [];
    		var measures = [];
    		
    		
    		function deleteDimensionRow(Id)  {
	    		console.log(Id.innerHTML);
	    	    var row = Id;//document.getElementById(Id);
	    	    var table = row.parentNode;
	    	    while ( table && table.tagName != 'TABLE' )
	    	        table = table.parentNode;
	    	    if ( !table )
	    	        return;
	    	    
	    	    
	    	    console.log(dimensions);
	    	    
	    	    var name = row.children[0].innerHTML;
	    	    console.log(name);
	    	    
	    	    for(var i=0; i < dimensions.length; i++){
	    	    	if(dimensions[i][0] === name){
	    	    		dimensions.splice(i,1);
	    	    	}
	    	    }
	    	    
	    	    console.log(dimensions);
	    	    
	    	    var checked;
	    	    checked = row.children[2].firstChild;
	    	    console.log(checked);
	    	    
	    	    table.deleteRow(row.rowIndex);
	    	    var tbody = table.children[1];
	    	}
    		
    		function addRowDimension() {		
    			var name = document.getElementById("dimensionID").value;
    			if(checkDimensionDuplicity(name) == false) {
    				var div,table, thead, tbody, th, tr, tn, selectedRow, dbSelect, tableSelect;
    				
    				table = document.getElementById("attrTable");
        			var rows = table.getElementsByTagName("tr");
        			var row, columns, set, data, button, p;
        			
        			set = [];
        			set.push(name);
        			for(var i = 1; i < rows.length; i++){
        				row = rows[i];
        				columns = row.getElementsByTagName("td");
        				data = [];
        				
        				data.push(columns[0].innerHTML);
        				data.push(columns[1].innerHTML);
        				data.push(columns[2].innerHTML);
        				data.push(columns[3].innerHTML);
        				
        				
        				button = columns[5].children;
        				button = button[0];
        				if(button.checked){
        					data.push("true");
        				}
        				else{
        					data.push("false");
        				}
        				
        				set.push(data);
        				console.log(data);
        			}
        			console.log(set);
        			var jsondata = JSON.stringify(set);
        			console.log(jsondata);
        			dimensions.push(set);
        			console.log(dimensions);
        			
        			table = document.getElementById("previewDimensionTable");
        			
        			if(table.children.length == 0){
        				tr = document.createElement("tr");
        				th = document.createElement("th");
        				th.setAttribute("scope","column");
    					tn = document.createTextNode("Dimension");
    					th.appendChild(tn);
    					tr.appendChild(th);
    					
    					th = document.createElement("th");
        				th.setAttribute("scope","column");
    					tn = document.createTextNode("Primary Key");
    					th.appendChild(tn);
    					tr.appendChild(th);
    					
    					th = document.createElement("th");
        				th.setAttribute("scope","column");
    					tn = document.createTextNode("Time Dimension");
    					th.appendChild(tn);
    					tr.appendChild(th);
    					
    					th = document.createElement("th");
        				th.setAttribute("scope","column");
    					tn = document.createTextNode("Delete");
    					th.appendChild(tn);
    					tr.appendChild(th);
    					
    					thead = document.createElement("thead");
        				thead.setAttribute("class","thead-dark");
        				thead.appendChild(tr);
        				tbody = document.createElement("tbody");
    					
        				table.appendChild(thead);
        				table.appendChild(tbody);
        				makeTableScroll("attrTable");
        			}
        			
					var button, i, label, div, p;
					tbody = table.children[1];
					console.log(tbody);
					tr = document.createElement("tr");
					var rowId = "row" + set[0];
					tr.id = rowId;
					
    				td =  document.createElement("td");
    				tn = document.createTextNode(set[0]);
    				td.appendChild(tn);
    				tr.appendChild(td);
    		
    				td =  document.createElement("td");
    				tn = document.createTextNode(set[1][4]);
    				td.appendChild(tn);
    				tr.appendChild(td);
    				
    				input = document.createElement("input");
    				input.setAttribute("type", "radio");
    				input.setAttribute("class", "form-check-input");
    				input.setAttribute("name", "optdecision");
    				input.setAttribute("onclick", "verifyChecked(this)");
    				
    				td =  document.createElement("td");
    				td.appendChild(input);
    				tr.appendChild(td);   			
    				
    				i = document.createElement("i");
    				i.setAttribute("class", "fas fa-minus");
    				
    				button = document.createElement("button");
    				button.setAttribute("type", "button");
    				button.setAttribute("class", "btn btn-danger");
    				button.setAttribute("onclick", "deleteDimensionRow(" + rowId + ")");
    				button.appendChild(i);
    				
    				td =  document.createElement("td");
    				td.appendChild(button);
    				tr.appendChild(td);	
    				tbody.appendChild(tr);
    			}
    		}
    		
    		function checkDimensionDuplicity(dimensionName){
        		for (i = 0; i < dimensions.length; i++) {
        			if(dimensions[i][0] === dimensionName){
        				return true;
        			}
        		}
      			return false;
        	}
    		
    		function addModelMeasures(){
    			var name = document.getElementById("factTableID").value;
    				var div,table, thead, tbody, th, tr, tn, selectedRow, dbSelect, tableSelect;
    				
    				table = document.getElementById("attrTable2");
        			var rows = table.getElementsByTagName("tr");
        			var row, columns, set, data, button, p;
        			
        			set = [];
        			set.push(name);
        			for(var i = 1; i < rows.length; i++){
        				row = rows[i];
        				columns = row.getElementsByTagName("td");
        				data = [];
        				
        				data.push(columns[0].innerHTML);
        				data.push(columns[1].innerHTML);
        				data.push(columns[2].innerHTML);
        				data.push(columns[3].innerHTML);
        				
        				set.push(data);
        				console.log(data);
        			}
        			console.log(set);
        			var jsondata = JSON.stringify(set);
        			console.log(jsondata);
        			measures.push(set);
        			console.log(measures);
        			
        			if(dimensions.length > 0 && measures.length > 0){
        				var button = document.getElementById("submitModel");
    	    	    	button.setAttribute("style","display: block;");
    	    	    	button.removeAttribute("disabled");
        			}
    		}
    		  	
    		function createModel(){
    			var information = [];
    			information.push(dimensions);
    			information.push(measures);
    			console.log(information);
    			var xhttp;
				xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function(){
					if(this.readyState == 4 && this.status == 200){
						alert("DDBM Created");
						var decisionTree = this.responseText;
						console.log(decisionTree);
						
						div = document.getElementById("divReport");
						var button = document.createElement("button");
						button.id = "reportButton";
						button.setAttribute("class","btn btn-success apply");
						button.setAttribute("onclick","generateReport()");
						button.innerHTML = "Generate Report";
						div.appendChild(button);
					}
				};
				xhttp.open("POST", "/CreateMDDBServlet", true);
				xhttp.send(JSON.stringify(information));
    		}
    		
    		function generateReport() {
    			var xhttp;
				xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function(){
					if(this.readyState == 4 && this.status == 200){
						alert("Report Generated");
						var report = this.responseText;
						console.log(report);
						var div = document.getElementById("myReportDiv");
						div.setAttribute("style","background-color: white; border: solid 1px black; width: 100%; height: 500px; overflow:auto;");
						
						var pre = document.createElement("pre");
						pre.setAttribute("style","padding-left: 120px;");
						pre.id = "reportResult";
						pre.innerHTML = report;
						div.appendChild(pre);
					}
				};
				xhttp.open("GET", "/GetMDDBReportServlet", true);
				xhttp.send();	
    		}
    	</script>
	</body>
</html>