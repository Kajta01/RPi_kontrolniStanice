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

    <?php include '../headerNoEdit.php';?>
    <div class="obsah-VelkaTabulka">
    <h1>Průběžné výsledky</h1>

    

        <?php 
            $tabulka = "V_000_Vysledky";
            include_once '../config.php';

            $conn = getdb();
            $sql = "SHOW COLUMNS FROM $tabulka";
            $result = mysqli_query($conn,$sql);
            echo '<table id="vysledky" class="table table-bordered table-sortable sticky-header">.
            <colgroup>
                <col span="2" >
                <col span="1" class="border">
                <col span="4" >
                <col span="1" class="border">
                <col span="6" >
                <col span="1" class="border">
                <col span="2" >
                <col span="1" class="border">
                <col span="2" >
                <col span="1" class="border">
                <col span="2" >
                <col span="1" class="border">
                <col span="2" >
                <col span="1" class="border">

            </colgroup>           
            <thead><tr>';
            $i = 0;
            while($rowN = mysqli_fetch_array($result)){
                echo'<th>'. $rowN['Field']."</th>";
                
                $Nadpisy[$i] = $rowN['Field'] ;
                $i=$i + 1;
            }
            echo "</tr></thead> <tbody>";
        
            $sql = "SELECT * FROM $tabulka";
            $result = mysqli_query($conn,$sql);
        
        
            while ($data = mysqli_fetch_array($result)) {
                if($data["Vyloucen"] == 1)
                echo "<tr class='lightGrey'>";
                else
                echo "<tr>";
                foreach($Nadpisy as &$nadpis)
                {
                    $hodnota="";
                    if (!in_array($nadpis, array("ID", "Prezdivka", "Vyloucen" )) )
                    $hodnota = ($data[$nadpis] != "0" and $data[$nadpis] != null) ? "notNull" : "null";
                    echo "<td class='".$nadpis. " " .$hodnota."'>" . $data[$nadpis] . "</td>";
                }
                echo "</tr>";
            }  
        
            echo "</tbody> </table>";
            mysqli_close($conn);

        
        
        ?>
    </div>


    <script src="tableSort.js"></script>
    <script src="kontrolaDat.js"></script>
</body>
</html>
