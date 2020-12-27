<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="stylesheet.css">
</head>
<body class="body">
    <?php include 'header.php';?>
    <div class="container">
        <h1> <?php echo $_GET['Nazev']; ?></h1>

        <?php 
            include 'config.php';
            $nazev = $_GET['Nazev'];

            $conn = getdb();
            $sql = "SHOW COLUMNS FROM $nazev";
            $result = mysqli_query($conn,$sql);
            echo '<table class="table table-bordered"> <thead><tr>';
            $i = 0;
            while($rowN = mysqli_fetch_array($result)){
                echo'<th>'. $rowN['Field']."</th>";
                $Nadpisy[$i] = $rowN['Field'] ;
                $i=$i + 1;
            }
            echo "</thead> <tbody>";
        
            $sql = "SELECT * FROM $nazev";
            $result = mysqli_query($conn,$sql);
        
        
            while ($data = mysqli_fetch_array($result)) {
                foreach($Nadpisy as &$nadpis)
                {
                    echo "<td>" . $data[$nadpis] . "</td>";
                }
                echo "</tr>";
            }  
        
            echo "</tbody> </table>";
            mysqli_close($conn);

        
        
        ?>
    </div>



</body>
</html>
