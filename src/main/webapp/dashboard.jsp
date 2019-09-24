  <%@ include file="common/head.jsp" %>
  <%@page import="java.util.*"%>
    <div class="rightpanel" style="margin-left: 260px;">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>Dashboard</li>
        </ul>
        
        <div class="pageheader" style="background-color:cadetblue">
            <div class="pageicon"><span class="iconfa-laptop"></span></div>
            <div class="pagetitle">
                <h5 style="color: black;">All Features Are Here</h5>
                <h1>Dashboard</h1>
            </div>
        </div>
        <%
        ArrayList<String> permissions = (ArrayList<String>)session.getAttribute("permissions");
        String userName= (String)session.getAttribute("userName");
        System.out.print("permission in jsp page");
        System.out.print(permissions.toString());
        %>
        <div class="maincontent">
            <div class="maincontentinner">
                <div class="row-fluid">
                    <div id="dashboard-left" class="span12">				
					
                        <ul class="shortcuts">
                        	<% if(permissions.contains("client.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                            <li class="archive">
                                <a href="client.jsp" style="text-align: center;">
                                   <!--  <span class="shortcuts-icon iconsi-archive"></span> -->
                                    <span class="shortcuts-label">Clients Dashboard</span>
                                </a>
                            </li>
                            <%}
                            if(permissions.contains("scheme.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                            <li class="archive" style="text-align: center;">
                                <a href="scheme.jsp"  style="text-align: center;">
                                    <span class="shortcuts-label">Scheme Dashboard</span>
                                </a>
                            </li>
                            <%}
                            if(permissions.contains("reference.jsp") || "admin".equalsIgnoreCase(userName)) { %>
							 <li class="archive">
                                <a href="reference.jsp"  style="text-align: center;">
                                    <!-- <span class="shortcuts-icon iconsi-archive"></span> -->
                                    <span class="shortcuts-label">Reference Master</span>
                                </a>
                            </li>
                            <%}
                            if(permissions.contains("supplier.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                            <li class="archive" style="text-align: center;">
                                <a href="supplier.jsp">
                                    <span class="shortcuts-label">Supplier Master</span>
                                </a>
                            </li>
                            <%}
                            if(permissions.contains("municipality.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                            <li class="archive" style="text-align: center;">
                                <a href="municipality.jsp">
                                    <span class="shortcuts-label">Municipality Master</span>
                                </a>
                            </li>
                            <%} 
                            if(permissions.contains("bank.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                            <li class="archive" style="text-align: center;">
                                <a href="bank.jsp">
                                    <span class="shortcuts-label">Bank <br> Master</span>
                                </a>
                            </li>
                             <%} 
                            if(permissions.contains("office_expenses.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                            <li class="archive" style="text-align: center;">
                                <a href="office_expenses.jsp">
                                    <span class="shortcuts-label">Office Exp.</span>
                                </a>
                            </li>
                             <%} 
                            if(permissions.contains("mouja.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                            <li class="archive" style="text-align: center;">
                                <a href="mouja.jsp">
                                    <span class="shortcuts-label">Mouja Master</span>
                                </a>
                            </li>
                             <%} 
                            if(permissions.contains("police_station.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                            <li class="archive" style="text-align: center;">
                                <a href="police_station.jsp">
                                    <span class="shortcuts-label">Police Station Master</span>
                                </a>
                            </li>
                             <%} 
                            if(permissions.contains("district.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                             <li class="archive" style="text-align: center;">
                                <a href="district.jsp">
                                    <span class="shortcuts-label">District Master</span>
                                </a>
                            </li>
                             <%} 
                            if(permissions.contains("report_by_scheme.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                             <li class="archive" style="text-align: center;">
                                <a href="report_by_scheme.jsp">
                                    <span class="shortcuts-label">Report By Scheme  and  Date</span>
                                </a>
                            </li>
                             <%} 
                            if(permissions.contains("report_profit_loss.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                            <li class="archive" style="text-align: center;">
                                <a href="report_profit_loss.jsp">
                                    <span class="shortcuts-label">Profit & loss Report</span>
                                </a>
                            </li>
                             <%} 
                            if(permissions.contains("report_by_supplier_select.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                             <li class="archive" style="text-align: center;">
                                <a href="report_by_supplier_select.jsp">
                                    <span class="shortcuts-label">Report By Supplier</span>
                                </a>
                            </li>
                             <%} 
                            if(permissions.contains("projects.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                            <li class="archive" style="text-align: center;">
                                <a href="projects.jsp">
                                    <span class="shortcuts-label">Project Dashboard</span>
                                </a>
                            </li>
                           <%} 
                            if(permissions.contains("investor.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                            <li class="archive" style="text-align: center;">
                                <a href="investor.jsp">
                                    <span class="shortcuts-label">Investor Master</span>
                                </a>
                            </li>
                             <%} 
                            if(permissions.contains("buyer.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                            <li class="archive" style="text-align: center;">
                                <a href="buyer.jsp">
                                    <span class="shortcuts-label">Buyer Master</span>
                                </a>
                            </li>
                             <%} 
                            if(permissions.contains("gst.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                            <li class="archive" style="text-align: center;">
                                <a href="gst.jsp">
                                    <span class="shortcuts-label">GST Master</span>
                                </a>
                            </li>
                             <%} 
                            if(permissions.contains("gst_report_by_scheme.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                            <li class="archive" style="text-align: center;">
                                <a href="gst_report_by_scheme.jsp">
                                    <span class="shortcuts-label">GST Report</span>
                                </a>
                            </li>
                             <%} 
                            if(permissions.contains("developer.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                             <li class="archive" style="text-align: center;">
                                <a href="developer.jsp">
                                    <span class="shortcuts-label">Developer Master</span>
                                </a>
                            </li>
                             <%} 
                            if(permissions.contains("emailSender.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                             <li class="archive" style="text-align: center;">
                                <a href="emailSender.jsp">
                                    <span class="shortcuts-label">Email Sender</span>
                                </a>
                            </li>
                             <%} 
                            if(permissions.contains("user_management.jsp") || "admin".equalsIgnoreCase(userName)) { %>
                            <li class="archive" style="text-align: center;">
                                <a href="user_management.jsp">
                                    <span class="shortcuts-label">User Management</span>
                                </a>
                            </li>
                            <%} %>
                        </ul>
                        
                        
                        <div class="divider30"></div>
                        <br />
                    </div><!--span8-->
                </div><!--row-fluid-->
                

  <%@ include file="common/foot.jsp" %>