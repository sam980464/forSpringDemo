<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="java.util.*"%>
<%
java.text.DateFormat df = new java.text.SimpleDateFormat("dd-MM-yyyy");
ArrayList<promis> investorList=new ArrayList<promis>();

%>
<script type="text/javascript" src="resources/js/datetimepicker.js"></script>
<script type="text/javascript">
loadBank();
function loadBank()
 {
 	var payment_method= document.getElementById("payment_method").value;
 	//alert(payment_method);
 	
 	
	 	var xmlhttp;
	 	if (window.XMLHttpRequest)
	 	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	 	  xmlhttp=new XMLHttpRequest();
	 	  }
	 	else
	 	  {// code for IE6, IE5
	 	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	 	  }
	 	xmlhttp.onreadystatechange=function()
	 	  {
	 	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	 	    {
	 		 	if(payment_method=="CHEQUE"){
	 	 			document.getElementById("bank_list").style.display= "inline";
	 	 			document.getElementById("cheque_no").style.display= "inline";
	 	 			document.getElementById("add_bank").style.display= "inline";
	 		  		document.getElementById("bank_list").innerHTML=xmlhttp.responseText;
	 		 	}
	 		 	else{
	 		 		document.getElementById("bank_list").style.display= "none";
	 		 		document.getElementById("cheque_no").style.display= "none";
	 		 		document.getElementById("add_bank").style.display= "none";
	 		 		document.getElementById("cheque_no").value="0000"
	 		 	}
	 	    }
	 	  }
	 	xmlhttp.open("GET","ActionServlet?todo=getBankListWI&sid="+document.getElementById("sid").value,true);
	 	xmlhttp.send();
 	
 }
</script>
<h4 class="widgettitle">Edit Miscellaneous Income</h4>
<form class="stdform stdform2" method="post" action="ProjectServlet">
					<table width="100%" border="1" class="tbl">
					  <tr>
					  <td>
					  <span>Refund ID</span>
					  <div>
<select name="inv_id" id="inv_id" class="input-large" required="required">	
<option value="">Select Item</option>				
<%
try{	
	investorList=new promis().getAllItem();
	boolean status=false;
	String id="";
	for(int i=0;i<investorList.size();i++){
   id=investorList.get(i).getId()+"";
%>	

<option <% if(id.equals(request.getParameter("promis"))){out.println("selected='selected'");} %>  value="<%=investorList.get(i).getId()%>"><%=investorList.get(i).getPromisName()%></option>
<%
}
}catch(Exception e){
	e.printStackTrace();
}
%>
</select>
					  </div>
					 </td>
					  </tr>
					  <tr>
						<td>
							<span>Amount</span>
							<div>
							 <div><input type="text" name="amount" id="amount" class="input-large" value="<%=request.getParameter("amount") %>" required="required"/></div>
							</div>
						</td>
						<td>
							<span>Payment Method</span>
							<div>
							<select name="payment_method" id="payment_method" style="width:60px" onchange="loadBank()" >
								<option <% if(request.getParameter("pm").equals("CASH")){out.println("selected='selected'");} %> value="CASH">CASH</option>
								<option <% if(request.getParameter("pm").equals("CHEQUE")){out.println("selected='selected'");} %> value="CHEQUE">CHEQUE</option>
							</select>
							<!-- <div id="bank_list" style="float:left;width:30px;  height:50px;"></div> -->
							<select id="bank_list" name="bank_list" style="float: right; margin: 1px; width: 135px;"></select>
							<input type="text" placeholder="Cheque No." value="<%=request.getParameter("no") %>" name="cheque_no"  id="cheque_no" class="input-small"  />
							</div>
							<a style="float: right;color: #fff;" id="add_bank" class="btn btn-inverse alertinverse color cboxElement" href="add_bank.jsp"><small>+</small></a>
						<input type="hidden" id="sid" value="<%=request.getParameter("bi") %>"> 
						</td>
						</tr>
			           <tr>
						<td rowspan="2">
						<br>
							<span>Date Created</span>
						  	<div>
						  	<input id="demo" name="datecreated" type="text" size="25" value="<%=request.getParameter("date") %>"><a href="javascript:NewCal('demo','ddmmyyyy')"><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
						  	<input type="hidden" id="misid" name="misid" value="<%=request.getParameter("misid") %>">
						  	</div>		
						</td>			  
					  </tr>
					</table>		                      
					<p class="stdformbutton">
					<br>
					<br>
						<input type="hidden" name="todo" value="editmis">
						<button class="btn btn-primary">Save</button>
						<button type="reset" class="btn">Reset Button</button>
					</p>
                    </form>