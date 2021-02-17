<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>


    <link rel="stylesheet" href="../stylesheet.css">
</head>

<body class="body">

    <?php include '../headerNoEdit.php'; ?>
    <div class="container">
        <h1>Finalní výsledky</h1>

        <h2>Živí</h2>

        <?php
        $tabulka = "V_0_FINAL";
        include_once '../config.php';

        $conn = getdb();
        $sql = "SHOW COLUMNS FROM $tabulka";
        $result = mysqli_query($conn, $sql);
        echo '<table class="table table-bordered table-sortable sticky-header final"> <thead><tr>';
        $i = 0;
        while ($rowN = mysqli_fetch_array($result)) {
            echo '<th class = "'.$rowN['Field'].'">' . $rowN['Field'] . "</th>";

            $Nadpisy[$i] = $rowN['Field'];
            $i = $i + 1;
        }
        echo "</tr></thead> <tbody>";

        $sql = "SELECT * FROM $tabulka where (Zivoty = 0) and (VyslednyCas is not null) and (Vyloucen = 0)  ";
        $result = mysqli_query($conn, $sql);

        $i = 1;
        while ($data = mysqli_fetch_array($result)) {

            if ($i < 4)
                echo "<tr class = 'gold'>";
            else
                echo "<tr>";

            $i++;

            foreach ($Nadpisy as &$nadpis) {
                echo "<td class='".$nadpis."' >" . $data[$nadpis] . "</td>";
            }
            echo "</tr>";
        }

        echo "</tbody> </table>";
        //mysqli_close($conn);



        ?>

        <h2>Mrtví</h2>
        <?php


        echo '<table class="table table-bordered table-sortable  sticky-header final"> <thead><tr>';
        foreach ($Nadpisy as $Nadpis) {
            echo '<th class = "'.$Nadpis.'">' . $Nadpis . "</th>";
        }

        echo "</tr></thead> <tbody>";

        $sql = "SELECT * FROM $tabulka where (Zivoty != 0) and (VyslednyCas is not null) and (Vyloucen = 0) ";
        $result = mysqli_query($conn, $sql);

        $i = 0;

        while ($data = mysqli_fetch_array($result)) {
            if ($i < 1)
                echo "<tr class='gold'>";
            else
                echo "<tr>";

            $i++;

            foreach ($Nadpisy as &$nadpis) {
                echo "<td class='".$nadpis."'>" . $data[$nadpis] . "</td>";
            }
            echo "</tr>";
        }

        echo "</tbody> </table>";




        ?>

        <h2>Ostatní</h2>
        <?php


        echo '<table class="table table-bordered table-sortable  sticky-header"> <thead><tr class="lightGrey">';
        foreach ($Nadpisy as $Nadpis) {
            echo '<th>' . $Nadpis . "</th>";
        }

        echo "</tr></thead> <tbody>";

        $sql = "SELECT * FROM $tabulka where (VyslednyCas is null) or ((VyslednyCas is not null) and (Vyloucen = 1) )";
        $result = mysqli_query($conn, $sql);


        while ($data = mysqli_fetch_array($result)) {

            echo "<tr class='lightGrey'>";

            foreach ($Nadpisy as &$nadpis) {
                echo "<td >" . $data[$nadpis] . "</td>";
            }
            echo "</tr>";
        }

        echo "</tbody> </table>";
        mysqli_close($conn);



        ?>

    </div>


    <script src="tableSort.js"></script>
</body>

</html>