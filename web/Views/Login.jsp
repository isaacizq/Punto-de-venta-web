<%-- 
    Document   : Login
    Created on : 23/10/2023, 12:05:48 PM
    Author     : Isaac
--%>
<%@page import="java.util.List"%>
<%@page import="Logic.Usuario"%>
<%@page import="Controller.UsuarioJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!doctype html>
<html lang="es">
    <head>
        <title>Login</title>
        <%
            response.setHeader("cache-Control", "no_Cache,no store,must-revalidate");
        %>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Bootstrap CSS v5.2.1 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
        <link rel="stylesheet" href="styles.css"/>
    </head>
    <body>
        <header>
            <!-- place navbar here -->
        </header>
        <main>
            <div class="container mt-4 col-lg-4 bs-info-bg-subtle ">
                <form action="Login.jsp" method="post">
                    <div class="card-body  px-5 py-3" style="background-color: white">
                        <center>
                            <h3>Login</h3>
                            <img src="img/20547283_6310507.jpg" class="img-fluid" width="400">
                            <h5>Bienvenidos </h5>
                        </center>
                        <div class="mb-3">
                            <label for="exampleFormControlInput1" class="form-label">ID de Usuario </label>
                            <input type="number" class="form-control" name="usuario" id="exampleFormControlInput1"
                                   placeholder="Example:904405045">
                        </div>
                        <label for="inputPassword" class="col-sm-2 col-form-label">Contreseña</label>
                        <input type="password" class="form-control" name="password" id="inputPassword" placeholder="********">
                        <br><br>
                        <div class="d-grid gap-2 col-4 mx-auto mt-5px mb-5">
                            <button class="btn btn-primary" name="buton" type="submit">Iniciar</button>                  
                        </div>
                    </div>
                </form>
            </div>
        </main>
        <footer>
            <!-- place footer here -->
        </footer>
        <!-- Bootstrap JavaScript Libraries -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
                integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous">
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
                integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz" crossorigin="anonymous">
        </script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>
</html>
<%
    UsuarioJpaController cu = new UsuarioJpaController();
    HttpSession sesion = request.getSession();
    String boton = request.getParameter("buton");
    if (boton != null) {
        int user = Integer.parseInt(request.getParameter("usuario"));
        Usuario u = cu.findUsuario(user);
        if (u != null) {
            sesion.setAttribute("usuario", user);
            String password = request.getParameter("password");
            if (password.equals(u.getContrasena())) {
                sesion.setAttribute("password", password);
                String name = (u.getNombreCompleto());
                sesion.setAttribute("nombre", name);
                sesion.setAttribute("codigo", u.getIdusuario());
                response.sendRedirect("index.jsp");
            } else {
%>
<script>
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Contraseña invalida',
                    })
</script>
<%
    }
} else {
%>
<script>
    Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: 'Id usuario no existente',
    })
</script>
<%
        }
    }


%>