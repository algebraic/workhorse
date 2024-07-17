package gov.michigan.lara.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.Objects;

public class RecordId implements Serializable {
    private String kpiId;
    private Date entryDate;

    public RecordId() {}

    public RecordId(String kpiId, Date entryDate) {
        this.kpiId = kpiId;
        this.entryDate = entryDate;
    }

    // Getters and setters

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RecordId that = (RecordId) o;
        return Objects.equals(kpiId, that.kpiId) && Objects.equals(entryDate, that.entryDate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(kpiId, entryDate);
    }
}
