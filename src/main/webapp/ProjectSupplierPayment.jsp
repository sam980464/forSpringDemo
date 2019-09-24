<%@page import="com.bo.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%
java.text.DateFormat df = new java.text.SimpleDateFormat("dd-MM-yyyy");
%>
<script type="text/javascript" src="resources/js/datetimepicker.js"></script>
<h4 class="widgettitle">Payment to Supplier</h4>
 <form class="stdform stdform2" method="post" action="ProjectServlet">
					<table width="100%" border="1" class="tbl">
					 <tr>
					 <td>
					<span>Expense ID</span>
							<div>
							 <div>
							 <input type="hidden" name="p_id" id="p_id" class="input-large" value="<%=request.getParameter("p_id") %>" readonly="readonly" />
							 <input type="text" name="exp_id" id="exp_id" class="input-large" value="EXP_00<%=request.getParameter("exp_id") %>" readonly="readonly" />
							 </div>
							</div>
						</td>
						</tr>
						<tr>
						<td>
							<span>Supplier Name</span>
							<div>
							<input type="hidden" name="sup_id" id="sup_id" class="input-large" value="<%=request.getParameter("sup_id") %>" readonly="readonly" />
							<%
							String supname=new ProjectDAO().getSupplierName(request.getParameter("sup_id"));
							 %>
							<input type="text" name="sup_name" id="sup_name" class="input-large" value="<%=supname %>" readonly="readonly"/>
							<% %>
							</div>
						</td>
						<td>
							<span>Expensed Amount</span>
							<div>
							<input type="text" name="exp_amount" id="exp_amount" class="input-large" value="<%=request.getParameter("exp_amount") %>" readonly="readonly"/>
							</div>
						</td>
					  </tr>
					 	<tr>
						<td>
						  <div>
							<span>Total Paid Amount</span>
							<div>
							<input type="text" name="paid_amount" id="paid_amount" class="input-large" value="<%=request.getParameter("total_amount") %>" readonly="readonly"/>
							</div>
							</div>
							<div>
							<span>Due Amount</span>
							<div>
							<input type="text" name="due_amount" id="due_amount" class="input-large" value="<%=request.getParameter("due_amount") %>" readonly="readonly"/>
							</div>
							</div>
						</td>
						</tr>
						<tr>
						<td>
						</td></tr></table>
								<table width="100%" border="1" class="tbl">
					<tr>
						<td>
						<span>Amount</span>
							<div>
								<input type="text" placeholder="0.00" name="amount_received" id="amount_received" required="required" onkeyup="checkOverflow()">
							</div>
						</td>
						<td>
						<span>Payment Method</span>
							<div>
							<select name="payment_method" id="payment_method_pop"  onchange="loadBank()" >
								<option value="CASH">CASH</option>
								<option value="CHEQUE">CHEQUE</option>
							</select>
							</div>
						</td>
					</tr>
				</table>
				<table width="100%" border="1" class="tbl" id="cheque_id_pop" style="display: none;">
					<tr>
						<td><span>Cheque Number</span>
							<div>
								<input type="text" placeholder="Cheque No."  name="cheque_no"  id="cheque_no" class="input-small" value=""  />
							</div>
						</td>
						<td><div><span>Bank</span>
							
							<select id="bank_list_pop" name="bank_list" style="width: 277px;" >
							<option value="none"></option>
							</select>
					
							</div>
					
						</td>
					</tr>
				</table>
				<table width="100%" border="1" class="tbl" id="cheque_id">
					<tr>
					<td>
					<span>Bill No</span>
					<div>
					<input type="text" value="<%=request.getParameter("bill_no") %>" class="input-small" name="billno" id="billno" readonly="readonly" />
				    </div>
					</td>
					<td>
					<span>Notes</span>
					<div>
							<textarea rows="5" cols="5" class="input-small" name="notes" id="notes"></textarea>
							</div>
					</td>
					</tr>
					<tr>
						<td>
							<span>Date Created</span>
						  	<div>
						  	<input id="demo" name="datecreated" type="text" size="25" value="<%=df.format(new java.util.Date()) %>"><a href="javascript:NewCal('demo','ddmmyyyy')" ><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
						  	</div>
						</td>
						<td>
						</td>
					</tr>
				</table>
								                      
					<p class="stdformbutton">
					<br>
					<br>
						<input type="hidden" name="todo" value="addSupplierPayment">
						<button class="btn btn-primary">Save</button>
						<button type="reset" class="btn">Reset Button</button>
					</p>
                   <script type="text/javascript">
                  // document.getElementById("cheque_id_pop").style.display= "none";
 function loadBank()
 {
 	var payment_method=document.getElementById("payment_method_pop").value;
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
	 	 			document.getElementById("cheque_id_pop").style.display= "";
	 		  		document.getElementById("bank_list_pop").innerHTML=xmlhttp.responseText;
	 		 	}
	 		 	else{
	 		 		document.getElementById("cheque_id_pop").style.display= "none";
	 		 		
	 		 	}
	 	    }
	 	  }
	 	xmlhttp.open("GET","ActionServlet?todo=getBankList",true);
	 	xmlhttp.send();
 	
 }
 function checkOverflow()
 {
 	
 	var due_amount=parseFloat(document.getElementById("due_amount").value);
 	var amount_received=parseFloat(document.getElementById("amount_received").value);
 	 if(amount_received>due_amount)
 		{
 		alert("You can't pay more than Due Amount!");
 		document.getElementById("amount_received").value="";
 		return false;
 		}
 	else
 		{
 		return true;
 		}
 }
                   </script>
                    </form>
                    
                    