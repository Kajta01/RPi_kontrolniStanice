<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Document</title>
</head>
<body>
    <div class="menu" id="menu">
    <ul>
        <li><a href="index.php">Domů</a></li>
        <li><a href="<?php echo "TabulkaEdit.php?Nazev=".$_GET['Nazev']?>">Edit</a></li>
        <li><a href="<?php echo "Import.php?Nazev=".$_GET['Nazev']?>">Import</a></li>
        <li><a href="<?php echo "deleteAll.php?Nazev=".$_GET['Nazev']?>" 
        onclick="return do_check();">Odstranit vše</a></li>
        
        
    </ul>
    </div>
</body>
</html>


<script>
function do_check()
{
    var return_value=prompt("Heslo pro smazání:");
    if(return_value==="grafana"){
        alert("Správné heslo!!");
        return true;
    }
    else{
        alert("Špatné heslo!");
        return false;
    }
        

}
</script>
