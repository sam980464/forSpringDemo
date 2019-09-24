<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<script type="text/javascript" src="resources/js/datetimepicker.js"></script>

<style>
.stdform select {
    width: 250px;
}

</style>


<script type="text/javascript">
function  calculate()
{
	var qty = document.getElementById("qty1").value;
	var per_unit_price = document.getElementById("per_unit_price").value;

	//alert(qty);
	//alert(per_unit_price);
	
	document.getElementById("amount_pop").value=qty*per_unit_price;
}
</script>
<%
	int exid=Integer.parseInt(request.getParameter("exid"));
	ArrayList<ExpensesBO> expensesList=null;
	Iterator<ExpensesBO> expIt;
	ExpensesBO expensesBO;
	try{
		Expenses expenses= new Expenses();
		expensesList=expenses.getAllItem(exid);
		
		if(expensesList != null){
			expIt = expensesList.iterator();
			while(expIt.hasNext()){
				expensesBO = (ExpensesBO)expIt.next();
				int cid= expensesBO.getClientId();
				int cur_eid=expensesBO.getEstimateId();
				String cur_qty=""+expensesBO.getQty();
				String cur_unit_price=""+expensesBO.getUnitPrice();
				String cur_amount=""+expensesBO.getTotalAmount();
				int  cur_supplier_id =expensesBO.getSupplierId();
				
				
				
%>	
<h4 class="widgettitle">Edit Expenses for ID :<%=request.getParameter("exid")  %> </h4>
 <form class="stdform stdform2" method="post" action="ActionServlet"  onsubmit="return beforeSubmitCheck();">
					<table width="100%" border="1" class="tbl">
					  <tr>
						<td>
							<span>Client Name  :</span>
							<div>
							<input type="hidden" name="client" value="<%=cid%>"/>
							<%
							Client client= new Client();
							%>
							<%=client.getClientNameById(cid) %>
							</div>
						</td>
						<td>
							<span>For Estimate :</span>
							<div>
							<input type="hidden" name="h_estimate" id="h_estimate" value="<%=cur_eid %>" />
							<input type="hidden" name="estimate" id="h_estimate" value="<%=cur_eid %>" />
							<%
							Scheme scheme= new Scheme();
							String sc_all=scheme.getSchemeNameByEstimateId(cur_eid);
							
							String sc_id=sc_all.split(":")[0];
							%>
							<%=sc_all.split(":")[1] %>
							</div>
						</td>
					  </tr>
					  <tr>
						<td>
							<span>Quantity</span>
							<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input id="qty1" class="input-small" type="text"  value="<%=cur_qty%>"  name="qty" >
							
							</div>
						</td>
						<td>
							<span>Per Unit Price</span>
							<div>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input id="per_unit_price" class="input-small"  type="text"  value="<%=cur_unit_price %>"  name="per_unit_price" onblur="calculate()" />
							</div>
						</td>
					  </tr>
					  <tr>
						<td>
							<span>Total Amount</span>
							<div>
							<input id="amount_pop" class="input-small" type="text" value="<%= cur_amount %>" required="required" name="amount">
							</div>
						</td>
						<td>
						<!--  	<span>Date</span>
							<div>
							<input id="exp_date" name="exp_date" class="input-small" type="text" value="<%=expensesBO.getExpDate() %>" required="required">
							</div>
							<td> -->
		<span>Date Created</span>
		<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input id="demo" readonly="readonly" type="text"  name="exp_date" class="input-small datepicker" value="<%=expensesBO.getExpDate() %>"  required="required"/>
	  	<b>(YYYY-MM-DD)</b>
	  	</div>	
	</td>
							<%-- <span>For Item</span>
							<div>
							<select name="item" id="item" class="uniformselect"  required="required" >
							<option value="0">Choose Item</option>
<%
	ArrayList<ItemBO> itemList=null;
	Iterator<ItemBO> itemIt;
	ItemBO itemBO;
	try{
		Item item= new Item();
		itemList=item.getAllItem();
		
		if(itemList != null){
			itemIt = itemList.iterator();
			while(itemIt.hasNext()){
				itemBO = (ItemBO)itemIt.next();
%>								
<option 
	<% 
	if(request.getParameter("cid")!=null){
	if(Integer.parseInt(request.getParameter("cid"))==itemBO.getId())
		{
			out.print("selected='selected'");
	} 
	}
	%> 
	value="<%=itemBO.getId()%>">
		<%=itemBO.getName()%>
</option>
<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%> 

							</select>
							</div>	 --%>
						</td>
					  </tr>
					  <tr>
						<td>
						
						<input type="hidden" id="supplier"  name="supplier" value="<%=expensesBO.getSupplierId() %>"  >
						<%
						Supplier supplier= new Supplier();
						int service_id=supplier.getServiceIdFromSupplier(expensesBO.getSupplierId());
						%>
							<span>Service :</span>
							<div>
							<input type="hidden" id="h_service" name="h_service" value="<%=service_id %>"  >
							<select name="service">
							<%
							Service service= new Service();
							String sup=request.getParameter("supid");
							String sr=request.getParameter("srid");
							String service_bfr=service.getServiceNameById(Integer.parseInt(sr));
							ArrayList<String> list=	service.getServiceList(Integer.parseInt(sup));
							for(int i=0;i<list.size();i++){
							if(list.get(i).split(":")[1].equals(service_bfr)){
							%>
							<option value="<%=list.get(i).split(":")[0] %>" selected="selected"><%=list.get(i).split(":")[1] %></option>
				            <%}else{ %>
							<option value="<%=list.get(i).split(":")[0] %>" ><%=list.get(i).split(":")[1] %></option>
							<%} } %>
							</select>
							</div>
						</td>
						<td>
							<span>Supplier :</span>
							<div>
							<input type="hidden" id="h_supplier"  value="<%=cur_supplier_id %>"  >
							<select >
							<%
							service= new Service();
							String sup_bfr=supplier.getSupplierNameById(cur_supplier_id);
							ArrayList<String> list1=service.getSupList(service_id);
							%>
							<option value="<%=cur_supplier_id %>" selected="selected" ><%=sup_bfr %></option>
							</select>
							
							
							</div>
						</td>
					  </tr>
					  <tr>
					  	<td>
							<span>Bill Number</span>
							<div>
							<input id="bill_number" class="input-small" type="text"  name="bill_number" value="<%=expensesBO.getBillNumber() %>">
							</div>
						</td>
						<td>
							
							<div>
							<span>Note</span>
							<textarea name="note" rows="" cols=""><%=expensesBO.getNote() %></textarea>
							</div>
						</td>
					  
					  </tr>
					</table>		                      
					<p class="stdformbutton">
						<input type="hidden" name="todo" value="updateOrder">
						<input type="hidden" name="exid" value="<%=request.getParameter("exid")%>">
						<input type="hidden" name="userid" value="<%=session.getAttribute("id")%>">
						<button class="btn btn-primary">Update</button>
						<button type="reset" class="btn">Reset Button</button>
					</p>
                    </form>
<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}

ExpensesPayment ex_payment= new ExpensesPayment();

%> 


<input type="hidden" name="already_paid" id="already_paid"   value="<%=String.format("%.2f", ex_payment.getTotalPaidByExpId(Integer.parseInt(request.getParameter("exid")))) %>">


<script>

function beforeSubmitCheck()
	{
	var already_paid= document.getElementById("already_paid").value;
	var amount      = document.getElementById("amount_pop").value;
	
	if(amount<already_paid){
		
		alert("Error : You already paid "+already_paid+". ");	
		return false;
	}
	else{
		
		return true;
	}
}

/*
loadEstimate();
loadSupplier();
loadService();



function loadService()
{
	var eid= document.getElementById("h_estimate").value;
	//alert(client);
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
	    document.getElementById("service").innerHTML=xmlhttp.responseText;
	   
	    }
	  }
	xmlhttp.open("GET","ActionServlet?todo=getServiceLov&eid="+eid,true);
	xmlhttp.send();
}



function loadEstimate()
{
	var client= document.getElementById("client").value;
	//alert(client);
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
	    document.getElementById("estimate").innerHTML=xmlhttp.responseText;
	    document.getElementById("estimate").value=document.getElementById("h_estimate").value;
	    }
	  }
	xmlhttp.open("GET","ActionServlet?todo=getSchemeLov&cid="+client,true);
	xmlhttp.send();
}


function loadSupplier()
{
	var service= document.getElementById("service").value;
	var selected_service= document.getElementById("h_service").value;
	
	//alert(service);
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
	    document.getElementById("supplier").innerHTML=xmlhttp.responseText;
	    document.getElementById("supplier").value=document.getElementById("h_supplier").value;
	    document.getElementById("service").selectedIndex = selected_service;
	   // document.getElementById('service').getElementsByTagName('option')[selected_service].selected = 'selected';
	   
	    }
	  }
	
	
	if(service==0){
		xmlhttp.open("GET","ActionServlet?todo=getSupplierLov",true);
	}
	else{
	xmlhttp.open("GET","ActionServlet?todo=getSupplierLov&serviceid="+service,true);
	}
	
	xmlhttp.send();
} */

function checkOverflow()
{
	
	var total_estimate=document.getElementById("total_estimate").value;
	var total_ordered=document.getElementById("total_ordered").value;
	var vartual_inhand=total_estimate-total_ordered;
	
	var amount=document.getElementById("amount").value;
	if(amount>vartual_inhand)
		{
		
		alert('Please Increase Estimate Amount Before Order More !');
		return false;
		}
	else{
		return true;
	}

}



//document.getElementById('service').options[23].selected = true;

  
</script>                    
               
                    
                    
                    