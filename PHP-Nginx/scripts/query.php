<?php

$servername = "mysql";
// $servername = "localhost";
$username = "root";
$password = "password";
$database = "COMPANY";

// MySQLi Procedural

// Create connection
$conn = mysqli_connect($servername, $username, $password, $database);

// Check connection
if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}

$sql = "SELECT Lname, Ssn FROM EMPLOYEE";
$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
  // output data of each row
  while($row = mysqli_fetch_assoc($result)) {
    echo "Social Security Number: " . $row["Ssn"]. " Last Name: " . $row["Lname"]. "<br>";
  }
} else {
  echo "0 results";
}

mysqli_close($conn);
?>
