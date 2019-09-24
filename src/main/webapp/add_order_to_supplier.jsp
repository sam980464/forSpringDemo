<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>

<%
Client client=new Client();
java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
%>


<style>
.stdform select {
    width: 250px;
}


</style>


<script type="text/javascript">
function dateCompare(){
 var demo=document.getElementById("demo").value;
 var demo1=document.getElementById("demo2").value;
 
 var firstValue = demo.split('-');
var secondValue = demo1.split('-');

 var firstDate=new Date();
 firstDate.setFullYear(firstValue[0],(firstValue[1] - 1 ),firstValue[2]);

 var secondDate=new Date();
 secondDate.setFullYear(secondValue[0],(secondValue[1] - 1 ),secondValue[2]);     
//alert(firstDate);
//alert(secondDate);
  if (firstDate < secondDate)
  {
   alert("You Can not update Expense before Estimation Date");
  return false;
   }
 else
  {
  //alert("First Date  is greater than Second Date"); 
  return true;
    
  }
 }

function  calculate()
{
	var qty = document.getElementById("qty").value;
	var per_unit_price = document.getElementById("per_unit_price").value;
	
	//alert(qty);
	//alert(per_unit_price);
	var num=qty*per_unit_price;
	var n=num.toFixed(2);
	document.getElementById("amount").value=n;

}
</script>

<script type="text/javascript" src="resources/js/datetimepicker.js"></script>
<script type="text/javascript" src="resources/js/jquery-1.9.1.min.js"></script>

<h4 class="widgettitle">Add Expenses for <b><%=client.getClientNameById(Integer.parseInt(request.getParameter("cid"))) %></b></h4>
 <form class="stdform stdform2" method="post" action="ActionServlet" onsubmit="return checkOverflow() && dateCompare()">
					<table width="100%" border="1" class="tbl">
					  <tr>
						<td>
							<span>Client Name</span>
							<div>
							<input type="hidden" name="client" value="<%=request.getParameter("cid")%>"/>
							<select name="client_lise"  onchange="loadEstimate()" id="client" class="uniformselect" disabled="disabled">
							<option value="0">Choose Client</option>
