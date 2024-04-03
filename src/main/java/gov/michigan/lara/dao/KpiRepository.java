package gov.michigan.lara.dao;

import gov.michigan.lara.domain.KPI;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

// Annotation
@org.springframework.stereotype.Repository

// Interface extending CrudRepository
public interface KpiRepository extends CrudRepository<KPI,Long>{

    @Query("SELECT DISTINCT k.bureau FROM KPI k order by bureau")
    List<String> getBureauList();

    @Query("SELECT DISTINCT k.KPI_Area FROM KPI k where k.bureau = :bureau")
    List<String> getKpiAreaByBureau(@Param("bureau") String bureau);

}
