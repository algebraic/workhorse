package gov.michigan.lara.dao;

import gov.michigan.lara.domain.RecordCount;
import org.springframework.data.repository.CrudRepository;

// Annotation
@org.springframework.stereotype.Repository

// Interface extending CrudRepository
public interface RecordRepository extends CrudRepository<RecordCount, Long> {
}
