<?php
 include_once '../config.php';
 $conn = getdb();
if ($_SERVER["REQUEST_METHOD"] == "POST") {


foreach ($_POST as $key => $value) {
    if(strpos($key , 'S_') == 1 )
    {
        $sql = 'INSERT INTO Zavod (ID_Cip, ID_Stanoviste, Cas) values ('.ltrim($key,"_S_").', '.$_POST['stanoviste'].', "'.$_POST['cas'].'")';
       
        echo $sql ."<br>";
        $result = mysqli_query($conn, $sql);
        echo mysqli_error($conn);
    }

   
}


}

?>


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

<body>

    <body class="body">
        <div class="container">

            <h1>Společný start</h1>

            <form action="" method="POST" enctype="multipart/form-data">

                <?php

                $sql = "SHOW COLUMNS FROM Ucastnik";

                $result = mysqli_query($conn, $sql);
                echo '<table class="table table-bordered"> <thead><tr>';
                $i = 0;
                echo "<th> <input type='checkbox'  id='all' name='checkedAll' onchange='OncheckedAll(this)' value='1'> Vše </th>";
                while ($rowN = mysqli_fetch_array($result)) {
                    echo '<th>' . $rowN['Field'] . "</th>";
                    $Nadpisy[$i] = $rowN['Field'];
                    $i = $i + 1;
                }
                echo "</thead> <tbody>";

                $sql = "SELECT * FROM Ucastnik";
                $result = mysqli_query($conn, $sql);




                while ($data = mysqli_fetch_array($result)) {
                    echo "<td class='checkInput'><input type='checkbox'  id='checkbox' name=_S_'" . $data["ID_Cip"] . "' value='1'></td>";
                    foreach ($Nadpisy as &$nadpis) {
                        echo "<td>" . $data[$nadpis] . "</td>";
                    }
                    echo "</tr>";
                }

                echo "</tbody> </table>";
                mysqli_close($conn);



                ?>
                <label for="appt">Čas:</label>
                <input type="datetime-local" id="cas" name="cas" required='required'>

                <label for="stanoviste">Choose your browser from the list:</label>
                <input list="stanovisteList" name="stanoviste" id="stanoviste" required='required'>


                <?php
                include_once "../function.php";
                $result = SeznamVsechStanovist();

                $message = "<datalist id='stanovisteList' >";
                while ($data = mysqli_fetch_array($result)) {

                    $message .= '<option value="' . $data["ID"] . '">' . $data["ID"] . ' - ' . $data["Nazev"] . '</option>';
                }
                $message .=  "</datalist>";
                echo $message;

                ?>

                <input type="submit" value="Provést">
            </form>

        </div>

    </body>

</html>


<script>
    function OncheckedAll(checkboxElem) {
        var input = $("table tbody .checkInput");

        if (checkboxElem.checked) {
            input.each(function() {
                $(this).children().prop("checked", true);
            });
        } else {
            input.each(function() {
                $(this).children().prop("checked", false);
            });
        }


    }
</script>