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
<link href="resources/player-style.css" rel="stylesheet">
<script src="resources/jQuery/jquery.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<title></title>
</head>
<body>
	<form style="display:none" action="PlayerMetaData" method="get">
		<input type="text" name="email" value="<%= request.getAttribute("UserMail") %>">
		<% if(request.getAttribute("userName") == null){ %>
		<input id="player-data" type="submit" value="Login">
		<%} %>
	</form>
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
   <% if(request.getAttribute("profileUpdated") != null && request.getAttribute("profileUpdated").equals("no")){ %>
   	<img src="resources/img/App_Logo.png" class="user-logo" alt="">
   <%} else if(request.getAttribute("profileUpdated") != null && request.getAttribute("profileUpdated").equals("yes")){
				DBConnection dbconnection = new DBConnection();
				try {
					Connection con = dbconnection.getConnection();
					Statement statement = con.createStatement();
					String sqlQuery = "select * from playerdata where Email='"+request.getAttribute("userEmail")+"'";
					ResultSet rs = statement.executeQuery(sqlQuery);
					while(rs.next()) {
						playerInfo.add(rs.getString(1));playerInfo.add(rs.getString(2));
						playerInfo.add(rs.getString(3));playerInfo.add(rs.getString(4));
						playerInfo.add(rs.getString(5));playerInfo.add(rs.getString(6));
						playerInfo.add(rs.getString(7));playerInfo.add(rs.getString(8));
						playerInfo.add(rs.getString(9));playerInfo.add(rs.getString(10));
						playerInfo.add(rs.getString(11));
					}
					sqlQuery = "select password from userData where Email='"+request.getAttribute("userEmail")+"'";
					rs = statement.executeQuery(sqlQuery);
					while(rs.next()){
						playerInfo.add(rs.getString(1));
					}
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				} 
			%>
			<img src="resources/upload-images/<%= playerInfo.get(9)%>" class="user-logo" alt="">
			<%}%>
   </button>
    <button class="dropdown-toggle drop-btn" type="button" data-bs-toggle="dropdown">
    <span class="caret"></span></button>
    <ul class="dropdown-menu">
    <% if(request.getAttribute("profileUpdated") != null && request.getAttribute("profileUpdated").equals("yes")){ %>
      <li style="cursor:pointer" id="editProfileData">My Profile</li>
      <%}%>
      <li><a href="index.html">Logout</a></li>
    </ul>
  </div>
   </div>
