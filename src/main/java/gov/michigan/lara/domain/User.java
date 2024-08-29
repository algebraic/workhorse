package gov.michigan.lara.domain;

import java.sql.Timestamp;

import javax.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@EqualsAndHashCode(callSuper = false)
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String username;
    private String displayName;

    @Column(unique = true, nullable = false)
    private String email;

    private String password;
    private String bureau;

    @Column(nullable = false)
    private boolean disabled;

    @Column(nullable = false, name="passwordExpired")
    private boolean passwordExpired;

    private Timestamp createdOn;
    private String createdBy;
    private Timestamp modifiedOn;
    private String modifiedBy;
}
