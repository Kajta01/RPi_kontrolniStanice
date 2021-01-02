<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <title>Document</title>

    <link rel="stylesheet" href="stylesheet.css">
</head>

<body class="body">
    <!--<?php include 'header.php'; ?>*******************-->
    <div class="uvod">
        <h1>Přehled tabulek</h1>
        <ul>
            <li class="button"><a href="Tabulka.php?Nazev=Cip"> <i class="fa fa-tags"></i> Čipy</a></li>
            <li class="button"><a href="Tabulka.php?Nazev=Ucastnik"> <i class="fa fa-users" aria-hidden="true"></i> Účastníci</a></li>
            <li class="button"><a href="Tabulka.php?Nazev=Stanoviste"> <i class="fa fa-map-marker-alt"></i> Seznam stanovišť</a></li>
            <li class="button"><a href="Tabulka.php?Nazev=ZtraceneZivoty"> <i class ="fa fa-heart"></i> Ztracené životy</a></li>
            <li class="button"><a href="Tabulka.php?Nazev=Zavod"> <i class='fa fa-running'></i> Závod</a></li>

        </ul>
        <h1>Stanoviště</h1>
        <ul>
            <?php
            include("function.php");
            $result = SeznamUkolovychStanovist();

            while ($data = mysqli_fetch_array($result)) {
                echo '<li class="button"><a href="TstanovisteBody.php?Nazev=' . $data['Nazev'] . '"> <i class="fa fa-bullseye" aria-hidden="true"></i> ' . $data['Nazev'] . "</li>";
            }
            ?>
        </ul>
    </div>
</body>

</html>