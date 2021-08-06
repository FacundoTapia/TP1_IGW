<%-- 
    Document   : Articulos
    Created on : 23 abr. 2021, 16:40:40
    Author     : carlos
--%>

<%@page import="ar.org.centro8.curso.java.aplicaciones.entities.Articulo"%>
<%@page import="ar.org.centro8.curso.java.aplicaciones.repositories.interfaces.I_ArticuloRepository"%>
<%@page import="ar.org.centro8.curso.java.aplicaciones.repositories.list.ArticuloRepositoryFactory"%>
<%@page import="ar.org.centro8.curso.java.aplicaciones.enums.Temporada"%>
<%@page import="ar.org.centro8.curso.java.aplicaciones.enums.Tipo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%I_ArticuloRepository ar=ArticuloRepositoryFactory.getArticuloRepository(); %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Articulos</title>
        <link rel="stylesheet" type="text/css" href="css/style.css"/>
    </head>
    <body>
        <h1>Mantenimiento de Articulos</h1>
        <form>
            <table>
                <tr>
                    <td>Descripción: </td>
                    <td><input type="text" name="descripcion" minlength="3" maxlength="25" required  style="width: 200px;"/></td>
                </tr>
                <tr>
                    <td>Tipo: </td>
                    <td>
                        <select name="tipo"  style="width: 208px;">
                            <%
                                for(Tipo t: Tipo.values()){
                                    out.println("<option value='"+t.toString()+"' selected >"+t.toString().toLowerCase()+"</option>");
                                }
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Color: </td>
                    <td><input type="text" name="color" minlength="3" maxlength="20" required  style="width: 200px;"/></td>
                </tr>
                <tr>
                    <td>Talle / Num: </td>
                    <td><input type="text" name="talle_num" minlength="1" maxlength="20" required  style="width: 200px;"/></td>
                </tr>
                <tr>
                    <td>Stock: </td>
                    <td><input type="number" name="stock" min="0" max="100000" required  style="width: 200px;"/></td>
                </tr>
                <tr>
                    <td>Stock Mínimo: </td>
                    <td><input type="number" name="stockMin" min="0" max="100000" required  style="width: 200px;"/></td>
                </tr>
                <tr>
                    <td>Stock Máximo: </td>
                    <td><input type="number" name="stockMax" min="0" max="100000" required  style="width: 200px;"/></td>
                </tr>
                <tr>
                    <td>Costo: </td>
                    <td><input type="number" name="costo" min="0" max="100000" required  style="width: 200px;"/></td>
                </tr>
                <tr>
                    <td>Precio: </td>
                    <td><input type="number" name="precio" min="0" max="100000" required  style="width: 200px;"/></td>
                </tr>
                <tr>
                <td>Temporada: </td>
                    <td>
                        <select name="temporada"  style="width: 208px;">
                            <%
                                for(Temporada t: Temporada.values()){
                                    out.println("<option value='"+t.toString()+"' selected >"+t.toString().toLowerCase()+"</option>");
                                }
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><input type="reset" value="Borrar"/></td>
                    <td><input type="submit" value="Enviar"/></td>
                </tr>
            </table>
        </form>
                        
        <%
            try {
                String descripcion=request.getParameter("descripcion");
                Tipo tipo=Tipo.valueOf(request.getParameter("tipo"));
                String color=request.getParameter("color");
                String talle_num=request.getParameter("talle_num");
                int stock=Integer.parseInt(request.getParameter("stock"));
                int stockMin=Integer.parseInt(request.getParameter("stockMin"));
                int stockMax=Integer.parseInt(request.getParameter("stockMax"));
                double costo=Double.parseDouble(request.getParameter("costo"));
                double precio=Double.parseDouble(request.getParameter("precio"));
                Temporada temporada=Temporada.valueOf(request.getParameter("temporada"));
                Articulo articulo=new Articulo(descripcion, tipo, color, talle_num, stock, stockMin, stockMax, costo, precio, temporada);
                ar.save(articulo);
                if(articulo.getId()==0){
                    out.println("<h3>No se pudo dar de alta el articulo</h3>");
                }else{
                    out.println("<h3>Se guardo el articulo id: "+articulo.getId()+"</h3>");
                }
                /*
                    Falta Testear
                
                
                    mirar videos de JSTL JSp Tag Library
                
                
                */
                
                
            } catch (Exception e) {
                out.println("<h3>Falta Ingresar Parametros</h3>");
            }
        %>
        
    </body>
</html>
