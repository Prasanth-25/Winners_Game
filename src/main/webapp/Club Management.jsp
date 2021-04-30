<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.util.*" %>
<%@ page import="winners.game.connection.DBConnection" %>
<%List<String> clubInfo = new ArrayList<String>();%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/style.css" rel="stylesheet">
<link href="resources/club-style.css" rel="stylesheet">
<script src="resources/jQuery/jquery.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<title>Club Management</title>
</head>
<body>
	<form style="display:none" action="ClubMetaData" method="get">
		<input type="text" name="email" value="<%= request.getAttribute("UserMail") %>">
		<% if(request.getAttribute("userName") == null){ %>
		<input id="club-data" type="submit" value="Login">
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
					String sqlQuery = "select * from clubdata where Email='"+request.getAttribute("userEmail")+"'";
					ResultSet rs = statement.executeQuery(sqlQuery);
					while(rs.next()) {
						clubInfo.add(rs.getString(1));clubInfo.add(rs.getString(2));
						clubInfo.add(rs.getString(3));clubInfo.add(rs.getString(4));
						clubInfo.add(rs.getString(5));clubInfo.add(rs.getString(6));
						clubInfo.add(rs.getString(7));clubInfo.add(rs.getString(8));
						clubInfo.add(rs.getString(9));clubInfo.add(rs.getString(10));clubInfo.add(rs.getString(11));
					}
					sqlQuery = "select password from userData where Email='"+request.getAttribute("userEmail")+"'";
					rs = statement.executeQuery(sqlQuery);
					while(rs.next()){
						clubInfo.add(rs.getString(1));
					}
					con.close();
				} catch (Exception e) {
					e.printStackTrace();
				} 
			%>
			<img src="resources/upload-images/<%= clubInfo.get(8)%>" class="user-logo" alt="">
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
			<img class="left-user-img" src="resources/upload-images/<%= clubInfo.get(8)%>">
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
			<span style="font-size:20px;font-weight:500">Available Sports: <%= clubInfo.get(3)%></span><br>
		</div><br>
		<button class="docs-view" onclick="getCertsData()">My Certificates</button><br><br>
		<embed id="docsData" src="resources/upload-images/<%= clubInfo.get(9)%>" width="100px" height="100px" type="application/pdf" hidden="true">
		<div class="location-view">
			<span><%= clubInfo.get(4)%></span><br>
			<span><%= clubInfo.get(5)%></span><br>
			<span><%= clubInfo.get(6)%> - <%= clubInfo.get(7)%></span>
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
		    <div class="form-group col-md-10">
		      <label><b>Available Sports</b></label><br>
		      <div class="form-check chk-box form-check-inline">
				  <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="Cricket">
				  <label class="form-check-label" for="inlineCheckbox1">Cricket</label>
			  </div>
			  <div class="form-check chk-box form-check-inline">
				  <input class="form-check-input" type="checkbox" id="inlineCheckbox2" value="VolleyBall">
				  <label class="form-check-label" for="inlineCheckbox2">VolleyBall</label>
			  </div>
			  <div class="form-check chk-box form-check-inline">
				  <input class="form-check-input" type="checkbox" id="inlineCheckbox3" value="FootBall">
				  <label class="form-check-label" for="inlineCheckbox3">FootBall</label>
			  </div>
			  <div class="form-check chk-box form-check-inline">
				  <input class="form-check-input" type="checkbox" id="inlineCheckbox4" value="BasketBall">
				  <label class="form-check-label" for="inlineCheckbox4">BasketBall</label>
			  </div>
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
		  <button hidden="true" id="saveClubData">Click</button>
		  </form>
		  <form action="ClubMetaData" method="post" enctype='multipart/form-data'>
			  <div class="form-group">
			    <label for="formControlFile1"><b>Profile Photo</b></label><br>
	    		<input type="file" name="file" class="form-control-file" id="formControlFile1">
			  </div><br>
			  <div class="form-group">
			    <label for="formControlFile2"><b>Certificates</b> <span style="font-size:13px">(Upload your Recent Nation-level or State-level certificates in a single PDF file)</span></label><br>
	    		<input type="file" name="file" class="form-control-file" id="formControlFile2" accept="application/pdf">
			  </div><br> 
			  <button type="submit" id="updateClubData" class="btn btn-primary">Update</button>
		</form>
	</div>
		<%}else if(request.getAttribute("profileUpdated") != null && request.getAttribute("profileUpdated").equals("yes")){
			if(clubInfo.get(10).equals("yes")){
		%>
			<div class="container">
			<div class="row">
			<%
			List<String> playerList =new ArrayList<String>();
			DBConnection dbconnection = new DBConnection();
			try {
				Connection con = dbconnection.getConnection();
				Statement statement = con.createStatement();
				String sqlQuery = "select * from playerdata where profileApproved='yes' ";
				ResultSet rs = statement.executeQuery(sqlQuery);
				while(rs.next()){%>
					<div class="col-md-3" style="height: fit-content;margin-top:15px">
					<div class="card" style="width: 12rem;">
					  <img class="card-img-top" src="resources/upload-images/<%= rs.getString(10)%>" alt="Card image cap">
					  <div class="card-body">
					    <h5 class="card-title"><%=rs.getString(1) %></h5>
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
			} %>
		</div>
		</div><br>
	<%	}else{%>
			<h5 id="cert-text-status">
			<span>Please wait.. Your Profile is in review. </span><br>
			<span>You will able to see the available players once your profile has been approved by admin.</span> 
			</h5>
	<%}} %>
		
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
			<div id="updateClubContent" class="popup-profile-update">
				<div id="closeEditPopup" class="close-profile-popup">
				<span>X</span>
				</div><br>
				<div class="container">
				<form id="updatePersonalData">
				  <h2>Personal Information</h2><br>
				  <div class="row">
				  <div class="col-md-5">
				      <label for="updateUser"><b>Username</b></label>
				      <input type="text" class="form-control" id="updateUser" name="updateUser" value="<%= clubInfo.get(0)%>">
				    </div>
				    <div class="col-md-5">
				      <label for="updateNumber"><b>Mobile Number</b></label>
				      <input type="text" class="form-control" id="updateNumber" name="updateNumber" value="<%= clubInfo.get(2)%>">
				    </div>
				   </div><br>
				   <div class="row">
					    <div class="col-md-5">
					      <label for="updateSports"><b>Available Sports</b></label>
					      <input type="text" class="form-control" id="updateSports" name="updateSports" value="<%= clubInfo.get(3)%>">
					    </div>
					    <div id="pwdUpdateBtn" class="col-md-4">
					      <label><b>Password</b></label>
					      <p id="changePwd"><b>Change Password</b></p>
					      <p id="pwdSuccess"><b>Password changed. Click Update to Proceed</b></p>
					    </div>
					    <div id="pwdCurrent" class="col-md-5">
					    <label><b>Current Password</b></label>
					    <input type="password" style="width:78%" class="form-control" id="currentPass" placeholder="Type Current Password">
					    <span style="color:#ff0000;margin-left:3px" id="wrongPass">Wrong Password!.Try again..</span>
					    <button style="float: right;margin-top: -39px;" class="btn btn-primary" onclick="validateCurrentPwd(event,'<%= clubInfo.get(11)%>')">Change</button>
					    </div>
					    <div id="pwdSet" class="col-md-5">
					    <label><b>New Password</b></label>
					    <input type="password" style="width:78%" class="form-control" id="newPass" placeholder="Type New Password">
					    <span style="color:#ff0000;margin-left:3px" id="wrongNewPass"></span>
					    <button style="float: right;margin-top: -39px;width: 82px" class="btn btn-primary">Set</button>
					    </div>
					    <div id="pwdConfirm" class="col-md-5">
					    <label><b>Confirm Password</b></label>
					    <input type="password" style="width:78%" class="form-control" id="confirmPass" placeholder="Confirm New Password">
					    <span style="color:#ff0000;margin-left:3px" id="wrongConfirmPass"></span>
					    <button style="float: right;margin-top: -39px;" class="btn btn-primary">Confirm</button>
					    </div>
				    </div>
				    <br>
				  <div class="form-group col-md-10">
				    <label for="updateAddress"><b>Address</b></label>
				    <input type="text" class="form-control" id="updateAddress" name="updateAddress" value="<%= clubInfo.get(4)%>">
				  </div><br>
				  <div class="form-group col-md-10">
				    <label for="updateAddress2"><b>Address line 2</b></label>
				    <input type="text" class="form-control" id="updateAddress2" name="updateAddress2" value="<%= clubInfo.get(5)%>">
				  </div><br>
				  <div class="row">
				    <div class="form-group col-md-6">
				      <label for="updateCity"><b>City</b></label>
				      <input type="text" name="updateCity" class="form-control" id="updateCity" value="<%= clubInfo.get(6)%>">
				    </div>
				    <div class="form-group col-md-2">
				      <label for="updateZip"><b>Zip</b></label>
				      <input type="text" name="updateZip" class="form-control" id="updateZip" value="<%= clubInfo.get(7)%>">
				    </div>
				  </div><br>
				  <button hidden="true" id="myProfileData">Click</button>
		  		</form>
		  		 <form action="UpdateClubServlet" method="post" enctype='multipart/form-data'>
				  <div class="form-group">
				    <label for="formControlFile1"><b>Profile Photo</b></label><br>
		    		<input type="file" name="file" class="form-control-file" id="formControlFile1">
				  </div><br>
				  <div class="form-group">
				    <label for="formControlFile2"><b>Certificates</b> <span style="font-size:13px">(Upload your Recent Nation-level or State-level certificates in a single PDF file)</span></label><br>
		    		<input type="file" name="file" class="form-control-file" id="formControlFile2" accept="application/pdf">
				  </div><br>
				   <button type="submit" hidden="true" id="docsPhotoUpdate">DocsPhotoUpdate</button>
			  	<button id="myProfileUpdate" class="btn btn-primary">Update</button>
				</form><br>
				</div>
			</div>
		</div>
		<%} %>
	</div>
	
	<div id="profilePopupView" class="popup-screen">
			<div class="popup-content">
				<div id="closeProfilePopup" class="close-profile-popup">
				<span>X</span>
				</div><br>
				<div class="container">
				<div class="data-box">
					<p><b>Username: </b><span id="profilename"></span></p>
					<p><b>Email: </b><span id="profilemail"></span></p>
					<!-- <p><b>Number: </b><span id="profilemobile"></span></p> -->
					<p><b>Sports: </b><span id="profilesports"></span></p>
					<p id="roleShow"><b>Role: </b><span id="profilerole"></span></p>
					<p><b>Address: </b>
					<span id="profileaddress"></span><br>
					<span id="profileaddress2"></span><br>
					<span id="profilecity"></span>-<span id="profilezip"></span>
					</p>
					<p id="certs-style" style="color:#2874f0;cursor:pointer"><b>Show Certificate</b></p>
					<embed id="docsProfileData" src="" width="100px" height="100px" type="application/pdf" hidden="true">
				</div>
				<div class="certs-profile-box">
					<h3 id="cert-text">Click the document to view here..</h3>
					<embed src="" type="application/pdf" width="100%" height="100%" id="viewProfileCerts">
				</div>
				</div>
			</div>
		</div>
