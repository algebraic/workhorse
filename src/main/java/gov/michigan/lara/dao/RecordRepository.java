package gov.michigan.lara.dao;

import gov.michigan.lara.domain.Record;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

@org.springframework.stereotype.Repository

// Interface extending CrudRepository
public interface RecordRepository extends CrudRepository<Record, Long> {

    @Query("select r FROM Record r where r.KPI_ID = :kpiId")
    List<Record> getRecordsByKpiId(@Param("kpiId") String kpiId);
}
