<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "hospital_management";

// Veritabanı bağlantısı
$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Yeni kullanıcı bilgileri
$new_username = 'newuser'; // Farklı bir kullanıcı adı girin
$new_password = 'newpassword'; // Güçlü bir şifre girin

// Şifreyi hashle
$hashed_password = password_hash($new_password, PASSWORD_DEFAULT);

// Hazırlıklı ifade kullanarak SQL enjeksiyonundan korunma
$stmt = $conn->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
$stmt->bind_param("ss", $new_username, $hashed_password);

if ($stmt->execute()) {
    echo "New user created successfully";
} else {
    echo "Error: " . $stmt->error;
}

$stmt->close();
$conn->close();
?>
