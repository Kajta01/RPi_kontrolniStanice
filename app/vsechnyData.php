<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Všechny tabluky</title>
</head>

<body>

</body>

</html>
<ul>
    <?php
    include_once "function.php";
    $result = getAllTable();

    while ($data = mysqli_fetch_array($result)) {
        echo '<li class="button"><a href="Tabulka.php?Nazev=' . $data['TABLE_NAME'] . '&Edit=N"> <i class="fa fa-bullseye" aria-hidden="true"></i> ' . $data['TABLE_NAME']  . "</a></li>";
    }
    ?>
</ul>

