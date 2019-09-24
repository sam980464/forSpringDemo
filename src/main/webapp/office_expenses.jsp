<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@ include file="common/head.jsp" %>
    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>Office Expenses</li>
        </ul>

<br>
<%
if (session.getAttribute("message")!=null){
%>
<div class="alert alert-info" style="background-color:yellow">
<%=session.getAttribute("message") %>
<% session.setAttribute("message",null); %>
</div>
<% } %>




<%
String from= request.getParameter("from");
String to=request.getParameter("to");
int exp_for=0;        		 
if(request.getParameter("exp_for")!=null){
exp_for=Integer.parseInt(request.getParameter("exp_for"));
} 

if(from==null)from="";
if(to==null)to="";


%>
        
		 
        <div class="maincontent">
            <div class="maincontentinner">
<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Expenses List</h4>
         <div class="widgetcontent">
           <a style="float: left; margin-right: 11px;" href="add_office_expenses.jsp" class="btn btn-inverse alertinverse color"><small>Add New Office Expenses</small></a>

<br><br>
<form>
<table  class="tbl" width="100%" border="1">
<tr>
<td>
	<span>From Date</span>
	<div>
	<input id="datepicker1" type="text" name="from" class="input-small datepicker" value="<%=from%>" />
	</div>	
</td>
<td>
	<span>To Date</span>
	<div>
	<input id="datepicker2" type="text" name="to" class="input-small datepicker" value="<%=to%>" />
	</div>
</td>
<td>
	<span>Expenses For</span>
							<div>
							<select name="exp_for"  id="exp_for"   >
							<option value="0">Select Item</option>
<%
	ArrayList<OfficeExpensesItemBO> officeExpensesItemList=null;
	Iterator<OfficeExpensesItemBO> officeExpensesItemIt;
	OfficeExpensesItemBO officeExpensesItemBO;
	try{
		OfficeExpensesItem officeExpensesItem= new OfficeExpensesItem();
		officeExpensesItemList=officeExpensesItem.getAllItem();
		
		if(officeExpensesItemList != null){
			officeExpensesItemIt = officeExpensesItemList.iterator();
	while(officeExpensesItemIt.hasNext()){
		officeExpensesItemBO = (OfficeExpensesItemBO)officeExpensesItemIt.next();
%>		
                    
<option <% if(exp_for==officeExpensesItemBO.getId()){ out.print("selected=selected");} %> value="<%=officeExpensesItemBO.getId()%>"><%=officeExpensesItemBO.getItemName()%></option>                 
<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>
							</select> 							
							</div>
</td>



<td><input type="submit" value="Search" class="alertdanger btn btn-danger alertdanger"></td>
 </tr>
 
</table>
</form>
<input type="submit" value="Export CSV" class="alertdanger btn btn-danger alertdanger" onclick="tableToExcel('exportCSV', 'export Table')">

</div>     
           
    	</div><!--widgetcontent-->
</div>

<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Expenses List for Current Month</h4>
         <div class="widgetcontent">
            <table id="exportCSV" class="table table-bordered responsive">
                   <!--  <colgroup>
                        <col class="con0" style="align: center; width: 4%" />
                        <col class="con1" />
                         <col class="con1" />
                        <col class="con0" />
                        <col class="con1" />
                        <col class="con0" />
                        <col class="con1" />
                    </colgroup> -->
                    <thead>
                        <tr>
                          	<th class="head0 nosort"><input type="checkbox" class="checkall" /></th>
                          	<th class="head1" style="display:block;width:70px">Date</th>
                            <th class="head0">Expenses For</th>
							<th class="head0">Amount</th>
							<th class="head1">Cheque Number(Bank NAme)</th>
							<th class="head0">Description</th>
							<th class="head1">Option</th>
                        </tr>
                    </thead>
                    <tbody>

<%
	OfficeExpensesItem  oei= new OfficeExpensesItem();
	ArrayList<OfficeExpensesBO> officeExpensesList=null;
	Iterator<OfficeExpensesBO> officeExpensesIt;
	
	OfficeExpensesBO officeExpensesItem;
	try{
		OfficeExpenses officeExpenses= new OfficeExpenses();
		
		officeExpenses.setFromDate(request.getParameter("from"));
		officeExpenses.setToDate(request.getParameter("to"));
		
		
		if(exp_for>0){
			
			officeExpenses.setExpensesName(exp_for);
		}
		else{
			officeExpensesList=officeExpenses.getAllItemByDate();
			
		}
		
		if(request.getParameter("from")==null){
			officeExpensesList=officeExpenses.getAllItemLimited(50);
		}
		else{
			
			officeExpensesList=officeExpenses.getAllItemByDate();
		}
		

		if(officeExpensesList != null){
			officeExpensesIt = officeExpensesList.iterator();
			while(officeExpensesIt.hasNext()){
				officeExpensesItem = (OfficeExpensesBO)officeExpensesIt.next();
%>
                    
                     <tr class="gradeX">
                          <td class="aligncenter"><span class="center">
                            <input type="checkbox" />
                          </span></td>
                          	<td>
                          	<%
                          	String[] datetime = officeExpensesItem.getDateTime().split(" ");
                          	%>
                          	<%=datetime[0] %></td>
                            <td><%=oei.getItemNameById(officeExpensesItem.getExpensesName()) %></td>                            
                            <td><%=String.format("%.2f", officeExpensesItem.getAmount())%></td>
                            <td>
                            <%
                            Bank bank= new Bank();
                            %>
                            <%
                            if(officeExpensesItem.getBankId()!=0)
                            {
                            %>
                            
                            <b><%=bank.getBankNameById(officeExpensesItem.getBankId()) %>-<%=bank.getBankAddressById(officeExpensesItem.getBankId()) %></b>
                            Cheque No :<b><%=officeExpensesItem.getChequeNo() %></b>
                            
                            <%
                            }
                            else{
                            	out.print("<b>CASH</b>");
                            }
                            
                            %>
                            </td>
                            <td>
                            <%=officeExpensesItem.getExpensesDesc() %>
                            </td>
							<td>
								<a href="edit_office_expenses.jsp?oe_id=<%=officeExpensesItem.getId() %>" class="color cboxElement">Edit<!-- <img src="resources/images/edit.png" /> --></a>  |
								<a href="ActionServlet?todo=deleteOfficeExpenses&oe_id=<%=officeExpensesItem.getId() %>"  onclick="return confirm('Are you sure?');">Delete<!-- <img src="resources/images/delete.png" /> --></a>
							</td>
                        </tr>
<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>                                   
                      </tbody>
                </table> 
    	</div><!--widgetcontent-->
</div>
<%@ include file="common/foot.jsp" %>