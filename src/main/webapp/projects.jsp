<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.bean.*"%>
 <%@ include file="common/head.jsp" %>
 <%
 ProjectDAO pdao=new ProjectDAO();
  %>
   <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>All Project</li>
        </ul>
<!-- <script type="text/javascript">
    jQuery(document).ready(function(){
        // dynamic table
        jQuery('#dyntable').dataTable({
            "sPaginationType": "full_numbers",
            "aaSortingFixed": [[0,'asc']],
            "fnDrawCallback": function(oSettings) {
                jQuery.uniform.update();
            }
        });
        
        jQuery('#dyntable2').dataTable( {
            "bScrollInfinite": true,
            "bScrollCollapse": true,
            "sScrollY": "300px"
        });
        
    });
    

</script>  -->       
		 
        <div class="maincontent">
            <div class="maincontentinner">
<% 
ArrayList<Project> itemPartList=null;
Iterator<Project> clientIt2;
Project clientItem;
Project pro_details=null;
if(request.getParameter("proid")==null){
%>
<div class="widget" id="client_not_selected">
		<%
				if (session.getAttribute("message")!=null){
				%>
				<div class="alert alert-info" style="background-color:yellow">
				<%=session.getAttribute("message") %>
				<% session.setAttribute("message",null); %>
				</div>
				<% } %>
         <h4 class="widgettitle">Choose Project To Go Dashboard</h4>
         <div class="widgetcontent">
             <form class="stdform stdform2" action="" method="get">
        
<p>
<select name="proid" data-placeholder="Choose a Project" style="width:350px" class="_chzn-select" tabindex="2">
<%
try{
	
	itemPartList=new ProjectDAO().getProjectName();
	
	if(itemPartList != null){
		clientIt2 = itemPartList.iterator();
		while(clientIt2.hasNext()){
			clientItem = (Project)clientIt2.next();
%>								
<option value="<%=clientItem.getId()%>"><%=clientItem.getPro_name()+"/"+clientItem.getC_name()%></option>
<%
	}
}}
catch(Exception e){
	
	e.printStackTrace();
}
%>
        </select>
<input type="submit" class="alertdanger btn btn-danger alertdanger" value="Go To Project Dashboard" >
 </p>   
    </form>
</div><!--widgetcontent-->
</div>
<%
}
else{
session.setAttribute("project_id",request.getParameter("proid"));
pro_details= pdao.getProjectDetails(request.getParameter("proid"));
session.setAttribute("project_name",pro_details.getPro_name());
session.setAttribute("project_address",pro_details.getSite_addr());
%>
<div>
<p><a href="projects.jsp" class="alertdanger btn btn-danger alertdanger">Back to Project Selection</a></p>
</div>
<%
				if (session.getAttribute("message")!=null){
				%>
				<div class="alert alert-info" style="background-color:yellow">
				<%=session.getAttribute("message") %>
				<% session.setAttribute("message",null); %>
				</div>
				<% } %>
<div class="widget" id="client_selected">
         <h4 class="widgettitle"><%=pro_details.getPro_name() %>/<%=pro_details.getSite_addr() %></h4>
         <div class="widgetcontent">
<div class="alert alert-info">
<div class="btn-group">
    <button data-toggle="dropdown" class="btn btn-danger">Investment<span class="caret"></span></button>
    <ul class="dropdown-menu">
        <li><a  class="color" href="project_add_investor.jsp">Add New Investor</a></li>
        <li><a  class="color" href="add_investment.jsp?proid=<%=request.getParameter("proid")%>">Add Investment Amount</a></li>
        <li><a  class="color" href="investment_list.jsp?proid=<%=request.getParameter("proid")%>">Investment List</a></li>
        <li><a  class="color" href="refund_list.jsp?proid=<%=request.getParameter("proid")%>">Refund List</a></li>
    <li><a  class="color" href="add_mis.jsp?proid=<%=request.getParameter("proid")%>">Add Miscellaneous Income</a></li>
    <li><a  class="color" href="mislist.jsp?proid=<%=request.getParameter("proid")%>">Miscellaneous Income List</a></li>
 
    </ul>
</div>
<div class="btn-group"> 
    <button data-toggle="dropdown" class="btn btn-danger">Project Expense<span class="caret"></span>
     </button>
    <ul class="dropdown-menu">
        <li><a class="color" href="addProjectExpense.jsp">Add Expense</a></li>
         <li><a class="color" href="ProjectExpenseList.jsp?proid=<%=session.getAttribute("project_id")%>" >Expense List</a></li>
	      <li><a href="ProjectExpenseListBySupplier.jsp">Expense Paid to Supplier</a></li>
    <li><a  class="color" href="add_misexp.jsp?proid=<%=request.getParameter("proid")%>">Add Miscellaneous Expense</a></li>
    <li><a  class="color" href="misexplist.jsp?proid=<%=request.getParameter("proid")%>">Miscellaneous Expense List</a></li>
    </ul>
</div>
<div class="btn-group">
    <button data-toggle="dropdown" class="btn btn-danger">Buyer<span class="caret"></span></button>
    <ul class="dropdown-menu">
      <!--    <li><a  class="color" href="project_add_buyer.jsp">Add New Buyer</a></li>  -->
      <!--   <li><a  class="color" href="add_buyerfor_project.jsp">Add Existing Buyer to Project</a></li> -->
      <li><a  class="color" href="add_buyerfor_project.jsp">Add New Buyer to Project</a></li>
        <li><a  class="color" href="add_buyerpayment_project.jsp">Payment from Buyer</a></li>
          <li><a  class="color" href="buyerEstimateList.jsp">Estimate List</a></li>
    <li><a  class="color" href="buyerPaymentList.jsp">Payment List</a></li>
         
    </ul>
</div>
<div class="btn-group">
    <button data-toggle="dropdown" class="btn btn-danger">Project Summary<span class="caret"></span></button>
    <ul class="dropdown-menu">
     <li><a href="AllBuyerSummery.jsp" target="blank">[Buyer Summary]</a></li>
    <li><a href="AllSummery_Project.jsp" target="blank">[All Summary]</a></li>      
    </ul>
</div>
<div class="btn-group">
    <button data-toggle="dropdown" class="btn btn-danger">Settings<span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a onclick="editProject()">Edit Project</a></li>
    </ul>
</div>
</div>
 <%} %>
