document.getElementById("fetch-patients").addEventListener("click", function () {
    fetch("fetch_data.php", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "action=fetch_patients"
    })
    .then(response => response.json())
    .then(data => {
        const tableBody = document.getElementById("patient-table").querySelector("tbody");
        tableBody.innerHTML = "";

        data.forEach(patient => {
            const row = document.createElement("tr");

            row.innerHTML = `
                <td>${patient.id}</td>
                <td><input type="text" value="${patient.name}" id="name-${patient.id}"></td>
                <td><input type="number" value="${patient.age}" id="age-${patient.id}"></td>
                <td>
                    <select id="gender-${patient.id}">
                        <option value="Male" ${patient.gender === 'Male' ? 'selected' : ''}>Male</option>
                        <option value="Female" ${patient.gender === 'Female' ? 'selected' : ''}>Female</option>
                    </select>
                </td>
                <td>
                    <button onclick="editPatient(${patient.id})">Edit</button>
                    <button onclick="deletePatient(${patient.id})">Delete</button>
                </td>
            `;

            tableBody.appendChild(row);
        });
    })
    .catch(error => console.error('Error:', error));
});

function editPatient(id) {
    const name = document.getElementById(`name-${id}`).value;
    const age = document.getElementById(`age-${id}`).value;
    const gender = document.getElementById(`gender-${id}`).value;

    fetch("fetch_data.php", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: `action=edit_patient&id=${id}&name=${encodeURIComponent(name)}&age=${encodeURIComponent(age)}&gender=${encodeURIComponent(gender)}`
    })
    .then(response => response.text())
    .then(data => {
        alert(data);
    })
    .catch(error => console.error('Error:', error));
}

function deletePatient(id) {
    if (confirm("Are you sure you want to delete this patient?")) {
        fetch("fetch_data.php", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: `action=delete_patient&id=${id}`
        })
        .then(response => response.text())
        .then(data => {
            alert(data);
            document.getElementById("fetch-patients").click(); // Refresh the table
        })
        .catch(error => console.error('Error:', error));
    }
}
