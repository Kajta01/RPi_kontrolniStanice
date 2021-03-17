<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<style>
.wrapper {
  display: flex;
  height: 100%;
  color: darkblue;
}
.col-right {
  flex-basis: 70%;
}
.col-left {
  flex-basis: 30%;

}
.green {
  background-color: green;
  flex-grow: 3;
}
.blue {
  background-color: blue;
}
.color {

  margin: 2px;
}

</style>
<body>
    <div class="wrapper">
        <div class="col-left color green">
        <?php include 'headerMain.php'; ?>

        </div>
        <div class="col-right color blue">
            Lorem 6
        </div>
    </div>
</body>

</html>
