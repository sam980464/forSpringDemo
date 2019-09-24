<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@page import="com.project.dao.*"%>
<%@page import="com.project.bean.*"%>

<%
String buyerid=request.getParameter("buyer_id");
Buyer buyer=new Buyer();
ArrayList<BuyerBean> buyerList = new ArrayList<BuyerBean>();
buyerList=new Buyer().getAllBuyer(buyerid,"");
%>
<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Edit Buyer</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="get" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td><span>Buyer Name</span>
							<div>
								<input type="text" value="<%=buyerList.get(0).getBuyer_name() %>" name="buyer_name">
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Mobile</span>
							<div>
							<input type="text" name="buyer_contactno" value="<%=buyerList.get(0).getBuyer_contactno()%>"/>
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Email Id</span>
							<div>
							<input type="text" name="buyer_email" value="<%=buyerList.get(0).getBuyer_email()%>"/>
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Address</span>
							<div>
							<input type="text" name="buyer_address" value="<%=buyerList.get(0).getBuyer_address()%>"/>
							</div>
						</td>
					</tr>
					<tr>
						<td><span>Buyer Details</span>
							<div>
							<textarea rows="" cols="" name="buyer_details"><%=buyerList.get(0).getBuyer_details()%></textarea>
							</div>
						</td>
					</tr>
					
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="updateBuyer"> 
					<input type="hidden" name="buyer_id" value="<%=request.getParameter("buyer_id")%>">
					<button class="btn btn-primary">Update</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->
