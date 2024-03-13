/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Logic;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author isaac
 */
@Entity
@Table(name = "producto_venta")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ProductoVenta.findAll", query = "SELECT p FROM ProductoVenta p"),
    @NamedQuery(name = "ProductoVenta.findByIdproductoVenta", query = "SELECT p FROM ProductoVenta p WHERE p.idproductoVenta = :idproductoVenta"),
    @NamedQuery(name = "ProductoVenta.findByCantidad", query = "SELECT p FROM ProductoVenta p WHERE p.cantidad = :cantidad")})
public class ProductoVenta implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "idproducto_venta")
    private Integer idproductoVenta;
    @Basic(optional = false)
    @Column(name = "cantidad")
    private int cantidad;
    @JoinColumn(name = "factura_idfactura", referencedColumnName = "idfactura")
    @ManyToOne(optional = false)
    private Factura facturaIdfactura;
    @JoinColumn(name = "productos_codigo", referencedColumnName = "codigo")
    @ManyToOne(optional = false)
    private Productos productosCodigo;

    public ProductoVenta() {
    }

    public ProductoVenta(Integer idproductoVenta) {
        this.idproductoVenta = idproductoVenta;
    }

    public ProductoVenta(Integer idproductoVenta, int cantidad) {
        this.idproductoVenta = idproductoVenta;
        this.cantidad = cantidad;
    }

    public Integer getIdproductoVenta() {
        return idproductoVenta;
    }

    public void setIdproductoVenta(Integer idproductoVenta) {
        this.idproductoVenta = idproductoVenta;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public Factura getFacturaIdfactura() {
        return facturaIdfactura;
    }

    public void setFacturaIdfactura(Factura facturaIdfactura) {
        this.facturaIdfactura = facturaIdfactura;
    }

    public Productos getProductosCodigo() {
        return productosCodigo;
    }

    public void setProductosCodigo(Productos productosCodigo) {
        this.productosCodigo = productosCodigo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idproductoVenta != null ? idproductoVenta.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProductoVenta)) {
            return false;
        }
        ProductoVenta other = (ProductoVenta) object;
        if ((this.idproductoVenta == null && other.idproductoVenta != null) || (this.idproductoVenta != null && !this.idproductoVenta.equals(other.idproductoVenta))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Logic.ProductoVenta[ idproductoVenta=" + idproductoVenta + " ]";
    }
    
}
