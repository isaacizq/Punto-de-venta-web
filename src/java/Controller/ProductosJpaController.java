/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import Controller.exceptions.NonexistentEntityException;
import Controller.exceptions.PreexistingEntityException;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import Logic.Categorias;
import Logic.Productos;
import Logic.Proveedores;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author isaac
 */
public class ProductosJpaController implements Serializable {

    public ProductosJpaController() {
        this.emf = Persistence.createEntityManagerFactory("Examen_Punto_VentaPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Productos productos) throws PreexistingEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Categorias categoriasCodigo = productos.getCategoriasCodigo();
            if (categoriasCodigo != null) {
                categoriasCodigo = em.getReference(categoriasCodigo.getClass(), categoriasCodigo.getCodigo());
                productos.setCategoriasCodigo(categoriasCodigo);
            }
            Proveedores proveedoresCodigo = productos.getProveedoresCodigo();
            if (proveedoresCodigo != null) {
                proveedoresCodigo = em.getReference(proveedoresCodigo.getClass(), proveedoresCodigo.getCodigo());
                productos.setProveedoresCodigo(proveedoresCodigo);
            }
            em.persist(productos);
            if (categoriasCodigo != null) {
                categoriasCodigo.getProductosList().add(productos);
                categoriasCodigo = em.merge(categoriasCodigo);
            }
            if (proveedoresCodigo != null) {
                proveedoresCodigo.getProductosList().add(productos);
                proveedoresCodigo = em.merge(proveedoresCodigo);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findProductos(productos.getCodigo()) != null) {
                throw new PreexistingEntityException("Productos " + productos + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Productos productos) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Productos persistentProductos = em.find(Productos.class, productos.getCodigo());
            Categorias categoriasCodigoOld = persistentProductos.getCategoriasCodigo();
            Categorias categoriasCodigoNew = productos.getCategoriasCodigo();
            Proveedores proveedoresCodigoOld = persistentProductos.getProveedoresCodigo();
            Proveedores proveedoresCodigoNew = productos.getProveedoresCodigo();
            if (categoriasCodigoNew != null) {
                categoriasCodigoNew = em.getReference(categoriasCodigoNew.getClass(), categoriasCodigoNew.getCodigo());
                productos.setCategoriasCodigo(categoriasCodigoNew);
            }
            if (proveedoresCodigoNew != null) {
                proveedoresCodigoNew = em.getReference(proveedoresCodigoNew.getClass(), proveedoresCodigoNew.getCodigo());
                productos.setProveedoresCodigo(proveedoresCodigoNew);
            }
            productos = em.merge(productos);
            if (categoriasCodigoOld != null && !categoriasCodigoOld.equals(categoriasCodigoNew)) {
                categoriasCodigoOld.getProductosList().remove(productos);
                categoriasCodigoOld = em.merge(categoriasCodigoOld);
            }
            if (categoriasCodigoNew != null && !categoriasCodigoNew.equals(categoriasCodigoOld)) {
                categoriasCodigoNew.getProductosList().add(productos);
                categoriasCodigoNew = em.merge(categoriasCodigoNew);
            }
            if (proveedoresCodigoOld != null && !proveedoresCodigoOld.equals(proveedoresCodigoNew)) {
                proveedoresCodigoOld.getProductosList().remove(productos);
                proveedoresCodigoOld = em.merge(proveedoresCodigoOld);
            }
            if (proveedoresCodigoNew != null && !proveedoresCodigoNew.equals(proveedoresCodigoOld)) {
                proveedoresCodigoNew.getProductosList().add(productos);
                proveedoresCodigoNew = em.merge(proveedoresCodigoNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = productos.getCodigo();
                if (findProductos(id) == null) {
                    throw new NonexistentEntityException("The productos with id " + id + " no longer exists.");
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
            Productos productos;
            try {
                productos = em.getReference(Productos.class, id);
                productos.getCodigo();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The productos with id " + id + " no longer exists.", enfe);
            }
            Categorias categoriasCodigo = productos.getCategoriasCodigo();
            if (categoriasCodigo != null) {
                categoriasCodigo.getProductosList().remove(productos);
                categoriasCodigo = em.merge(categoriasCodigo);
            }
            Proveedores proveedoresCodigo = productos.getProveedoresCodigo();
            if (proveedoresCodigo != null) {
                proveedoresCodigo.getProductosList().remove(productos);
                proveedoresCodigo = em.merge(proveedoresCodigo);
            }
            em.remove(productos);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Productos> findProductosEntities() {
        return findProductosEntities(true, -1, -1);
    }

    public List<Productos> findProductosEntities(int maxResults, int firstResult) {
        return findProductosEntities(false, maxResults, firstResult);
    }

    private List<Productos> findProductosEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Productos.class));
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

    public Productos findProductos(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Productos.class, id);
        } finally {
            em.close();
        }
    }

    public int getProductosCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Productos> rt = cq.from(Productos.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
