package com.jivitHealcare.Repo;

import com.jivitHealcare.Entity.Hospital;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Query;
import java.util.Optional;
import java.util.List;
@Repository
public interface HospitalDao extends JpaRepository<Hospital,Long> {
    Hospital findByEmail(String email);

    Optional<Hospital> findByEmailAndOtp(String email, String otp);

    @Query("SELECT h FROM Hospital h WHERE h.isDeleted = false")
    List<Hospital> findAllActiveHospitals();
}
