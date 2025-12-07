-- 建立 Keyspace
CREATE KEYSPACE hospital WITH replication = {
  'class': 'SimpleStrategy',
  'replication_factor': 1
};

USE hospital;

-- 病歷查詢表（依病人查詢）
CREATE TABLE medical_record_by_patient (
  patient_id int,
  record_id int,
  visit_time timestamp,
  diagnosis text,
  PRIMARY KEY (patient_id, visit_time)
);

-- 插入資料
INSERT INTO medical_record_by_patient (patient_id, record_id, visit_time, diagnosis)
VALUES (1, 10, '2025-12-06', 'Normal');

-- 查詢病人所有病歷
SELECT * FROM medical_record_by_patient
WHERE patient_id = 1;
