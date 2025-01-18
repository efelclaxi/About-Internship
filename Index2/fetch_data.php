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

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $action = $_POST['action'];

    if ($action === "fetch_patients") {
        $sql = "SELECT * FROM patients";
        $result = $conn->query($sql);
        $patients = [];

        while ($row = $result->fetch_assoc()) {
            $patients[] = $row;
        }

        echo json_encode($patients);
    } elseif ($action === "edit_patient") {
        $id = $_POST['id'];
        $name = $_POST['name'];
        $age = $_POST['age'];
        $gender = $_POST['gender'];

        $stmt = $conn->prepare("UPDATE patients SET name = ?, age = ?, gender = ? WHERE id = ?");
        $stmt->bind_param("sisi", $name, $age, $gender, $id);

        if ($stmt->execute()) {
            echo "Patient updated successfully";
        } else {
            echo "Error updating patient: " . $stmt->error;
        }

        $stmt->close();
    } elseif ($action === "delete_patient") {
        $patient_id = $_POST['id'];

        $stmt = $conn->prepare("DELETE FROM patients WHERE id = ?");
        $stmt->bind_param("i", $patient_id);

        if ($stmt->execute()) {
            echo "Patient deleted successfully";
        } else {
            echo "Error deleting patient: " . $stmt->error;
        }

        $stmt->close();
    } elseif ($action === "login") {
        $username = $_POST['username'];
        $password = $_POST['password'];

        // Şifreleri düz metin olarak karşılaştırma
        $stmt = $conn->prepare("SELECT * FROM users WHERE username = ? AND password = ?");
        $stmt->bind_param("ss", $username, $password);

        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            echo "Login successful";
        } else {
            echo "Invalid username or password";
        }

        $stmt->close();
    }
}

$conn->close();
?>
