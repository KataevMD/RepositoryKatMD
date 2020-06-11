package main.model;


import javax.persistence.*;

@Entity
@Table(name = "formula")
public class Formula {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Column(name = "formula_id", updatable = false, nullable = false)
    private Long formula_id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "mapTable_id")
    private MapTable mapTable;

    @Column(name = "coefficient_id")
    private Long coefficient_id;

    @Column(name = "formula")
    private String formula;

    public Long getFormula_id() {
        return formula_id;
    }

    public void setFormula_id(Long formula_id) {
        this.formula_id = formula_id;
    }

    public Long getCoefficient_id() {
        return coefficient_id;
    }

    public void setCoefficient_id(Long coefficient_id) {
        this.coefficient_id = coefficient_id;
    }

    public String getFormula() {
        return formula;
    }

    public void setFormula(String formula) {
        this.formula = formula;
    }

    public MapTable getMapTable() {
        return mapTable;
    }

    public void setMapTable(MapTable mapTable) {
        this.mapTable = mapTable;
    }
    public void setItem(MapTable mapTable)
    {
        if (this.mapTable != null)
            this.mapTable.internalRemoveFormula(this);
        this.mapTable = mapTable;
        if (mapTable != null)
            mapTable.internalAddFormula(this);
    }
}
