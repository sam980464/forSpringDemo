<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.dao.*"%>
<%

java.text.DateFormat df = new java.text.SimpleDateFormat("dd-MM-yyyy");
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
	 		 	}
	 	    }
	 	  }
	 	xmlhttp.open("GET","ActionServlet?todo=getBankList",true);
	 	xmlhttp.send();
 	
 }
</script>

<style>
.stdform select {
    width: 250px;
}

</style>


<script type="text/javascript">


function  calculate()
{
	

}
</script>


<h4 class="widgettitle">Add Buyer for <b>Project</b></h4>
 <form class="stdform stdform2" method="get" action="ActionServlet" onsubmit="return checkOverflow()">
					<table width="100%" border="1" class="tbl">
					  <tr>
						<td>
							<span>Buyer Name</span>
							<div>
							<input type="text" value="" name="buyer_name">
											</div>
						</td>
						<td><span>Mobile</span>
							<div>
							<input type="text" value="" name="buyer_contactno">
							</div>
						</td>
						</tr><tr>
						
						<td><span>Address</span>
							<div>
							<input type="text" name="buyer_address">
							</div>
						</td>
					
						<td>
							<span>Estimate Amount</span>
							<div>
							<input id="estamnt" class="input-small" type="text"  name="estamnt">
							<input type="hidden" id="pro_id" name="pro_id" value="<%=(String)session.getAttribute("project_id") %>">
							</div>
						</td>
					  </tr>
					  <tr>
						<td>
							<span>Paid Amount</span>
							<div>
							<input id="pamamnt" class="input-small" type="text"  name="pamamnt"  placeholder="0.0">
														</div>
						</td>
						<td>
							<span>Payment Method</span>
							<div>
							<select name="payment_method" id="payment_method" style="width:60px" onchange="loadBank()" >
								<option value="CASH">CASH</option>
								<option value="CHEQUE">CHEQUE</option>
							</select>
							<!-- <div id="bank_list" style="float:left;width:30px;  height:50px;"></div> -->
							<select id="bank_list" name="bank_list" style="float: right; margin: 1px; width: 135px;"></select>
							<input type="text" placeholder="Cheque No." value="" name="cheque_no"  id="cheque_no" class="input-small"  />
							</div>
							<a style="float: right;color: #fff;" id="add_bank" class="btn btn-inverse alertinverse color cboxElement" href="add_bank.jsp"><small>+</small></a>
						</td>
						</tr>
						<tr>
						<td>
							<span>Date Created</span>
						  	<div>
						  	<input id="demo" name="datecreated" type="text" size="25" value="<%=df.format(new java.util.Date()) %>"><a href="javascript:NewCal('demo','ddmmyyyy')" ><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
						  	</div>
						</td>
						  </tr>
						<tr>
						<td>
							<span>Floor-Flat Remark</span>
							<textarea  name="note" rows="" cols=""></textarea>
							<input type="hidden" value="NA" name="buyer_email">
							<input type="hidden" value="NA" name="buyer_details">
							
							
						</td>
					  </tr>
					</table>		                      
					<p class="stdformbutton">
					
						<input type="hidden" name="todo" value="addbuyerforproject">
						<input type="hidden" name="userid" value="">
						<button class="btn btn-primary">Save</button>
						<button type="reset" class="btn">Reset Button</button>
					</p>
<div id="getOnOrderStatusdiv" style="height: 59px;"></div>	

</form>
