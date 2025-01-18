document.getElementById("login-form").addEventListener("submit", function(e) {
    e.preventDefault();
    
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;

    fetch("fetch_data.php", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: `action=login&username=${encodeURIComponent(username)}&password=${encodeURIComponent(password)}`
    })
    .then(response => response.text())
    .then(data => {
        if (data === "Login successful") {
            window.location.href = "dashboard.html";
        } else {
            alert("Invalid username or password");
        }
    });
});

// Hastaları fetch etmek için
function fetchPatients() {
    fetch("fetch_data.php", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "action=fetch_patients"
    })
    .then(response => response.json())
    .then(data => {
        console.log(data);
        // Bu verileri HTML tablosuna veya başka bir yapıya ekleyebilirsiniz
    });
}
