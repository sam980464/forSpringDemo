<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<script type="text/javascript" src="resources/js/datetimepicker.js"></script>
<%
	ArrayList<OfficeExpensesBO> officeExpensesList=null;
	Iterator<OfficeExpensesBO> officeExpensesIt;
	OfficeExpensesBO officeExpensesItem;
	try{
		OfficeExpenses officeExpenses= new OfficeExpenses();
		officeExpenses.setId(Integer.parseInt(request.getParameter("oe_id")));
		officeExpensesList=officeExpenses.getAllItembyId();
		if(officeExpensesList != null){
			officeExpensesIt = officeExpensesList.iterator();
			while(officeExpensesIt.hasNext()){
				officeExpensesItem = (OfficeExpensesBO)officeExpensesIt.next();
%>

<div class="row-fluid">
	<div class="widgetbox">
		<h4 class="widgettitle">Edit Office Expenses for <b><%=officeExpensesItem.getExpensesName()%></b></h4>
		<div class="widgetcontent nopadding">


			<form class="stdform stdform2" method="post" action="ActionServlet">
				<table width="100%" border="1" class="tbl">
					<tr>
						<td colspan=2>
							<span>Expenses For</span>
							<div>
							
<select name="exp_for"  required="required"  >
<%
	ArrayList<OfficeExpensesItemBO> officeExpensesItemList=null;
	Iterator<OfficeExpensesItemBO> officeExpensesItemIt;
	OfficeExpensesItemBO officeExpensesItemBO;
	try{
		OfficeExpensesItem oei= new OfficeExpensesItem();
		officeExpensesItemList=oei.getAllItem();
		
		if(officeExpensesItemList != null){
			officeExpensesItemIt = officeExpensesItemList.iterator();
	while(officeExpensesItemIt.hasNext()){
		officeExpensesItemBO = (OfficeExpensesItemBO)officeExpensesItemIt.next();
%>		
                    
<option <%if (officeExpensesItem.getExpensesName()==officeExpensesItemBO.getId()){ out.print("selected=selected");} %>  value="<%=officeExpensesItemBO.getId()%>"><%=officeExpensesItemBO.getItemName()%></option>                 
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
							<input type="text" name="amount" id="amount" class="input-large" required="required" value="<%=officeExpensesItem.getAmount()%>" />
							</div>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<span>Expenses Description</span>
							<div>
							<textarea class="" id="exp_desc" name="exp_desc" rows="5" cols="80" style="min-width: 100px"><%=officeExpensesItem.getExpensesDesc()%></textarea>
							</div>
						</td>
						<td colspan=2>
							<span>Bank</span>
							<div>
<select name="bank" id="bank"  style="width: 220px;"  >							
<option value="0" <% if(officeExpensesItem.getBankId()==0){ out.print("selected=selected");} %>>Cash</option>
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
                        
              <option <% if(officeExpensesItem.getBankId()==bankItem.getId()){ out.print("selected=selected");} %> value="<%=bankItem.getId() %>"><%=bankItem.getBankName() %>[<%=bankItem.getAddress() %>]</option>
                        
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
							<input type="text" name="date_time" id="date_time" class="input-large" value="<%	String[] datetime = officeExpensesItem.getDateTime().split(" ");
                          	%><%=datetime[0] %>" placeholder="YYYY-MM-DD"/><a href="javascript:NewCal('date_time','yyyymmdd')" ><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>[YYYY-MM-DD]
							</div>
						</td>
						<td colspan=2>
							<span>Cheque Number</span>
							<div>
							<input type="text" name="cq_no" id="cq_no" value="<%=officeExpensesItem.getChequeNo()%>" class="input-large"/>
							</div>
						</td>
					</tr>
				</table>
				<p class="stdformbutton">
					<input type="hidden" name="todo" value="updateOfficeExpenses">
					<input type="hidden" name="id" value="<%=request.getParameter("oe_id") %>"> 
					
					<button class="btn btn-primary">Update</button>
					<button type="reset" class="btn">Reset Button</button>
				</p>
			</form>
			 			
		</div>
		<!--widgetcontent-->
	</div>
</div>
<!--row-fluid-->


<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>