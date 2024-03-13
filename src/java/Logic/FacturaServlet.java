/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Logic;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author isaac
 */
@WebServlet(name = "FacturaServlet", urlPatterns = {"/FacturaServlet"})
public class FacturaServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static ArrayList<FacturaItem> facturaItems = new ArrayList<>();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los datos enviados desde el cliente
        long idfacturas = Long.parseLong(request.getParameter("idfactura"));
        String productNames = request.getParameter("productName");
        int productos = Integer.parseInt(request.getParameter("pro"));
        int quantitys = Integer.parseInt(request.getParameter("quantity"));
        double costt = Double.parseDouble(request.getParameter("cost"));
        double subtotals = quantitys * costt;
        double IVAs = subtotals * 0.19;
        int totals = (int) (subtotals + IVAs);

        // Crear un nuevo FacturaItem y agregarlo al ArrayList
        FacturaItem facturaItem = new FacturaItem(idfacturas, productNames, productos, quantitys, costt, subtotals, IVAs, totals);
        facturaItems.add(facturaItem);

        // Construir la respuesta JSON
        String jsonResponse = "{\"success\": true, \"message\": \"Item añadido exitosamente\"}";

        // Enviar la respuesta JSON al cliente
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
    }

    // Métodos adicionales para obtener y devolver el ArrayList si es necesario
}

class FacturaItem {

    private long idfactura;
    private String productName;
    private int producto;
    private int quantity;
    private double cost;
    private double subtotal;
    private double IVA;
    private int total;

    public FacturaItem(long idfactura, String productName, int producto, int quantity, double cost, double subtotal, double IVA, int total) {
        this.idfactura = idfactura;
        this.productName = productName;
        this.producto = producto;
        this.quantity = quantity;
        this.cost = cost;
        this.subtotal = subtotal;
        this.IVA = IVA;
        this.total = total;
    }

    // Getters y setters si es necesario
}
