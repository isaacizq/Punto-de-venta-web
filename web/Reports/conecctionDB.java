package Reports;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import net.sf.jasperreports.engine.JRException;
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

    public void GetReport_int(String rutasReport, int num) {
        try {
            conect = DriverManager.getConnection("jdbc:mysql://localhost:3306/punto_venta", "root", "5108");
            String ruta = getClass().getResource(rutasReport).getPath();
            Map parametros = new HashMap();
            parametros.put("num", num);
            JasperReport reporte = (JasperReport) JRLoader.loadObjectFromFile(ruta);
            JasperPrint rimprimir = JasperFillManager.fillReport(reporte, parametros, conect);
            JasperViewer.viewReport(rimprimir, false);

        } catch (SQLException ex) {
            Logger.getLogger(conecctionDB.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JRException ex) {
            Logger.getLogger(conecctionDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
