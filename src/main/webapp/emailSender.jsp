<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.bo.*"%>
<%@page import="com.dao.*"%>
<%@page import="java.util.*"%>
<%@ include file="common/head.jsp" %>

    <div class="rightpanel">
        <ul class="breadcrumbs">
            <li><a href="dashboard.html"><i class="iconfa-home"></i></a> <span class="separator"></span></li>
            <li>Email Sender</li>
        </ul>


        <div class="maincontent">
            <div class="maincontentinner">
				<div class="widget" id="client_not_selected">
				   <h4 class="widgettitle">Email Sender</h4>
				   <div class="widgetcontent">
				   	<form action="ActionServlet" method="post" >
					<table border="0" width="60%" align="center">
						<caption><h2>Send New E-mail</h2></caption>
						<tr>
							<td width="50%">Recipient address </td>
							<td><input type="text" name="recipient" size="50"/></td>
						</tr>
						<tr>
							<td>Subject </td>
							<td><input type="text" name="subject" size="50"/></td>
						</tr>
						<tr>
							<td>Content </td>
							<td><textarea rows="10" cols="39" name="content"></textarea> </td>
						</tr>
						<tr>
							<td>Attach file </td>
							<td><input type="file" name="file" size="50" /></td>
						</tr>
						<tr>
							<td colspan="2" align="center"><input type="submit" value="Send"/></td>
						</tr>
					</table>	
					<input type="hidden" name="todo" value="sendMail" />
				</form>

				   </div> 
	    		</div>
			</div>
			<%@ include file="common/foot.jsp" %>
			
		</div>
	</div>	







