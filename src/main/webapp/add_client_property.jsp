<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<style>
.stdform select {
    background: none repeat scroll 0 0 #D9271D;
    border: 1px solid #BBBBBB;
    color: #FFFFFF;
    padding: 5px 2px;
    width: 220px;
}
</style>
<%
Client client= new Client();
int cid= Integer.parseInt(request.getParameter("cid"));
java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); 
String client_name=client.getClientNameById(cid);
%>

<script type="text/javascript" src="resources/js/datetimepicker.js"></script>

<h4 class="widgettitle">Add Property Details of :<b> <%=client_name %></b></h4>
 <form class="stdform stdform2" method="post" action="ActionServlet">
 
 <%-- <select>
<%
int cid= Integer.parseInt(request.getParameter("cid"));
 
ArrayList<EstimateBO> estimateList=null;
Iterator<EstimateBO> estimateIt;
EstimateBO estimateItem;
try{
	Estimate estimate= new Estimate();
	estimateList=estimate.getAllItem(cid);
	
	if(estimateList != null){
		estimateIt = estimateList.iterator();
		while(estimateIt.hasNext()){
			estimateItem = (EstimateBO)estimateIt.next();
%>

<option>
<% Scheme scheme= new Scheme(); %>
<%=scheme.getSchemeNameById(estimateItem.getSchemeId())%>
:  [  <%=estimateItem.getAmount() %>  ]
</option>

<%
	
		}
	}}
	catch(Exception e){
		
		e.printStackTrace();
	}
%>
 </select> --%>
 
					<table width="100%" border="1" class="tbl">
					  <tr>
						<td colspan=2>
							<span>Mouja</span>
							<div>
								<select name="mouja" id="mouja" class="uniformselect" required="required">
								<option value="0">Select Mouja</option>
