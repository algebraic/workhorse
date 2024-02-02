package gov.michigan.lara.util;

import gov.michigan.lara.domain.KPI;
import org.springframework.data.repository.CrudRepository;

// Annotation
@org.springframework.stereotype.Repository

// Interface extending CrudRepository
public interface Repository extends CrudRepository<KPI, Long> {
}
