<%-- 
    Document   : articulos
    Created on : 6 ago. 2021, 05:14:57
    Author     : Facu
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="ar.org.centro8.curso.java.connectors.Connector"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/styleArticulos.css"/>
        <title>Articulos</title>
    </head>
    <body>
        <h1>Alta de Articulos</h1>
        <form>
            <table id="tableAlta">
                <tr>
                    <td>Descripcion:</td>
                    <td><input type="text" name="descripcion" required style="width: 200px"/></td>
                </tr>
                <tr>
                    <td>Tipo:</td>
                    <td>
                        <select name="tipo" style="width: 208px">
                             <option value="CALZADO" selected>Calzado</option>
                             <option value="ROPA">Ropa</option>
                         </select>                         
                    </td>
                </tr>
                <tr>
                    <td>Color:</td>
                    <td><input type="text" name="color" required style="width: 200px"/></td>
                </tr>
                <tr>
                    <td>Talle:</td>
                    <td><input type="text" name="talle_num" required style="width: 200px"/></td>
                </tr>
                <tr>
                    <td>Stock:</td>
                    <td><input type="number" name="stock" style="width: 200px"/></td>
                </tr>
                <tr>
                    <td>Stock Minimo:</td>
                    <td><input type="number" name="stockMin" style="width: 200px"/></td>
                </tr>
                <tr>
                    <td>Stock Maximo:</td>
                    <td><input type="number" name="stockMax" style="width: 200px"/></td>
                </tr>                
                <tr>
                    <td>Costo:</td>
                    <td><input type="number" name="costo" style="width: 200px"/></td>
                </tr>                
                <tr>
                    <td>Precio:</td>
                    <td><input type="number" name="precio" style="width: 200px"/></td>
                </tr>      
                <tr>
                    <td>Temporada:</td>
                    <td>
                        <select name="temporada" style="width: 208px">
                             <option value="VERANO" selected>Verano</option>
                             <option value="OTOÑO">Otoño</option>
                             <option value="INVIERNO">Invierno</option>
                             <option value="PRIMAVERA">Primavera</option>
                         </select>                         
                    </td>
                </tr>                
                <tr>
                    <td>
                        <input type="reset" value="Borrar"/>
                        <input type="submit" value="Enviar"/>
                    </td>
                </tr>
            </table>
        </form>        
        
        <%
        
        try {
            String descripcion = request.getParameter("descripcion");
            String tipo = request.getParameter("tipo");
            String color = request.getParameter("color");
            String talle_num = request.getParameter("talle_num");
            int stock = Integer.parseInt(request.getParameter("stock"));
            int stockMin = Integer.parseInt(request.getParameter("stockMin"));
            int stockMax = Integer.parseInt(request.getParameter("stockMax"));
            double costo = Double.parseDouble(request.getParameter("costo"));
            double precio = Double.parseDouble(request.getParameter("precio"));
            String temporada = request.getParameter("temporada");
            
            try(PreparedStatement ps = Connector
                    .getConnection()
                    .prepareStatement("insert into articulos"
                            + "(descripcion, tipo, color, talle_num, stock, stockMin, stockMax, costo, precio, temporada) "
                            + "values(?,?,?,?,?,?,?,?,?,?);",
                            PreparedStatement.RETURN_GENERATED_KEYS)){
                    ps.setString(1, descripcion);
                    ps.setString(2, tipo);
                    ps.setString(3, color);
                    ps.setString(4, talle_num);
                    ps.setInt(5, stock);
                    ps.setInt(6, stockMin);
                    ps.setInt(7, stockMax);
                    ps.setDouble(8, costo);
                    ps.setDouble(9, precio);
                    ps.setString(10, temporada);
                    ps.execute();

                    int id = 0;
                    ResultSet rs = ps.getGeneratedKeys();
                    while (rs.next()) id = rs.getInt(1);
                    if (id == 0) {
                        out.println("<h3>No se pudo dar de alta el cliente</h3>");
                    } else {
                        out.println("<h3>El cliente se dio de alta con el id:" + id + "</h3>");
                    }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
            out.println("<h3>Error de parametros</h3>");
        }

        %>
        
        <hr>
        
        <h2>Busqueda de Articulos</h2>
        
        <form id="formBusqueda">
            Buscar Descripcion: <input type="text" name="buscarDescripcion"/>
            Buscar Color: <input type="text" name="buscarColor"/>
            Buscar Talle: <input type="text" name="buscarTalleNum"/>
            <input type="reset" value="Borrar"/>
            <input type="submit" value="Enviar"/>
        </form>
        
        <br>
        
        <%
        
            try {
                
                String buscarDescripcion = request.getParameter("buscarDescripcion");
                String buscarColor = request.getParameter("buscarColor");
                String buscarTalle = request.getParameter("buscarTalle");
                
                if (buscarDescripcion == null) buscarDescripcion = ""; 
                if (buscarColor == null) buscarColor = ""; 
                if (buscarTalle == null) buscarTalle = "";
                
                try(ResultSet rs = Connector
                        .getConnection()
                        .createStatement()
                        .executeQuery("select * from articulos where descripcion like '%"+buscarDescripcion+"%' and color like '%"+buscarColor+"%' and talle_num like '%"+buscarTalle+"%';")){
                    
                    out.println("<table id='tablaBD'>");
                    out.println("<tr>");
                    out.println("<th>ID</th>");
                    out.println("<th>Descripcion</th>");
                    out.println("<th>Tipo</th>");
                    out.println("<th>Color</th>");
                    out.println("<th>Talle</th>");
                    out.println("<th>Stock</th>");
                    out.println("<th>Stock Minimo</th>");
                    out.println("<th>Stock Maximo</th>");
                    out.println("<th>Costo</th>");
                    out.println("<th>Precio</th>");
                    out.println("<th>Temporada</th>");
                    out.println("</tr>");
                    
                    
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>"+rs.getInt("id")+"</td>");
                        out.println("<td>"+rs.getString("descripcion")+"</td>");
                        out.println("<td>"+rs.getString("tipo")+"</td>");
                        out.println("<td>"+rs.getString("color")+"</td>");
                        out.println("<td>"+rs.getString("talle_num")+"</td>");
                        out.println("<td>"+rs.getInt("stock")+"</td>");
                        out.println("<td>"+rs.getInt("stockMin")+"</td>");
                        out.println("<td>"+rs.getInt("stockMax")+"</td>");
                        out.println("<td>"+rs.getDouble("costo")+"</td>");
                        out.println("<td>"+rs.getDouble("precio")+"</td>");
                        out.println("<td>"+rs.getString("temporada")+"</td>");
                        out.println("</tr>");
                    }
                    
                    out.println("</table>");
                    
                } catch (Exception e) {
                    System.out.println(e);
                    out.println("<h3>Error al recibir los parametros</h3>");
                }
                
            } catch (Exception e) {
                out.println("<h3>Error de parametros</h3>");
                System.out.println(e);
            }
        
        %>
        
    </body>
</html>
