<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Add Old Service For Scheme</h4>
		<div class="widgetcontent nopadding">
			<form class=" stdform2" method="post" action="ActionServlet">
				<table width="800" border="1" class="tbl">
					<tr>
						<td><span>Scheme List</span>
							<div>
<select name="service_id" id="service_id" class="uniformselect" required="required" ">
<option value="0">Choose Service</option>

<%
ArrayList<ServiceBO> serviceList=null;
Iterator<ServiceBO> serviceIt;
ServiceBO serviceBO;
try{
	Service service= new Service();
	serviceList=service.getAllItem();
	
	if(serviceList != null){
		serviceIt = serviceList.iterator();
		while(serviceIt.hasNext()){
			serviceBO = (ServiceBO)serviceIt.next();
%>								
<option 
	<% 
if(request.getParameter("cid")!=null){
if(Integer.parseInt(request.getParameter("cid"))==serviceBO.getId())
	{
		out.print("selected='selected'");
} 
}
%> 
value="<%=serviceBO.getId()%>">
<%=serviceBO.getName()%>
</option>
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
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="addOldService"> 
					<input type="hidden" name="scheme_id" value="<%=request.getParameter("scheme_id") %>" >
					<button class="btn btn-primary">Add</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
