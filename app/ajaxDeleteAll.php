

<?php
include_once 'config.php';
$conn = getdb();


$tabulka  = $_POST['Tabulka'];



$sql = "DELETE FROM " . $tabulka;


$result = mysqli_query($conn, $sql);


if ($result == 1) {
   $message = "<p class='btn btn-success' align='center'>Deleted</p>";
} else {
   $message =  "<p class='btn btn-danger' align='center:'>Error: " . $sql . "<br>" . mysqli_error($conn) .
      "<br> <strong> !!! Pres F5 !!!</strong></p>";
}

mysqli_close($conn);

$response = array();
$response['success'] = $result;
$response['general_message'] = $message;
$response['sql'] = $sql;
exit(json_encode($response));

?>
