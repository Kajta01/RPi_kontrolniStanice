

<?php
// Load the database configuration file
include_once 'config.php';
$conn = getdb();
$tabulka = $_POST['nameTable'];
if (isset($_POST['importSubmit'])) {
    echo "File: ".$_FILES['file']['name'] . "<br>";
    // Allowed mime types
    $csvMimes = array('text/x-comma-separated-values', 'text/comma-separated-values', 'application/octet-stream', 'application/vnd.ms-excel', 'application/x-csv', 'text/x-csv', 'text/csv', 'application/csv', 'application/excel', 'application/vnd.msexcel', 'text/plain');
    // Validate whether selected file is a CSV file
    if (!empty($_FILES['file']['name']) && in_array($_FILES['file']['type'], $csvMimes)) {

        // If the file is uploaded
        if (is_uploaded_file($_FILES['file']['tmp_name'])) {


            $jsonData = getJsonFromCSV($_FILES['file']['tmp_name']);

            $data = json_decode($jsonData, true);

            $sloupce = getSloupce();

            foreach ($data as $da) {
                $SQLdata = "";
                $SQLnazvy = "";

                foreach ($sloupce as $sloupec) {
                    if($sloupec != "ID"){
                        $SQLnazvy .= $sloupec.", "; 
                    if ($da[$sloupec] != "") {
                        $SQLdata .= '"' . $da[$sloupec] . '", ';
                    } else {
                        $SQLdata .=  "NULL, ";
                    }
                }
                }
                $SQLdata = rtrim($SQLdata, ", ");
                $SQLnazvy = rtrim($SQLnazvy, ", ");
                $sql = "INSERT INTO " . $tabulka . " (".$SQLnazvy.") values (".$SQLdata.")";

                echo "<br>" . $sql;

                $result = mysqli_query($conn, $sql);
                echo $result;

                if($result == 1){
                   echo "<p class='btn btn-success' align='center'>New record created successfully</p>";
                   }
                   else{
                    echo   "<p class='btn btn-danger' align='center:'>Error: " . $sql . "<br>" . mysqli_error($conn).
                    "<br> <strong> !!! Pres F5 !!!</strong></p>";
                   }

                


            }
            mysqli_close($conn);

            $qstring = '?status=succ';
        } else {
            $qstring = '?status=err';
        }
    } else {
        $qstring = '?status=invalid_file';
    }
}

// Redirect to the listing page
//header("Location: index.php".$qstring);

function getJsonFromCSV($file)
{
    // open csv file
    if (!($fp = fopen($file, 'r'))) {
        die("Can't open file...");
    }

    //read csv headers
    $key = fgetcsv($fp, "1024", ",");

    obsahujeSloupce($key);

    // parse csv rows into array
    $json = array();
    while ($row = fgetcsv($fp, "1024", ",")) {
        $json[] = array_combine($key, $row);
    }

    // release file handle
    fclose($fp);

    // encode array to json
    return json_encode($json);
}

function obsahujeSloupce($nadpisy)
{
    $tabulka = $_POST['nameTable'];
    $conn = getdb();
    $chyby = array();

    echo "Povinné sloupce: <br>";
    $sql = "SHOW COLUMNS FROM $tabulka WHERE `Null` = 'NO'";
    $result = mysqli_query($conn, $sql);
    while ($col = mysqli_fetch_array($result)) {
        $col = $col['Field'];
        if ($col != "ID") {
            echo "Sloupec '" . $col . "' ";
            if (in_array($col, $nadpisy)) {
                echo '<i style="color:green;">obsahuje <br></i>';
            } else {
                echo '<i style="color:red;">neobsahuje <br></i>';
                array_push($chyby, '"' . $col . '"');
            }
        }
    }
    echo mysqli_error($conn);
    echo "<br>";
    echo "Volitelné sloupce: <br>";
    $sql = "SHOW COLUMNS FROM $tabulka WHERE `Null` = 'YES'";
    $result = mysqli_query($conn, $sql);
    while ($col = mysqli_fetch_array($result)) {
        $col = $col['Field'];
        if ($col != "ID") {
            echo "Sloupec '" . $col . "' ";
            if (in_array($col, $nadpisy)) {
                echo '<i style="color:green;">obsahuje <br></i>';
            } else {
                echo '<i style="color:red;">neobsahuje <br></i>';
            }
        }
    }
    echo "<br>";
    if (empty($chyby)) {
        echo '<p style="color:green;">  Vše je ok   </p>';
    } else {
        echo "<p>Chyby: </p>";
        foreach ($chyby as $ch) {
            echo $ch;
        }
        exit();
    }
    echo "<br>";
}
function getSloupce()
{
    $tabulka = $_POST['nameTable'];
    $conn = getdb();
    $sloupce = array();

    $sql = "SHOW COLUMNS FROM $tabulka ";
    $result = mysqli_query($conn, $sql);
    while (($row =  mysqli_fetch_array($result))) {
        $sloupce[] = $row['Field'];
    }
    mysqli_close($conn);
    return  $sloupce;
}


?>


