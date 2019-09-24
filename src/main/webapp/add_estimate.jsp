<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%
Client client=new Client();
java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
String client_name=client.getClientNameById(Integer.parseInt(request.getParameter("cid")));
%>


<script type="text/javascript" src="resources/js/datetimepicker.js"></script>

<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Create An Estimate for <b><%=client_name %></b></h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="1000px" border="1" class="tbl">
					<tr>
						<td colspan="2"><span>For Scheme</span>
							<div id="scheme_p" style="float:left;">
								<select style="width:290px;" name="scheme_parent_id" id="scheme_parent_id"
									class="uniformselect" required="required" onchange="getChildLis(this)">
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
								<div id="scheme_child_div" style="float:right;">
								
								</div>

							</div></td>
							
							
					</tr>
					<tr>
						<td><span>Amount(<b>Rs</b>)</span>
							<div>
								<input type="text" name="amount" id="amount" class="input-large"
									required="required" placeholder="0.00" />
							</div></td>
						<td><span>Estimate Note</span>
							<div>
								<textarea cols="80" rows="5" name="note" id="note" class=""></textarea>
							</div></td>
					</tr>
					<tr>
						<td>
							<span>Date</span>
							<div>
							<input type="text" value="<%= df.format(new java.util.Date()) %>"  name="datecreated" id="demo"><a href="javascript:NewCal('demo','yyyymmdd')"><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
							<b>[YYYY-MM-DD]</b>
							</div>
						</td>
						<td>
						&nbsp;
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="addEstimate"> 
					<input type="hidden" name="userid" value='<%=session.getAttribute("id")%>'>
					<input type="hidden" value="<%=request.getParameter("cid") %>" name="client">
					<button class="btn btn-primary">Save</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->



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