<%
	ArrayList<MoujaBO> moujaList=null;
	Iterator<MoujaBO> moujaIt;
	MoujaBO moujaBO;
	try{
		Mouja mouja= new Mouja();
		moujaList=mouja.getAllItem();
		if(moujaList != null){
			moujaIt = moujaList.iterator();
			while(moujaIt.hasNext()){
				moujaBO = (MoujaBO)moujaIt.next();
%> 
	<option value="<%=moujaBO.getId() %>"><%=moujaBO.getMoujaName() %></option>

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
							<span>Dag No</span>
							<div>
								<input type="text" name="dag_no" id="dag_no" class="input-large" required="required" />
							</div>
						</td>
					  </tr>
					  <tr>
						<td colspan=2>
							<span>Khatian No</span>
							<div>
								<input type="text" name="khatian" id="khatian" class="input-large" required="required" />
							</div>
						</td>
						<td colspan=2>
							<span>J.L. No</span>
							<div>
								<input type="text" name="jl_no" id="ja_no" class="input-large" required="required" />
							</div>
						</td>
					  </tr>
					  <tr>
						<td colspan=2>
							<span>Touji No</span>
							<div>
								<input type="text" name="touji" id="touji" class="input-large" required="required" />
							</div>
						</td>
						<td colspan=2>
							<span>Word No</span>
							<div>
								<input type="text" name="word" id="word" class="input-large" required="required" />
							</div>
						</td>
					  </tr>
					  <tr>
						<td colspan=2>
							<span>Police Station</span>
							<div>
								<select name="police" id="police" class="uniformselect" required="required">
								<option value="0">Select Police Station</option>
<%
	ArrayList<PoliceStationBO> policeStationList=null;
	Iterator<PoliceStationBO> policeStationIt;
	PoliceStationBO policeStationBO;
	try{
		PoliceStation policeStation= new PoliceStation();
		policeStationList=policeStation.getAllItem();
		if(policeStationList != null){
			policeStationIt = policeStationList.iterator();
			while(policeStationIt.hasNext()){
				policeStationBO = (PoliceStationBO)policeStationIt.next();
%>
	<option value="<%=policeStationBO.getId() %>"><%=policeStationBO.getPoliceStationName() %></option>
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
							<span>District</span>
							<div>
								<select name="district" id="district" class="uniformselect" required="required">
								<option value="0">Select District</option>
<%
	ArrayList<DistrictBO> districtList=null;
	Iterator<DistrictBO> districtIt;
	DistrictBO districtBO;
	try{
		District district= new District();
		districtList=district.getAllItem();
		if(districtList != null){
			districtIt = districtList.iterator();
			while(districtIt.hasNext()){
				districtBO = (DistrictBO)districtIt.next();
%> 
<option value="<%=districtBO.getId() %>"><%=districtBO.getDistrictName() %></option>

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
					<!--   <tr>
						<td colspan=2>
							<span>Bigha</span>
							<div>
								<input type="text" name="bigha" id="bigha" class="input-large" required="required" />
							</div>
						</td>
						<td colspan=2>
							<span>Sq. Ft.</span>
							<div>
								<input type="text" name="sq_ft" id="sq_ft" class="input-large" required="required" />
							</div>
						</td>
					  </tr>
					  <tr>
						<td colspan=2>
							<span>Katha</span>
							<div>
								<input type="text" name="katha" id="katha" class="input-large" required="required" />
							</div>
						</td>
						<td colspan=2>
							&nbsp;
						</td>
					  </tr>
					  <tr>
						<td colspan=2>
							<span>Chatak</span>
							<div>
								<input type="text" name="chatak" id="chatak" class="input-large" required="required" />
							</div>
						</td>
						<td colspan=2>
							&nbsp;
						</td>
					  </tr> -->
					  <tr>
					  	<td>
					  	<span>Bigha</span>
					  	<input type="text" onblur="calculate()" value="0" name="bigha" id="bigha" class="input-small" required="required" />
					  	</td>
					  	<td>
					  	<span>Katha</span>
					  	<input type="text" onblur="calculate()"   value="0"  name="katha" id="katha" class="input-small" required="required" />
					  	</td>
					  	<td>
					  	<span>Chatak</span>
					  	<input type="text" onblur="calculate()"   value="0"  name="chatak" id="chatak" class="input-small" required="required" />
					  	</td>
					  	<td>
					  	<span>Sq Ft</span>
					  	<input type="text" onblur="calculate()"  value="0" name="sq_ft" id="sq_ft" class="input-small" required="required" />
					  	</td>
					  </tr>
					  <tr>
					    <td colspan=2>
							<span>Total Sq Ft.</span>
							<div>
								<input type="text" value=""  name="total_sq_ft" id="total_sq_ft" class="input-large" required="required" />
							</div>
						</td>
						<td colspan=2>
							<span>Total Sq. Mtr.</span>
							<div>
								<input type="text" value=""  name="total_sq_mtr" id="total_sq_mtr" class="input-large" required="required" />
							</div>
						</td>
					  </tr>
					  
					  <tr>
						<td colspan=2>
							<span>Date Of Deposit</span>
							<div>
								<input type="text" value="<%= df.format(new java.util.Date()) %>"  name="date_of_deposit"  class="input-large" required="required" id="demo" /><a href="javascript:NewCal('demo','yyyymmdd')"><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
							</div>
						</td>
						<td colspan=2>
							<span>Date Of Sanction</span>
							<div>
								<input type="text" value="<%= df.format(new java.util.Date()) %>" name="date_of_sanction"  class="input-large" required="required" id="demo1" /><a href="javascript:NewCal('demo1','yyyymmdd')"><img src="resources/images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
							</div>
						</td>
					  </tr>
					   <tr>
						<td colspan=2>
							<span>Remarks</span>
							<div>
								<textarea name="remarks"></textarea>
							</div>
						</td>
						<td colspan=2>
							&nbsp;
						</td>
					  </tr>
					</table>		                      
					<p class="stdformbutton">
						<input type="hidden" name="todo" value="addClientProperty">
						<input type="hidden" name="cid" value="<%=cid %>">
						<button class="btn btn-primary">Save</button>
						<button type="reset" class="btn">Reset Button</button>
					</p>
                    </form>



<script type="text/javascript" src="resources/js/jquery-1.10.2.js"></script>
<script>
$(function() {
    $('#bigha,#katha,#chatak,#sq_ft').blur(function(e) {
       // if(e.which == 13) {
            calculate();
       // }
    });
});

$("#bigha,#katha,#chatak,#sq_ft").keydown(function(event) {
	// Allow: backspace, delete, tab, escape, enter and .
	if ( $.inArray(event.keyCode,[46,8,9,27,13,190]) !== -1 ||
		 // Allow: Ctrl+A
		(event.keyCode == 65 && event.ctrlKey === true) || 
		 // Allow: home, end, left, right
		(event.keyCode >= 35 && event.keyCode <= 39)) {
			 // let it happen, don't do anything
			 return;
	}
	else {
		// Ensure that it is a number and stop the keypress
		if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105 )) {
			event.preventDefault(); 
		}   
	}
});

function calculate()
{
var cur_bigha=0.00;
var cur_katha=0.00;
var cur_chatak=0.00;
var cur_sq_ft=0.00;
var cur_total_sq_ft=0.00;
	
var bigha=0.00;
var katha=0.00;
var chatak=0.00;
var sq_ft=0.00;
var total_sq_ft=0.00;


cur_bigha=parseInt($('#bigha').val());
cur_katha=parseInt($('#katha').val());
cur_chatak=parseInt($('#chatak').val());
cur_sq_ft=parseInt($('#sq_ft').val());


if(cur_sq_ft>=45)
	{
	cur_sq_ft=parseInt($('#sq_ft').val());
	cur_chatak=parseInt($('#chatak').val());
	sq_ft=cur_sq_ft%45;
	chatak=(cur_chatak+(cur_sq_ft-sq_ft)/45);
	$('#chatak').val(chatak);
	$('#sq_ft').val(sq_ft);
	}

if(cur_chatak>=16)
	{
	cur_katha=parseInt($('#katha').val());
	cur_chatak=parseInt($('#chatak').val());		
	chatak=cur_chatak%16;
	katha=(cur_katha+(cur_chatak-chatak)/16);
	$('#katha').val(katha);
	$('#chatak').val(chatak);
	}

if(cur_katha>=20)
	{
	cur_katha=parseInt($('#katha').val());
	cur_bigha=parseInt($('#bigha').val());		
	katha=cur_katha%20;
	bigha=(cur_bigha+(cur_katha-katha)/20);
	$('#katha').val(katha);
	$('#bigha').val(bigha);
	}

bigha=parseInt($('#bigha').val());
katha=parseInt($('#katha').val());
chatak=parseInt($('#chatak').val());
sq_ft=parseInt($('#sq_ft').val());

total_sq_ft=(20*720*bigha);
total_sq_ft=total_sq_ft+(720*katha);
total_sq_ft=total_sq_ft+(45*chatak);
total_sq_ft=total_sq_ft+sq_ft;
$('#total_sq_ft').val(total_sq_ft);

total_sq_mtr=total_sq_ft/10.764;
$('#total_sq_mtr').val(total_sq_mtr.toFixed(2));



}
</script>


                    



                    
