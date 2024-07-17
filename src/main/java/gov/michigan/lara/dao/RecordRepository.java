package gov.michigan.lara.dao;

import gov.michigan.lara.domain.Record;
import gov.michigan.lara.domain.RecordId;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

@org.springframework.stereotype.Repository

// Interface extending CrudRepository
public interface RecordRepository extends CrudRepository<Record, RecordId> {

    @Query("select r FROM Record r where r.kpiId = :kpiId")
    List<Record> getRecordsByKpiId(@Param("kpiId") String kpiId);

    @Query("SELECT r FROM Record r WHERE r.kpiId = :kpiId AND YEAR(r.entryDate) = :year")
    List<Record> getRecordsByKpiYear(@Param("kpiId") String kpiId, @Param("year") int year);

    // @Query("SELECT DISTINCT YEAR(r.entryDate) FROM Record r where r.kpiId = :kpiId")
    @Query("SELECT DISTINCT YEAR(r.entryDate) FROM Record r WHERE SUBSTRING(r.kpiId, 1, 3) = SUBSTRING(:kpiId, 1, 3) order by YEAR(r.entryDate) desc")
    List<Integer> getKpiYears(@Param("kpiId") String kpiId);

    @Query("SELECT r FROM Record r WHERE r.kpiId = :kpiId AND r.entryDate = :date")
    Record getRecordByKpiDate(@Param("kpiId") String kpiId, @Param("date") Date date);
    
}