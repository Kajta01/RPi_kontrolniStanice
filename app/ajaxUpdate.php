<?php
include_once 'config.php';
$conn = getdb();


$tabulka  = $_POST['Tabulka'];
$data  =  $_POST['data'];






if ($tabulka==''){echo "null";}

$decodedData = json_decode($data, true);
 
//var_dump the array so that we can view it's structure.
//var_dump($decodedData);
$hodnoty = "";
foreach($decodedData as $key => $value)
{

  $hodnoty .= $key  ." = ". $value .", ";
  
}

$upraveneHodnoty = rtrim($hodnoty, ", ");
//echo $upraveneHodnoty;

 $sql = "UPDATE " . $tabulka . " SET " .$upraveneHodnoty. " WHERE id = ".$decodedData['ID'];



 /**UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition; */




 //echo $sql;
 $result = mysqli_query($conn, $sql);
 if($result == 1){
  $message = "<p class='btn btn-success' align='center'>Record updated successfully</p>";
 }
 else{
  $message =  "<p class='btn btn-danger' align='center:'>Error: " . $sql . "<br>" . mysqli_error($conn).
  "<br> <strong> !!! Pres F5 !!!</strong></p>";
 }
 mysqli_close($conn);

$response = array();
$response['success'] = $result;
$response['general_message'] = $message;
$response['sql'] = $sql;
exit(json_encode($response));

?>