<%
	ArrayList<ClientBO> itemPartList=null;
	Iterator<ClientBO> testIt;
	ClientBO clientItem;
	try{
		Client test= new Client();
		itemPartList=test.getAllItem();
		
		if(itemPartList != null){
			testIt = itemPartList.iterator();
			while(testIt.hasNext()){
				clientItem = (ClientBO)testIt.next();
%>								
<option 
	<% 
	if(request.getParameter("cid")!=null){
	if(Integer.parseInt(request.getParameter("cid"))==clientItem.getId())
		{
			out.print("selected='selected'");
	} 
	}
	%> 
	value="<%=clientItem.getId()%>">
		<%=clientItem.getClientName()%>
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
						<td>
							<span>For Estimate</span>
							<div>
							<select name="estimate" id="estimate" class="uniformselect" required="required"  onchange="loadService()" >
							</select>
							<div id="scheme_child_div" style="float:right;">
								</div>
							</div>
						</td>
					  </tr>
					  <tr>
						<td><input type="hidden" name="val" id="val" value="00000">
							<span>Service</span>
							<div>
							<select name="service" id="service" class="uniformselect"  required="required" onchange="loadSupplier()">
							

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
						<td>
							<span>Supplier</span>
							<div>
							<select name="supplier" required="required" id="supplier" class="uniformselect" >
							<option value="0">Choose Supplier</option>
							</select>
							</div>
						</td>					  
					  <tr>
						<td>
							<span>Quantity</span>
							<div>
							<input id="qty" class="input-small" type="text"  name="qty">
							</div>
						</td>
						<td>
							<span>Per Unit Price(<b>Rs.</b>)</span>
							<div>
							<input id="per_unit_price" value="0.00" class="input-small" type="text"  name="per_unit_price" onblur="calculate()">
							</div>
						</td>
					  </tr>
					  <tr>
						<td>
							<span>Total Amount(<b>Rs.</b>)</span>
							<div>
							<input id="amount" placeholder="0.00" class="input-small" type="text" required="required" name="amount">
							</div>
						</td>
						<td>
							<span>Bill Number</span>
							<div>
							<%
							Expenses expenses= new Expenses();
							%>
							<input id="bill_number" class="input-small" type="text" required="required" value="R-<%=expenses.getMaxId()+1 %>"  name="bill_number">
							
							</div>
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
							<span>Date</span>
							<div>
							<input type="text" value="<%= df.format(new java.util.Date()) %>" class="input-small datepicker hasDatepicker" name="datecreated" id="demo" /><a href="javascript:NewCal('demo','yyyymmdd')"><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
							<b>[YYYY-MM-DD]</b>
							</div>
						</td>
						<td>
							<span>Estimation Date</span>
							<div>
							<input type="text" value="" class="input-small datepicker hasDatepicker" readonly name="datecreated2" id="demo2" />
							<b>[YYYY-MM-DD]</b>
							</div>
						</td>
						</tr>
						<tr>
						<td>
							<span>Note</span>
							<textarea  name="note" rows="" cols=""></textarea>
						</td>
					  </tr>
					<tr>
					<td>
					<input type="checkbox" name="more_item_on_bill" id = "more_item_on_bill_id"/><b>Add More Item On Same Bill?</b>
					</td>
					</tr>  
					</table>		                      
					<p class="stdformbutton">
					
						<input type="hidden" name="todo" value="addOrder">
						
						<input type="hidden" name="userid" value="<%=session.getAttribute("id")%>">
						<button class="btn btn-primary" id="saveButton" >Save</button>
						<button class="btn" style="display:none" id="nextButton" >Enter</button>
						<button type="reset" class="btn">Reset Button</button>
					</p>
<div id="getOnOrderStatusdiv" style="height: 59px;"></div>	

</form>
<script>
loadEstimate();
$('#more_item_on_bill_id').change(function() {
    if($(this).is(":checked")) {
    	$('#saveButton').css('display','none');
        $('#nextButton').css('display','inline');
    } else {
    	$('#saveButton').css('display','inline');
        $('#nextButton').css('display','none');
    }
        
});
function getOnOrderStatus(eid)
{
	//alert(eid);
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
	    document.getElementById("getOnOrderStatusdiv").innerHTML=xmlhttp.responseText;
	   
	    }
	  }
	xmlhttp.open("GET","ActionServlet?todo=getOnOrderStatus&eid="+eid,true);
	xmlhttp.send();
}


function loadService()
{
	getChildList();
	document.getElementById("val").value=0;
	var eid= document.getElementById("estimate").value.split('_');
	//alert(eid[0]);
	getOnOrderStatus(eid[0]);
    document.getElementById("demo2").value=eid[2];
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
	xmlhttp.open("GET","ActionServlet?todo=getServiceLov&eid="+eid[0],true);
	xmlhttp.send();
}
function loadChildSchemeService()
{
	//getChildList();
	var eid1= document.getElementById("scheme_child_id").value;
	document.getElementById("val").value=document.getElementById("scheme_child_id").value;
	//getOnOrderStatus(eid1);

	//alert(eid1);
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
	xmlhttp.open("GET","ActionServlet?todo=getServiceLov5&eid="+eid1,true);
	xmlhttp.send();
}



function loadEstimate()
{
  // getChildList(this);
  //getChildList();
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
	   
	    }
	  }
	xmlhttp.open("GET","ActionServlet?todo=getSchemeLov&cid="+client,true);
	xmlhttp.send();
}


function loadSupplier()
{
	var service= document.getElementById("service").value;
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
	   
	    }
	  }
	xmlhttp.open("GET","ActionServlet?todo=getSupplierLov&serviceid="+service,true);
	xmlhttp.send();
}

 
 
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

function getChildList(){
	var eid= document.getElementById("estimate").value.split('_');
	//alert(eid[1]);
	//alert(document.getElementById("scheme_id").value);
	var scheme_id=eid[1] ;
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
	xmlhttp.open("GET","ActionServlet?todo=getChildScheme5&parent="+scheme_id+"&selectedchild=0",true);
	xmlhttp.send(); 
	
	
}

</script>                    
                    
                    
                    