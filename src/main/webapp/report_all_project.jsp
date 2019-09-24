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
        <div class="maincontent">
            <div class="maincontentinner">
<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Search</h4>
         <div class="widgetcontent">
          <form>
</form>
<input type="submit" value="Export" class="alertdanger btn btn-danger alertdanger" onclick="tableToExcel('exportCSV', 'export Table')">
</div>     
           
    	</div><!--widgetcontent-->
</div>

<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Projects At a Glance</h4>
         <div class="widgetcontent">
            
 <table id="exportCSV" class="table table-bordered table-invoice-full">
	 <colgroup>
	    <col class="con1" />
	    <col class="con0" />
		<col class="con1" />
		<col class="con1" />
		<col class="con1" />
		<col class="con1" />
		</colgroup>
	<thead>
            <tr>
             <th class="head0">Project Name</th>
             <th class="head0">Invested Amount</th>
              <th class="head1">Refunded Amount</th>
             <th class="head1">Expensed Amount</th>
             <th class="head1">Total Buyer Payment</th>
             <th class="head0">Net Profit</th>
          	</tr>
           </thead>
         <tbody>                  
<%
long invest_sum=0,refund_sum=0,expense_sum=0,payment_sum=0,project_profit=0,profit_sum=0;
ProjectDAO pdao=new ProjectDAO();
ArrayList<Project> pro_details=pdao.getAllProjectReport();
for(int i=0;i<pro_details.size();i++){
invest_sum+=Long.parseLong(pro_details.get(i).getInvestment_sum());
refund_sum+=Long.parseLong(pro_details.get(i).getRefund_sum());
expense_sum+=Long.parseLong(pro_details.get(i).getExpensed_sum());
payment_sum+=Long.parseLong(pro_details.get(i).getBuyer_payment_sum());
project_profit=Long.parseLong(pro_details.get(i).getInvestment_sum())+Long.parseLong(pro_details.get(i).getBuyer_payment_sum())-Long.parseLong(pro_details.get(i).getExpensed_sum())-Long.parseLong(pro_details.get(i).getRefund_sum());
profit_sum+=project_profit;

 %>
                        <tr class="gradeX">
                         <td>
                          <a href="ProjectServlet?proid=<%=pro_details.get(i).getId() %>&todo=fromReport"><%=pro_details.get(i).getPro_name() %>/<%=pro_details.get(i).getSite_addr() %></a>                      
                         </td>
                            <td>
                              <%=pro_details.get(i).getInvestment_sum() %> 	
                            </td>
                            <td>
	                            <%=pro_details.get(i).getRefund_sum() %>
                            </td>
                            <td>
                              <%=pro_details.get(i).getExpensed_sum() %>
                            </td>
                            <td>
                            <%=pro_details.get(i).getBuyer_payment_sum() %>
                            </td>
                            <td>
                             <%=project_profit %>
                            </td>
                                 </tr>
  <%
  }
   %>
   <tr>
   <td><b>Total No Of Sites:<%=pro_details.size() %></b></td>
   <td><b><%=invest_sum %></b></td>
   <td><b><%=refund_sum %></b></td>
   <td><b><%=expense_sum %></b></td>
   <td><b><%=payment_sum %></b></td>
   <td><b><%=profit_sum %></b></td>
   </tr>
                        
                    </tbody>
                </table>
                <!-- 
<div class="amountdue">
	<h1><span><b>Total Investment:<%=invest_sum %> </b></span><span><b>Total Refunded:<%=refund_sum %></b></span><span><b>Total Expense:<%=expense_sum %></b></span><span><b>Total Buyers Payment:<%=payment_sum %></b></span><span><b>Total Net Profit:<%=profit_sum %></b></span></h1><br />
</div>
 -->
<br>
<%@ include file="common/foot.jsp" %>
<script>

function getChildList(){
	
	//alert(document.getElementById("scheme_id").value);
	var scheme_id= document.getElementById("scheme_parent_id").value;
	//alert(scheme_id);
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
	    document.getElementById("scheme_child_div").innerHTML=xmlhttp.responseText;
	   
	    }
	  }
	xmlhttp.open("GET","ActionServlet?todo=getChildScheme&parent="+scheme_id+"&selectedchild=0",true);
	xmlhttp.send(); 
}
</script>