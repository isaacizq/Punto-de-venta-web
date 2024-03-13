/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Logic;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author isaac
 */
@Entity
@Table(name = "productos")
@NamedQueries({
    @NamedQuery(name = "Productos.findAll", query = "SELECT p FROM Productos p"),
    @NamedQuery(name = "Productos.findByCodigo", query = "SELECT p FROM Productos p WHERE p.codigo = :codigo"),
    @NamedQuery(name = "Productos.findByNombre", query = "SELECT p FROM Productos p WHERE p.nombre = :nombre"),
    @NamedQuery(name = "Productos.findByDescripcion", query = "SELECT p FROM Productos p WHERE p.descripcion = :descripcion"),
    @NamedQuery(name = "Productos.findByUnidadMedida", query = "SELECT p FROM Productos p WHERE p.unidadMedida = :unidadMedida"),
    @NamedQuery(name = "Productos.findByPrecioUnitario", query = "SELECT p FROM Productos p WHERE p.precioUnitario = :precioUnitario"),
    @NamedQuery(name = "Productos.findByCantidadIngreso", query = "SELECT p FROM Productos p WHERE p.cantidadIngreso = :cantidadIngreso"),
    @NamedQuery(name = "Productos.findByCantidadDisponible", query = "SELECT p FROM Productos p WHERE p.cantidadDisponible = :cantidadDisponible"),
    @NamedQuery(name = "Productos.findByFechaIngreso", query = "SELECT p FROM Productos p WHERE p.fechaIngreso = :fechaIngreso"),
    @NamedQuery(name = "Productos.findByFechaCaducidad", query = "SELECT p FROM Productos p WHERE p.fechaCaducidad = :fechaCaducidad")})
public class Productos implements Serializable {

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "productosCodigo")
    private List<ProductoVenta> productoVentaList;

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "codigo")
    private Integer codigo;
    @Basic(optional = false)
    @Column(name = "nombre")
    private String nombre;
    @Basic(optional = false)
    @Column(name = "descripcion")
    private String descripcion;
    @Basic(optional = false)
    @Column(name = "unidad_medida")
    private int unidadMedida;
    @Basic(optional = false)
    @Column(name = "precio_unitario")
    private int precioUnitario;
    @Basic(optional = false)
    @Column(name = "cantidad_ingreso")
    private int cantidadIngreso;
    @Basic(optional = false)
    @Column(name = "cantidad_disponible")
    private int cantidadDisponible;
    @Basic(optional = false)
    @Column(name = "fecha_ingreso")
    @Temporal(TemporalType.DATE)
    private Date fechaIngreso;
    @Basic(optional = false)
    @Column(name = "fecha_caducidad")
    @Temporal(TemporalType.DATE)
    private Date fechaCaducidad;
    @JoinColumn(name = "categorias_codigo", referencedColumnName = "codigo")
    @ManyToOne(optional = false)
    private Categorias categoriasCodigo;
    @JoinColumn(name = "proveedores_codigo", referencedColumnName = "codigo")
    @ManyToOne(optional = false)
    private Proveedores proveedoresCodigo;

    public Productos() {
    }

    public Productos(Integer codigo) {
        this.codigo = codigo;
    }

    public Productos(Integer codigo, String nombre, String descripcion, int unidadMedida, int precioUnitario, int cantidadIngreso, int cantidadDisponible, Date fechaIngreso, Date fechaCaducidad) {
        this.codigo = codigo;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.unidadMedida = unidadMedida;
        this.precioUnitario = precioUnitario;
        this.cantidadIngreso = cantidadIngreso;
        this.cantidadDisponible = cantidadDisponible;
        this.fechaIngreso = fechaIngreso;
        this.fechaCaducidad = fechaCaducidad;
    }

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getUnidadMedida() {
        return unidadMedida;
    }

    public void setUnidadMedida(int unidadMedida) {
        this.unidadMedida = unidadMedida;
    }

    public int getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(int precioUnitario) {
        this.precioUnitario = precioUnitario;
    }

    public int getCantidadIngreso() {
        return cantidadIngreso;
    }

    public void setCantidadIngreso(int cantidadIngreso) {
        this.cantidadIngreso = cantidadIngreso;
    }

    public int getCantidadDisponible() {
        return cantidadDisponible;
    }

    public void setCantidadDisponible(int cantidadDisponible) {
        this.cantidadDisponible = cantidadDisponible;
    }

    public Date getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(Date fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public Date getFechaCaducidad() {
        return fechaCaducidad;
    }

    public void setFechaCaducidad(Date fechaCaducidad) {
        this.fechaCaducidad = fechaCaducidad;
    }

    public Categorias getCategoriasCodigo() {
        return categoriasCodigo;
    }

    public void setCategoriasCodigo(Categorias categoriasCodigo) {
        this.categoriasCodigo = categoriasCodigo;
    }

    public Proveedores getProveedoresCodigo() {
        return proveedoresCodigo;
    }

    public void setProveedoresCodigo(Proveedores proveedoresCodigo) {
        this.proveedoresCodigo = proveedoresCodigo;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (codigo != null ? codigo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Productos)) {
            return false;
        }
        Productos other = (Productos) object;
        if ((this.codigo == null && other.codigo != null) || (this.codigo != null && !this.codigo.equals(other.codigo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return nombre;
    }

    @XmlTransient
    public List<ProductoVenta> getProductoVentaList() {
        return productoVentaList;
    }

    public void setProductoVentaList(List<ProductoVenta> productoVentaList) {
        this.productoVentaList = productoVentaList;
    }
    
}
