<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

<div id="printable">
<h3>
<%
double total_estimate=0.0;
int cid=Integer.parseInt(request.getParameter("cid"));
Client client  =new Client();
%>
<%=client.getClientNameById(cid) %>
</h3>
<h4><b>Paid By Client:</b></h4>
<table border="1" width="700px">
	<tr>
		<th>Estimated</th>
		<th>Received</th>
		<th>Due Amount</th>
	</tr>
	<tr>
		<td>
		<%
    		Estimate estimate= new Estimate();
    		total_estimate=total_estimate+estimate.getTotalEstimateByClientId(cid);
    		%>
    		<%=String.format("%.2f",estimate.getTotalEstimateByClientId(cid) )%>
		</td>
		<td><%=String.format("%.2f", client.getTotalPaidCid(cid))%></td>
		<td><%=String.format("%.2f",client.getTotalDueCid(cid) )%></td>
	</tr>
</table>

<h4><b>Expenses For Client</b></h4>
<table border="1" width="700px">
	<tr>
		<th>Expenses For Client</th>
		<th>Expenses Paid</th>
		<th>Due</th>
		<th>Amount In  Hand </th>
	</tr>
	<tr>
		<td><%=String.format("%.2f",client.getTotalExpByCid(cid) )%></td>
		<td><%=String.format("%.2f", client.getTotalExpPaidByCid(cid))%></td>
		<td><%=String.format("%.2f", (client.getTotalExpByCid(cid)-client.getTotalExpPaidByCid(cid)))%></td>
		<td><%=String.format("%.2f", client.getTotalPaidCid(cid)-client.getTotalExpPaidByCid(cid))%></td>
	</tr>
</table>
</div>

<input type="submit" value="Export" class="alertdanger btn btn-danger alertdanger" onclick="tableToExcel('printable', 'export Table')">
