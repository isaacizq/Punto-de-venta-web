<%@page import="Controller.ProductosJpaController"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.LocalDate"%>
<%@page import="Logic.Proveedores" %>
<%@page import="Controller.ProveedoresJpaController" %>
<%@page import="Logic.Productos" %>
<%@page import="java.util.List" %>
<%@page import="Controller.ProductoVentaJpaController" %>
<%@page import="Controller.CategoriasJpaController" %>
<%@page import="Logic.Categorias" %>
<!doctype html>
<html lang="es">

    <head>
        <title>Formulario Productos</title>
        <%
            HttpSession cecion = request.getSession();
        %>

        <%
            response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
        %>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS v5.2.1 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
              rel="stylesheet"
              integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT"
              crossorigin="anonymous">
        <link rel="stylesheet" href="styles.css"/>
        <link rel="stylesheet" href="style.css"/>


    </head>

    <body>
        <header>
            <div class="container">
                <nav class="navbar navbar-expand-lg bg-body-tertiary navbar mb-2"
                     style="background-color: #e3f2fd;">
                    <div class="container-fluid">
                        <a class="fs-4 navbar-brand" href="index.jsp">Menu</a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarSupportedContent"
                                aria-controls="navbarSupportedContent" aria-expanded="false"
                                aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                <li class="nav-item">
                                    <a class="fs-4 nav-link active" aria-current="page"
                                       href=Productos.jsp">Productos</a>
                                </li>
                                <li class="nav-item">
                                    <a class="fs-4 nav-link active" href="Categorias.jsp">categorias</a>
                                </li>
                                <li class="nav-item">
                                    <a class="fs-4 nav-link active" href="Clientes.jsp">Clientes</a>
                                </li>
                                <li class="nav-item">
                                    <a class="fs-4 nav-link active" href="Proveedores.jsp">Proveedores</a>
                                </li>
                                <li class="nav-item">
                                    <a class="fs-4 nav-link active" href="Factura.jsp">Nueva Venta</a>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="fs-4 nav-link dropdown-toggle" href="#" role="button"
                                       data-bs-toggle="dropdown" aria-expanded="false">
                                        Reporte
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li><a class="fs-4 dropdown-item" href="RProveedores.jsp" target="_blank">Proveedores</a>
                                        </li>
                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>
                                        <li><a class="fs-4 dropdown-item" href="Rcategorias.jsp"target="_blank">Categorias</a></li>

                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>
                                        <li><a class="fs-4 dropdown-item" href="RProductos.jsp" target="_blank">Productos</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <div class="dropdown ">
                            <button class="btn btn-secondary dropdown-toggle" type="button"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                Usuario
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#"><img
                                            src="img/user_1177568.png" alt=""></a>
                                </li>
                                <li><a class="dropdown-item" href=""><%= cecion.getAttribute("nombre")%></a></li>
                                <li><form action="Productos.jsp"><input class="dropdown-item" name="link" type="submit" value="Salir">
                                        <%if (request.getParameter("link") != null) {
                                                cecion.removeAttribute("usuario");
                                                cecion.removeAttribute("password");
                                            }
                                            if (cecion.getAttribute("usuario") == null) {
                                                request.getRequestDispatcher("Login.jsp").forward(request, response);
                                            }
                                        %>
                                    </form></li>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
        </header>
        <main>
            <div class="container mt-4 px-4 col-12" style="background-color:#B5E5E6">
                <p class="fs-1 fst-italic text-center"> Formulario Productos</p>
                <i><img src="img/product-range_3896962.png" class="rounded mx-auto d-block" alt="alt"/></i>
                <div class="row gx-5">
                    <div class="col-sm-12 col-md-12 mt-2 col-lg-5">
                        <form action="Productos.jsp" method="post">
                            <div class="row mt-4">
                                <div class="col mb-3 ">
                                    <label for="formGroupExampleInput" class="fs-4 form-label">Codigo</label>
                                    <input type="number" name="codigo" class="form-control"
                                           id="formGroupExampleInput" placeholder="Digite el Codigo">
                                </div>
                                <div class="col mb-3">
                                    <label for="formGroupExampleInput2"
                                           class="fs-4 form-label">Nombre</label>
                                    <input type="text" name="nombre" class="form-control"
                                           id="formGroupExampleInput2" placeholder="Digite el Nombre">
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="formGroupExampleInput" class="fs-4 form-label">Categoria</label>
                                <select name="categorias" class="form-select">
                                    <% CategoriasJpaController cc = new CategoriasJpaController();
                                        List lista = cc.findCategoriasEntities();
                                        for (int i = 0; i < lista.size(); i++) {
                                            Categorias obj = (Categorias) lista.get(i);
                                            out.print("<option value='" + obj.getCodigo() + "'>");
                                            out.print(obj.getNombre());
                                            out.print("</option>");
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="formGroupExampleInput2"
                                       class="fs-4 form-label">Proveedores</label>
                                <select name="proveedores" class="form-select">
                                    <% ProveedoresJpaController cp = new ProveedoresJpaController();
                                        List listas = cp.findProveedoresEntities();
                                        for (int i = 0; i
                                                < listas.size(); i++) {
                                            Proveedores ob = (Proveedores) listas.get(i);
                                            out.print("<option value='" + ob.getCodigo()
                                                    + "'>");
                                            out.print(ob.getNombre());
                                            out.print("</option>");
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="row">
                                <div class="col mb-3">
                                    <label for="formGroupExampleInput"
                                           class="fs-4 form-label">Descripcion</label>
                                    <input type="text" name="descripcion" class="form-control"
                                           id="formGroupExampleInput" placeholder="Digite el Descripcion">
                                </div>
                                <div class="col mb-3">
                                    <label for="formGroupExampleInput2" class="fs-4 form-label">Unidad de
                                        Medida</label>
                                    <input type="number" name="unidad" class="form-control"
                                           id="formGroupExampleInput2" placeholder="Digite un Numero">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col mb-3">
                                    <label for="formGroupExampleInput" class="fs-4 form-label">Precio
                                        unitario</label>
                                    <input type="number" name="precio" class="form-control"
                                           id="formGroupExampleInput"
                                           placeholder="Digite el Precio *unidad">
                                </div>
                                <div class="col mb-3">
                                    <label for="formGroupExampleInput2" class="fs-4 form-label">Cantidad de
                                        Ingreso</label>
                                    <input type="number" name="ingreso" class="form-control"
                                           id="formGroupExampleInput2" placeholder="Digite la cantidad">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col mb-3">
                                    <label for="formGroupExampleInput" class="fs-4 form-label">Cantidad
                                        Disponible</label>
                                    <input type="number" name="disponible" class="form-control"
                                           id="formGroupExampleInput"
                                           placeholder="Digite la cantidad de ingreso">
                                </div>
                                <div class="col mb-3">
                                    <label for="formGroupExampleInput2" class="fs-4 form-label">Fecha
                                        Caducidad</label>
                                    <input type="date" name="fcaducidad" class="form-control"
                                           id="formGroupExampleInput2" placeholder="">
                                </div>
                            </div>

                            <br><br>
                            <div class="d-grid gap-2 col-4 mx-auto mt-5px mb-5">
                                <button class="fs-4 btn btn-primary mb-4" name="button"
                                        type="submit">Guardar</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-sm-12 col-md-12 col-lg-7 mt-4 text-center">
                        <div class="table-wrapper-scroll-y my-custom-scrollbar">
                            <table class="table table-bordered table-striped mb-0 mt-4">
                                <p class="fs-3 fst-italic text-center">Productos registrados</p>
                                <thead>
                                    <tr>
                                        <th>Codigo</th>
                                        <th>Nombres</th>
                                        <th>Categoria</th>
                                        <th>Proveedor</th>
                                        <th>Descripción</th>
                                        <th>Unidad de medida</th>
                                        <th>Precio</th>
                                        <th>Cantidad Ingreso</th>
                                        <th>Cantidad Disponible</th>
                                        <th>Fecha de ingreso</th>
                                        <th>fecha de Caducidad</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        ProductosJpaController ne = new ProductosJpaController();
                                        List<Productos> eto = ne.findProductosEntities();
                                        for (Productos c : eto) {
                                    %>
                                    <tr>
                                        <td><%= c.getCodigo()%></td>
                                        <td><%= c.getNombre()%></td>
                                        <td><%= c.getCategoriasCodigo()%></td>
                                        <td><%= c.getProveedoresCodigo()%></td>
                                        <td><%= c.getDescripcion()%></td>
                                        <td><%= c.getUnidadMedida()%></td>
                                        <td><%= c.getPrecioUnitario()%></td>
                                        <td><%= c.getCantidadIngreso()%></td>
                                        <td><%= c.getCantidadDisponible()%></td>
                                        <td><%= c.getFechaIngreso()%></td>
                                        <td><%= c.getFechaCaducidad()%></td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                        </div>
                        <br>
                        <form action="Productos.jsp" method="post">
                            <div class="row">
                                <div class="col">
                                    <div class="d-grid gap-2 col-4 mx-auto mt-5px mb-5">
                                        <button class="fs-5 btn btn-primary mb-4" name="buton" type="submit">Buscar</button>
                                    </div>
                                </div>
                                <div class="col">
                                    <input type="number" name="id" class="form-control" id="formGroupExampleInput"
                                           placeholder="Digite la cedula a buscar">
                                </div>
                            </div>
                        </form>
                        <%
                            if (request.getParameter("buton") != null) {
                                int id = Integer.parseInt(request.getParameter("id"));
                                ProductosJpaController controller = new ProductosJpaController();
                                Productos custom = controller.findProductos(id);
                                if (custom != null) {
                        %>
                        <div class="table-wrapper-scroll-y my-custom-scrollbar">
                            <table class="table table-bordered table-striped mb-0 mt-4" border="1">
                                <p class="fs-3 fst-italic text-center">Producto Encontrado</p>
                                <thead>
                                    <tr>
                                        <th>Codigo</th>
                                        <th>Nombres</th>
                                        <th>Categoria</th>
                                        <th>Proveedor</th>
                                        <th>Descripción</th>
                                        <th>Unidad de medida</th>
                                        <th>Precio</th>
                                        <th>Cantidad Ingreso</th>
                                        <th>Cantidad Disponible</th>
                                        <th>Fecha de ingreso</th>
                                        <th>fecha de Caducidad</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><%= custom.getCodigo()%></td>
                                        <td><%= custom.getNombre()%></td>
                                        <td><%= custom.getCategoriasCodigo()%></td>
                                        <td><%= custom.getProveedoresCodigo()%></td>
                                        <td><%= custom.getDescripcion()%></td>
                                        <td><%= custom.getUnidadMedida()%></td>
                                        <td><%= custom.getPrecioUnitario()%></td>
                                        <td><%= custom.getCantidadIngreso()%></td>
                                        <td><%= custom.getCantidadDisponible()%></td>
                                        <td><%= custom.getFechaIngreso()%></td>
                                        <td><%= custom.getFechaCaducidad()%></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <%
                        } else {
                        %>
                        <div class="col-sm-12 col-md-12 col-lg-7 text-center">
                            <p class="fs-3 fst-italic text-center">Producto no encontrado</p>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>         
                </div>
            </div>
        </main>
        <footer>
            <!-- place footer here -->
        </footer>
        <!-- Bootstrap JavaScript Libraries -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
                integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
                crossorigin="anonymous">
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
                integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
                crossorigin="anonymous">
        </script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>
</html>
<%
    String boton = request.getParameter("button");

    if (boton != null) {
        CategoriasJpaController n = new CategoriasJpaController();
        ProveedoresJpaController control = new ProveedoresJpaController();
        ProductosJpaController con = new ProductosJpaController();
        int codigo = Integer.parseInt(request.getParameter("codigo"));
        String nom = request.getParameter("nombre");
        int categoria = Integer.parseInt(request.getParameter("categorias"));
        int proveedor = Integer.parseInt(request.getParameter("proveedores"));
        String descrip = request.getParameter("descripcion");
        int unidad = Integer.parseInt(request.getParameter("unidad"));
        int precio = Integer.parseInt(request.getParameter("precio"));
        int ingreso = Integer.parseInt(request.getParameter("ingreso"));
        int disponible = Integer.parseInt(request.getParameter("disponible"));
        Date fechaActual = new Date();
        String fechav = request.getParameter("fcaducidad");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaven = sdf.parse(fechav);
        Productos obje = new Productos();
        obje.setCodigo(codigo);
        obje.setNombre(nom);
        Categorias p = n.findCategorias(categoria);
        obje.setCategoriasCodigo(p);
        Proveedores pro = control.findProveedores(proveedor);
        obje.setProveedoresCodigo(pro);
        obje.setDescripcion(descrip);
        obje.setUnidadMedida(unidad);
        obje.setPrecioUnitario(precio);
        obje.setCantidadIngreso(ingreso);
        obje.setCantidadDisponible(disponible);
        obje.setFechaIngreso(fechaActual);
        obje.setFechaCaducidad(fechaven);
        con.create(obje); %>
<script>
                    Swal.fire({
                        title: 'Do you want to save the changes?',
                        showDenyButton: true,
                        showCancelButton: true,
                        confirmButtonText: 'Save',
                        denyButtonText: `Don't save`,
                    }).then((result) => {
                        /* Read more about isConfirmed, isDenied below */
                        if (result.isConfirmed) {
                            Swal.fire('Saved!', '', 'success')
                        } else if (result.isDenied) {
                            Swal.fire('Changes are not saved', '', 'info')
                        }
                    })
</script>
<% }%>