</nav>
	<div class="container">
		<div class="user-details">
		
		<div class="first-userBlock">
		<button class="left-user-logo">
		<% if(request.getAttribute("profileUpdated") != null && request.getAttribute("profileUpdated").equals("no")){ %>
			<img class="left-user-img" src="resources/img/unnameduser.png">
			<%} else if(request.getAttribute("profileUpdated") != null && request.getAttribute("profileUpdated").equals("yes")){%>
			<img class="left-user-img" src="resources/upload-images/<%= playerInfo.get(9)%>">
			<%}%>
		</button>
		<span id="displayName" class="user-name-left"><%= request.getAttribute("userName") %></span>
		</div>
		
		<div class="second-userBlock">
		<p style="margin-left:9px;display:table;"><img width="25px" src="resources/img/email-logo.png">&nbsp;<%= request.getAttribute("userEmail") %></p>
		<p style="margin-left:9px;"><img width="25px" src="resources/img/mobile.png">&nbsp;<span id="displayNumber"><%= request.getAttribute("userNumber") %></span></p>
		</div>
		
		<% if(request.getAttribute("profileUpdated") != null && request.getAttribute("profileUpdated").equals("yes")){ %>
		<div class="third-userBlock">
		<div class="profile-block">
			<span style="font-size:20px;font-weight:500"><%= playerInfo.get(3)%></span><br>
			<span style="font-size:1.1rem"><%= playerInfo.get(4)%></span><br>
		</div><br>
		<button class="docs-view" onclick="getCertsData()">My Certificates</button><br><br>
		<embed id="docsData" src="resources/upload-images/<%= playerInfo.get(10)%>" width="100px" height="100px" type="application/pdf" hidden="true">
		<div class="location-view">
			<span><%= playerInfo.get(5)%></span><br>
			<span><%= playerInfo.get(6)%></span><br>
			<span><%= playerInfo.get(7)%> - <%= playerInfo.get(8)%></span>
		</div>
		</div>
		<%}%>
		
		</div>
		
		<div class="post-cards">
		
		<% if(request.getAttribute("profileUpdated") != null && request.getAttribute("profileUpdated").equals("no")){ %>
		<div class="container" style="height: fit-content;">
		<h2>Add some more details to your profile..</h2><br>
		<form>
		  <div class="row">
		    <div class="form-group col-md-4">
		      <label for="inputSport"><b>Pick a Sport</b></label>
		      <select id="inputSport" class="form-control" name="sportsData">
		        <option selected>Choose...</option>
		        <option>Cricket</option>
		        <option>VolleyBall</option>
		        <option>FootBall</option>
		        <option>BasketBall</option>
		      </select>
		    </div>
		    <div class="col-md-6">
		      <label for="Role"><b>Role</b></label>
		      <input type="text" class="form-control" id="Role" name="roleData" placeholder="Describe your Role here ">
		    </div>
		  </div><br>
		  <div class="form-group col-md-10">
		    <label for="inputAddress"><b>Address</b></label>
		    <input type="text" class="form-control" id="inputAddress" name="address" placeholder="Building No., Street Name">
		  </div><br>
		  <div class="form-group col-md-10">
		    <label for="inputAddress2"><b>Address line 2</b></label>
		    <input type="text" class="form-control" id="inputAddress2" name="addressLine2" placeholder="Apartment, studio, or floor">
		  </div><br>
		  <div class="row">
		    <div class="form-group col-md-6">
		      <label for="inputCity"><b>City</b></label>
		      <input type="text" name="cityData" class="form-control" id="inputCity">
		    </div>
		    
		    <div class="form-group col-md-2">
		      <label for="inputZip"><b>Zip</b></label>
		      <input type="text" name="zipData" class="form-control" id="inputZip">
		    </div>
		  </div><br>
		  <button hidden="true" id="savePlayerData">Click</button>
		  </form>
		  <form action="PlayerMetaData" method="post" enctype='multipart/form-data'>
			  <div class="form-group">
			    <label for="formControlFile1"><b>Profile Photo</b></label><br>
	    		<input type="file" name="file" class="form-control-file" id="formControlFile1">
			  </div><br>
			  <div class="form-group">
			    <label for="formControlFile2"><b>Certificates</b> <span style="font-size:13px">(Upload your Recent Nation-level or State-level certificates in a single PDF file)</span></label><br>
	    		<input type="file" name="file" class="form-control-file" id="formControlFile2" accept="application/pdf">
			  </div><br> 
			  <button type="submit" id="updatePlayerData" class="btn btn-primary">Update</button>
		</form>
	</div>
		<%}else if(request.getAttribute("profileUpdated") != null && request.getAttribute("profileUpdated").equals("yes")){%>
			<div class="container">
			<div class="card" style="width: 18rem;">
			  <img class="card-img-top" src="..." alt="Card image cap">
			  <div class="card-body">
			    <h5 class="card-title">Card title</h5>
			    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
			    <a href="#" class="btn btn-primary">Go somewhere</a>
			  </div>
			</div>
			</div>
		<%} %>
		
		</div>
		<div id="docsPopupView" class="popup-screen">
			<div class="popup-content">
				<div id="closePopup" class="close-popup">
				<span>X</span>
				</div>
				<div class="certs-box">
					<embed src="" type="application/pdf" width="100%" height="100%" id="viewCerts">
				</div>
			</div>
		</div>
		
	<% if(request.getAttribute("profileUpdated") != null && request.getAttribute("profileUpdated").equals("yes")){ %>
		<div id="editProfilePopup" class="popup-screen">
			<div id="updatePlayerContent" class="popup-profile-update">
				<div id="closeEditPopup" class="close-profile-popup">
				<span>X</span>
				</div><br>
				<div class="container">
				<form>
				  <h2>Personal Information</h2><br>
				  <div class="row">
				  <div class="col-md-5">
				      <label for="updateUser"><b>Username</b></label>
				      <input type="text" class="form-control" id="updateUser" name="updateUser" value="<%= playerInfo.get(0)%>">
				    </div>
				    <div class="col-md-5">
				      <label for="updateNumber"><b>Mobile Number</b></label>
				      <input type="text" class="form-control" id="updateNumber" name="updateNumber" value="<%= playerInfo.get(2)%>">
				    </div>
				   </div><br>
				   <div class="row">
					    <div class="col-md-5">
					      <label for="updateRole"><b>Role</b></label>
					      <input type="text" class="form-control" id="updateRole" name="updateRole" value="<%= playerInfo.get(4)%>">
					    </div>
					    <div id="pwdUpdateBtn" class="col-md-4">
					      <label><b>Password</b></label>
					      <p id="changePwd"><b>Change Password</b></p>
					    </div>
					    <div id="pwdCurrent" class="col-md-5">
					    <label><b>Password</b></label>
					    <input type="password" style="width:78%" class="form-control" id="currentPass" placeholder="Type Current Password">
					    <span style="color:#ff0000;margin-left:3px" id="wrongPass">Wrong Password!.Try again..</span>
					    <button style="float: right;margin-top: -39px;" class="btn btn-primary" onclick="validateCurrentPwd(event,'<%= playerInfo.get(11)%>')">Change</button>
					    </div>
					    <div id="pwdSet" class="col-md-5">
					    <label><b>Password</b></label>
					    <input type="password" style="width:78%" class="form-control" id="newPass" placeholder="Type New Password">
					    <button style="float: right;margin-top: -39px;width: 82px" class="btn btn-primary">Set</button>
					    </div>
					    <div id="pwdConfirm" class="col-md-5">
					    <label><b>Password</b></label>
					    <input type="password" style="width:78%" class="form-control" id="confirmPass" placeholder="Confirm New Password">
					    <button style="float: right;margin-top: -39px;" class="btn btn-primary">Confirm</button>
					    </div>
				    </div>
				    <br>
				  <div class="form-group col-md-10">
				    <label for="updateAddress"><b>Address</b></label>
				    <input type="text" class="form-control" id="updateAddress" name="updateAddress" value="<%= playerInfo.get(5)%>">
				  </div><br>
				  <div class="form-group col-md-10">
				    <label for="updateAddress2"><b>Address line 2</b></label>
				    <input type="text" class="form-control" id="updateAddress2" name="updateAddress2" value="<%= playerInfo.get(6)%>">
				  </div><br>
				  <div class="row">
				    <div class="form-group col-md-6">
				      <label for="updateCity"><b>City</b></label>
				      <input type="text" name="updateCity" class="form-control" id="updateCity" value="<%= playerInfo.get(7)%>">
				    </div>
				    <div class="form-group col-md-2">
				      <label for="updateZip"><b>Zip</b></label>
				      <input type="text" name="updateZip" class="form-control" id="updateZip" value="<%= playerInfo.get(8)%>">
				    </div>
				  </div><br>
				  <button hidden="true" id="myProfileData">Click</button>
		  		</form>
		  		 <form action="UpdatePlayerServlet" method="post" enctype='multipart/form-data'>
				  <div class="form-group">
				    <label for="formControlFile1"><b>Profile Photo</b></label><br>
		    		<input type="file" name="file" class="form-control-file" id="formControlFile1">
				  </div><br>
				  <div class="form-group">
				    <label for="formControlFile2"><b>Certificates</b> <span style="font-size:13px">(Upload your Recent Nation-level or State-level certificates in a single PDF file)</span></label><br>
		    		<input type="file" name="file" class="form-control-file" id="formControlFile2" accept="application/pdf">
				  </div><br> 
			  	<button type="submit" id="myProfileUpdate" class="btn btn-primary">Update</button>
				</form><br>
				</div>
			</div>
		</div>
		<%} %>
	</div>
	

