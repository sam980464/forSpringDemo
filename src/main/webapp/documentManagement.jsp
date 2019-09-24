<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@ include file="common/head.jsp" %>

    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>Document Management</li>
        </ul>


        <div class="maincontent">
            <div class="maincontentinner">
<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Upload Document</h4>
         <div class="widgetcontent">
          <form>
<table  class="tbl" width="100%" border="1">
<tr>

<td style="padding-left:20%">
	<span>Document's Note </span>
	<div>
	<textarea rows="4" cols="50"></textarea>
	</div>	
</td>
</tr>
<tr>
<td style="padding-left:20%">
	<span>Upload Document </span>
	<div>
	<input id="datepicker2" type="file" name="to" class="input-small "  />
	</div>	
</td>




 </tr>
 
</table>
</form>


</div>     
           
    	</div>
</div>

<div class="widget" id="client_not_selected">
         <h4 class="widgettitle">Uploaded Documents</h4>
         <div class="widgetcontent">
            
 <table id="exportCSV" class="table table-bordered responsive">
	 <colgroup>
	   <col class="con0" style="align: center; width: 4%" />
	    <col class="con1" />
	    <col class="con0" />
		<col class="con1" />
	</colgroup>
	<thead>
            <tr>
              	<th class="head0 nosort"><input type="checkbox" class="checkall" /></th>
              	<th class="head0">No.</th>
              	<th class="head1">Document's Note </th>
              	<th class="head0">Uploaded Date</th>
              	<th class="head1">File Name</th>
              	<th class="head0">Options</th>
              	        	
          	</tr>
           </thead>
                           
 
    	<tr>
    		<td class="aligncenter"><span class="center"><input type="checkbox" /></span></td>
    		<td><%=1 %></td>
    		
    		<td><%="PLAN Document" %></td>
    		
    		<td>    		
    		<%="21-09-2018"%>
    		</td>		
    		<td>
    		<%="ajit_kumar_plan.dxf"%>
    		</td>
    		<td>
	    		<a href="#" class="color cboxElement">Download</a> | 
				<a href="#" class="color cboxElement">Delete</a> | 
				<a href="#" class="color cboxElement">Send Mail To Client</a> 
    		</td>
    		
    		
    		
    		
    			
    	</tr>
				    							
                  
</table>
    	</div><!--widgetcontent-->
</div>



<br>


<%@ include file="common/foot.jsp" %>



