package main.model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "coefficient")
public class Coefficient {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "coefficient_id", updatable = false, nullable = false)
    private Long coefficient_id;

    @Column(name = "nameCoeff")
    private String name;

    @OneToMany(mappedBy = "coefficient", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ValueCoefficient> coefficientValue;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "mapTable_id")
    private MapTable mapTable;

    public Coefficient() {

    }

    public Long getId() {
        return coefficient_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    //
    public List<ValueCoefficient> getCoefficientValue() {
        return this.coefficientValue;
    }

    public void setCoefficientValue(List<ValueCoefficient> coefficientValue) {
        this.coefficientValue = coefficientValue;
    }

    public void internalAddCoeffValue(ValueCoefficient cValue) {
        this.coefficientValue.add(cValue);
    }

    public void internalRemoveCoeffValue(ValueCoefficient cValue) {
        this.coefficientValue.remove(cValue);
    }

    public void removeCoeffValue(ValueCoefficient cValue) {
        cValue.setItem(null);
    }

    public void addCoeffValue(ValueCoefficient cValue) {
        cValue.setItem(this);
    }

    //
    public void setItem(MapTable mapTable) {
        if (this.mapTable != null)
            this.mapTable.internalRemoveCoefficient(this);
        this.mapTable = mapTable;
        if (mapTable != null)
            mapTable.internalAddCoefficient(this);
    }
}
