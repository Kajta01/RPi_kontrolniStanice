<?php

    $servername = "localhost";
    $username = "grafana";
    $password = "grafana";
    $db = "Users";
    try {
        $conn = mysqli_connect($servername, $username, $password, $db);
        //echo "Connected successfully"; 
    }
        catch(exception $e){
        echo "Connection failed: " . $e->getMessage();
    }
        

?>