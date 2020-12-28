<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" href="stylesheet.css">
</head>

<body class="body">
    <!--<?php include 'header.php'; ?>*******************-->
    <div class="uvod">
        <h1>Hlavní tabulky</h1>
        <ul>
            <li class="button"><a href="Tabulka.php?Nazev=Cipy">Čipy</a></li>
            <li class="button"><a href="Tabulka.php?Nazev=Ucastnici">Účastníci</a></li>
            <li class="button"><a href="Tabulka.php?Nazev=Stanoviste">Seznam stanovišť</a></li>
            <li class="button"><a href="Tabulka.php?Nazev=ZtraceneZivoty">Ztracené životy</a></li>
            <li class="button"><a href="Tabulka.php?Nazev=Zavod">Závod</a></li>

        </ul>
        <h1>Jednotlivé stanoviště</h1>
        <ul>
            <?php
            include("function.php");
            $result = SeznamUkolovychStanovist();

            while ($data = mysqli_fetch_array($result)) {
                echo '<li class="button"><a href="TstanovisteBody.php?Nazev=' . $data['Nazev'] . '">' . $data['Nazev'] . "</li>";
            }
            ?>
        </ul>
    </div>
</body>

</html>