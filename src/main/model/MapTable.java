package main.model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "mapTable")
public class MapTable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Column(name = "mapTable_id", updatable = false, nullable = false)
    private Long mapTable_id;

    @Column(name = "nameMapTable")
    private String name;

    @Column(name = "numberMapTable")
    private String numberTable;

    @OneToMany(mappedBy = "mapTable", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Parameter> listParameter;

    @OneToMany(mappedBy = "mapTable", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Coefficient> listCoefficient;

    @OneToMany(mappedBy = "mapTable", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Formula> listFormula;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "section_id")
    private Section section;

    public MapTable() {

    }

    public List<Formula> getListFormula() {
        return listFormula;
    }

    public void setListFormula(List<Formula> listFormula) {
        this.listFormula = listFormula;
    }

    public void internalAddFormula(Formula formula) {
        this.listFormula.add(formula);
    }

    public void internalRemoveFormula(Formula formula) {
        this.listFormula.remove(formula);
    }

    public void addFormula(Formula formula) {
        formula.setItem(this);
    }

    public void setItem(Section section)
    {
        if (this.section != null)
            this.section.internalRemoveMapTable(this);
        this.section = section;
        if (section != null)
            section.internalAddMapTable(this);
    }

    public void setMapTable_id(Long mapTable_id) {
        this.mapTable_id = mapTable_id;
    }

    public void setListParameter(List<Parameter> listParameter) {
        this.listParameter = listParameter;
    }

    public void setSection(Section section) {
        this.section = section;
    }

    public Long getMapTable_id() {
        return mapTable_id;
    }

    public String getName() {
        return name;
    }


    public void setName(String name) {
        this.name = name;
    }


    public String getNumberTable() {
        return numberTable;
    }


    public void setNumberTable(String numberTable) {
        this.numberTable = numberTable;
    }

	public void internalAddParametr(Parameter param) {
		this.listParameter.add(param);
	}

	public void internalRemoveParametr(Parameter param) {
		this.listParameter.remove(param);
	}

	public void removeParametr(Parameter param) {
		param.setItem(null);
	}

	public void addParametr(Parameter param) {
		param.setItem(this);
	}

    public List<Parameter> getListParameter() {
        return listParameter;
    }

    public Section getSection() {
        return section;
    }

    public List<Coefficient> getListCoefficient() {
        return listCoefficient;
    }

    public void setListCoefficient(List<Coefficient> listCoefficient) {
        this.listCoefficient = listCoefficient;
    }

    public void internalAddCoefficient(Coefficient coefficient) {
        this.listCoefficient.add(coefficient);
    }

    public void internalRemoveCoefficient(Coefficient coefficient) {
        this.listCoefficient.remove(coefficient);
    }

    public void addCoefficient(Coefficient coefficient) {
        coefficient.setItem(this);
    }
}
