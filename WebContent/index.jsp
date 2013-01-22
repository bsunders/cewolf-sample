<%@page contentType="text/html"%>
<%@taglib uri="cewolf.tld" prefix="cewolf" %>
<HTML>


<head>


	<script src="http://172.16.101.129/tibbr/connect/js/TIB.js"> </script>
 
	<script type="text/javascript">

		var current_user = null;

		console.log("Running TIB.init function.... ");
 		TIB.init({
	        host: "172.16.101.129/tibbr",
	        tunnelUrl: "http://localhost:8080/cewolf-sample/tunnel.html"
	    });

 		TIB.onInit(function(){
	        console.log("TIB init completed");
         });

	       

	    TIB.onLogin(function(user) {
	    		console.log("TIB logon completed");
	            current_user = user[0];
	            console.log("logged on user ID:"+ current_user.login);
	    });

		function showme(user) {

		    var me = document.getElementById("welcome");
	        me.innerHTML = "<li>" + "Full Name: " + user.first_name + " " + user.last_name + "</li>";
	        me.innerHTML += "<li>" + "User id: " + user.id + "</li>";
	        me.innerHTML += "<li>" + "Login: " + user.login + "</li>";
	        me.innerHTML += "<li>" + "Email: " + user.email + "</li>";
		}

		function getFollowers(user){

	        var id = user.id;
	        TIB.api({
	            url: "/users/" + id + "/idols",
	            method: "GET",
	            onResponse: function(data) {
	                var div = document.getElementById("followers");
	                div.innerHTML +=  user.first_name + " has " + data.total_entries + " followers:";
	                for(var i = 0; i < data.items.length; i ++) {
	                    div.innerHTML += "<li>" + data.items[i].display_name + "</li>";
	                }
	            }
	         });

		}


		function postMessage(user, target, text){
			var msg = document.getElementById("messageA").value;

			TIB.api({
                url: "/messages.json", 
                method: "POST",
                params:{
                        'message':{
                        'user_id'       :  user.id,
                        'content'       :   "@" + target + " " + msg
                        }    
                },   
                onResponse :function(data){
                	var div = document.getElementById("post");
                	if (data["errors"])  {
                		div.innerHTML +=  data["errors"] ;
                	}
	                
	           }
            });   


		}

	</script>
</head>

<BODY>
<HR>
<jsp:useBean id="pageViews" class="ben.com.PageViewCountData"/>
<cewolf:chart 
    id="line" 
    title="Page View Statistics" 
    type="line" 
    xaxislabel="Page" 
    yaxislabel="Views">
    <cewolf:data>
        <cewolf:producer id="pageViews"/>
    </cewolf:data>
</cewolf:chart>
<p>
<cewolf:img chartid="line" renderer="cewolf" width="400" height="300"/>
<P>
<P><P>
<P>

<button type="button" onClick="javascript:showme(current_user);" > Get logged in user </button>
<div id='welcome'>  </div>
<br>
<button type="button" onClick="javascript:getFollowers(current_user);" > Retrieve Followers </button>
<div id='followers'>  </div>


<br>
<input id="messageA" type="text" value="blah">
<button type="button" onClick="javascript:postMessage(current_user, current_user.login, 'Hello from javascript API');" > Post Message </button>
<div id='post'>  </div>



</BODY>
</HTML>