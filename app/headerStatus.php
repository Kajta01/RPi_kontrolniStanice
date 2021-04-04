<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>

</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-light " style="background-color: #f1f1f1;">
        <div class="container-lg">

            <a href="/app/index.php">
                <h1><?php include_once "function.php";
                    echo AktualniAkce(); ?></h1>
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">

                <ul class="navbar-nav">

                    <li class="nav-item">
                        <a class="nav-link" href="/app/index.php">Přehled tabulek</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/NRdashboard">Node RED </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="/app/vsechnyData.php">Všechny data</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/Stanoviste">Stanoviste </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/Vysledky"> Po závodu</a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Online data
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">

                            <li><a class="dropdown-item" href="/OnlineZavod">Online závod</a></li>
                            <li><a class="dropdown-item" href="/app/Tabulka.php?Nazev=TTN_Data">TTN_Data</a></li>
                        </ul>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="/logout.php">Odhlásit se</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>



</body>

</html>