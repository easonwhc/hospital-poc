-- ============================================
--   Hospital Database Schema (Full Version)
--   AUTO_INCREMENT + FK + ENGINE + CHARSET
-- ============================================

CREATE TABLE patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    identity_number VARCHAR(12) NOT NULL,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_name VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE nurse (
    nurse_id INT AUTO_INCREMENT PRIMARY KEY
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE pharmacist (
    pharmacist_id INT AUTO_INCREMENT PRIMARY KEY
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_time DATETIME NOT NULL,
    department VARCHAR(50) NOT NULL,
    reason VARCHAR(255),
    status VARCHAR(20) NOT NULL,

    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE medical_record (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    treatment_result VARCHAR(1000),
    exam_result VARCHAR(1000),
    visit_time DATETIME NOT NULL,
    appointment_id INT,
    exam_image_ids TEXT,

    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE diagnosis_result (
    diagnosis_result_id INT AUTO_INCREMENT PRIMARY KEY,
    record_id INT NOT NULL,
    doctor_id INT NOT NULL,
    prescription VARCHAR(1000) NOT NULL,
    medical_advice VARCHAR(1000),
    diagnosis VARCHAR(1000) NOT NULL,
    treatment_plan VARCHAR(1000),
    status VARCHAR(20),
    reject_reason TEXT,
    diagnosis_status VARCHAR(20),
    hospitalized TINYINT(1) NOT NULL DEFAULT 0,

    FOREIGN KEY (record_id) REFERENCES medical_record(record_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE medication (
    medication_id INT AUTO_INCREMENT PRIMARY KEY,
    medication_name VARCHAR(100) NOT NULL,
    usage_text VARCHAR(500) NOT NULL,
    side_effect VARCHAR(1000),
    remain_amount INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE medication_record (
    medication_record_id INT AUTO_INCREMENT PRIMARY KEY,
    diagnosis_result_id INT NOT NULL,
    medication_id INT NOT NULL,
    pharmacist_id INT NOT NULL,
    quantity INT NOT NULL,

    FOREIGN KEY (diagnosis_result_id) REFERENCES diagnosis_result(diagnosis_result_id),
    FOREIGN KEY (medication_id) REFERENCES medication(medication_id),
    FOREIGN KEY (pharmacist_id) REFERENCES pharmacist(pharmacist_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE ward (
    ward_id INT AUTO_INCREMENT PRIMARY KEY,
    ward_record VARCHAR(1000),
    ward_name VARCHAR(50),
    ward_status VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE allocation_record (
    allocation_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    ward_id INT NOT NULL,
    allocation_date DATETIME NOT NULL,
    leave_date DATETIME,

    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (ward_id) REFERENCES ward(ward_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE care_log (
    care_log_id INT AUTO_INCREMENT PRIMARY KEY,
    nurse_id INT NOT NULL,
    patient_id INT NOT NULL,
    log_time DATETIME,
    log_content TEXT NOT NULL,

    FOREIGN KEY (nurse_id) REFERENCES nurse(nurse_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE notification (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    type VARCHAR(50) NOT NULL,
    content VARCHAR(500) NOT NULL,
    scheduled_time DATETIME NOT NULL,
    is_sent TINYINT(1) NOT NULL,
    related_record_id INT,

    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (related_record_id) REFERENCES medical_record(record_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
