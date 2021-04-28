<?php include_once 'config.php'; ?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> <?php echo $_GET['Nazev'] . " - " . AktualniAkce(); ?> </title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src='https://use.fontawesome.com/releases/v5.15.2/js/all.js'data-auto-a11y='true'></script>

    <link rel="stylesheet" href="../stylesheet.css">
</head>

<body class="body">
    <?php include 'headerStatus.php';?>
    
    <h1>
        <?php if ($_GET['Popis'] == "") {
            echo $_GET['Nazev'];
        } else {
            echo $_GET['Nazev'] . " - " . $_GET['Popis'];
        } ?>
    </h1>
    <div class="container">
   
        <?php
        if ($_GET['Nazev'] == "Stanoviste") {
            echo '<iframe src="http://' . getIP() . ':3838/Stanoviste" width="100%" height="400px"></iframe>';
        }
        if($_GET['Edit'] != "N") {include 'header.php';}
        
        $nazev = $_GET['Nazev'];
        if (($nazev == "TTN_Data" ) && ($_GET['Edit'] != "N")) {
            $conn = getdbApp();
            $akce = AktualniAkce();
            $sql = "SELECT * FROM $nazev where Akce = '$akce' ";
        } else if(($nazev == "TTN_Data" )) { 
            $conn = getdbApp(); 
            $sql = "SELECT * FROM $nazev"; 
        } else {
            $conn = getdb();
            $sql = "SELECT * FROM $nazev";
        }
        $sqlC = "SHOW COLUMNS FROM $nazev";
        $result = mysqli_query($conn, $sqlC);
        echo '<div class="table-responsive">';
        echo '<table class="table data-view table-bordered table-striped"> <thead><tr>';
        $i = 0;
        while ($rowN = mysqli_fetch_array($result)) {
            echo '<th>' . $rowN['Field'] . "</th>";
            $Nadpisy[$i] = $rowN['Field'];
            $i = $i + 1;
        }
        echo "</thead> <tbody>";

        
        $result = mysqli_query($conn, $sql);

        while ($data = mysqli_fetch_array($result)) {
            foreach ($Nadpisy as &$nadpis) {
                echo "<td>" . $data[$nadpis] . "</td>";
            }
            echo "</tr>";
        }

        echo "</tbody> </table> </div>";
        mysqli_close($conn);
        ?>
    </div>
</body>

</html>