<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.util.*" %>
<%@ page import="winners.game.connection.DBConnection" %>
<%List<String> playerInfo = new ArrayList<String>();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/style.css" rel="stylesheet">
<link href="resources/admin-style.css" rel="stylesheet">
<script src="resources/jQuery/jquery.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<title>Admin</title>
</head>
<body>
<nav class="navbar navbar-light bg-light">
  <div class="navbar-logo">
  <a class="navbar-brand" href="">
    <img src="resources/img/App_Logo.png" class="logo-img" alt="">
    <span class="logo-text">Winners Game</span>
  </a>
   </div>
   <div class="navbar-user">
   <div class="dropdown">
   <button class="user-img"> 
   	<img src="resources/img/App_Logo.png" class="user-logo" alt="">
   </button>
    <button class="dropdown-toggle drop-btn" type="button" data-bs-toggle="dropdown">
    <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="index.html">Logout</a></li>
    </ul>
  </div>
   </div>
</nav>
<div class="container">
	<div class="post-cards">
	<h5 style="margin-top:15px;margin-left:15px"><b>Pending Approval - Player profile</b></h5><br>
	<div class="row" style="margin-left: 15px;">
		<%
		List<String> playerList =new ArrayList<String>();
			DBConnection dbconnection = new DBConnection();
			try {
				Connection con = dbconnection.getConnection();
				Statement statement = con.createStatement();
				String sqlQuery = "select * from playerdata where profileApproved='no' ";
				ResultSet rs = statement.executeQuery(sqlQuery);
				while(rs.next()){%>
				<div class="col-md-2" style="height: fit-content">
					<div class="card" style="width: 12rem;">
					  <img class="card-img-top" src="resources/upload-images/<%= rs.getString(10)%>" alt="Card image cap">
					  <div class="card-body">
					    <h5 class="card-title"><b><%=rs.getString(1) %></b></h5>
					    <span><b>Sports:</b></span>
					    <p class="card-text"><%=rs.getString(4) %></p>
					    <button id="expandProfile" onclick="showProfile('<%= rs.getString(2)%>')" class="btn btn-primary">Expand</button>
					  </div>
					</div>
					</div>
				<%}
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}%>
		</div>
		
		<h5 style="margin-top:15px;margin-left:15px"><b>Pending Approval - Club profile</b></h5><br>
	<div class="row" style="margin-left: 15px;">
		<%
		List<String> clubList =new ArrayList<String>();
			dbconnection = new DBConnection();
			try {
				Connection con = dbconnection.getConnection();
				Statement statement = con.createStatement();
				String sqlQuery = "select * from clubdata where profileApproved='no' ";
				ResultSet rs = statement.executeQuery(sqlQuery);
				while(rs.next()){%>
				<div class="col-md-2" style="height: fit-content">
					<div class="card" style="width: 12rem;">
					  <img class="card-img-top" src="resources/upload-images/<%= rs.getString(9)%>" alt="Card image cap">
					  <div class="card-body">
					    <h5 class="card-title"><b><%=rs.getString(1) %></b></h5>
					    <span><b>Available Sports:</b></span>
					    <p class="card-text"><%=rs.getString(4) %></p>
					    <button id="expandProfile" onclick="showProfile('<%= rs.getString(2)%>')" class="btn btn-primary">Expand</button>
					  </div>
					</div>
					</div>
				<%}
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}%>
		</div><br>
		
	</div>
</div>
	<div id="profilePopupView" class="popup-screen">
			<div class="popup-content">
				<div id="closePopup" class="close-popup">
				<span>X</span>
				</div><br>
				<div class="container">
				<div class="data-box">
					<p><b>Username: </b><span id="profilename"></span></p>
					<p><b>Email: </b><span id="profilemail"></span></p>
					<p><b>Number: </b><span id="profilemobile"></span></p>
					<p><b>Sports: </b><span id="profilesports"></span></p>
					<p id="roleShow"><b>Role: </b><span id="profilerole"></span></p>
					<p><b>Address: </b>
					<span id="profileaddress"></span><br>
					<span id="profileaddress2"></span><br>
					<span id="profilecity"></span>-<span id="profilezip"></span>
					</p>
					<p id="certs-style" style="color:#2874f0;cursor:pointer"><b>Show Certificate</b></p>
					<embed id="docsData" src="" width="100px" height="100px" type="application/pdf" hidden="true">
					<button id="acceptProfile" class="btn btn-primary">Accept</button>&nbsp;
					<button id="rejectProfile" class="btn btn-warning">Reject</button>
				</div>
				<div class="certs-box">
					<h3 id="cert-text">Click the document to view here..</h3>
					<embed src="" type="application/pdf" width="100%" height="100%" id="viewCerts">
				</div>
				</div>
			</div>
		</div>
</body>
<script type="text/javascript">
$('#profilePopupView').hide();
function showProfile(email){
	$("#viewCerts").hide();$("#cert-text").show();
	let playerData = {};
	playerData["profileEmail"] = email;
	$.ajax({
		  url: 'ProfileData',
		  type: 'GET',
		  data: playerData,
		  dataType: 'JSON',
		  success: function(response) {
			  $("#profilename").text(response[0]);$("#profilemail").text(response[1]);
			  $("#profilemobile").text(response[2]);$("#profilesports").text(response[3]);
			 if(response.length === 11){
				 $("#roleShow").show();$("#profilerole").text(response[4]);
				 $("#profileaddress").text(response[5]);$("#profileaddress2").text(response[6]);
				 $("#profilecity").text(response[7]);$("#profilezip").text(response[8]);
				 $('#profilePopupView').show();
				 $('#docsData').attr('src', 'resources/upload-images/'+response[10]);
			 }else{
				 $("#roleShow").hide();$("#profileaddress").text(response[4]);
				 $("#profileaddress2").text(response[5]);$("#profilecity").text(response[6]);
				 $("#profilezip").text(response[7]);$('#profilePopupView').show();
				 $('#docsData').attr('src', 'resources/upload-images/'+response[9]);
			 }
		  }
		});
}
$("#closePopup").on('click', function(){
	$('#profilePopupView').hide();
});
$("#profilePopupView").on('click', function(e){
	if(e.target.id === "profilePopupView"){
		$('#profilePopupView').hide();
	}
});
$(document).on('keydown', function(e){
	if(e.keyCode === 27){
		$('#profilePopupView').hide();
	}
});
$("#certs-style").on('click', function(){
	$("#cert-text").hide();$("#viewCerts").show();
	 $('#viewCerts').attr('src', $("#docsData").attr('src'));
});
$("#acceptProfile").on('click', function(){
	let playerData = {};
	playerData["profileEmail"] = $("#profilemail").text();
	playerData["profileStatus"] ="accept";
	$.ajax({
		  url: 'ProfileData',
		  type: 'POST',
		  data: playerData,
		  success: function(response) {
			  if(response === "success"){
				  $('#profilePopupView').hide();
				  location.reload();
			  }
		  }
		});
	
});
$("#rejectProfile").on('click', function(){
	let playerData = {};
	playerData["profileEmail"] = $("#profilemail").text();
	playerData["profileStatus"] ="reject";
	$.ajax({
		  url: 'ProfileData',
		  type: 'POST',
		  data: playerData,
		  success: function(response) {
			  if(response === "success"){
				  $('#profilePopupView').hide();
				  location.reload();
			  }
		  }
		});
	
});
</script>
</html>