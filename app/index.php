<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src='https://use.fontawesome.com/releases/v5.15.2/js/all.js'data-auto-a11y='true'></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
    <title>Administrace závodu</title>

    <link rel="stylesheet" href="../stylesheet.css">
</head>

<body>
    <?php include 'headerStatus.php'; ?>
    <div class="bodyIndex">
        <div class="uvod">
            <div class="vysledky">
                <ul>
                    <li class="button"><a href="funkce/FinalniVysledky.php"> <i class="fa fa-list-alt" aria-hidden="true"></i> Výsledky</a></li>
                    <li class="button"><a href="funkce/PrubezneVysledky.php"> <i class="fas fa-ruler-combined"></i> Detailní výsledky</a></li>
                    <li class="button"><a href="/app/serial/"> <i class="fas fa-plug"></i> Data RFID</a></li>

                </ul>
            </div>
            <div class="tabulky">
                <div class="prehled">
                    <h1>Před závodem</h1>
                    <ul>
                        <li class="button"><a href="Tabulka.php?Nazev=Cip"> <i class="fa fa-tags"></i> Čipy</a></li>
                        <li class="button"><a href="Tabulka.php?Nazev=Ucastnik"> <i class="fa fa-users" aria-hidden="true"></i> Účastníci</a></li>

                        <li class="button"><a href="Tabulka.php?Nazev=Stanoviste"> <i class="fa fa-map-marker-alt"></i> Stanoviště</a></li>
                        <li class="button"><a href="Tabulka.php?Nazev=Skupina"> <i class="fa fa-object-group" aria-hidden="true"></i> Skupina stanovišť</a></li>
                        <li class="button"><a href="funkce/SpolecnyStart.php"><i class="fas fa-flag"></i> Společný start</a></li>

                    </ul>
                </div>
                <div class="stanoviste">
                    <h1>Body</h1>
                    <ul>
                        <?php
                        include_once "function.php";
                        $result = SeznamUkolovychStanovist();

                        while ($data = mysqli_fetch_array($result)) {
                            echo '<li class="button"><a href="Tabulka.php?Nazev=' . $data['Nazev'] . '&Popis=' . $data['Popis'] . '"> <i class="fa fa-bullseye" aria-hidden="true"></i> ' . $data['Nazev'] . " - " . $data['Popis'] . "</a></li>";
                        }
                        ?>
                        <li class="button"><a href="Tabulka.php?Nazev=ZtraceneZivoty"> <i class="fa fa-heart"></i> Ztracené životy</a></li>
                    </ul>
                </div>
            </div>           
        </div>
    </div>
</body>

</html>