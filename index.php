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

<body class="bodyIndex">
    <!--<?php include 'header.php'; ?>*******************-->
    <div class="uvod">
        <div class="vysledky">
            <ul>
                <li class="button"><a href="Tabulka.php?Nazev=0_FINAL"> <i class="fa fa-list-alt" aria-hidden="true"></i> Výsledky</a></li>
                <li class="button"><a href="Tabulka.php?Nazev=V_000_Vysledky"> <i class="fa fa-list-alt" aria-hidden="true"></i> Průběžné výsledky</a></li>

            </ul>
        </div>
        <div class="tabulky">
            <div class="prehled">
                <h1>Přehled tabulek</h1>
                <ul>
                    <li class="button"><a href="Tabulka.php?Nazev=Cip"> <i class="fa fa-tags"></i> Čipy</a></li>
                    <li class="button"><a href="Tabulka.php?Nazev=Ucastnik"> <i class="fa fa-users" aria-hidden="true"></i> Účastníci</a></li>
                    <li class="button"><a href="Tabulka.php?Nazev=Skupina"> <i class="fa fa-object-group" aria-hidden="true"></i> Skupina stanovišť</a></li>
                    <li class="button"><a href="Tabulka.php?Nazev=Stanoviste"> <i class="fa fa-map-marker-alt"></i> Seznam stanovišť</a></li>
                    <li class="button"><a href="Tabulka.php?Nazev=ZtraceneZivoty"> <i class="fa fa-heart"></i> Ztracené životy</a></li>
                    <li class="button"><a href="Tabulka.php?Nazev=Zavod"> <i class='fa fa-running'></i> Závod</a></li>

                </ul>
            </div>
            <div class="stanoviste">
                <h1>Stanoviště</h1>
                <ul>
                    <?php
                    include_once "function.php";
                    $result = SeznamUkolovychStanovist();

                    while ($data = mysqli_fetch_array($result)) {
                        echo '<li class="button"><a href="Tabulka.php?Nazev=' . $data['Nazev'] . '&Popis='.$data['Popis'].'"> <i class="fa fa-bullseye" aria-hidden="true"></i> ' . $data['Nazev'] . " - " . $data['Popis'] . "</a></li>";
                    }
                    ?>
                </ul>
            </div>
        </div>
        <div class="ostatni">
            <div class="funkce">
                <h1>Funkce</h1>

                <ul>
                    <li class="button"><a href="funkce/SpolecnyStart.php"> Společný start</a></li>

                </ul>
            </div>
            <div class="dotazy">
                <h1>Dotazy</h1>
                <ul>
                    <?php
                    include_once "function.php";
                    $result = SeznamSkupinStanovist();

                    while ($data = mysqli_fetch_array($result)) {
                        echo '<li class="button"><a href="Tabulka.php?Nazev=V_' . $data['Nazev'] . '"> <i class="fa fa-bullseye" aria-hidden="true"></i> ' . $data['Nazev']  . "</a></li>";
                    }
                    ?>
                </ul>
            </div>
        </div>
    </div>
</body>

</html>