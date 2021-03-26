<?php
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

function AktualniAkce()
{
    $conn = getdbApp();
   
    $sql = "SELECT Nazev FROM Aktualni_Akce Limit 1";
    
    $result = mysqli_query($conn, $sql);
    mysqli_close($conn);


    while ($data = mysqli_fetch_array($result)) {
        $result = $data['Nazev'];
    }
    return  $result;
}

function getdb(){
    $servername = "localhost";
    $username = "grafana";
    $password = "grafana";
    $db = AktualniAkce();

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
