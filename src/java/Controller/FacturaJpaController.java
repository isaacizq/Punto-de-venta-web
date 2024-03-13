/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Controller.exceptions.IllegalOrphanException;
import Controller.exceptions.NonexistentEntityException;
import Controller.exceptions.PreexistingEntityException;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import Logic.Clientes;
import Logic.Factura;
import Logic.Usuario;
import Logic.ProductoVenta;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author isaac
 */
public class FacturaJpaController implements Serializable {

    public FacturaJpaController() {
        this.emf = Persistence.createEntityManagerFactory("Examen_Punto_VentaPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Factura factura) throws PreexistingEntityException, Exception {
        if (factura.getProductoVentaList() == null) {
            factura.setProductoVentaList(new ArrayList<ProductoVenta>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Clientes clientesCedula = factura.getClientesCedula();
            if (clientesCedula != null) {
                clientesCedula = em.getReference(clientesCedula.getClass(), clientesCedula.getCedula());
                factura.setClientesCedula(clientesCedula);
            }
            Usuario usuarioIdusuario = factura.getUsuarioIdusuario();
            if (usuarioIdusuario != null) {
                usuarioIdusuario = em.getReference(usuarioIdusuario.getClass(), usuarioIdusuario.getIdusuario());
                factura.setUsuarioIdusuario(usuarioIdusuario);
            }
            List<ProductoVenta> attachedProductoVentaList = new ArrayList<ProductoVenta>();
            for (ProductoVenta productoVentaListProductoVentaToAttach : factura.getProductoVentaList()) {
                productoVentaListProductoVentaToAttach = em.getReference(productoVentaListProductoVentaToAttach.getClass(), productoVentaListProductoVentaToAttach.getIdproductoVenta());
                attachedProductoVentaList.add(productoVentaListProductoVentaToAttach);
            }
            factura.setProductoVentaList(attachedProductoVentaList);
            em.persist(factura);
            if (clientesCedula != null) {
                clientesCedula.getFacturaList().add(factura);
                clientesCedula = em.merge(clientesCedula);
            }
            if (usuarioIdusuario != null) {
                usuarioIdusuario.getFacturaList().add(factura);
                usuarioIdusuario = em.merge(usuarioIdusuario);
            }
            for (ProductoVenta productoVentaListProductoVenta : factura.getProductoVentaList()) {
                Factura oldFacturaIdfacturaOfProductoVentaListProductoVenta = productoVentaListProductoVenta.getFacturaIdfactura();
                productoVentaListProductoVenta.setFacturaIdfactura(factura);
                productoVentaListProductoVenta = em.merge(productoVentaListProductoVenta);
                if (oldFacturaIdfacturaOfProductoVentaListProductoVenta != null) {
                    oldFacturaIdfacturaOfProductoVentaListProductoVenta.getProductoVentaList().remove(productoVentaListProductoVenta);
                    oldFacturaIdfacturaOfProductoVentaListProductoVenta = em.merge(oldFacturaIdfacturaOfProductoVentaListProductoVenta);
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findFactura(factura.getIdfactura()) != null) {
                throw new PreexistingEntityException("Factura " + factura + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Factura factura) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Factura persistentFactura = em.find(Factura.class, factura.getIdfactura());
            Clientes clientesCedulaOld = persistentFactura.getClientesCedula();
            Clientes clientesCedulaNew = factura.getClientesCedula();
            Usuario usuarioIdusuarioOld = persistentFactura.getUsuarioIdusuario();
            Usuario usuarioIdusuarioNew = factura.getUsuarioIdusuario();
            List<ProductoVenta> productoVentaListOld = persistentFactura.getProductoVentaList();
            List<ProductoVenta> productoVentaListNew = factura.getProductoVentaList();
            List<String> illegalOrphanMessages = null;
            for (ProductoVenta productoVentaListOldProductoVenta : productoVentaListOld) {
                if (!productoVentaListNew.contains(productoVentaListOldProductoVenta)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain ProductoVenta " + productoVentaListOldProductoVenta + " since its facturaIdfactura field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (clientesCedulaNew != null) {
                clientesCedulaNew = em.getReference(clientesCedulaNew.getClass(), clientesCedulaNew.getCedula());
                factura.setClientesCedula(clientesCedulaNew);
            }
            if (usuarioIdusuarioNew != null) {
                usuarioIdusuarioNew = em.getReference(usuarioIdusuarioNew.getClass(), usuarioIdusuarioNew.getIdusuario());
                factura.setUsuarioIdusuario(usuarioIdusuarioNew);
            }
            List<ProductoVenta> attachedProductoVentaListNew = new ArrayList<ProductoVenta>();
            for (ProductoVenta productoVentaListNewProductoVentaToAttach : productoVentaListNew) {
                productoVentaListNewProductoVentaToAttach = em.getReference(productoVentaListNewProductoVentaToAttach.getClass(), productoVentaListNewProductoVentaToAttach.getIdproductoVenta());
                attachedProductoVentaListNew.add(productoVentaListNewProductoVentaToAttach);
            }
            productoVentaListNew = attachedProductoVentaListNew;
            factura.setProductoVentaList(productoVentaListNew);
            factura = em.merge(factura);
            if (clientesCedulaOld != null && !clientesCedulaOld.equals(clientesCedulaNew)) {
                clientesCedulaOld.getFacturaList().remove(factura);
                clientesCedulaOld = em.merge(clientesCedulaOld);
            }
            if (clientesCedulaNew != null && !clientesCedulaNew.equals(clientesCedulaOld)) {
                clientesCedulaNew.getFacturaList().add(factura);
                clientesCedulaNew = em.merge(clientesCedulaNew);
            }
            if (usuarioIdusuarioOld != null && !usuarioIdusuarioOld.equals(usuarioIdusuarioNew)) {
                usuarioIdusuarioOld.getFacturaList().remove(factura);
                usuarioIdusuarioOld = em.merge(usuarioIdusuarioOld);
            }
            if (usuarioIdusuarioNew != null && !usuarioIdusuarioNew.equals(usuarioIdusuarioOld)) {
                usuarioIdusuarioNew.getFacturaList().add(factura);
                usuarioIdusuarioNew = em.merge(usuarioIdusuarioNew);
            }
            for (ProductoVenta productoVentaListNewProductoVenta : productoVentaListNew) {
                if (!productoVentaListOld.contains(productoVentaListNewProductoVenta)) {
                    Factura oldFacturaIdfacturaOfProductoVentaListNewProductoVenta = productoVentaListNewProductoVenta.getFacturaIdfactura();
                    productoVentaListNewProductoVenta.setFacturaIdfactura(factura);
                    productoVentaListNewProductoVenta = em.merge(productoVentaListNewProductoVenta);
                    if (oldFacturaIdfacturaOfProductoVentaListNewProductoVenta != null && !oldFacturaIdfacturaOfProductoVentaListNewProductoVenta.equals(factura)) {
                        oldFacturaIdfacturaOfProductoVentaListNewProductoVenta.getProductoVentaList().remove(productoVentaListNewProductoVenta);
                        oldFacturaIdfacturaOfProductoVentaListNewProductoVenta = em.merge(oldFacturaIdfacturaOfProductoVentaListNewProductoVenta);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Long id = factura.getIdfactura();
                if (findFactura(id) == null) {
                    throw new NonexistentEntityException("The factura with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Long id) throws IllegalOrphanException, NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Factura factura;
            try {
                factura = em.getReference(Factura.class, id);
                factura.getIdfactura();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The factura with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<ProductoVenta> productoVentaListOrphanCheck = factura.getProductoVentaList();
            for (ProductoVenta productoVentaListOrphanCheckProductoVenta : productoVentaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Factura (" + factura + ") cannot be destroyed since the ProductoVenta " + productoVentaListOrphanCheckProductoVenta + " in its productoVentaList field has a non-nullable facturaIdfactura field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Clientes clientesCedula = factura.getClientesCedula();
            if (clientesCedula != null) {
                clientesCedula.getFacturaList().remove(factura);
                clientesCedula = em.merge(clientesCedula);
            }
            Usuario usuarioIdusuario = factura.getUsuarioIdusuario();
            if (usuarioIdusuario != null) {
                usuarioIdusuario.getFacturaList().remove(factura);
                usuarioIdusuario = em.merge(usuarioIdusuario);
            }
            em.remove(factura);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Factura> findFacturaEntities() {
        return findFacturaEntities(true, -1, -1);
    }

    public List<Factura> findFacturaEntities(int maxResults, int firstResult) {
        return findFacturaEntities(false, maxResults, firstResult);
    }

    private List<Factura> findFacturaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Factura.class));
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

    public Factura findFactura(Long id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Factura.class, id);
        } finally {
            em.close();
        }
    }

    public int getFacturaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Factura> rt = cq.from(Factura.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
