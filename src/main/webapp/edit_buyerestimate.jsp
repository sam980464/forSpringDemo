<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.bean.*"%>
<%@page import="com.project.dao.*"%>
<%
//java.text.DateFormat df = new java.text.SimpleDateFormat("dd-MM-yyyy");
%>
<script type="text/javascript" src="resources/js/datetimepicker.js"></script>

<style>
.stdform select {
    width: 250px;
}

</style>




<h4 class="widgettitle">Edit Buyer  <b>Estimation</b></h4>
 <form class="stdform stdform2" method="get" action="ActionServlet" onsubmit="return checkOverflow()">
					<table width="100%" border="1" class="tbl">
					  <tr>
						<td>
							<span>Buyer Name</span>
							<div>
							<select name="buyer"  onchange="loadDetails()" id="buyer" class="uniformselect" readonly>
							
<% String pid= request.getParameter("eid");
   ArrayList<AddBuyerToProjectBean> buyerbean=new ArrayList<AddBuyerToProjectBean>();
   buyerbean= new AddBuyerToProject().getEstimateList(pid,"");
	%>								
<option 
	
	value="<%=buyerbean.get(0).getBuyer_id()%>" >
		<%=buyerbean.get(0).getBuyer_name()%>
</option>
							</select>					
							</div>
						</td>
						<td>
							<span>On Date</span>
							<div>
						  	<input id="demo" name="datecreated" type="text" size="25" value="<%=buyerbean.get(0).getBuyer_estimate_date()%>"><a href="javascript:NewCal('demo','ddmmyyyy')" ><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
						  	</div>
						</td>
					  </tr>
					  <tr>
						<td>
						<input type="hidden" value="<%=pid%>" name="pid">
							<span>Estimate Amount</span>
							<input type="text" class="input-small"  name="new" id="new" value="<%=buyerbean.get(0).getBuyer_estimate_amount()%>">
						</td>
						  </tr>
						  <tr>
						<td>
							<span>Note</span>
							<textarea  name="note" rows="" cols=""><%=buyerbean.get(0).getBuyer_estimate_details()%></textarea>
						</td>
					  </tr>
					</table>		                      
					<p class="stdformbutton">
					
						<input type="hidden" name="todo" value="buyerEstimateupdate">
						<input type="hidden" name="userid" value="">
						<button class="btn btn-primary">Update</button>
						<button type="reset" class="btn">Reset Button</button>
					</p>
<div id="getTotalDetails" style="height: 59px;"></div>	

</form>
