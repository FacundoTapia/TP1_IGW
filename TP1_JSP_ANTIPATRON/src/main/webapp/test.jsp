<%-- 
    Document   : test
    Created on : 6 ago. 2021, 00:35:17
    Author     : Facu
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        
        <%
            //codigo java
            out.println("<h2>Hola mundo JSP!</h2>");
            System.out.println("Esto sale por consola del servidor");
            
            int x = 0;
        %>
        
        <hr>
        
        <%
            System.out.println("x: " + x);
            
            List<String> list = new ArrayList();
            list.add("Primavera");
            list.add("Verano");
            list.add("Invierno");
            list.add("Otoño");
            
            list.forEach(System.out::println);
            try {
                String nombre = request.getParameter("nombre");
                int edad = Integer.parseInt(request.getParameter("edad"));
                out.println("<h3>Hola " + nombre + ", su edad es " + edad + "?");                    
            } catch (Exception e) {
                System.out.println(e);
            }
        %>
        
    </body>
</html>