</body>
<script type="text/javascript">
$('#club-data').click();
$('#docsPopupView').hide();
$('#editProfilePopup').hide();
$('#profilePopupView').hide();
$("#updateClubData").on('click', function(e){
		$("#saveClubData").click();
});
var pwdValidation;
$("#wrongPass").hide();
$("#saveClubData").on('click', function(e){
	e.preventDefault();
	var inputSport = "";
	$(':checkbox:checked').each(function(i){
		if(i === 0)
			inputSport = $(this).val();
		else
			inputSport = inputSport + "," + $(this).val();
        });
	let clubData = {}
	clubData["sportsData"] = inputSport;
	clubData["addressData"] = $('#inputAddress').val();
	clubData["address2Data"] = $('#inputAddress2').val();
	clubData["cityData"] = $('#inputCity').val();
	clubData["zipData"] = $('#inputZip').val();
	//console.log(clubData)
	$.ajax({
		  url: 'ClubMetaData',
		  type: 'POST',
		  data: clubData,
		  success: function(response) {}
		});
	});
$("#closeProfilePopup").on('click', function(){
	$('#profilePopupView').hide();
});
$("#profilePopupView").on('click', function(e){
	if(e.target.id === "profilePopupView"){
		$('#profilePopupView').hide();
	}
});
function getCertsData(){
	$('#viewCerts').attr('src', $("#docsData").attr('src'));
	$('#docsPopupView').show();
}
function showProfile(email){
	$("#viewProfileCerts").hide();$("#cert-text").show();
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
				 $('#docsProfileData').attr('src', 'resources/upload-images/'+response[10]);
			 }else{
				 $("#roleShow").hide();$("#profileaddress").text(response[4]);
				 $("#profileaddress2").text(response[5]);$("#profilecity").text(response[6]);
				 $("#profilezip").text(response[7]);$('#profilePopupView').show();
				 $('#docsProfileData').attr('src', 'resources/upload-images/'+response[9]);
			 }
		  }
		});
}
$("#certs-style").on('click', function(){
	$("#cert-text").hide();$("#viewProfileCerts").show();
	 $('#viewProfileCerts').attr('src', $("#docsProfileData").attr('src'));
});
$("#closePopup").on('click', function(){
	$('#docsPopupView').hide();
});
$("#closeEditPopup").on('click', function(){
	$('#editProfilePopup').hide();
	$("#pwdUpdateBtn").show();
});
$("#docsPopupView").on('click', function(){
	$('#docsPopupView').hide();
});
$(document).on('keydown', function(e){
	if(e.keyCode === 27){
		$('#docsPopupView').hide();
		$('#editProfilePopup').hide();
		$('#profilePopupView').hide();
		$("#pwdUpdateBtn").show();
	}
});
$("#editProfileData").on('click', function(){
	$('#editProfilePopup').show();
	pwdValidation = undefined;
	$("#pwdCurrent").hide();$("#pwdSet").hide();
	$("#pwdConfirm").hide();
	$("#changePwd").show();$("#pwdSuccess").hide();
});
$("#editProfilePopup").on('click', function(e){
	if(e.target.id === "editProfilePopup"){
		$('#editProfilePopup').hide();
		$("#pwdUpdateBtn").show();
	}
});
$("#changePwd").on('click', function(e){
	$("#pwdUpdateBtn").hide();
	pwdValidation = "open";
	$("#pwdCurrent").show();$("#pwdSet").hide();
	$("#pwdConfirm").hide();
	$("#currentPass").val("");$("#newPass").val("");$("#confirmPass").val("");
	$("#wrongPass").hide();$("#wrongNewPass").hide();$("#wrongConfirmPass").hide();
});
function validateCurrentPwd(e, passData){
	e.preventDefault();
	if($("#currentPass").val() === passData){
		$("#pwdUpdateBtn").hide();
		$("#pwdCurrent").hide();$("#pwdSet").show();
		$("#pwdConfirm").hide();$("#wrongPass").hide();
	}else{
		$("#wrongPass").show();
	}
}
$("#pwdSet button").on('click', function(e){
	e.preventDefault();
	if($("#newPass").val()===''){
		$("#wrongNewPass").show();$("#wrongNewPass").text("Password can't be null!.");
	}else{
		$("#pwdUpdateBtn").hide();
		$("#pwdCurrent").hide();$("#pwdSet").hide();
		$("#pwdConfirm").show();$("#wrongNewPass").hide();
		$("#wrongNewPass").text("");
	}
});
$("#pwdConfirm button").on('click', function(e){
	e.preventDefault();
	if($("#confirmPass").val()===''){
		$("#wrongConfirmPass").show();$("#wrongConfirmPass").text("Password can't be null!.");
	}
	else if($("#newPass").val()===$("#confirmPass").val()){
		pwdValidation = "closed";
		$("#pwdCurrent").hide();$("#pwdSet").hide();
		$("#pwdConfirm").hide();$("#pwdUpdateBtn").show();
		$("#changePwd").hide();$("#pwdSuccess").show();
		$("#wrongConfirmPass").hide();$("#wrongConfirmPass").text("");
	}else{
		$("#pwdUpdateBtn").hide();
		$("#pwdCurrent").hide();$("#pwdSet").show();
		$("#pwdConfirm").hide();$("#wrongPass").hide();
		$("#wrongNewPass").show();$("#wrongNewPass").text("Passwords didn't matched!.");
	}
});

