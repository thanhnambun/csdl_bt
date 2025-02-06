use ss5 ;
SELECT 
    CONCAT(p.FullName, ' (', YEAR(a.AppointmentDate) - YEAR(p.DateOfBirth), ') - ', d.FullName) AS PatientDoctorInfo,
    a.AppointmentDate,
    m.Diagnosis
FROM 
    appointments a
JOIN 
    patients p ON a.PatientID = p.PatientID
JOIN 
    doctors d ON a.DoctorID = d.DoctorID
JOIN 
    medicalrecords m ON a.PatientID = m.PatientID AND a.DoctorID = m.DoctorID
WHERE 
    a.AppointmentDate BETWEEN '2025-01-20' AND '2025-01-30'
ORDER BY 
    a.AppointmentDate;


SELECT 
    p.FullName AS PatientName,
    YEAR(a.AppointmentDate) - YEAR(p.DateOfBirth) AS AgeAtAppointment,
    a.AppointmentDate,
    CASE
        WHEN YEAR(a.AppointmentDate) - YEAR(p.DateOfBirth) > 50 THEN 'Nguy cơ cao'
        WHEN YEAR(a.AppointmentDate) - YEAR(p.DateOfBirth) BETWEEN 30 AND 50 THEN 'Nguy cơ trung bình'
        ELSE 'Nguy cơ thấp'
    END AS RiskLevel
FROM 
    appointments a
JOIN 
    patients p ON a.PatientID = p.PatientID
WHERE 
    a.AppointmentDate BETWEEN '2025-01-20' AND '2025-01-30'
ORDER BY 
    a.AppointmentDate;


DELETE a
FROM appointments a
JOIN patients p ON a.PatientID = p.PatientID
JOIN doctors d ON a.DoctorID = d.DoctorID
WHERE 
    (YEAR(a.AppointmentDate) - YEAR(p.DateOfBirth)) > 30
    AND (d.Specialization = 'Noi Tong Quat' OR d.Specialization = 'Chan Thuong Chinh Hinh');
    
SELECT 
    p.FullName AS PatientName,
    d.Specialization,
    YEAR(a.AppointmentDate) - YEAR(p.DateOfBirth) AS AgeAtAppointment
FROM 
    appointments a
JOIN 
    patients p ON a.PatientID = p.PatientID
JOIN 
    doctors d ON a.DoctorID = d.DoctorID
ORDER BY 
    a.AppointmentDate;