<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

    <title>Document</title>
</head>
<body>
    <div class="menu" id="menu">
    <ul>
        <li><a href="index.php"><i class="fa fa-arrow-left" aria-hidden="true"></i> Přehled tabulek</a></li>
        <li><a href="<?php echo "TabulkaEdit.php?Nazev=" . $_GET['Nazev'] . "&Popis=".$_GET['Popis']?>"><i class="fa fa-pencil"></i> Editace</a></li>       
               
        
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
