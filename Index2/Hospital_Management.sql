CREATE DATABASE hospital_management;
USE hospital_management;

-- User authentication 
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, -- Hashlenmiş şifre saklamak için
    role ENUM('admin', 'doctor', 'receptionist') NOT NULL, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Patients 
CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    contact VARCHAR(15),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Doctors 
CREATE TABLE doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- appointments 
CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE
);

-- prescriptions 
CREATE TABLE prescriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    medication TEXT NOT NULL,
    dosage TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE
);

-- payments 
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Paid', 'Pending', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
);


INSERT INTO users (username, password, role) VALUES 
('admin', '$2y$10$Vb8cGshf/NOpwXy5xY0Gqu4QxjJXw4YazFZUEWUpUt5dRLI06EDuW', 'admin'), -- password : 'admin123' 
('doctor1', '$2y$10$abcdef1234567890abcdef1234567890abcdef1234567890abcdef12', 'doctor');

INSERT INTO doctors (name, specialty, phone, email) VALUES 
('Dr. Ahmet Kaya', 'Cardiology', '05554443322', 'ahmet.kaya@hospital.com'),
('Dr. Elif Yılmaz', 'Neurology', '05552221100', 'elif.yilmaz@hospital.com');

INSERT INTO patients (name, age, gender, contact, address) VALUES 
('Mehmet Yıldız', 45, 'Male', '05443332211', 'İstanbul, Türkiye'),
('Ayşe Demir', 30, 'Female', '05335556677', 'Ankara, Türkiye');

INSERT INTO appointments (patient_id, doctor_id, appointment_date, status) VALUES 
(1, 1, '2025-02-10 14:30:00', 'Scheduled'),
(2, 2, '2025-02-11 10:00:00', 'Completed');

INSERT INTO payments (patient_id, amount, status) VALUES 
(1, 250.00, 'Paid'),
(2, 300.00, 'Pending');
