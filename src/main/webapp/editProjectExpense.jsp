<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="java.util.*"%>
<script type="text/javascript" src="resources/js/datetimepicker.js"></script>
<%
java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
%>
<h4 class="widgettitle">Edit Project Expense</h4>
 <form class="stdform stdform2" method="post" action="ProjectServlet">
					<table width="100%" border="1" class="tbl">
					  <tr>
					  <td>
					  <span>Expense ID</span>
					  <div><input type="text" name="exp_id" id="exp_id" class="input-large" value="EXP_00<%=request.getParameter("exp_id") %>" readonly="readonly"/></div>
					  </td>
					  <td>
					  <span>Supplier Name</span>
					  <div>
					  <input type="hidden" name="sup_id" id="sup_id" class="input-large" value="<%=request.getParameter("sup_id") %>" readonly="readonly"/>
					  <%
					  ProjectDAO pdao=new ProjectDAO();
					  String supname=pdao.getSupplierName(request.getParameter("sup_id"));
					   %>
					   <input type="text" name="sup_name" id="sup_name" class="input-large" value="<%=supname %>" readonly="readonly"/>
					  </div>
					  </td>
					  </tr>
					   <tr>
						<td>
							<span>Unit</span>
							<div>
							 <div><input type="text" name="unit" id="unit" class="input-large" value="<%=request.getParameter("unit") %>"  onkeyup="calculate(0)"/></div>
							</div>
						</td>
						<td>
							<span>Quantity</span>
							<div>
							 <div><input type="text" name="quan" id="quan" class="input-large" value="<%=request.getParameter("quan")%>" onkeyup="calculate(0)"></div>
							</div>
						</td>
						</tr>
					
					  <tr>
						<td>
							<span>Expensed Amount</span>
							<div>
							 <div><input type="text" name="exp_amount" id="exp_amount" class="input-large" value="<%=request.getParameter("exp_amount") %>"  onkeyup="calculate(1)" /></div>
							</div>
						</td>
						<td>
							<span>Paid Amount</span>
							<div>
							 <div><input type="text" id="paidamnt" name="paidamnt" class="input-large" value="<%=request.getParameter("paidamnt") %>"></div>
							</div>
						</td>
						</tr>
						<tr>
						<td>
							<span>Note</span>
							<div>
							 <div><textarea rows="5" cols="10" name="note" id="note" class="input-large"></textarea></div>
							</div>
						</td>
						</tr>
						
		               <tr>
						<td>
							<span>Bill No</span>
							<div>
							 <div><input type="text" name="bill_no" id="bill_no" class="input-large" value="<%=request.getParameter("bill_no") %>" readonly="readonly"/></div>
							</div>
						</td>
						<td>
							<span>Date Created</span>
						    <div><input id="demo" type="text" name="datecreated" class="input-small datepicker" value="<%= df.format(new java.util.Date()) %>" required="required" /><a href="javascript:NewCal('demo','yyyymmdd')"><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
						  	<b>(YYYY-MM-DD)</b>
						  	</div>
						  		
						</td>					  
					  </tr>
					</table>		                      
					<p class="stdformbutton">
					<br>
					<br>
						<input type="hidden" name="todo" value="updateProjectExpense">
						<button class="btn btn-primary">Save</button>
						<button type="reset" class="btn">Reset Button</button>
					</p>
                    </form>
                    <script type="text/javascript">
                    function calculate(val){
                    var paid_amount=parseFloat(document.getElementById("paidamnt").value);
if(val==0){
var quan=parseFloat(document.getElementById("quan").value);
var unit_price=parseFloat(document.getElementById("unit").value);
var total_amount=quan*unit_price;
 
}
if(val==0){
document.getElementById("exp_amount").value=""+(total_amount);
if(paid_amount>total_amount){
alert("WARNING!!!!Edited Expensed Amount is less than Already Paid Amount:"+paid_amount+",(You can edit your paid amount in Expense Paid to Supplier tab)");
}
}if(val==1){
//alert(val);
if(paid_amount>parseFloat(document.getElementById("exp_amount").value)){
alert("WARNING!!!!Edited Expensed Amount is less than Already Paid Amount:"+paid_amount+",(You can edit your paid amount in Expense Paid to Supplier tab)");
}
}
}
</script>
