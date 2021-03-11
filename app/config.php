<?php
function getdb(){
    $servername = "localhost";
    $username = "grafana";
    $password = "grafana";
    $db = "CJTZV_19";
    try {
        $conn = mysqli_connect($servername, $username, $password, $db);
        //echo "Connected successfully"; 
    }
        catch(exception $e){
        echo "Connection failed: " . $e->getMessage();
    }
        return $conn;    
}
function getdbApp(){
    $servername = "localhost";
    $username = "grafana";
    $password = "grafana";
    $db = "App";
    try {
        $conn = mysqli_connect($servername, $username, $password, $db);
        //echo "Connected successfully"; 
    }
        catch(exception $e){
        echo "Connection failed: " . $e->getMessage();
    }
        return $conn;    
}

function getDeletePassword(){
    return "grafana";
}

function getIP(){
    return "89.176.133.101";//"192.168.0.109";
}

?>
