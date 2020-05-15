package main.model;

import javax.persistence.*;

@Entity
@Table(name = "coefficientValue")
//@SequenceGenerator(name = "mapseq2", sequenceName="mapseq",allocationSize=50)
public class ValueCoefficient {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "coeffValue_id", updatable = false, nullable = false, unique = true)
    private Long coeffValue_id;

    @Column(name = "nameCoeffValue")
    private String valName;

    @Column(name = "valueCoeffValue")
    private Double value;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "coefficient_id")
    private Coefficient coefficient;

    public ValueCoefficient() {

    }

    public Long getCoeffValue_id() {
        return coeffValue_id;
    }

    public void setCoeffValue_id(Long coeffValue_id) {
        this.coeffValue_id = coeffValue_id;
    }

    public void setCoefficient(Coefficient coefficient) {
        this.coefficient = coefficient;
    }

    public String getValName() {
        return valName;
    }

    public void setValName(String valName) {
        this.valName = valName;
    }

    public Double getValue() {
        return value;
    }

    public void setValue(Double value) {
        this.value = value;
    }

    public Coefficient getCoefficient() {
        return this.coefficient;
    }

    public void setItem(Coefficient coefficient) {
        if (this.coefficient != null)
            this.coefficient.internalRemoveCoeffValue(this);
        this.coefficient = coefficient;
        if (coefficient != null)
            coefficient.internalAddCoeffValue(this);
    }

}
