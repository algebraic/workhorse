package gov.michigan.lara.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import gov.michigan.lara.domain.Role;

public interface RoleRepository extends JpaRepository<Role, Long> {
}
