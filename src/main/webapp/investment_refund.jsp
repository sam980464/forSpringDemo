<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="java.util.*"%>
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
<h4 class="widgettitle">Investment Refund</h4>
 <form class="stdform stdform2" method="post" action="ProjectServlet">
					<table width="100%" border="1" class="tbl">
					  <tr>
					  <td>
					  <span>Investor ID</span>
					  <div><input type="text" name="inv_id" id="inv_id" class="input-large" value="INV_00<%=request.getParameter("id") %>" readonly="readonly"/></div>
					  </td>
					  <td>
					    <%
					  ProjectDAO pdao=new ProjectDAO();
					  String name= pdao.getInvestorName(request.getParameter("id"));
					   %>
					  <span>Investor Name</span>
					  <div><input type="text" name="name" id="name" class="input-large" value="<%=name %>" readonly="readonly"/></div>
					  </td>
					  </tr>
					  <tr>
						<td>
							<span>Invested Amount</span>
							<div>
							 <div><input type="text" name="amount" id="amount" class="input-large" value="<%=request.getParameter("amount") %>" required="required"/></div>
							</div>
						</td>
						</tr>
						<tr>
						<td>
							<span>Promised Refund</span>
							<div>
							<input type="text" name="pro_amount" id="pro_amount" class="" value="<%=request.getParameter("pro_amount") %>" required="required"/>
							</div>
						</td>
						<td>
							<span>Total Refunded Amount</span>
							<div>
							<input type="text" name="total_amount" id="total_amount" class="" value="<%=request.getParameter("total_amount") %>" readonly="readonly" required="required"/>
							</div>
						</td>
					  </tr>
					 <tr>
						<td>
							<span>Due Refund Amount</span>
							<div>
							<input type="text" name="due_amount" id="due_amount" class="" value="<%=request.getParameter("due_amount") %>" required="required"/>
							</div>
						</td></tr><tr>
						
						<td>
							<span>Amount to be Refunded</span>
							<div>
							<input type="text" name="new_amount" id="new_amount" class="" value="" required="required"/>
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
						<td rowspan="2">
						<br>
							<span>Date Created</span>
						  	<div>
						  	<input id="demo" name="datecreated" type="text" size="25" value="<%=df.format(new java.util.Date()) %>"><a href="javascript:NewCal('demo','ddmmyyyy')"><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
						  	</div>	
						</td>
						<td>
							<span>Note</span>
							<div>
							<textarea rows="2" cols="10" name="note" id="note"></textarea>
							</div>
						</td>					  
					  </tr>
					</table>		                      
					<p class="stdformbutton">
					<br>
					<br>
						<input type="hidden" name="todo" value="investmentRefund">
						<button class="btn btn-primary">Save</button>
						<button type="reset" class="btn">Reset Button</button>
					</p>
                    </form>