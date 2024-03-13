/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Controller.exceptions.NonexistentEntityException;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import Logic.Factura;
import Logic.ProductoVenta;
import Logic.Productos;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author isaac
 */
public class ProductoVentaJpaController implements Serializable {

    public ProductoVentaJpaController( ) {
        this.emf = Persistence.createEntityManagerFactory("Examen_Punto_VentaPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(ProductoVenta productoVenta) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Factura facturaIdfactura = productoVenta.getFacturaIdfactura();
            if (facturaIdfactura != null) {
                facturaIdfactura = em.getReference(facturaIdfactura.getClass(), facturaIdfactura.getIdfactura());
                productoVenta.setFacturaIdfactura(facturaIdfactura);
            }
            Productos productosCodigo = productoVenta.getProductosCodigo();
            if (productosCodigo != null) {
                productosCodigo = em.getReference(productosCodigo.getClass(), productosCodigo.getCodigo());
                productoVenta.setProductosCodigo(productosCodigo);
            }
            em.persist(productoVenta);
            if (facturaIdfactura != null) {
                facturaIdfactura.getProductoVentaList().add(productoVenta);
                facturaIdfactura = em.merge(facturaIdfactura);
            }
            if (productosCodigo != null) {
                productosCodigo.getProductoVentaList().add(productoVenta);
                productosCodigo = em.merge(productosCodigo);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(ProductoVenta productoVenta) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            ProductoVenta persistentProductoVenta = em.find(ProductoVenta.class, productoVenta.getIdproductoVenta());
            Factura facturaIdfacturaOld = persistentProductoVenta.getFacturaIdfactura();
            Factura facturaIdfacturaNew = productoVenta.getFacturaIdfactura();
            Productos productosCodigoOld = persistentProductoVenta.getProductosCodigo();
            Productos productosCodigoNew = productoVenta.getProductosCodigo();
            if (facturaIdfacturaNew != null) {
                facturaIdfacturaNew = em.getReference(facturaIdfacturaNew.getClass(), facturaIdfacturaNew.getIdfactura());
                productoVenta.setFacturaIdfactura(facturaIdfacturaNew);
            }
            if (productosCodigoNew != null) {
                productosCodigoNew = em.getReference(productosCodigoNew.getClass(), productosCodigoNew.getCodigo());
                productoVenta.setProductosCodigo(productosCodigoNew);
            }
            productoVenta = em.merge(productoVenta);
            if (facturaIdfacturaOld != null && !facturaIdfacturaOld.equals(facturaIdfacturaNew)) {
                facturaIdfacturaOld.getProductoVentaList().remove(productoVenta);
                facturaIdfacturaOld = em.merge(facturaIdfacturaOld);
            }
            if (facturaIdfacturaNew != null && !facturaIdfacturaNew.equals(facturaIdfacturaOld)) {
                facturaIdfacturaNew.getProductoVentaList().add(productoVenta);
                facturaIdfacturaNew = em.merge(facturaIdfacturaNew);
            }
            if (productosCodigoOld != null && !productosCodigoOld.equals(productosCodigoNew)) {
                productosCodigoOld.getProductoVentaList().remove(productoVenta);
                productosCodigoOld = em.merge(productosCodigoOld);
            }
            if (productosCodigoNew != null && !productosCodigoNew.equals(productosCodigoOld)) {
                productosCodigoNew.getProductoVentaList().add(productoVenta);
                productosCodigoNew = em.merge(productosCodigoNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = productoVenta.getIdproductoVenta();
                if (findProductoVenta(id) == null) {
                    throw new NonexistentEntityException("The productoVenta with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            ProductoVenta productoVenta;
            try {
                productoVenta = em.getReference(ProductoVenta.class, id);
                productoVenta.getIdproductoVenta();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The productoVenta with id " + id + " no longer exists.", enfe);
            }
            Factura facturaIdfactura = productoVenta.getFacturaIdfactura();
            if (facturaIdfactura != null) {
                facturaIdfactura.getProductoVentaList().remove(productoVenta);
                facturaIdfactura = em.merge(facturaIdfactura);
            }
            Productos productosCodigo = productoVenta.getProductosCodigo();
            if (productosCodigo != null) {
                productosCodigo.getProductoVentaList().remove(productoVenta);
                productosCodigo = em.merge(productosCodigo);
            }
            em.remove(productoVenta);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<ProductoVenta> findProductoVentaEntities() {
        return findProductoVentaEntities(true, -1, -1);
    }

    public List<ProductoVenta> findProductoVentaEntities(int maxResults, int firstResult) {
        return findProductoVentaEntities(false, maxResults, firstResult);
    }

    private List<ProductoVenta> findProductoVentaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(ProductoVenta.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public ProductoVenta findProductoVenta(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(ProductoVenta.class, id);
        } finally {
            em.close();
        }
    }

    public int getProductoVentaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<ProductoVenta> rt = cq.from(ProductoVenta.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
