<%@ page session="true" %>
<%
    session.invalidate(); // destroy the session
    response.sendRedirect("index.jsp"); // redirect to home page
%>
