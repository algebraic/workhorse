package gov.michigan.lara.dao;

import gov.michigan.lara.config.UserDetailsUtil;
import gov.michigan.lara.domain.KPI;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

// Annotation
@org.springframework.stereotype.Repository

// Interface extending CrudRepository
public interface KpiRepository extends CrudRepository<KPI,String>{

    // @Query("SELECT DISTINCT k.bureau FROM KPI k order by bureau")
    @Query("SELECT DISTINCT k.bureau FROM KPI k WHERE :userbureau = '*' OR k.bureau LIKE CONCAT(:userbureau, '%') ORDER BY k.bureau")
    List<String> getBureauList(@Param("userbureau") String userbureau);

    @Query("SELECT DISTINCT k.KPI_Area FROM KPI k where k.bureau = :bureau")
    List<String> getKpiAreaByBureau(@Param("bureau") String bureau);

    @Query("SELECT DISTINCT k.KPI_ID, k.KPI_Name FROM KPI k where k.bureau = :bureau and k.KPI_Area = :area")
    List<Object[]> getKpiIdsByArea(@Param("bureau") String bureau, @Param("area") String area);

    // @Query("SELECT DISTINCT k.KPI_ID, k.KPI_Name FROM KPI k where k.bureau = :bureau and k.KPI_Area = :area")
    @Query("select k.dataType FROM KPI k where k.KPI_ID = :kpiId")
    String getKpiDataType(@Param("kpiId") String kpiId);
    
}
