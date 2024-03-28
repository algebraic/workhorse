package gov.michigan.lara.dao;

import gov.michigan.lara.domain.KPI;
import org.springframework.data.repository.CrudRepository;

// Annotation
@org.springframework.stereotype.Repository

// Interface extending CrudRepository
public interface KpiRepository extends CrudRepository<KPI, Long> {
}
