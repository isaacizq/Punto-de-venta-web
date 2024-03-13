package Logic;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;

import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

import net.sf.jasperreports.engine.util.JRLoader;

import net.sf.jasperreports.view.JasperViewer;

/**
 *
 * @author isaac
 */
public class conecctionDB {

    private Connection conect;

    public void GetReport(String rutasReport) {

        try {
            conect = DriverManager.getConnection("jdbc:mysql://localhost:3306/punto_venta", "root", "5108");
            String ruta = getClass().getResource(rutasReport).getPath();

            // Este código compila el informe
            JasperReport reporte = (JasperReport) JRLoader.loadObjectFromFile(ruta);

            JasperPrint rimprimir = JasperFillManager.fillReport(reporte, null, conect);
            JasperViewer.viewReport(rimprimir, false);

        } catch (SQLException ex) {
            java.util.logging.Logger.getLogger(conecctionDB.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (JRException ex) {
            java.util.logging.Logger.getLogger(conecctionDB.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }

    }

    public void GetReport_date(String rutasReport, Date fecha) {
        try {
            conect = DriverManager.getConnection("jdbc:mysql://localhost:3306/punto_venta", "root", "5108");
            String ruta = getClass().getResource(rutasReport).getPath();
            Map parametros = new HashMap();
            parametros.put("fecha", fecha);
            JasperReport reporte = (JasperReport) JRLoader.loadObjectFromFile(ruta);
            JasperPrint rimprimir = JasperFillManager.fillReport(reporte, parametros, conect);
            JasperViewer.viewReport(rimprimir, false);
        } catch (SQLException ex) {
            Logger.getLogger(conecctionDB.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JRException ex) {
            Logger.getLogger(conecctionDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void GetReport_datevenci(String rutasReport, Date fecha, Date vencimiento) {
        try {
            conect = DriverManager.getConnection("jdbc:mysql://localhost:3306/punto_venta", "root", "5108");
            String ruta = getClass().getResource(rutasReport).getPath();
            Map parametros = new HashMap();
            parametros.put("fecha", fecha);
            JasperReport reporte = (JasperReport) JRLoader.loadObjectFromFile(ruta);
            JasperPrint rimprimir = JasperFillManager.fillReport(reporte, parametros, conect);
            JasperViewer.viewReport(rimprimir, false);
        } catch (SQLException ex) {
            Logger.getLogger(conecctionDB.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JRException ex) {
            Logger.getLogger(conecctionDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public byte[] generateReportPDF(String reportPath, int num) {
        Connection connection = null;
        try {
            // Establecer la conexión con la base de datos
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/votacion", "root", "5108");

            // Cargar el reporte desde el archivo .jasper
            InputStream reportStream = getClass().getResourceAsStream(reportPath);
            JasperReport jasperReport = (JasperReport) JRLoader.loadObject(reportStream);

            // Crear un mapa de parámetros para el reporte
            Map<String, Object> parameters = new HashMap<>();
            parameters.put("num", num);

            // Llenar el reporte con los datos y la conexión a la base de datos
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, connection);

            // Exportar el reporte a un arreglo de bytes (PDF)
            byte[] pdfBytes = JasperExportManager.exportReportToPdf(jasperPrint);

            return pdfBytes;
        } catch (SQLException | JRException ex) {
            ex.printStackTrace();
            return null;
        } finally {
            // Cerrar la conexión con la base de datos
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

}
