<?php
include 'config.php';
$conn = getdb();


$tabulka  = $_POST['Tabulka'];
$id  = $_POST['ID'];



$sql = "SELECT * FROM " . $tabulka;
//echo $sql;
$result = mysqli_query($conn, $sql);

$message = "<select class ='combo'> <option value='NULL'> NULL </option>";

while ($data = mysqli_fetch_array($result)) {

    switch ($tabulka) {
        case "Ucastnik":
            $message .= '<option value="' . $data["ID"] . '">' . $data["ID"] . ' - ' . $data["Prezdivka"] . '</option>';
            break;
        case "Stanoviste":
            $message .= '<option value="' . $data["ID"] . '">' . $data["ID"] . ' - ' . $data["Nazev"] . '</option>';
            break;
        case "Cip":
            $message .= '<option value="' . $data["ID"] . '">' . $data["ID"] . '</option>';
            break;
        case "Skupina":
            $message .= '<option value="' . $data["ID"] . '">' . $data["ID"] . ' - ' . $data["Nazev"] . '</option>';
            break;
    }
}
$message .=  "</select>";
mysqli_close($conn);




$response = array();
$response['id'] = $id;
$response['sql'] = $sql;
$response['message'] = $message;
exit(json_encode($response));
