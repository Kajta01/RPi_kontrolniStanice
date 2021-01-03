<?php
include_once "config.php";

function SeznamUkolovychStanovist(){

    $conn = getdb();
    $sql = "SELECT Nazev, Popis FROM Stanoviste WHERE Ukolove is True";
    $result = mysqli_query($conn, $sql);

    mysqli_close($conn);
    return $result;
}
function SeznamVsechStanovist(){

    $conn = getdb();
    $sql = "SELECT ID, Nazev FROM Stanoviste";
    $result = mysqli_query($conn, $sql);

    mysqli_close($conn);
    return $result;
}

function ExistujeTabulka($nazev){
    $conn = getdb();
    $sql = "SHOW COLUMNS FROM $nazev";
    $result = mysqli_query($conn, $sql);
    $data = mysqli_fetch_array($result);
    mysqli_close($conn);

    return $data['Field'];
}

function VytvoritTabulkuStanoviste($nazev)
{
    
    $conn = getdb();
    $sql = "CREATE TABLE $nazev (
        ID_Ucastnik int NOT NULL,
        Body int NOT NULL,
        FOREIGN KEY (ID_Ucastnik) REFERENCES Ucastnici(ID)
    );";
    $result = mysqli_query($conn, $sql);

    echo "vytvoreno";
    mysqli_close($conn);
}

 function StanovisteBodyTabulka($nazev){

    $existuje = ExistujeTabulka($nazev);
    if($existuje == null)
    {
        echo "null";
        VytvoritTabulkuStanoviste($nazev);
    }
    else
    {
        echo "ano";
        $conn = getdb();
        $sql = "SHOW COLUMNS FROM $nazev";
        $result = mysqli_query($conn,$sql);
        while($row = mysqli_fetch_array($result)){
            echo $row['Field']."<br>";
        }
        mysqli_close($conn);
    }

} 

//StanovisteBodyTabulka("aaaaa");

?>