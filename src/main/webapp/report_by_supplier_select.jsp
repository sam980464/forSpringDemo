<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@ include file="common/head.jsp" %>

<div class="rightpanel">
<ul class="breadcrumbs">
  <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
  <li>Report By Supplier</li>
</ul>

  <input type="submit" value="Export" class=" btn"  style="display: table; float: right; margin: 8px;" onclick="tableToExcel('exportCSV', 'export Table')" >

<div class="widget" id="client_not_selected">
  <h4 class="widgettitle">Select Supplier</h4>
  <div class="widgetcontent">
<form action="report_by_supplier.jsp">
<select name="id">
<%
int i=1;
double paid_amount=0.0;
Client client=new Client();
ExpensesPayment ep= new ExpensesPayment();
	ArrayList<SupplierBO> supplierList=null;
	Iterator<SupplierBO> supplierIt;
	SupplierBO supplierItem;
	try{
		Supplier supplier= new Supplier();
		
		if(request.getParameter("id")==null)
		{
		supplierList=supplier.getAllItem();
		}
		else{
			supplierList=supplier.getAllItembySupplierid(Integer.parseInt(request.getParameter("id")));
		}
		if(supplierList != null){
			supplierIt = supplierList.iterator();
			while(supplierIt.hasNext()){
				supplierItem = (SupplierBO)supplierIt.next();
%>	
		<option value="<%=supplierItem.getId() %>"><%=supplierItem.getSupplierName() %></option>
<%
	i++;
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>  
  </select>
  <input type="submit" value="Search" class="alertdanger btn btn-danger alertdanger" >
  </form>
  </div>
  <!--widgetcontent-->
</div>
<%@ include file="common/foot.jsp" %>
