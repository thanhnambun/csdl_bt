use ss6;
DELETE FROM Appointments
WHERE AppointmentDate < NOW()
AND DoctorId = (SELECT DoctorId FROM Doctors WHERE FullName = 'Phan Huong');

SELECT a.AppointmentId, p.FullName AS PatientName, d.FullName AS DoctorName, 
       a.AppointmentDate, a.Status
FROM Appointments a
JOIN Patients p ON a.PatientId = p.PatientId
JOIN Doctors d ON a.DoctorId = d.DoctorId;

UPDATE Appointments 
SET Status = 'Dang cho'
WHERE AppointmentDate >= NOW()
AND PatientId = (SELECT PatientId FROM Patients WHERE FullName = 'Nguyen Van An')
AND DoctorId = (SELECT DoctorId FROM Doctors WHERE FullName = 'Phan Huong');

SELECT a.AppointmentId, p.FullName AS PatientName, d.FullName AS DoctorName, 
       a.AppointmentDate, a.Status
FROM Appointments a
JOIN Patients p ON a.PatientId = p.PatientId
JOIN Doctors d ON a.DoctorId = d.DoctorId;

SELECT p.FullName AS PatientName, d.FullName AS DoctorName, 
       a.AppointmentDate, m.Diagnosis
FROM Appointments a
JOIN Patients p ON a.PatientId = p.PatientId
JOIN Doctors d ON a.DoctorId = d.DoctorId
JOIN MedicalRecords m ON a.PatientId = m.PatientId AND a.DoctorId = m.DoctorId
WHERE a.PatientId IN (
    SELECT PatientId FROM Appointments
    GROUP BY PatientId, DoctorId
    HAVING COUNT(*) >= 2
);

SELECT UPPER(CONCAT('BỆNH NHÂN: ', p.FullName, ' - BÁC SĨ: ', d.FullName)) AS Info,
       a.AppointmentDate, m.Diagnosis, a.Status
FROM Appointments a
JOIN Patients p ON a.PatientId = p.PatientId
JOIN Doctors d ON a.DoctorId = d.DoctorId
LEFT JOIN MedicalRecords m ON a.PatientId = m.PatientId AND a.DoctorId = m.DoctorId
ORDER BY a.AppointmentDate ASC;

SELECT UPPER(CONCAT('BỆNH NHÂN: ', p.FullName, ' - BÁC SĨ: ', d.FullName)) AS Info, -- câu 6 giống câu 5
       a.AppointmentDate, m.Diagnosis, a.Status
FROM Appointments a
JOIN Patients p ON a.PatientId = p.PatientId
JOIN Doctors d ON a.DoctorId = d.DoctorId
LEFT JOIN MedicalRecords m ON a.PatientId = m.PatientId AND a.DoctorId = m.DoctorId
ORDER BY a.AppointmentDate ASC;