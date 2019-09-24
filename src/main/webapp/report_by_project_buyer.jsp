<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="com.project.bean.*"%>
<%@page import="java.util.*"%>
<%@ include file="common/head.jsp" %>

<div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>Report By Project</li>
        </ul>

<%
ArrayList<Project> itemPartList=null;
Iterator<Project> clientIt2;
Project clientItem;

String from= request.getParameter("from");
String to=request.getParameter("to");
int scheme_id=0;
if(from==null)from="";
if(to==null)to="";
%>
        <div class="maincontent">
            <div class="maincontentinner">
<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Search</h4>
         <div class="widgetcontent">
          <form>
<table  class="tbl" width="100%" border="1">
<tr>

<td colspan="0"><span>For Project</span>
<div id="scheme_p" style="float:left;">
	<select style="width:233px;" name="project_id" id="project_id"
		class="uniformselect" required="required">
		<option value="0">Select Project</option>


		<%
try{
	
	itemPartList=new ProjectDAO().getProjectName();
	
	if(itemPartList != null){
		clientIt2 = itemPartList.iterator();
		while(clientIt2.hasNext()){
			clientItem = (Project)clientIt2.next();
%>								
<option value="<%=clientItem.getId()%>"><%=clientItem.getPro_name()+"/"+clientItem.getSite_addr()%></option>
<%
	}
}}
catch(Exception e){
	
	e.printStackTrace();
}
%>
	</select>
	<div id="scheme_child_div" style="float:right;">	
	</div>
	&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="submit" value="Search" class="alertdanger btn btn-danger alertdanger">
</div></td>
<td align="left"></td>
 </tr>
</table>
</form>

<input type="submit" value="Export" class="alertdanger btn btn-danger alertdanger" onclick="tableToExcel('exportCSV', 'export Table')">
</div>     
           
    	</div><!--widgetcontent-->
</div>

<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Search Result</h4>
         <div class="widgetcontent">
            
 <table id="exportCSV" class="table table-bordered table-invoice-full">
	 <colgroup>
                    <col class="con0 width5" />
                    <col class="con1 width5" />
                    <col class="con0 width5" />
                    <col class="con1 width5" />
                    <col class="con0 width5" />
                    <col class="con1 width20" />
                </colgroup>
                <thead>
                    <tr>
                       <th class="head0">Buyer Name</th>
                        <th class="head0">Estimate Date</th>
                        <th class="head1">Estimate Id</th>
                        <th class="head0">Project Name</th>
                        <th class="head1">Estimated Amount</th>
                        <th class="head0">Amount Received</th>
                         
                    </tr>
                </thead>
                                      
<tbody>
                <%
              if(request.getParameter("project_id")!=null){
                 ArrayList<ProjectSummeryBean> paymentList=null;
                  ArrayList<ProjectSummeryBean> paymenListBuyer=null;
	              ProjectSummeryBean psbean;
	              ProjectSummeryBean psbean1;
	              int totalEstimate=0;
	              int totalPaid=0;
	              int buyerTotal=0;
	          	ProjectSummeryDao psdao=new ProjectSummeryDao();
	           
	try{
		paymentList=psdao.getSummeryList("buyerTotal",request.getParameter("project_id"));
		if(paymentList != null){
				for(int i=0;i<paymentList.size();i++){
				psbean = (ProjectSummeryBean)paymentList.get(i);
                 %>
                    <tr>
                        <td><%=psbean.getBuyerName() %></td>
                        <td>
						<%=psbean.getEst_date() %>
						</td>
                        <td class="right">
                        <%=psbean.getEst_id() %>
						</td>
                        <td class="right">
                        <%=psbean.getPro_name() %>
						</td>
                        <td class="right">
                        <%=psbean.getEst_amount() %>
                        	</td>
                        <td class="right">
                        <table width=100%>
                        	<tr>
	                        	<th>Date Received</th>
	                        	<th>Amount</th>
	                        	</tr>
	                        	<%ProjectSummeryDao psdao1=new ProjectSummeryDao();
                        paymenListBuyer=psdao1.getSummeryList("buyerTotalbyId",psbean.getEst_id());
		         totalEstimate+=Float.parseFloat(psbean.getEst_amount());
				for(int j=0;j<paymenListBuyer.size();j++){
				psbean1 = (ProjectSummeryBean)paymenListBuyer.get(j);
				totalPaid+=Float.parseFloat(psbean1.getPamount());
				buyerTotal+=Float.parseFloat(psbean1.getPamount());
         %>
                        	<tr>
	                        	<td><%=psbean1.getPdate() %></td>
	                        	<td><%=psbean1.getPamount() %> </td>
                        	</tr>
                        	<%}
                        	
                        	 %>
             <tr style="color: red;">
             	<td><b>Total</b></td>
             	<td><%=buyerTotal %></td>
             </tr>    </table>
                        
						</td>
                    </tr>
                    <%	buyerTotal=0;}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
  %>
                    
                    </tbody>
                </table>
                <table class="table invoice-table">
                    <tbody>
                        <tr>
                        	<td class="width65 msg-invoice">
          						<h4></h4>
          						<p></p>
                            </td>
                            <td class="width15 right numlist">
                            	<strong>Estimated Amount</strong>
                                <strong>Total Paid</strong>
                                <strong>Total Paid For Expenses</strong>
                             
                            </td>
                            <td class="width20 right numlist">
                                <strong>Rs.<%=totalEstimate %> </strong>
                                <strong>Rs. <%=totalPaid %></strong>
                                <strong>Rs. <%=totalEstimate-totalPaid %> </strong>
                             
                                
                            </td>
                        </tr>
                    </tbody>
          </table>
          <%} %>
</div>
<br>


<%@ include file="common/foot.jsp" %>