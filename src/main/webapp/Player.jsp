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
					String sqlQuery = "select * from playerdata";
					ResultSet rs = statement.executeQuery(sqlQuery);
					while(rs.next()) {
						playerInfo.add(rs.getString(1));playerInfo.add(rs.getString(2));
						playerInfo.add(rs.getString(3));playerInfo.add(rs.getString(4));
						playerInfo.add(rs.getString(5));playerInfo.add(rs.getString(6));
						playerInfo.add(rs.getString(7));playerInfo.add(rs.getString(8));
						playerInfo.add(rs.getString(9));playerInfo.add(rs.getString(10));
						playerInfo.add(rs.getString(11));
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
      <li><a href="#">Edit Profile</a></li>
      <li><a href="#">Logout</a></li>
    </ul>
  </div>
   </div>
</nav>
	<div class="container">
		<div class="user-details">
		<button class="left-user-logo">
		<% if(request.getAttribute("profileUpdated") != null && request.getAttribute("profileUpdated").equals("no")){ %>
			<img class="left-user-img" src="resources/img/unnameduser.png">
			<%} else if(request.getAttribute("profileUpdated") != null && request.getAttribute("profileUpdated").equals("yes")){%>
			<img class="left-user-img" src="resources/upload-images/<%= playerInfo.get(9)%>">
			<%}%>
		</button>
		<span style="margin:auto;display:table"><%= request.getAttribute("userName") %></span><hr>
		<span style="margin:auto;display:table"><b>Email:</b>&nbsp;<%= request.getAttribute("userEmail") %></span>
		<span style="margin:9px;"><b>Phone:</b>&nbsp;<%= request.getAttribute("userNumber") %></span><hr>
		<% if(request.getAttribute("profileUpdated") != null && request.getAttribute("profileUpdated").equals("yes")){ %>
		<span><%= playerInfo.get(3)%></span>
		<span><%= playerInfo.get(4)%></span>
		<span><%= playerInfo.get(5)%></span>
		<span><%= playerInfo.get(6)%></span>
		<span><%= playerInfo.get(7)%></span>
		<span><%= playerInfo.get(8)%></span>
		<embed src="resources/upload-images/<%= playerInfo.get(10)%>" width="50" height="37" type="application/pdf">
		<%}%>
		</div>
		<div>
		Popupmodel
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
		<%}%>
		
		</div>
	</div>

</body>
<script type="text/javascript">
$('#player-data').click();
$("#updatePlayerData").on('click', function(){
	
		$("#savePlayerData").click()
		
	
});
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
</script>
</html>