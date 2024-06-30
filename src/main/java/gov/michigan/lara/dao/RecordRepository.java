package gov.michigan.lara.dao;

import gov.michigan.lara.domain.Record;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

@org.springframework.stereotype.Repository

// Interface extending CrudRepository
public interface RecordRepository extends CrudRepository<Record, String> {

    @Query("select r FROM Record r where r.KPI_ID = :kpiId")
    List<Record> getRecordsByKpiId(@Param("kpiId") String kpiId);

    @Query("SELECT r FROM Record r WHERE r.KPI_ID = :kpiId AND YEAR(r.ENTRYDATE) = :year")
    List<Record> getRecordsByKpiYear(@Param("kpiId") String kpiId, @Param("year") int year);

    @Query("SELECT DISTINCT YEAR(r.ENTRYDATE) FROM Record r where r.KPI_ID = :kpiId")
    List<Integer> getKpiYears(@Param("kpiId") String kpiId);
}