-- ============================================
-- SQL 查詢語法示範 (Hospital PoC)
-- ============================================

-- ------------------------------
-- 1. 基礎查詢：查詢所有病人
-- ------------------------------
SELECT *
FROM patient;

-- ------------------------------
-- 2. 基礎條件查詢：查詢特定病人
-- ------------------------------
SELECT patient_id, name, phone
FROM patient
WHERE name = '王小明';


-- ------------------------------
-- 3. LIKE 模糊查詢：搜尋姓名中含「王」
-- ------------------------------
SELECT *
FROM patient
WHERE name LIKE '%王%';


-- ------------------------------
-- 4. 查詢醫師所有門診預約
-- ------------------------------
SELECT appointment_id, appointment_time, department
FROM appointment
WHERE doctor_id = 1
ORDER BY appointment_time DESC;


-- ------------------------------
-- 5. JOIN 查詢（兩表）
-- 查看病歷與對應的病人資訊
-- ------------------------------
SELECT mr.record_id, p.name AS patient_name, mr.visit_time
FROM medical_record mr
JOIN patient p ON mr.patient_id = p.patient_id;


-- ------------------------------
-- 6. JOIN（三表）：病歷 + 病人 + 醫師
-- ------------------------------
SELECT 
    mr.record_id,
    p.name AS patient_name,
    d.doctor_name,
    mr.visit_time
FROM medical_record mr
JOIN patient p ON mr.patient_id = p.patient_id
JOIN doctor d ON mr.doctor_id = d.doctor_id
ORDER BY mr.visit_time DESC;


-- ------------------------------
-- 7. JOIN（四表）：
-- 查詢病人 → 預約 → 病歷 → 診斷結果
-- ------------------------------
SELECT 
    p.name AS patient_name,
    a.appointment_time,
    mr.record_id,
    dr.diagnosis
FROM patient p
JOIN appointment a ON p.patient_id = a.patient_id
JOIN medical_record mr ON a.appointment_id = mr.appointment_id
JOIN diagnosis_result dr ON mr.record_id = dr.record_id
ORDER BY a.appointment_time DESC;


-- ------------------------------
-- 8. GROUP BY：
-- 統計各科別的預約數量
-- ------------------------------
SELECT department, COUNT(*) AS total_appointments
FROM appointment
GROUP BY department
ORDER BY total_appointments DESC;


-- ------------------------------
-- 9. GROUP BY：
-- 統計每位醫師處理的病歷數
-- ------------------------------
SELECT d.doctor_name, COUNT(*) AS records_count
FROM medical_record mr
JOIN doctor d ON mr.doctor_id = d.doctor_id
GROUP BY mr.doctor_id;


-- ------------------------------
-- 10. INSERT 語法示例：新增病人
-- ------------------------------
INSERT INTO patient (identity_number, name, phone)
VALUES ('A876543210', '陳小華', '0988001122');


-- ------------------------------
-- 11. INSERT：新增預約
-- ------------------------------
INSERT INTO appointment (patient_id, doctor_id, appointment_time, department, reason, status)
VALUES (1, 1, '2025-12-10 14:00:00', '內科', '例行檢查', 'Scheduled');


-- ------------------------------
-- 12. UPDATE：更新病歷檢查結果
-- ------------------------------
UPDATE medical_record
SET exam_result = '檢驗正常'
WHERE record_id = 1;


-- ------------------------------
-- 13. DELETE：刪除尚未完成的預約
-- ------------------------------
DELETE FROM appointment
WHERE appointment_id = 50
  AND status = 'Scheduled';


-- ------------------------------
-- 14. INDEX（加速查詢）
-- 建議在 patient.name 建立索引用於搜尋
-- ------------------------------
CREATE INDEX idx_patient_name
ON patient (name);


-- ------------------------------
-- 15. INDEX（外鍵常用欄位加速）
-- ------------------------------
CREATE INDEX idx_mr_patient
ON medical_record (patient_id);

CREATE INDEX idx_mr_doctor
ON medical_record (doctor_id);

