<%@page import="Logic.ProductoVenta"%>
<%@page import="Controller.ProductoVentaJpaController"%>
<%@page import="Logic.venta"%>
<%@page import="Controller.UsuarioJpaController"%>
<%@page import="Logic.Usuario"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.LocalDate"%>
<%@page import="Logic.Factura"%>
<%@page import="Controller.FacturaJpaController"%>
<%@page import="java.util.HashMap"%>
<%@page import="Logic.Productos"%>
<%@page import="Controller.ProductosJpaController"%>
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
        <title>Factura</title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <%
            response.setHeader("Cache-Control", "no-Cache,no-store,must-revalidate");
        %>
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
                                <%// atrapa la sesion que manda el jsp de login
                                    HttpSession cecion = request.getSession();
                                %>
                                <li><a class="dropdown-item" href=""><%= cecion.getAttribute("nombre")%></a></li>
                                <li><form action="Factura.jsp"><input class="dropdown-item" name="link" type="submit" value="Salir">
                                        <%
                                            if (request.getParameter("link") != null) {  //Cierra sesion al eliminar los atributos de la seseion
                                                cecion.removeAttribute("usuario");
                                                cecion.removeAttribute("password");

                                            }
                                            if (cecion.getAttribute("usuario") == null) {//valida si la sesion no tiene atributos y redirecciona al login
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
            <div class="container mt-4 px-4" style="background-color: #B5E5E6">
                <p class="fs-1 fst-italic text-center"> Formulario Factura</p>
                <i><img src="img/delivery-boy_9557578.png" class="rounded mx-auto d-block" alt="alt"/></i>
                <div class="row gx-5">
                    <div class="col-sm-12 col-md-12 mt-2 col-lg-6">
                        <div class="mb-3 mt-5">
                            <label  class="fs-4 form-label">Cedula</label>
                            <i><img src="img/clipboard_759763.png" alt="alt"/></i>
                            <input type="text" id="clien" class="form-control"
                                   placeholder="Digite el campo a buscar">
                        </div>
                        <div class="table-wrapper-scroll-y my-custom-scrollbar">
                            <table class="table table-bordered table-striped mb-0 mt-4" id="tab" border="1">
                                <p class="fs-3 fst-italic text-center">Clientes registrados</p>
                                <thead>
                                    <tr>
                                        <th scope="col">Cedula</th>
                                        <th scope="col">Nombres</th>
                                        <th scope="col">Apellidos</th>
                                        <th scope="col">Telefono</th>
                                        <th scope="col">Agregar</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% //llena la tabla de clientes con los datos de la DataBases
                                        ClientesJpaController ne = new ClientesJpaController();
                                        List<Clientes> eto = ne.findClientesEntities();
                                        for (Clientes c : eto) {
                                    %>
                                    <tr>
                                        <td><%= c.getCedula()%></td>
                                        <td><%= c.getNombre()%></td>
                                        <td><%= c.getApellidos()%></td>
                                        <td><%= c.getTelefono()%></td>
                                        <td><button type="button" onclick="Digitarpadre(<%= c.getCedula()%>)" class="btn btn-primary">Agregar</button></td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                        </div>
                        <br>
                        <label class="fs-4 form-label">Codigo</label>
                        <i><img src="img/clipboard_759763.png" alt="alt"/></i>
                        <input type="text" id="codigo" class="form-control" 
                               placeholder="Digite el campo a buscar">
                        <br>
                        <div class="table-wrapper-scroll-y my-custom-scrollbar">
                            <table class="table table-bordered table-striped mb-0 mt-4" border="1" id="tab2">
                                <p class="fs-3 fst-italic text-center">Productos registrados</p>
                                <thead>
                                    <tr>
                                        <th scope="col">Codigo</th>
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Descripción</th>
                                        <th scope="col">Precio</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%  //llena la tabla de Productos con los datos de la DataBases
                                        ProductosJpaController nes = new ProductosJpaController();
                                        List<Productos> etos = nes.findProductosEntities();
                                        for (Productos ce : etos) {
                                    %>
                                    <tr>
                                        <td><%= ce.getCodigo()%></td>
                                        <td><%= ce.getNombre()%></td>
                                        <td><%= ce.getDescripcion()%></td>
                                        <td><%= ce.getPrecioUnitario()%></td>
                                        <td><button type="submit" name="button" onclick="Digitarpadres(<%= ce.getCodigo()%>, '<%= ce.getNombre()%>',<%= ce.getPrecioUnitario()%>)" class="btn btn-primary">Agregar</button></td>
                                    </tr>
                                    <%}%>
                                </tbody>                                
                            </table>
                        </div><br>
                        <div class="table-wrapper-scroll-y my-custom-scrollbar">
                            <table id="facturaTable" style="background-color: #F0F8E5"  class="table table-bordered table-striped mb-0 mt-4">
                                <p class="fs-3 fst-italic text-center">Productos Agregados</p>
                                <thead>
                                    <tr>
                                        <th scope="col">Codigo</th>
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Cantidad</th>
                                        <th scope="col">Precio</th>
                                        <th scope="col">Subtotal</th>
                                    </tr>
                                </thead>
                                <tbody id="product">
                                </tbody>
                            </table>
                        </div><br><!-- comment -->  
                    </div>
                    <br>
                    <div class="col-sm-12 col-md-12 col-lg-6 text-center">
                        <form action="Factura.jsp" method="post">
                            <div class="mb-3 mt-5">
                                <label class="fs-4 form-label">Vendedor(@):<%= cecion.getAttribute("nombre")%></label>
                            </div>
                            <div class="mb-3">
                                <label for="formGroupExampleInput" class="fs-4 form-label">Id Factura  
                                    <i><img src="img/clipboard_759763.png" alt="alt"/></i>
                                </label>
                                <input type="number" name="id" id="fact" class="form-control"
                                       placeholder="Digite la identificación">
                            </div>
                            <div class="mb-3">
                                <label for="formGroupExampleInput2" class="fs-4 form-label">Cliente</label>
                                <i><img src="img/user_1177568.png" alt="alt"/></i>
                                <input type="number" name="cliente" readonly class="form-control" id="custom"
                                       >
                            </div>
                            <div class="mb-3">
                                <label for="formGroupExampleInput2" class="fs-4 form-label">Producto</label>
                                <i><img src="img/newspaper_3208892.png" alt="alt"/></i>
                                <input type="number" name="producto" readonly class="form-control" id="pro"
                                       >
                            </div>
                            <div class="mb-3">
                                <label for="formGroupExampleInput" class="fs-4 form-label">Nombre del producto  
                                    <i><img src="img/clipboard_759763.png" alt="alt"/></i>
                                </label>
                                <input type="text" name="nproducto" readonly class="form-control" id="npro"
                                       >
                            </div>
                            <div class="mb-3">
                                <label for="formGroupExampleInput2" class="fs-4 form-label">Cantidad</label>
                                <i><img src="img/clipboard_759763.png " alt="alt"/></i>
                                <input type="number" id="cant" name="cantidad" class="form-control" 
                                       >
                            </div>
                            <div class="d-grid gap-2 col-4 mx-auto mt-5px mb-5">
                                <button class="fs-4 btn btn-primary mb-4" name="guardar" type="submit">Guardar</button>
                            </div>
                        </form>
                        <div class="d-grid gap-2 col-4 mx-auto mt-5px mb-5">
                            <button class="fs-4 btn btn-primary mb-4" name="agregar">Agregar</button>
                        </div>  
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
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>

</html>
<%

    FacturaJpaController cf = new FacturaJpaController();
    UsuarioJpaController usu = new UsuarioJpaController();
    ClientesJpaController control = new ClientesJpaController();
    Factura facbus = new Factura();

    if (request.getParameter("guardar") != null) {
        long idFactura = Long.parseLong(request.getParameter("id"));
        int count = Integer.parseInt(request.getParameter("cantidad"));
        int cliente = Integer.parseInt(request.getParameter("cliente"));
        int product = Integer.parseInt(request.getParameter("producto"));
        Date fechaActual = new Date();
        Clientes cli = control.findClientes(cliente);
        int usus = (int) cecion.getAttribute("usuario");
        Usuario u = usu.findUsuario(usus);
        // Crea un objeto Factura con los datos
        facbus = cf.findFactura(idFactura);

        if (facbus != null) {
%>
<script>
                                            Swal.fire({
                                                icon: "error",
                                                title: "Oops...",
                                                text: "factura existente!",
                                                footer: '<a href="#">Why do I have this issue?</a>'
                                            });
</script>
<%
} else if (count == 0 && cliente == 0 && product == 0) {%>
<script>
    Swal.fire({
        icon: "error",
        title: "Oops...",
        text: "Campos Vacios!",
        footer: '<a href="#">Why do I have this issue?</a>'
    });
</script>
<%
} else {
    Factura fact = new Factura();
    fact.setIdfactura(idFactura);
    fact.setFecha(fechaActual);
    fact.setClientesCedula(cli);
    fact.setUsuarioIdusuario(u);
    // Guarda la factura en la base de datos (puedes adaptar esto según tu lógica)
    cf.create(fact);
    List<venta> lista = (ArrayList<venta>) cecion.getAttribute("lista");
    ProductoVentaJpaController controller = new ProductoVentaJpaController();

    for (int i = 0; i < lista.size(); i++) {
        ProductoVenta obj = new ProductoVenta();
        obj.setProductosCodigo(lista.get(i).getProducto());
        obj.setFacturaIdfactura(fact);
        obj.setCantidad(lista.get(i).getCantidad());
        controller.create(obj);
    }

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
<%        }
    }
%>
<script>
    const filtroInput = document.getElementById("clien");
    const filas = document.getElementById("tab").querySelectorAll("table tbody tr");
    filtroInput.addEventListener("input", function () {
        const filtro = filtroInput.value.trim().toLowerCase();
        filas.forEach(function (fila) {
            const textoFila = fila.textContent.toLowerCase();
            if (textoFila.includes(filtro)) {
                fila.style.display = "";
            } else {
                fila.style.display = "none";
            }
        });
       });

    const filtroInputs = document.getElementById("codigo");
    const filass = document.getElementById("tab2").querySelectorAll("table tbody tr");
    filtroInputs.addEventListener("input", function () {
        const filtros = filtroInputs.value.trim().toLowerCase();
        filass.forEach(function (fil) {
            const textoFilas = fil.textContent.toLowerCase();
            if (textoFilas.includes(filtros)) {
                fil.style.display = "";
            } else {
                fil.style.display = "none";
            }
        });
       });
    function Digitarpadre(cc) {

        codigo = document.getElementById("custom");
        codigo.value = cc;
    }
    var cost;
    function Digitarpadres(codigos, nombre, precio) {

        code = document.getElementById("pro");
        code.value = codigos;
        nom = document.getElementById("npro");
        nom.value = nombre;
        cost = precio;
    }

    document.querySelector("button[name='agregar']").addEventListener("click", function () {
        var codigos = document.getElementById("pro").value;
        var cantidad = document.getElementById("cant").value;

        $.ajax({
            type: "POST",
            url: "Readpro.jsp",
            data: "codigo=" + codigos + "&cantidad=" + cantidad,
            dataType: "html",
            success: function (data) {
                $("#product").empty();
                $("#product").append(data);
            }
                     });

    <%
        cecion.removeAttribute("lista");
    %>
    });
    /* Captura los datos del formulario
     var idFactura = document.querySelector("input[name='id']").value;
     var producto = document.querySelector("input[name='producto']").value;
     var cantidad = document.querySelector("input[name='cantidad']").value;
     var Nompro = document.querySelector("input[name='nproducto']").value;
     
     if (idFactura === "" || producto === "" || cantidad === "") {
     alert("Por favor complete todos los campos antes de guardar.");
     return; // No ejecutar la operación si hay campos vacíos
     }
     
     // Crea una nueva fila de datos
     var newRow = document.getElementById("facturaTable").insertRow();
     var cell1 = newRow.insertCell(0);
     var cell2 = newRow.insertCell(1);
     var cell3 = newRow.insertCell(2);
     var cell4 = newRow.insertCell(3);
     var cell5 = newRow.insertCell(4);
     var cell6 = newRow.insertCell(5);
     var cell7 = newRow.insertCell(6);
     var cell8 = newRow.insertCell(7);
     
     // Agrega los valores a las celdas
     cell1.innerHTML = idFactura;
     cell2.innerHTML = Nompro;
     cell3.innerHTML = producto;
     cell4.innerHTML = cantidad;
     cell5.innerHTML = cost;
     cell6.innerHTML = cost * cantidad;
     cell7.innerHTML = (cost * cantidad) * 0.19;
     cell8.innerHTML = (cost * cantidad) + ((cost * cantidad) * 0.19);
     
     
     
     
     
     // Borra los valores del formulario después de agregarlos a la tabla
     // document.querySelector("input[name='cantidad']").value = "";
     
     
     });*/

</script>



