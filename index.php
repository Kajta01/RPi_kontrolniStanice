<?php
// Initialize the session
session_start();
 
// Check if the user is already logged in, if yes then redirect him to welcome page
if(isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === true){
    header("location: app/index.php");
    exit;
} 
include_once "app/function.php";

$username = $password = "";
$username_err = $password_err = "";

if($_SERVER["REQUEST_METHOD"] == "POST"){
 
    // Check if username is empty
    if(empty(trim($_POST["zavod"]))){
        $username_err = "Vyberte název akce.";
    } else{
        $username = trim($_POST["zavod"]);
    }
    
    // Check if password is empty
    if(empty(trim($_POST["password"]))){
        $password_err = "Vyplňte heslo";
    } else{
        $password = trim($_POST["password"]);
    }
    if(empty($username_err) && empty($password_err)){
        $conn = getdbApp();
        // Prepare a select statement
        $sql = "SELECT Nazev, Heslo FROM Akce WHERE Nazev = ?";
        
        if($stmt = mysqli_prepare($conn, $sql)){
            
            // Bind variables to the prepared statement as parameters
            mysqli_stmt_bind_param($stmt, "s", $param_username);
            
            // Set parameters
            $param_username = $username;
            
            // Attempt to execute the prepared statement
            if(mysqli_stmt_execute($stmt)){
                // Store result
                mysqli_stmt_store_result($stmt);
               
                // Check if username exists, if yes then verify password
                if(mysqli_stmt_num_rows($stmt) == 1){   
                                    
                    // Bind result variables
                    mysqli_stmt_bind_result($stmt, $username, $hashed_password);
                    if(mysqli_stmt_fetch($stmt)){
                        if($password == $hashed_password){
                            // Password is correct, so start a new session
                            session_start();
                            
                            // Store data in session variables
                            $_SESSION["loggedin"] = true;
                            $_SESSION["username"] = $username;
                            
                            setDB($username);
                            
                            // Redirect user to welcome page
                            header("location: app/index.php");
                        } else{
                            // Display an error message if password is not valid
                            $password_err = "The password you entered was not valid.";
                        }
                    }
                } else{
                    // Display an error message if username doesn't exist
                    $username_err = "No account found with that username.";
                }
            } else{
                echo "Oops! Something went wrong. Please try again later.";
            }
                
            // Close statement
            mysqli_stmt_close($conn);
        }
    }
}

?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Závody</title>
    <link rel="stylesheet" href="stylesheet.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.css">
</head>

<body>
    <div class="wrapper-login">
        <h2>Administrace závodu</h2>
        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
            <div class="form-group">
                <label>Závod</label>
                
                <select class="form-control" id="zavod" name="zavod" value="Vyberte">
                    <option value="" selected disabled hidden>Vyberte:</option>
                    <option value="opice" >opice</option>
                    <?php                  
                    $result = getVsechnyAkce();
                    while ($data = mysqli_fetch_array($result)) {                   
                       echo '<option value="'.$data['Nazev'].'">'.$data['Nazev'].'</option>';
                    }                         
                    ?>
                </select>
                <span class="help-block text-danger"><?php echo $username_err; ?></span>
            </div>
            
            <div class="form-group">
                <label>Heslo</label>              
                <input type="password" name="password" class="form-control">
                <span class="help-block text-danger"><?php echo $password_err; ?></span>               
            </div>
            <div class="form-group">
                <input type="submit" class="btn btn-primary" value="Vstupit">
            </div>
        </form>

        <hr>

        

            <div class="btn btn-secondary"><a href="/" onclick="javascript:event.target.port=3355">Výsledky závodů</a></div>

    </div>

</body>

</html>