$("#myProfileData").on('click', function(e){
	e.preventDefault();
	let playerData = {}
	playerData["email"] = '<%=request.getAttribute("userEmail")%>';
	playerData["nameUpdate"] = $('#updateUser').val();
	playerData["numberUpdate"] = $('#updateNumber').val();
	playerData["sportsUpdate"] = $('#updateSports').val();
	playerData["addressUpdate"] = $('#updateAddress').val();
	playerData["address2Update"] = $('#updateAddress2').val();
	playerData["cityUpdate"] = $('#updateCity').val();
	playerData["zipUpdate"] = $('#updateZip').val();
	if(pwdValidation === 'closed'){
		playerData["pwdUpdate"] = $('#confirmPass').val();
	}
	//console.log(playerData)
	$.ajax({
		  url: 'UpdateClubServlet',
		  type: 'GET',
		  data: playerData,
		  success: function(response) {}
		});
})

$("#myProfileUpdate").on('click', function(e){
	e.preventDefault();
	var nonEmptyField = 0;
	var count = 0;
	$("#updatePersonalData input[type='text']").each(function(index){
		if($(this).val() == ''){
			if(count === 0){
				$(this).focus();
			}
			count++;
			$(this).css("border-color","red");
		}else{
			$(this).css("border-color","#ced4da");
			nonEmptyField = nonEmptyField + 1;
		}
		if( index === 6 ){
			$("#updatePersonalData input[type='password']").each(function(){
				if(pwdValidation === 'open'){
				if($(this).val() == ''){
					$(this).focus();
					$(this).css("border-color","red");
				}else{
					$(this).css("border-color","#ced4da");
				}
				}
			});
		}
	});
	
	if(nonEmptyField === 7 && (pwdValidation === undefined || pwdValidation === 'closed')){
		console.log("Profile is all set to be update");
		$("#myProfileData").click();
		$("#docsPhotoUpdate").click();
	}
});
</script>
</html>