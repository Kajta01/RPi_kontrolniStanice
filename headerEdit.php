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
        
        <li><a href="javascript:void(0);"onclick="formToggle('importFrm');" ><i class="fa fa-upload" aria-hidden="true"></i></i> Import</a></li>
        
        <li><a href="<?php echo "deleteAll.php?Nazev=".$_GET['Nazev']?>" 
        onclick="return do_check();"><i class="fa fa-trash-o"></i> Odstranit vše</a></li>

        <li><a href="<?php echo "Tabulka.php?Nazev=".$_GET['Nazev']?>"><i class="fa fa-close"></i> Ukončit editaci</a></li>
        
        
    </ul>
    </div>
</body>
</html>

<?php include_once 'config.php'; ?>
<script>
function do_check()
{
    var return_value=prompt("Heslo pro smazání:");
    if(return_value===getDeletePassword()){
        alert("Správné heslo!!");
        return true;
    }
    else{
        alert("Špatné heslo!");
        return false;
    }
        

}
</script>
