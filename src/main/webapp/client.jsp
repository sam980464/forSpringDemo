<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.bean.DeveloperBean"%>
<%@page import="com.project.dao.*"%>

 <%@ include file="common/head.jsp" %>
    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>All Client</li>
        </ul>

 <% 
if((session.getAttribute("isSuccess") != null) || request.getParameter("isSuccess") !=null){
%>
<script type="text/javascript">
alert("Item has been successfully added.Please check Expenses List");
</script>

<%
session.setAttribute("isSuccess",null);
} 
%> 
 <% 
if(null!=request.getParameter("pid") && null!=request.getParameter("eid") ){
	
%>
<script type="text/javascript">
window.open("bill.jsp?cid="+<%=request.getParameter("cid")%>+"&eid="+<%=request.getParameter("eid")%>+"&pid="+<%=request.getParameter("pid")%>,'_blank');;
</script>

<%	
}
 %>
		 
        <div class="maincontent">
            <div class="maincontentinner">
<% 
if(request.getParameter("cid")==null){
%>
<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Choose Client To Go Dashboard</h4>
         <div class="widgetcontent">
             <form class="stdform stdform2" action="" method="get">      
<p>
<select name="cid" data-placeholder="Choose a Client" style="width:350px" class="_chzn-select" tabindex="2">
<%
ArrayList<ClientBO> itemPartList=null;
Iterator<ClientBO> clientIt2;
ClientBO clientItem;
try{
	Client test= new Client();
	itemPartList=test.getAllItemWithSameNameClient();
	if(itemPartList != null){
		clientIt2 = itemPartList.iterator();
		while(clientIt2.hasNext()){
			clientItem = (ClientBO)clientIt2.next();
%>								
<option value="<%=clientItem.getId()%>"><%=clientItem.getClientName()%></option>
<%
	}
}}
catch(Exception e){
	
	e.printStackTrace();
}
%>
        </select>
<input type="submit" class="alertdanger btn btn-danger alertdanger" value="Go To Client Dashboard" >
 </p>   
    </form>
</div><!--widgetcontent-->
</div>
<%
}
else{
%> 
<%
	ArrayList<ClientBO> clientLists=null;
	Iterator<ClientBO> testIt;
	ClientBO clientItem;
	try{
		Client client= new Client();
		clientLists=client.getAllItem(Integer.parseInt(request.getParameter("cid")));
		if(clientList != null){
			testIt = clientLists.iterator();
			while(testIt.hasNext()){
				clientItem = (ClientBO)testIt.next();
%>   
<%
if (session.getAttribute("message")!=null){
%>
<div class="alert alert-info" style="background-color:yellow">
<%=session.getAttribute("message") %>
<% session.setAttribute("message",null); %>
</div>
<% } %>


<div class="widget" id="client_selected">
         <h4 class="widgettitle"><%=clientItem.getClientName()%></h4>
         <div class="widgetcontent">
<div class="alert alert-info">
<div class="btn-group">
    <button data-toggle="dropdown" class="btn btn-danger">Estimate<span class="caret"></span></button>
    <ul class="dropdown-menu">
        <li><a  class="color" href="add_estimate.jsp?cid=<%=request.getParameter("cid") %>">Create Estimate</a></li>
        <li><a  class="color" href="estimate_list.jsp?cid=<%=request.getParameter("cid") %>">Estimate List</a></li>
    </ul>
</div>
<div class="btn-group"> 
    <button data-toggle="dropdown" class="btn btn-danger">Payment History<span class="caret"></span>
     </button>
    <ul class="dropdown-menu">
    	<%-- <li><a class="color" href="payment_history.jsp?cid=<%=request.getParameter("cid")%>">All Payment List</a></li> --%>
<%
int cid=Integer.parseInt(request.getParameter("cid"));
	ArrayList<EstimateBO> estimateList=null;
	Iterator<EstimateBO> estimateIt;
	EstimateBO estimateItem;
	try{
		Estimate estimate= new Estimate();
		estimateList=estimate.getAllItem(cid);
		
		if(estimateList != null){
			estimateIt = estimateList.iterator();
			while(estimateIt.hasNext()){
				estimateItem = (EstimateBO)estimateIt.next();
%> 
 <% Scheme scheme= new Scheme(); %>   
        <li><a class="color" href="payment_history.jsp?cid=<%=request.getParameter("cid") %>&estimateid=<%=estimateItem.getId()%>"><%=scheme.getSchemeNameById(estimateItem.getSchemeId())%>  [<%=String.format("%.2f", estimateItem.getAmount()) %>]</a></li>
<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>         
	 
    </ul>
</div>



<%-- <a href="payment_history.jsp?cid=<%=request.getParameter("cid") %>"  class="btn btn-danger alertdanger color">
<small>Payment History</small>
</a> --%>

<div class="btn-group">
    <button data-toggle="dropdown" class="btn btn-danger">Expenses for Client<span class="caret"></span></button>
    <ul class="dropdown-menu">
        <li><a  class="color" href="add_order_to_supplier.jsp?cid=<%=request.getParameter("cid") %>">New Expenses</a></li>
        <li><a  class="color" href="ordered_list.jsp?cid=<%=request.getParameter("cid") %>">Expenses List</a></li>
        <li><a  class="color" href="supplier_paid_list.jsp?cid=<%=request.getParameter("cid") %>">Expenses Paid to Supplier</a></li>
    </ul>
</div>


<div class="btn-group">
   
    <button data-toggle="dropdown" class="btn btn-danger">
     Account Status<span class="caret"></span>
     </button>
    
    <ul class="dropdown-menu">
    	<li><a href="account_summary_by_eid.jsp?cid=<%=request.getParameter("cid") %>" >All Summary</a></li>
<%
//int cid=Integer.parseInt(request.getParameter("cid"));

	//ArrayList<EstimateBO> estimateList=null;
	//Iterator<EstimateBO> estimateIt;
	//EstimateBO estimateItem;
	try{
		Estimate estimate= new Estimate();
		estimateList=estimate.getAllItem(cid);
		
		if(estimateList != null){
			estimateIt = estimateList.iterator();
			while(estimateIt.hasNext()){
				estimateItem = (EstimateBO)estimateIt.next();
%> 
 <% Scheme scheme= new Scheme(); %>   
        <li><a href="account_summary_by_eid.jsp?cid=<%=request.getParameter("cid") %>&eid=<%=estimateItem.getId()%>"><%=scheme.getSchemeNameById(estimateItem.getSchemeId())%>  [<%=String.format("%.2f", estimateItem.getAmount()) %>]</a></li>
<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>         
	 
    </ul>
</div>






<%-- <a  href="accountStatus.jsp?cid=<%=request.getParameter("cid") %>"  class="btn btn-danger alertdanger color">
<small>Account Status</small>
</a> --%>



<div class="btn-group">
    <button data-toggle="dropdown" class="btn btn-danger">Option<span class="caret"></span></button>
    <ul class="dropdown-menu">
        <li><a  onclick="editMe()">Edit Client</a></li>
        <li><a onclick="return confirm('Are you sure?');"   href="ActionServlet?todo=deleteClient&id=<%=clientItem.getId()%>">Delete Client</a></li>
        <li><a href="documentManagement.jsp">Document Management</a></li>
    </ul>
</div>


<% 
PropertyDetails propertyDetails= new PropertyDetails();
propertyDetails.setCid(cid);

%>



<div class="btn-group">
    <button data-toggle="dropdown" class="btn btn-danger">Property Details<span class="caret"></span></button>
    <ul class="dropdown-menu">
    	<% if(propertyDetails.hasExists()==1){ %>
        <li><a  class="color" href="edit_client_property.jsp?cid=<%=request.getParameter("cid") %>">Edit Property Details</a></li>
        <% }else{ %>
        <li><a  class="color" href="add_client_property.jsp?cid=<%=request.getParameter("cid") %>">Add Property Details</a></li>
        <% } %>
    </ul>
</div>


<%-- <a  href="edit_client_property.jsp?cid=<%=request.getParameter("cid") %>"  class="btn btn-danger alertdanger color">
<small>Property Details</small>
</a> --%>

</div>
<form class="stdform" method="post" action="ActionServlet">
<table width="100%" border="1" class="tbl">
  <tr>
	<td colspan=2>
		<span>Name</span>
		<div>
		
		<select name="mr_ms" id="selection2" style="width: 100px" class="uniformselect">
		<option value="">Choose One</option>
		<option <%if(clientItem.getMrMs().equals("Mr")){out.print("selected=selected");}%> value="Mr">Mr</option>
		<option <%if(clientItem.getMrMs().equals("Mrs")){out.print("selected=selected");}%> value="Mrs">Mrs</option>
		<option <%if(clientItem.getMrMs().equals("Ms")){out.print("selected=selected");}%> value="Ms">Ms</option>
		<option <%if(clientItem.getMrMs().equals("Md")){out.print("selected=selected");}%>  value="Md">Md</option>
		<option <%if(clientItem.getMrMs().equals("Sri")){out.print("selected=selected");}%> value="Sri">Sri</option>
		<option <%if(clientItem.getMrMs().equals("Sekh")){out.print("selected=selected");}%> value="Sekh">Sekh</option>
		<option <%if(clientItem.getMrMs().equals("Smt")){out.print("selected=selected");}%> value="Smt">Smt</option>
		<option  <%if(clientItem.getMrMs().equals("M/S")){out.print("selected=selected");}%> value="M/S">M/S</option>
		</select>
		<input type="text" name="name" id="name" value="<%=clientItem.getClientName()%>" class="input-xxlarge"  />
		</div>
	</td>
	</tr>
	<tr>
	<td>
		<span>Guardian's Name</span>
		<div>
		<select name="gar_rel" id="selection2" class="uniformselect" style="width: 100px" required="required">
		<option value="0">Choose One</option>
		<option <% if(clientItem.getGuardianRelation().equals("SON")){out.print("selected='selected'");}  %> value="SON">SON</option>
		<option <% if(clientItem.getGuardianRelation().equals("WIFE")){out.print("selected='selected'");}  %> value="WIFE">WIFE</option>
		<option <% if(clientItem.getGuardianRelation().equals("HUSBAND")){out.print("selected='selected'");}  %> value="HUSBAND">HUSBAND</option>
		<option <% if(clientItem.getGuardianRelation().equals("DAUGHTER")){out.print("selected='selected'");}  %> value="DAUGHTER">DAUGHTER</option>
		</select>
		<input type="text" name="gar_name" id="name" class="input-large" required="required" value="<%=clientItem.getGuardianName() %>" />
		</div>
	</td>
	<td>
		<span>Date Created</span>
		<div ><input id="datepicker" type="text" name="datecreated" class="input-small datepicker" value="<%=clientItem.getDateCreated() %>" />
	  	
	  	<b>(YYYY-MM-DD)</b>
	  	</div>	
	</td>
  </tr>
  <tr>
	<td>
		<span>Present Address</span>
		<div>
		<textarea cols="80" rows="5" name="present_addr" id="location2" class=""><%=clientItem.getPresentAddress().trim() %></textarea>
		</div>
	</td>
	<td>
		<span>Permanent Address</span>
		<div>
		<textarea cols="80" rows="5" name="per_addr" id="location2" class=""><%=clientItem.getPermanentAddress().trim() %></textarea>
		</div>
	</td>
  </tr>
  <tr>
	<td>
		<span>Municipality</span>
		<div>
		<select style="width:330px" name="municipality" id="municipality"  class="uniformselect" disabled required>
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
			
			<option <% if(clientItem.getMunicipality()==municipalityItem.getId()){out.print("selected='selected'");}  %>   value="<%=municipalityItem.getId()%>"><%=municipalityItem.getMunicipalityName()%></option>
			

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
		<input type="text" name="word_no" id="phone" class="input-large" required="required"  value="<%=clientItem.getWordNo() %>"/>
		</div>
	</td>
  </tr>
  <tr>
	<td>
		<span>Contact Number 1</span>
		<div>
		<input type="text" name="mobile_no" id="phone" class="input-large" required="required" value="<%=clientItem.getMobile()%>"/>
		</div>	
	</td>
	<td>
		<span>Contact Number 2</span>
		<div>
		<input type="text" name="land_no" id="phone" class="input-large"  value="<%=clientItem.getLand() %>" />
		</div>
	</td>
  </tr>
  <tr>
	<td>
		<span>Reference</span>
		<div>
			<select name="ref" id="ref" class="uniformselect">
				<option value="0">Choose One</option>
<%
ArrayList<ReferenceBO> refarenceList=null;
Iterator<ReferenceBO> refarenceIt;
ReferenceBO refarenceItem;
try{
	Reference refarence= new Reference();
	refarenceList=refarence.getAllItem();
	
	if(refarenceList != null){
refarenceIt = refarenceList.iterator();
while(refarenceIt.hasNext()){
	refarenceItem = (ReferenceBO)refarenceIt.next();
%>								
								
<option <% if(refarenceItem.getId()==clientItem.getRef()){out.print("selected='selected'");}  %> value="<%=refarenceItem.getId()%>"><%=refarenceItem.getName()%></option>
			

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
							<span>State</span>
							<div>
							<select name="stateName" id="stateName" class="uniformselect">
									<option value="">Choose One</option>
									<option <% if(clientItem.getState_name().equals("Andhra Pradesh")){out.print("selected='selected'");}  %> value="Andhra Pradesh">Andhra Pradesh</option>
									<option <% if(clientItem.getState_name().equals("Arunachal Pradesh")){out.print("selected='selected'");}  %> value="Arunachal Pradesh">Arunachal Pradesh</option>
									<option <% if(clientItem.getState_name().equals("Assam")){out.print("selected='selected'");}  %> value="Assam">Assam</option>
									<option <% if(clientItem.getState_name().equals("Bihar")){out.print("selected='selected'");}  %>  value="Bihar">Bihar</option>
									<option <% if(clientItem.getState_name().equals("Chhattisgarh")){out.print("selected='selected'");}  %> value="Chhattisgarh">Chhattisgarh</option>
									<option <% if(clientItem.getState_name().equals("Goa")){out.print("selected='selected'");}  %> value="Goa">Goa</option>
									<option <% if(clientItem.getState_name().equals("Gujarat")){out.print("selected='selected'");}  %> value="Gujarat">Gujarat</option>
									<option <% if(clientItem.getState_name().equals("Haryana")){out.print("selected='selected'");}  %> value="Haryana">Haryana</option>
									<option <% if(clientItem.getState_name().equals("Himachal Pradesh")){out.print("selected='selected'");}  %> value="Himachal Pradesh">Himachal Pradesh</option>
									<option <% if(clientItem.getState_name().equals("Jammu & Kashmir")){out.print("selected='selected'");}  %> value="Jammu & Kashmir">Jammu & Kashmir</option>
									<option <% if(clientItem.getState_name().equals("Jharkhand")){out.print("selected='selected'");}  %> value="Jharkhand">Jharkhand</option>
									<option <% if(clientItem.getState_name().equals("Karnataka")){out.print("selected='selected'");}  %> value="Karnataka">Karnataka</option>
									<option <% if(clientItem.getState_name().equals("Kerala")){out.print("selected='selected'");}  %> value="Kerala">Kerala</option>
									<option <% if(clientItem.getState_name().equals("Madhya Pradesh")){out.print("selected='selected'");}  %> value="Madhya Pradesh">Madhya Pradesh</option>
									<option <% if(clientItem.getState_name().equals("Maharashtra")){out.print("selected='selected'");}  %> value="Maharashtra">Maharashtra</option>
									<option <% if(clientItem.getState_name().equals("Manipur")){out.print("selected='selected'");}  %> value="Manipur">Manipur</option>
									<option <% if(clientItem.getState_name().equals("Meghalaya")){out.print("selected='selected'");}  %> value="Meghalaya">Meghalaya</option>
									<option <% if(clientItem.getState_name().equals("Mizoram")){out.print("selected='selected'");}  %> value="Mizoram">Mizoram</option>
									<option <% if(clientItem.getState_name().equals("Nagaland")){out.print("selected='selected'");}  %> value="Nagaland">Nagaland</option>
									<option <% if(clientItem.getState_name().equals("Odisha")){out.print("selected='selected'");}  %> value="Odisha">Odisha</option>
									<option <% if(clientItem.getState_name().equals("Punjab")){out.print("selected='selected'");}  %> value="Punjab">Punjab</option>
									<option <% if(clientItem.getState_name().equals("Rajasthan")){out.print("selected='selected'");}  %> value="Rajasthan">Rajasthan</option>
									<option <% if(clientItem.getState_name().equals("Sikkim")){out.print("selected='selected'");}  %> value="Sikkim">Sikkim</option>
									<option <% if(clientItem.getState_name().equals("Tamil Nadu")){out.print("selected='selected'");}  %> value="Tamil Nadu">Tamil Nadu</option>
									<option <% if(clientItem.getState_name().equals("Telangana")){out.print("selected='selected'");}  %> value="Telangana">Telangana</option>
									<option <% if(clientItem.getState_name().equals("Tripura")){out.print("selected='selected'");}  %> value="Tripura">Tripura</option>
									<option <% if(clientItem.getState_name().equals("Uttarakhand")){out.print("selected='selected'");}  %> value="Uttarakhand">Uttarakhand</option>
									<option <% if(clientItem.getState_name().equals("Uttar Pradesh")){out.print("selected='selected'");}  %> value="Uttar Pradesh">Uttar Pradesh</option>
									<option <% if(clientItem.getState_name().equals("West Bengal")){out.print("selected='selected'");}  %> value="West Bengal">West Bengal</option>
							</select>		
							</div>
						</td>
	</tr><tr>
	<td>
		<span>Email Id 1</span>
		<div>
			<input  type="email" name="email" class="input-large" value="<%=clientItem.getEmail() %>" />
		</div>	
	</td>
	<td>
		<span>Email Id 2</span>
		<div>
		<%if(clientItem.getEmail1()==null) {
		clientItem.setEmail1("");
		}
		 %>
			<input  type="email1" name="email1" class="input-large" value="<%=clientItem.getEmail1() %>" />
		</div>	
	</td>
  </tr>
  <tr>
  <td colspan="2">
  	<span>Associated Developer</span>
	<div>
	<select style="width:290px" name="developer" id="selection2" class="uniformselect" required="required" >
	<option value="0">None</option>
	
		<%
			ArrayList<DeveloperBean> developerListList=null;
			Iterator<DeveloperBean> developerIt;
			DeveloperBean developerItem;
			try{
				Developer developer= new Developer();
				developerListList=developer.getAllDeveloper("all");
				
				if(developerListList != null){
					developerIt = developerListList.iterator();
					while(developerIt.hasNext()){
						developerItem = (DeveloperBean)developerIt.next();
		%>								
										<option <% if(clientItem.getAssociatedDeveloperId()==developerItem.getDeveloper_id()){out.print("selected='selected'");}  %>   value="<%=developerItem.getDeveloper_id()%>"><%=developerItem.getDeveloper_name()%></option>
										
										
		
		<%
			
				}
			}}
			catch(Exception e){
				
				e.printStackTrace();
			}
		%>  							
									</select>
									&nbsp;
									
									</div>	
  
  </td>
  </tr>

</table>		                      
<p class="" id="stdformbutton" >
	<input type="hidden" name="todo" value="updateClient">
	<input type="hidden" name="id" value="<%=request.getParameter("cid")%>">
	<button class="btn btn-primary">Update</button>
	<button type="reset" class="btn">Reset Button</button>
</p>
               </form>
               
  
    </div>
         
</div>

<%

	}
}}
catch(Exception e){
	
	e.printStackTrace();
}
%>

<% } %>



<script>
document.getElementById("stdformbutton").style.display="none";
function editMe()
{
	document.getElementById("stdformbutton").style.display="block";
	document.getElementById("municipality").disabled= false;
}


</script>

      
                           
                            
                        

  <%@ include file="common/foot.jsp" %>