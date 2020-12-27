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
        <li><a href="<?php echo "deleteAll.php?Nazev=".$_GET['Nazev']?>">Delete all</a></li>
        <li><a href="<?php echo "TabulkaEdit.php?Nazev=".$_GET['Nazev']?>">Edit</a></li>
        
    </ul>
    </div>
</body>
</html>

