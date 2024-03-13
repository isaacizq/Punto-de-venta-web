<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Controller.ClientesJpaController"%>
<%@page import="Logic.Clientes"%>
<%@page import="Controller.ProveedoresJpaController"%>
<%@page import="Logic.Proveedores"%>
<%@page import="Controller.CategoriasJpaController" %>
<%@page import="Logic.Categorias" %>
<!doctype html>
<html lang="es">

    <head>
        <title>Formulario de Clientes</title>
        <%
            response.setHeader("Cache-Control", "no-Cache,no-store,must-revalidate");
        %>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS v5.2.1 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
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
                                       href="Productos.jsp">Productos</a>
                                </li>
                                <li class="nav-item">
                                    <a class="fs-4 nav-link active" href="Categorias.jsp">Categorias</a>
                                </li>
                                <li class="nav-item">
                                    <a class="fs-4 nav-link active" href="Proveedores.jsp">Proveedores</a>
                                </li>
                                <li class="nav-item">
                                    <a class="fs-4 nav-link active" href="Clientes.jsp">Clientes</a>
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
                                <%
                                    HttpSession cecion = request.getSession();
                                %>
                                <li><a class="dropdown-item" href=""><%= cecion.getAttribute("nombre")%></a></li>
                                <li><form action="Clientes.jsp"><input class="dropdown-item" name="link" type="submit" value="Salir">
                                        <%if (request.getParameter("link") != null) {
                                                cecion.removeAttribute("usuario");
                                                cecion.removeAttribute("password");
                                            }%>
                                    </form></li>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
        </header>
        <main>
            <div class="container mt-4 px-4" style="background-color: #B5E5E6">
                <p class="fs-1 fst-italic text-center"> Formulario Clientes</p>
                <i><img src="img/delivery-boy_9557578.png" class="rounded mx-auto d-block" alt="alt"/></i>
                <div class="row gx-5">
                    <div class="col-sm-12 col-md-12 mt-2 col-lg-5">
                        <form action="Clientes.jsp" method="post">
                            <div class="mb-3">
                                <label for="formGroupExampleInput" class="fs-4 form-label">Cedula  
                                    <i><img src="img/clipboard_759763.png" alt="alt"/></i>
                                </label>
                                <input type="number" name="codigo" class="form-control" id="formGroupExampleInput"
                                       placeholder="Digite la identificación">
                            </div>
                            <div class="mb-3">
                                <label for="formGroupExampleInput2" class="fs-4 form-label">Nombres </label>
                                <i><img src="img/newspaper_3208892.png" alt="alt"/></i>
                                <input type="text" name="nombre" class="form-control" id="formGroupExampleInput2"
                                       placeholder="Digite el Nombre">
                            </div>
                            <div class="mb-3">
                                <label for="formGroupExampleInput2" class="fs-4 form-label">Apellidos </label>
                                <i><img src="img/newspaper_3208892.png" alt="alt"/></i>
                                <input type="text" name="apellidos" class="form-control" id="formGroupExampleInput2"
                                       placeholder="Digite el Nombre">
                            </div>
                            <div class="mb-3">
                                <label for="formGroupExampleInput" class="fs-4 form-label">Telefono  
                                    <i><img src="img/phone-call_455705.png" alt="alt"/></i>
                                </label>
                                <input type="text" name="telefono" class="form-control" id="formGroupExampleInput"
                                       placeholder="Digite su telefono">
                            </div>
                            <div class="mb-3">
                                <label for="formGroupExampleInput2" class="fs-4 form-label">Dirección </label>
                                <i><img src="img/placeholders_1004300.png" alt="alt"/></i>
                                <input type="text" name="direccion" class="form-control" id="formGroupExampleInput2"
                                       placeholder="Digite su domicilio">
                            </div>
                            <div class="mb-3">
                                <label for="formGroupExampleInput2" class="fs-4 form-label">Correo </label>
                                <i><img src="img/email_10400871.png" alt="alt"/></i>
                                <input type="text" name="correo" class="form-control" id="formGroupExampleInput2"
                                       placeholder="Digite su correo">
                            </div>
                            <br><br>
                            <div class="d-grid gap-2 col-4 mx-auto mt-5px mb-5">
                                <button class="fs-4 btn btn-primary mb-4" name="buton" type="submit">Guardar</button>
                            </div>

                        </form>
                    </div>
                    <div class="col-sm-12 col-md-12 col-lg-7 text-center">
                        <div class="table-wrapper-scroll-y my-custom-scrollbar">
                            <table class="table table-bordered table-striped mb-0 mt-4">
                                <p class="fs-3 fst-italic text-center">Clientes registrados</p>
                                <thead>
                                    <tr>
                                        <th scope="col">Cedula</th>
                                        <th scope="col">Nombres</th>
                                        <th scope="col">Apellidos</th>
                                        <th scope="col">Telefono</th>
                                        <th scope="col">Dirección</th>
                                        <th scope="col">Correo</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        ClientesJpaController n = new ClientesJpaController();
                                        List<Clientes> eto = n.findClientesEntities();
                                        for (Clientes c : eto) {
                                    %>
                                    <tr>
                                        <th scope="row"><%= c.getCedula()%></th>
                                        <td><%= c.getNombre()%></td>
                                        <td><%= c.getApellidos()%></td>
                                        <td><%= c.getTelefono()%></td>
                                        <td><%= c.getDireccion()%></td>
                                        <td><%= c.getCorreo()%></td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                        </div>
                        <br>
                        <form action="Clientes.jsp" method="post">
                            <div class="row">
                                <div class="col">
                                    <div class="d-grid gap-2 col-4 mx-auto mt-5px mb-5">
                                        <button class="fs-5 btn btn-primary mb-4" name="button" type="submit">Buscar</button>
                                    </div>
                                </div>
                                <div class="col">
                                    <input type="number" name="cedula" class="form-control" id="formGroupExampleInput"
                                           placeholder="Digite la cedula a buscar">
                                </div>
                            </div>
                        </form>
                        <%
                            if (request.getParameter("button") != null) {
                                int cedula = Integer.parseInt(request.getParameter("cedula"));
                                ClientesJpaController controller = new ClientesJpaController();
                                Clientes custom = controller.findClientes(cedula);
                                if (custom != null) {
                        %>
                        <table class="table table-striped" border="1">
                            <p class="fs-3 fst-italic text-center">Cliente Encontrado</p>
                            <thead>
                                <tr>
                                    <th>Cedula</th>
                                    <th>Nombres</th>
                                    <th>Apellidos</th>
                                    <th>Telefono</th>
                                    <th>Dirección</th>
                                    <th>Correo</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><%= custom.getCedula()%></td>
                                    <td><%= custom.getNombre()%></td>
                                    <td><%= custom.getApellidos()%></td>
                                    <td><%= custom.getTelefono()%></td>
                                    <td><%= custom.getDireccion()%></td>
                                    <td><%= custom.getCorreo()%></td>
                                </tr>
                            </tbody>
                        </table>
                        <%
                        } else {
                        %>
                        <div class="col-sm-12 col-md-12 col-lg-7 text-center">
                            <p class="fs-3 fst-italic text-center">Cliente no encontrado</p>
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
<% String boton = request.getParameter("buton");
    if (cecion.getAttribute("usuario") == null) {
        request.getRequestDispatcher("Login.jsp").forward(request, response);
    }
    if (boton != null) {
        int codigo = Integer.parseInt(request.getParameter("codigo"));
        String nom = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String direccion = request.getParameter("direccion");
        String tel = request.getParameter("telefono");
        String correo = request.getParameter("correo");
        Clientes obj = new Clientes();
        obj.setCedula(codigo);
        obj.setNombre(nom);
        obj.setApellidos(apellidos);
        obj.setTelefono(tel);
        obj.setDireccion(direccion);
        obj.setCorreo(correo);
        ClientesJpaController ne = new ClientesJpaController();
        ne.create(obj);

%>
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
<%    }%>