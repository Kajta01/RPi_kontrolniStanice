<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        .menu ul {
            display: flex;
            justify-content: space-around;
            max-width: 750px;
            margin: 10px auto;
        }

        li {
            display: inline-block;
        }

        body {
            border-bottom: 1px solid black;
        }
    </style>
</head>

<body>

    <body>
        <div class="menu">
        <?php include_once "function.php"; echo '<h1 >'. AktualniAkce() .'</h1>';?>
            <ul>
                <li><a href="/app/index.php"><i class="fa fa-arrow-left" aria-hidden="true"></i> Přehled tabulek</a></li>

                <li id="status"><a href="/NRdashboard">Node RED</a></li>
                <li><a href="/app/Tabulka.php?Nazev=TTN_Data"> TTN_Data</a></li>
                <li><a href="/" onclick="javascript:event.target.port=3333" >Stanoviste</a></li>
               

                <li><a href="/" onclick="javascript:event.target.port=3344" >Online zavod</a></li>

                
                
               


            </ul>
        </div>
    </body>

</body>

</html>