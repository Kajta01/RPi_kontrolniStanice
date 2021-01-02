<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="TabulkaEdit.js"></script>
  <link rel="stylesheet" href="stylesheet.css">
</head>

<body class="body">
  <?php include_once 'headerEdit.php'; ?>

  <div class="container">
    <div id="displaymessage" class= "message"></div>
    
    <h1 id="Tabulka"> <?php echo $_GET['Nazev']; ?></h1>

       <!-- CSV file upload form   style="display: none;" -->
       <div class="col-md-12" id="importFrm" style="display: none;" >
        <form action="importData.php" method="post" enctype="multipart/form-data">
            <input type="hidden" id="nameTable" name="nameTable" value="<?php echo $_GET['Nazev']; ?>">
            <input type="file" name="file" />
            <input type="submit" class="btn btn-primary" name="importSubmit" value="IMPORT">
        </form>
    </div>
    

    <?php
    include_once 'config.php';
    $nazev = $_GET['Nazev'];

    $conn = getdb();
    $sql = "SHOW COLUMNS FROM $nazev";
    $result = mysqli_query($conn, $sql);
    echo '<table class="table table-bordered" id="table"> <thead><tr>';
    $i = 0;
    while ($rowN = mysqli_fetch_array($result)) {
      echo '<th id="'.$rowN['Field'].'">' . $rowN['Field'] . "</th>";
      $Nadpisy[$i] = $rowN['Field'];
      $i = $i + 1;
    }
    echo'<th class="akce" >Akce</th>';
    echo "</thead> <tbody>";

    $sql = "SELECT * FROM $nazev";
    $result = mysqli_query($conn, $sql);


    while ($data = mysqli_fetch_array($result)) {
      $id = $data["ID"];
      foreach ($Nadpisy as &$nadpis) {
        echo "<td id=".$nadpis.">" . $data[$nadpis] . "</td>";
      }
      echo '<td>
                <a class="add" title="Add" data-toggle="tooltip"><i class="fa fa-plus"></i></a>
                <a class="edit" title="Edit" data-toggle="tooltip"><i class="fa fa-pencil"></i></a>
                <a class="delete" title="Delete" data-toggle="tooltip"><i class="fa fa-trash-o"></i></a>
                </td>';
      echo "</tr>";
    }

    echo "</tbody> </table>";
    mysqli_close($conn);



    ?>
    <button type="button" class="btn btn-info add-new" ><i class="fa fa-plus"></i> Přidat řádek</button>

  </div>
  

  

</body>

</html>


<!-- Show/hide CSV upload form -->
<script>
function formToggle(ID){
    var element = document.getElementById(ID);
    if(element.style.display === "none"){
        element.style.display = "block";
    }else{
        element.style.display = "none";
    }
}
</script>