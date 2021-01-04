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
    <div class="container">
    <h1>Finalní výsledky</h1>

    

        <?php 
            $tabulka = "V_0_FINAL";
            include_once '../config.php';

            $conn = getdb();
            $sql = "SHOW COLUMNS FROM $tabulka";
            $result = mysqli_query($conn,$sql);
            echo '<table class="table table-bordered table-sortable"> <thead><tr>';
            $i = 0;
            while($rowN = mysqli_fetch_array($result)){
                echo'<th>'. $rowN['Field']."</th>";
                
                $Nadpisy[$i] = $rowN['Field'] ;
                $i=$i + 1;
            }
            echo "</tr></thead> <tbody>";
        
            $sql = "SELECT * FROM $tabulka where Zivoty = 0";
            $result = mysqli_query($conn,$sql);
        
            $i = 1;
            while ($data = mysqli_fetch_array($result)) {
                
                if($i<4)
                echo "<tr class = 'gold'>";
                else
                echo "<tr>";

                $i++;

                foreach($Nadpisy as &$nadpis)
                {
                    echo "<td >" . $data[$nadpis] . "</td>";
                    
                }
                echo "</tr>";
            }  
        
            echo "</tbody> </table>";
            //mysqli_close($conn);

        
        
        ?>
        <?php 
        
            
        echo '<table class="table table-bordered table-sortable"> <thead><tr>';
            foreach($Nadpisy as $Nadpis)
            {
                echo'<th>'. $Nadpis."</th>";
            }

            echo "</tr></thead> <tbody>";
        
            $sql = "SELECT * FROM $tabulka where Zivoty != 0";
            $result = mysqli_query($conn,$sql);
        
        
            while ($data = mysqli_fetch_array($result)) {

                foreach($Nadpisy as &$nadpis)
                {
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
