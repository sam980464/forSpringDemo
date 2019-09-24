<%@page import="com.bo.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.bean.ProjectSupplierPaymentBean"%>
<%
java.text.DateFormat df = new java.text.SimpleDateFormat("dd-MM-yyyy");
%>
<%
ProjectDAO pdao=new ProjectDAO();
ProjectSupplierPaymentBean bean=pdao.getPaymentDetails((String)session.getAttribute("project_id"),request.getParameter("p_id"));
%>
<script type="text/javascript" src="resources/js/datetimepicker.js"></script>
<h4 class="widgettitle">Edit Supplier Payment</h4>
 <form class="stdform stdform2" method="post" action="ProjectServlet">
					<table width="100%" border="1" class="tbl">
					 <tr>
					 <td>
					<span>Expense ID</span>
							<div>
							 <div>
							 <input type="text" name="exp_id" id="exp_id" class="input-large" value="EXP_00<%=bean.getExpense_id() %>" readonly="readonly" />
							 </div>
							</div>
						</td>
						<td>
					<span>Payment ID</span>
							<div>
							 <div>
							 <input type="text" name="p_id" id="p_id" class="input-large" value="P_00<%=request.getParameter("p_id") %>" readonly="readonly" />
							
							 </div>
							</div>
						</td>
						</tr>
						<tr>
						<td>
							<span>Supplier Name</span>
							<div>
							<input type="hidden" name="sup_id" id="sup_id" class="input-large" value="<%=bean.getSupplier_id() %>" readonly="readonly" />
							<%
							String supname=new ProjectDAO().getSupplierName(bean.getSupplier_id());
							 %>
							<input type="text" name="sup_name" id="sup_name" class="input-large" value="<%=supname %>" readonly="readonly"/>
							
							</div>
						</td>
					  </tr>
					 	<tr>
						<td>
						  <div>
							<span>Paid Amount</span>
							<div>
							<input type="text" name="paid_amount" id="paid_amount" class="input-large" value="<%=bean.getPaid_amount() %>" required="required"/>
							</div>
							</div>
						</td>
						</tr>
						<tr>
						<td>
						  <div>
							<span>Payment Method</span>
							<div>
							<% if(bean.getPayment_method().trim().equals(null)||bean.getPayment_method().trim().equals("CHEQUE")){ %>
							<input type="text" name="method" id="method" class="input-large" value="<%=bean.getPayment_method() %>/<%=bean.getCheque_no() %>" readonly="readonly"/>
							<%}  if(bean.getPayment_method().trim().equals("CASH")){%>
							<input type="text" name="method" id="method" class="input-large" value="<%=bean.getPayment_method() %>" readonly="readonly"/>
							<%} %>
							</div>
							</div>
						</td>
						<td>
						<%if(bean.getBank_id().trim().equals("none")==false){ %>
						<div>
						<span>Bank</span>
						<div>
						<%
							Bank bank=pdao.getBankDetails(bean.getBank_id()); 
							%>
							<input type="text" name="bank" id="bank" class="input-large" value="<%=bank.getBankName() %>/<%=bank.getAddress() %>" readonly="readonly"/>
							</div>
							</div>
							<%} %>
						</td>
						</tr>
						<tr>
						<td>
						</td></tr></table>
								<table width="100%" border="1" class="tbl">
					<tr>
						<td>
						<span>Change Payment Method</span>
							<div>
							<select name="payment_method" id="payment_method"  onchange="loadBank()" >	
							<option value="none" selected="selected">Change Payment Method</option>
							<option value="CHEQUE">CHEQUE</option>
							<option value="CASH">CASH</option>
							</select>
							</div>
						</td>
					</tr>
				</table>
				
				<table width="100%" border="1" class="tbl" id="cheque_id_pop" >
				
					<tr>
					    
						<td><span>Cheque Number</span>
							<div>
								<input type="text" placeholder="Cheque No."  name="cheque_no"  id="cheque_no" class="input-small" value=""  />
							</div>
						</td>
						<td><span>Bank</span>
							<div>
							<select id="bank_list" name="bank_list" style="width: 277px;" >
							<option value="none"></option>
							</select>
							</div>
						</td>
						
					</tr>
				</table>
				
				<table width="100%" border="1" class="tbl" id="cheque_id">
					<tr>
					<td>
					<span>Notes</span>
					<div>
							<textarea rows="5" cols="5" class="input-small" name="notes" id="notes"><%=bean.getNote() %></textarea>
							</div>
					</td>
					</tr>
					<tr>
						<td>
							<span>Payment Date</span>
							<div>
						  	<input id="demo" name="datecreated" type="text" size="25" value="<%=df.format(new java.util.Date()) %>"><a href="javascript:NewCal('demo','ddmmyyyy')" ><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
						  	</div></td>
						<td>
						</td>
					</tr>
				</table>
								                      
					<p class="stdformbutton">
					<br>
					<br>
						<input type="hidden" name="todo" value="editSupplierPayment">
						<button class="btn btn-primary">Save</button>
						<button type="reset" class="btn">Reset Button</button>
					</p>
<script type="text/javascript">

 function loadBank()
 {
 	var payment_method=document.getElementById("payment_method").value;
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
	 	 			document.getElementById("cheque_id_pop").style.display= "block";
	 	 			
	 		  		document.getElementById("bank_list").innerHTML=xmlhttp.responseText;
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
                    
                    