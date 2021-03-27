<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.css">

</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <h1><?php include_once "function.php";
            echo AktualniAkce(); ?></h1>
        <div class="navbar-collapse">

            <ul class="navbar-nav mr-auto mt-2 mt-lg-0">

                <li class="nav-item active">
                    <a class="nav-link" href="/app/index.php"><i class="fa fa-arrow-left" aria-hidden="true"></i> Přehled tabulek<span class="sr-only">(current)</span></a>
                </li>

                <li class="nav-item active">
                    <a class="nav-link" href="/NRdashboard">Node RED <span class="sr-only">(current)</span></a>
                </li>

                <li class="nav-item active">
                    <a class="nav-link" href="/app/vsechnyData.php" >Všechny data<span class="sr-only">(current)</span></a>
                </li>

                <li class="nav-item active">
                    <a class="nav-link" href="/app/Tabulka.php?Nazev=TTN_Data">TTN_Data <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="/" onclick="javascript:event.target.port=3333">Stanoviste <span class="sr-only">(current)</span></a>
                </li>

                <li class="nav-item active">
                    <a class="nav-link" href="/" onclick="javascript:event.target.port=3344">Online závod <span class="sr-only">(current)</span></a>
                </li>
                
                <li class="nav-item active">
                    <a class="nav-link" href="/" onclick="javascript:event.target.port=3355"> Po závodu <span class="sr-only">(current)</span></a>
                </li>

                <li class="nav-item active">
                    <a class="nav-link" href="../logout.php">Odhlásit se <span class="sr-only">(current)</span></a>
                </li>
            </ul>
        </div>
    </nav>

</body>

</html>