</body>
<script type="text/javascript">
$('#player-data').click();
$('#docsPopupView').hide();
$('#editProfilePopup').hide();
$("#updatePlayerData").on('click', function(){
	
		$("#savePlayerData").click()
		
	
});
$("#wrongPass").hide();
$("#savePlayerData").on('click', function(){
	console.log("Clicked")
	let playerDataJson = []
	let playerData = {}
	playerData["sportsData"] = $('#inputSport').val();
	playerData["roleData"] = $('#Role').val();
	playerData["addressData"] = $('#inputAddress').val();
	playerData["address2Data"] = $('#inputAddress2').val();
	playerData["cityData"] = $('#inputCity').val();
	playerData["zipData"] = $('#inputZip').val();
	playerDataJson.push(playerData)
	console.log(playerData)
	$.ajax({
		  url: 'PlayerMetaData',
		  type: 'POST',
		  data: playerData,
		  success: function(response) {}
		});
	});
function getCertsData(){
	$('#viewCerts').attr('src', $("#docsData").attr('src'));
	$('#docsPopupView').show();
}
$("#closePopup").on('click', function(){
	$('#docsPopupView').hide();
});
$("#closeEditPopup").on('click', function(){
	$('#editProfilePopup').hide();
	$("#pwdUpdateBtn").show();
	$("#currentPass").val("");
	$("#wrongPass").hide();
});
$("#docsPopupView").on('click', function(){
	$('#docsPopupView').hide();
});
$(document).on('keydown', function(e){
	if(e.keyCode === 27){
		$('#docsPopupView').hide();
		$('#editProfilePopup').hide();
		$("#pwdUpdateBtn").show();
		$("#currentPass").val("");
		$("#wrongPass").hide();
	}
});
$("#editProfileData").on('click', function(){
	$('#editProfilePopup').show();
	$("#pwdCurrent").hide();$("#pwdSet").hide();
	$("#pwdConfirm").hide();
});
$("#editProfilePopup").on('click', function(e){
	if(e.target.id === "editProfilePopup"){
		$('#editProfilePopup').hide();
		$("#pwdUpdateBtn").show();
		$("#currentPass").val("");
		$("#wrongPass").hide();
	}
});
$("#changePwd").on('click', function(e){
	$("#pwdUpdateBtn").hide();
	$("#pwdCurrent").show();$("#pwdSet").hide();
	$("#pwdConfirm").hide();
});
function validateCurrentPwd(e, passData){
	e.preventDefault();
	if($("#currentPass").val() === passData){
		$("#pwdUpdateBtn").hide();
		$("#pwdCurrent").hide();$("#pwdSet").show();
		$("#pwdConfirm").hide();
		$("#wrongPass").hide();
	}else{
		$("#wrongPass").show();
	}
}
$("#pwdSet button").on('click', function(e){
	e.preventDefault();
	console.log($("#newPass").val());
	$("#pwdUpdateBtn").hide();
	$("#pwdCurrent").hide();$("#pwdSet").hide();
	$("#pwdConfirm").show();
});
$("#pwdConfirm button").on('click', function(e){
	e.preventDefault();
	console.log($("#confirmPass").val());
	/*$("#pwdUpdateBtn").hide();
	$("#pwdCurrent").hide();$("#pwdSet").hide();
	$("#pwdConfirm").show();*/
});
</script>
</html>