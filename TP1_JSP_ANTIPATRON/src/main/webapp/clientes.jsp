<%-- 
    Document   : clientes.jsp
    Created on : 6 ago. 2021, 01:26:44
    Author     : Facu
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="ar.org.centro8.curso.java.connectors.Connector"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Clientes</title>
    </head>
    <body>
        <h1>Mantenimiento de clientes</h1>
        <form>
            <table>
                <tr>
                    <td>Nombre:</td>
                    <td><input type="text" name="nombre" required style="width: 200px"/></td>
                </tr>
                <tr>
                    <td>Apellido:</td>
                    <td><input type="text" name="apellido" required style="width: 200px"/></td>
                </tr>
<!--                <tr>
                    <td>Edad:</td>
                    <td><input type="number" min="18" max="120" name="edad" style="width: 200px"/></td>
                </tr>-->
                <tr>
                    <td>Direccion:</td>
                    <td><input type="text" name="direccion" style="width: 200px"/></td>
                </tr>
                <tr>
                    <td>Email:</td>
                    <td><input type="email" name="email" style="width: 200px"/></td>
                </tr>
                <tr>
                    <td>Telefono:</td>
                    <td><input type="text" name="telefono" style="width: 200px"/></td>
                </tr>
                <tr>
                    <td>Tipo de Documento:</td>
                    <td>
                        <select name="tipoDocumento" style="width: 208px">
                             <option value="DNI" selected>DNI</option>
                             <option value="LIBRETA_ENROLAMIENTO">LIBRETA_ENROLAMINETO</option>
                             <option value="LIBRETA_CIVICA">LIBRETA_CIVICA</option>
                             <option value="PASS">PASS</option>
                         </select>                           
                    </td>
                </tr>
                <tr>
                    <td>Numero Documento:</td>
                    <td><input type="text" name="numeroDocumento" required style="width: 200px"/></td>
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
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                //int edad = Integer.parseInt(request.getParameter("edad"));
                String direccion = request.getParameter("direccion");
                String email = request.getParameter("email");
                String telefono = request.getParameter("telefono");
                String tipoDocumento = request.getParameter("tipoDocumento");
                String numeroDocumento = request.getParameter("numeroDocumento");

//                if(nombre != null && !nombre.isEmpty() && apellido != null && !apellido.isEmpty())
//                {
                    try(PreparedStatement ps = 
                            Connector.getConnection().prepareStatement("insert into clientes"
                            + "(nombre, apellido, direccion, email, telefono, tipoDocumento, numeroDocumento) "
                            + "values(?,?,?,?,?,?,?)",
                                    PreparedStatement.RETURN_GENERATED_KEYS)){
                            ps.setString(1, nombre);
                            ps.setString(2, apellido);
                            //ps.setInt(3, edad);
                            ps.setString(3, direccion);
                            ps.setString(4, email);
                            ps.setString(5, telefono);
                            ps.setString(6, tipoDocumento);
                            ps.setString(7, numeroDocumento);
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
                        //out.println("<h3></h3>");
                    }
//                }
                
            } catch (Exception e) {
                out.println("<h3>Faltan parametros</h3>");
            }
        
        %>
        
        <hr>
        
        <form>
            Buscar por apellido:            <input type="text" name="buscarApellido">
            Buscar por numero de documento: <input type="text" name="buscarNumeroDocumento"><br>
            <input type="reset" value="Borrar"/>
            <input type="submit" value="Enviar"/>
        </form>
        
        <br>
        
        <%
        
        try {
                
            String buscarApellido = request.getParameter("buscarApellido");
            String buscarNumeroDocumento = request.getParameter("buscarNumeroDocumento");
            
            if(buscarApellido == null) buscarApellido = "";
            if(buscarNumeroDocumento == null) buscarNumeroDocumento = "";
            
            try(ResultSet rs = Connector.getConnection().createStatement()
                    .executeQuery("select * from clientes where apellido like '%"+buscarApellido+"%' and numeroDocumento like '%"+buscarNumeroDocumento+"%' "))
            {
                    out.println("<table border=1>");
                    out.println("<tr>");
                    out.println("<th>ID</th>");
                    out.println("<th>Nombre</th>");
                    out.println("<th>Apellido</th>");
                    out.println("<th>Direccion</th>");
                    out.println("<th>Email</th>");
                    out.println("<th>Telefono</th>");
                    out.println("<th>Tipo Documento</th>");
                    out.println("<th>Numero Documento</th>");
                    out.println("</tr>");
                    
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>"+rs.getInt("id")+"</td>");
                        out.println("<td>"+rs.getString("nombre")+"</td>");
                        out.println("<td>"+rs.getString("apellido")+"</td>");
                        out.println("<td>"+rs.getString("direccion")+"</td>");
                        out.println("<td>"+rs.getString("email")+"</td>");
                        out.println("<td>"+rs.getString("telefono")+"</td>");
                        out.println("<td>"+rs.getString("tipoDocumento")+"</td>");
                        out.println("<td>"+rs.getString("numeroDocumento")+"</td>");
                        out.println("</tr>");                            
                    }
                    
                    out.println("</table>");
            } catch (Exception e) {
                System.out.println(e);
                out.println("<h3>Ocurrio un error</h3>");            
            }
        } catch (Exception e) {
            System.out.println(e);
            out.println("<h3>Ocurrio un error con los parametros</h3>");
        }
        
        %>
        
    </body>
</html>
