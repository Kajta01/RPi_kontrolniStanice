<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src='https://use.fontawesome.com/releases/v5.15.2/js/all.js'data-auto-a11y='true'></script>
    <link rel="stylesheet" href="../stylesheet.css">
</head>

<body>
<nav class="nav nav-allow-edit justify-content-center bg-light">
<ul class="nav">
  <li class="nav-item">
  <a class="nav-link allow-edit" href="<?php echo "TabulkaEdit.php?Nazev=" . $_GET['Nazev'] . "&Popis=" . $_GET['Popis'] ?>">
  <i class="fas fa-edit"></i></i> Editace</a> 
  </li>
  <li class="nav-item">
  <a class="nav-link" href="#"><i class="fas fa-file-excel"></i> Export do excelu</a>
  </li>
</ul>
</nav>
</body>

</html>