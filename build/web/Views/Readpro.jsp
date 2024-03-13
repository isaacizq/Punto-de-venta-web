<%@page import="Logic.venta"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Logic.Productos"%>
<%@page import="Controller.ProductosJpaController"%>
<%
    int codigo = Integer.parseInt(request.getParameter("codigo"));
    int cantidad = Integer.parseInt(request.getParameter("cantidad"));
    ProductosJpaController control = new ProductosJpaController();
    Productos obj = control.findProductos(codigo);

    HttpSession cecion = request.getSession();
    List<venta> lista = (ArrayList<venta>) cecion.getAttribute("lista");

    if (obj != null) {
        if (lista == null) {
            lista = new ArrayList();
            venta productocant = new venta(obj, cantidad);
            lista.add(productocant);
            cecion.setAttribute("lista", lista);
        } else {
            int bandera = 0;
            for (int i = 0; i < lista.size(); i++) {

                if (lista.get(i).getProducto().getCodigo() == codigo) {
                    int nueva = lista.get(i).getCantidad() + cantidad;
                    lista.get(i).setCantidad(nueva);
                    cecion.setAttribute("lista", lista);
                    bandera = 1;
                    break;
                }

            }

            if (bandera == 0) {
                venta productocant = new venta(obj, cantidad);
                lista.add(productocant);
                cecion.setAttribute("lista", lista);
            }
        }

        if (lista != null) {
            double total = 0.0;
            for (int i = 0; i < lista.size(); i++) {
            
                out.print("<tr><td>" + lista.get(i).getProducto().getCodigo() + "</td><td>" + lista.get(i).getProducto().getNombre() + "</td><td>" + lista.get(i).getCantidad() + "</td><td>" + lista.get(i).getProducto().getPrecioUnitario() + "</td><td>" + lista.get(i).getProducto().getPrecioUnitario() * lista.get(i).getCantidad() + "</td></tr>");
                total=total+lista.get(i).getProducto().getPrecioUnitario()*lista.get(i).getCantidad();
            }
            out.print("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><th>Total</th><td>"+total+"</td</tr>");
            double iva = total*0.19;
            out.print("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><th>IVA</th><td>"+iva+"</td</tr>");
            double stotal = total+iva;
            out.print("<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><th>Total a pagar</th><td>"+stotal+"</td</tr>");
        }

    }

%>