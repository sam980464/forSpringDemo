<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.dao.ProjectDAO"%>
<%@page import="com.project.bean.Project"%>
<%
java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
%>
<script type="text/javascript" src="resources/js/datetimepicker.js"></script>
<style>
/* .stdform select {
    width: 245px !important;
} */
</style>
<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle"><b>Add Project Expense</b></h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ProjectServlet">
				<table width="1000px" border="1" class="tbl">
					<tr>
						<td colspan="2"><span>Select Scheme</span>
							<div id="scheme_p" style="float:left;">
								<select style="width:290px;" name="scheme_parent_id" id="scheme_parent_id" class="uniformselect" onchange="getChildList();">
									<option value="">Select Parent Scheme</option>
									<%
										ArrayList<SchemeBO> schemeList = null;
										Iterator<SchemeBO> schemeIt;
										SchemeBO schemeBO;
										try {
											Scheme scheme = new Scheme();
											schemeList = scheme.getAllParentItem();

											if (schemeList != null) {
												schemeIt = schemeList.iterator();
												while (schemeIt.hasNext()) {
													schemeBO = (SchemeBO) schemeIt.next();
									%>

									<option value="<%=schemeBO.getId()%>"><%=schemeBO.getSchemeName()%></option>
									<%
										}
											}
										} catch (Exception e) {

											e.printStackTrace();
										}
									%>
								</select>     
								<div id="scheme_child_div" style="float:right;"></div>
							</div></td>	
					</tr>
					<tr>
						<td colspan="2">
						<span>Select Service</span>
							<div id="service_list" style="float:left;">
								<select style="width:290px;" name="service_id" id="service_id" class="uniformselect" onchange="getSupplierList(this.id);">
								</select>
								</div>
								<span>Select Supplier</span>
								<div id="supplier_list" style="float:right;">
								<select style="width:290px;" name="supplier_id" id="supplier_id" class="uniformselect" >
								</select>
								</div>
								</td>
								</tr>
							<tr>
								<td colspan="2">
								<div style="float: left;">
								<span>Quantity</span>
								<input type="text" name="quan" id="quan" class="input-large"   onkeyup="calculate(0)" placeholder="0.0" />
								</div>
								<div style="float: right;">
								<span>Unit Price</span>
								<input type="text" name="unit_price" id="unit_price" class="input-large"   onkeyup="calculate(0)" placeholder="0.0" />
								</div>
								</td>
								</tr>
								<tr>
								<td colspan="2">
								<span>Total Amount</span>
								<div>
								<input type="text" name="total_amount" id="total_amount" class="input-large" required="required" value="" onkeyup="calculate(1)"  />
								</div>
								<span>Bill No</span>
								<div>
								<input type="text" name="bill_no" id="bill_no" class="input-large" required="required" value="RT_105<%=new ProjectDAO().getMaxRow("expense_id","project_expense") %>" readonly="readonly"  />
								</div>
								</td>
								</tr>
								 <tr>
					  <td>
					  		<span>Date</span>
							<div>
						  	<input id="demo" name="date" type="text" size="25" value="<%=df.format(new java.util.Date()) %>" required="required"><a href="javascript:NewCal('demo','yyyymmdd')"><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
						  	</div>
							<span>Estimate Note</span>
							<div>
								<textarea cols="80" rows="5" name="note" id="note" class="input-large"></textarea>
							</div>
							</td>
					  </tr>
					  <tr>
					  <td>
					  <div style="float: left;">
					  <b>Add more Expenses Under the same Bill</b><input type="checkbox" name="status" id="status">
					  </div>
					  </td>
					  
					  </tr>
						
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="addProjectExpense"> 
					<input type="hidden" name="userid" value="">
					<input type="hidden" value="" name="client">
					<button class="btn btn-primary">Save</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
				<%
				ProjectDAO pdao=new ProjectDAO();
				Project project=pdao.getProjectFundAmount(session.getAttribute("project_id").toString());
				 %>
				 <table width="1200px" border="1" class="tbl">
				 <tr>
				 <td>Total Investment</td>
				 <td>Total Buyers' Payment</td>
				 <td>Total Expensed Payment</td>
				 <td>Total Investor Refund</td>
				 <td>Total Fund Amount</td>
				 </tr>
				 <tr>
				 <td>
				 <input type="text" readonly="readonly" value="<%=project.getInvestment_sum() %>"/>
				 </td>
				 <td>
				 <input type="text" readonly="readonly" value="<%=project.getBuyer_payment_sum() %>"/>
				 </td>
				 <td>
				 <input type="text" readonly="readonly" value="<%=project.getExpensed_sum() %>"/>
				 </td>
				 <td>
				 <input type="text" readonly="readonly" value="<%=project.getRefund_sum() %>"/>
				 </td>
				 <td>
				 <input type="text" name="fund_amount" id="fund_amount" readonly="readonly" value="<%=Long.parseLong(project.getBuyer_payment_sum())+Long.parseLong(project.getInvestment_sum())-Long.parseLong(project.getExpensed_sum())-Long.parseLong(project.getRefund_sum()) %>"/>
				 </td>
				 </tr>
				 </table>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<input type="hidden" name="haschild" id="haschild" value="0"/>
<!--row-fluid-->
<script type="text/javascript">
function getChildList(){
	//alert(document.getElementById("scheme_id").value);
	var scheme_id= document.getElementById("scheme_parent_id").value;
	//alert(scheme_id);
	 var xmlhttp;
	 var buffer;
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
	    if(xmlhttp.responseText=="") {
	    buffer="0";
	    }else{
	    buffer=xmlhttp.responseText;
	    }
	    document.getElementById("scheme_child_div").innerHTML=xmlhttp.responseText;
	    if(buffer==0){
	     getServiceList("0");
	     }else{
	     getServiceList("1");
	     //document.getElementById("haschild").value="1";
	     }
	     
	    }
	  }
	xmlhttp.open("GET","ActionServlet?todo=getChildScheme&parent="+scheme_id+"&selectedchild=0",false);
	xmlhttp.send();	
}
function getServiceList(flag){
var scheme_id;
if(flag==1){
scheme_id= document.getElementById("scheme_child_id").value;
}else{
scheme_id= document.getElementById("scheme_parent_id").value;
}	 var xmlhttp;
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
	    document.getElementById("service_list").innerHTML=xmlhttp.responseText;
	   
	    }
	  }
	xmlhttp.open("GET","ProjectServlet?todo=getServiceList1&scheme="+scheme_id,false);
	xmlhttp.send();
} 
function getSupplierList(service){
var service_id= document.getElementById("service_id").value;
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
	    document.getElementById("supplier_list").innerHTML=xmlhttp.responseText;
	    }
	  }
	xmlhttp.open("GET","ProjectServlet?todo=getSupplierList&service="+service_id,false);
	xmlhttp.send();
}
function calculate(val){
if(val==0){
var quan=parseFloat(document.getElementById("quan").value);
var unit_price=parseFloat(document.getElementById("unit_price").value);
var total_amount=quan*unit_price;
}else{
var total_amount=parseFloat(document.getElementById("total_amount").value);
}
var total_fund=parseFloat(document.getElementById("fund_amount").value);
//alert(total_amount+":"+total_fund);
if(total_amount>=0){
if(total_fund>=(total_amount)){
document.getElementById("total_amount").value=""+(total_amount);
}else{
alert("Your Expense Amount exceeds project fund!!!!");
document.getElementById("total_amount").value="";
}
}
}

</script>