<script type="text/javascript">

document.getElementById("btnlist").style.display="none";
function editProject()
{
	document.getElementById("btnlist").style.display="block";
}
</script>
<%
if(request.getParameter("proid")!=null){
 %>
 <form class="stdform stdform2" method="post" action="ProjectServlet">
					<table width="100%" border="1" class="tbl">
					  <tr>
					  <td>
					  <span>Project Name</span>
					 <div><input type="text" name="pro_name" id="pro_name" style="width: 200px" required="required" value="<%= pro_details.getPro_name()%>"/></div>
					  </td>
						<td>
							<span>Client Name</span>
							<div><input type="text" name="c_name" id="c_name" style="width: 200px"   value="<%= pro_details.getC_name()%>"/></div>
						</td>
						</tr>
						<tr>
						<td>
							<span>Site Address</span>
							<div><textarea cols="10" rows="2" name="site_addr" id="site_addr" class="input-xxlarge" required="required" ><%= pro_details.getSite_addr()%></textarea></div>
						</td>
						<td colspan=2>
							<span>Project Type</span>
							<div>
							<select name="project-type" id="project-type" class="uniformselect" required="required">
							<option value="">Choose One</option>
							<option <%if(pro_details.getPro_typ().equals("1"))out.println("selected=selected");%> value="1">Joint-Venture</option>
							<option <%if(pro_details.getPro_typ().equals("2"))out.println("selected=selected");%> value="2">Purchased-Land</option>
							</select>
						</div>
						</td>
						</tr>
						<tr>
						<td>
							<span>No of Floors.</span>
							<div><input type="text" name="site_no_floors" id="site_no_floors" class="input-small" value="<%= pro_details.getSite_no_floors()%>"/></div>
						</td>
						<td>
							<span>No of Units.</span>
							<div><input type="text" name="site_no_units" id="site_no_units" class="input-small"  value="<%= pro_details.getSite_no_units()%>"/></div>
						</td>
					  </tr>
					  <tr>
	<td>
		<span>Municipality</span>
		<div>
		<select style="width:222px" name="municipality" id="selection2" class="uniformselect">
			<option value="">Select Municipality</option>
			
<%
ArrayList<MunicipalityBO> municipalityList=null;
Iterator<MunicipalityBO> municipalityIt;
MunicipalityBO municipalityItem;
try{
	Municipality municipality= new Municipality();
	municipalityList=municipality.getAllItem();
	
	if(municipalityList != null){
		municipalityIt = municipalityList.iterator();
		while(municipalityIt.hasNext()){
			municipalityItem = (MunicipalityBO)municipalityIt.next();
%>								
			
			<option <% if(pro_details.getMunicipality().equals(municipalityItem.getId()+"")){out.print("selected='selected'");}  %>   value="<%=municipalityItem.getId()%>"><%=municipalityItem.getMunicipalityName()%></option>
			

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
	<td>
		<span>Ward Number</span>
		<div>
		<input type="text" name="word_no" id="phone" class="input-large" required="required"  value="<%=pro_details.getWord_no() %>"/>
		</div>
	</td>
  </tr>
  <tr>
	<td>
		<span>Contact Number 1</span>
		<div>
		<input type="text" name="mobile_no" id="phone" class="input-large" required="required" value="<%=pro_details.getContact1()%>"/>
		</div>	
	</td>
	<td>
		<span>Contact Number 2</span>
		<div>
		<input type="text" name="land_no" id="phone" class="input-large"  value="<%=pro_details.getContact2() %>" />
		</div>
	</td>
  </tr>
			<tr>
	<td>
		<span>Email Id 1</span>
		<div>
			<input  type="email" name="email" class="input-large" value="<%=pro_details.getEmail1() %>" />
		</div>	
	</td>
	<td>
		<span>Email Id 2</span>
		<div>
			<input  type="email1" name="email1" class="input-large" value="<%=pro_details.getEmail2() %>" />
		</div>	
	</td>
  </tr>		  
		              <tr>
		              	<td style="float: left;">
								<span>Date Created</span>
								<div><input id="datepicker" type="text" name="datecreated" class="input-small datepicker" value="<%= pro_details.getDate()%>" required="required"/><b>(YYYY-MM-DD)</b></div>	
						</td>					  
					</tr>
					<tr>
		                <td style="float: left;">
							<span>Details</span>
							<div><textarea rows="2" cols="10" name="site_note" id="site_note" class="" ><%= pro_details.getSite_details()%></textarea></div>
						</td>			 					  
					  </tr>
					</table>	
					<div id="btnlist" style="display: none;" >	                      
					<p class="stdformbutton">
					<br>
					<br>
						<input type="hidden" name="todo" value="updateProjectDetails">
						<button class="btn btn-primary">Save Changes</button>
						<button type="reset" class="btn">Reset Button</button>
					</p>
					</div>
                    </form>
                    <%} %>
  <%@ include file="common/foot.jsp" %>
    