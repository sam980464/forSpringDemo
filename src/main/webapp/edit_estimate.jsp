<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%
Client client=new Client();
int eid=Integer.parseInt(request.getParameter("eid"));
Estimate estimate= new Estimate();
int cid=estimate.getClientIdByEstimateId(eid);
int schemeid=estimate.getSchemeIDByEstimateId(eid);
double amount= estimate.getAmountByEstimateId(eid);
String note= estimate.getNoteByEstimateId(eid);
String estimate_date=estimate.getEstimateDateByEstimateId(eid);
%>

<style>
/* .stdform select {
    width: 245px !important;
} */
</style>
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
<script type="text/javascript" src="resources/js/datetimepicker.js"></script>

<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Create An Estimate for <b><%=client.getClientNameById(cid) %></b></h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="1000px" border="1" class="tbl">
					<tr>
						<td><span>ClientName</span>
							<div>
								<input type="hidden" value="<%=cid %>" name="client">
								<select style="width: 300px;" name="client_list" disabled="disabled" id="selection2"
									class="uniformselect" required="required">
									<option value="">Choose One</option>

									<%
										ArrayList<ClientBO> itemPartList = null;
										Iterator<ClientBO> testIt;
										ClientBO clientItem;
										try {
											Client test = new Client();
											itemPartList = test.getAllItem();

											if (itemPartList != null) {
												testIt = itemPartList.iterator();
												while (testIt.hasNext()) {
													clientItem = (ClientBO) testIt.next();
									%>
									<option
										<%-- <%if (request.getParameter("cid") != null) {
							if (Integer.parseInt(request.getParameter("cid")) == clientItem
									.getId()) {
								out.print("selected='selected'");
							}
						}%> --%>
<% 
if(cid==clientItem.getId())
	{
		out.print("selected='selected'");
} 
%>
										value="<%=clientItem.getId()%>">
										<%=clientItem.getClientName()%>
									</option>




									<%
										}
											}
										} catch (Exception e) {

											e.printStackTrace();
										}
									%>

								</select>
							</div></td>
						<td><span>For Scheme</span>
						
						<input type="hidden" value="<%=schemeid %>" id="childid">
						<%
						Scheme scheme= new Scheme();
						int hasParent=scheme.hasParent(schemeid);
						%>
						<%//=hasParent %>
						
							<div id="scheme_p">
								<select style="width:150px;" name="scheme_parent_id" id="scheme_parent_id"
									class="uniformselect" required="required" onchange="getChildLis(this)">
									<option value="">Select Parent Scheme</option>


									<%
										ArrayList<SchemeBO> schemeList = null;
										Iterator<SchemeBO> schemeIt;
										SchemeBO schemeBO;
										try {
											scheme = new Scheme();
											schemeList = scheme.getAllParentItem();

											if (schemeList != null) {
												schemeIt = schemeList.iterator();
												while (schemeIt.hasNext()) {
													schemeBO = (SchemeBO) schemeIt.next();
									%>

									<option
									
									<% 
									if(hasParent!=0){
										if(hasParent==schemeBO.getId())
										{
											out.print("selected='selected'");
										}	
									}
									else{
										if(schemeid==schemeBO.getId()){
											out.print("selected='selected'");
										}
									}
									 
									%>
									 value="<%=schemeBO.getId()%>"><%=schemeBO.getSchemeName()%></option>
									<%
										}
											}
										} catch (Exception e) {

											e.printStackTrace();
										}
									%>


								</select>
								
								<div id="scheme_child_div" style="float:right;width:150px;">
								
								</div>


							</div></td>
					</tr>
					<tr>
						<td><span>Amount(<b>Rs</b>)</span>
							<div>
								<input type="text" name="amount" id="amount" class="input-large"
									required="required" value="<%=String.format("%.2f", amount) %>" />
							</div></td>
						<td><span>Estimate Note</span>
							<div>
								<textarea cols="80" rows="5" name="note" id="note" class=""><%=note %></textarea>
							</div></td>
					</tr>
					<tr>
					  <td>
					  		<span>Estimate Date</span>
							<div>
							<input type="text" value="<%=estimate_date %>" name="estimate_date"  class="input-small datepicker" required="required" id="demo" /><a href="javascript:NewCal('demo','yyyymmdd')"><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
							(YYYY-MM-DD)
							</div>
					  </td>
					  <td></td>
					  
					  </tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="editEstimate">
						<input type="hidden" name="id" value="<%=eid%>">
						<input type="hidden" name="userid" value="<%=session.getAttribute("id")%>">
						<button class="btn btn-primary">Update</button>
						<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->



<script>
getChildList();

function getChildList(){
	
	//alert(document.getElementById("scheme_id").value);
	var scheme_id= document.getElementById("scheme_parent_id").value;
	var childid= document.getElementById("childid").value;
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
	xmlhttp.open("GET","ActionServlet?todo=getChildScheme&parent="+scheme_id+"&selectedchild="+childid,true);
	xmlhttp.send(); 
	
	
}

 


</script>