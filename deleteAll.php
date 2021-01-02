

<?php
include_once 'config.php';
$conn = getdb();


$tabulka  = $_GET['Nazev'];

echo $tabulka;


 $sql = "DELETE FROM " . $tabulka;
 

 $result = mysqli_query($conn, $sql);
 if($result == 1){
  $message = "<p class='btn btn-info' align='center'>New record created successfully</p>";
 }
 else{
  $message =  "<p class='btn btn-danger' align='center:'>Error: " . $sql . "<br>" . mysqli_error($conn).
  "<br> <strong> !!! Pres F5 !!!</strong></p>";
 }
 mysqli_close($conn);

echo $message;
$url= "Tabulka.php?Nazev=". $_GET['Nazev'];
//header( "Location: $url" );

?>



DELETE FROM employees;