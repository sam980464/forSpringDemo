<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>


<script type="text/javascript" src="resources/js/datetimepicker.js"></script>

<style>
#exp_for {
    width: 220px;
}
</style>

<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>


<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Add New Office Expenses</h4>
		<div class="widgetcontent nopadding">
			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td colspan=2>
							<span>Expenses For</span>
							<div>
							<select name="exp_for"  id="exp_for"  required="required"  >
<%
	ArrayList<OfficeExpensesItemBO> officeExpensesItemList=null;
	Iterator<OfficeExpensesItemBO> officeExpensesItemIt;
	OfficeExpensesItemBO officeExpensesItemBO;
	try{
		OfficeExpensesItem officeExpensesItem= new OfficeExpensesItem();
		officeExpensesItemList=officeExpensesItem.getAllItem();
		
		if(officeExpensesItemList != null){
			officeExpensesItemIt = officeExpensesItemList.iterator();
	while(officeExpensesItemIt.hasNext()){
		officeExpensesItemBO = (OfficeExpensesItemBO)officeExpensesItemIt.next();
%>		
                    
<option value="<%=officeExpensesItemBO.getId()%>"><%=officeExpensesItemBO.getItemName()%></option>                 
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
						<td colspan=2>
							<span>Amount</span>
							<div>
							<input type="text" name="amount" id="amount" placeholder="0.00" class="input-large number" required="required" />
							</div>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<span>Expenses Description</span>
							<div>
							<textarea class="" id="exp_desc" name="exp_desc" rows="5" cols="80" style="min-width: 100px"></textarea>
							</div>
						</td>
						<td colspan=2>
							<span>Bank</span>
							<div>
<select name="bank" id="bank"  style="width: 220px;"  >							
<option value="0">Cash</option>
<%
	ArrayList<BankBO> bankList=null;
	Iterator<BankBO> bankIt;
	BankBO bankItem;
	try{
		Bank bank= new Bank();
		bankList=bank.getAllItem();
		
		if(bankList != null){
			bankIt = bankList.iterator();
			while(bankIt.hasNext()){
				bankItem = (BankBO)bankIt.next();
%>       
                        
                            <option value="<%=bankItem.getId() %>"><%=bankItem.getBankName() %>[<%=bankItem.getAddress() %>]</option>
                        
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
					<tr>
						<td colspan=2>
							<span>Date</span>
								<div>
								<input type="text" value="<%= df.format(new java.util.Date()) %>" class="input-large" name="datecreated" id="demo"><a href="javascript:NewCal('demo','yyyymmdd')"><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
								<b>[YYYY-MM-DD]</b>
								</div>
							
						</td>
						<td colspan=2>
							<span>Cheque Number</span>
							<div>
							<input type="text" name="cq_no" id="cq_no" class="input-large"/>
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="addOfficeExpenses">
					 <input type="hidden" name="userid" value="<%=session.getAttribute("id")%>">
					<button class="btn btn-primary">Save</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
		</div>
		<!--widgetcontent-->
	</div>
</div>
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!--row-fluid-->