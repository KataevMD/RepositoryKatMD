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

    @Column(name = "formulMapTable")
    private String formul;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "collection_id")
    private CollectionMapTable collectionMapTable;

    public MapTable() {

    }
    public void setItem(CollectionMapTable collectionMapTable)
    {
        if (this.collectionMapTable != null)
            this.collectionMapTable.internalRemoveMapTable(this);
        this.collectionMapTable = collectionMapTable;
        if (collectionMapTable != null)
            collectionMapTable.internalAddMapTable(this);
    }

    public String getFormul() {
        return formul;
    }


    public void setFormul(String formul) {
        this.formul = formul;
    }

    public void setMapTable_id(Long mapTable_id) {
        this.mapTable_id = mapTable_id;
    }

    public void setListParameter(List<Parameter> listParameter) {
        this.listParameter = listParameter;
    }

    public void setCollectionMapTable(CollectionMapTable collectionMapTable) {
        this.collectionMapTable = collectionMapTable;
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


	//
	public List<Parameter> getListParametr() {
		return this.listParameter;
	}

	public void setListParametr(List<Parameter> listParametr) {
		this.listParameter = listParametr;
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
    //

    public List<Parameter> getListParameter() {
        return listParameter;
    }

    public CollectionMapTable getCollectionMapTable() {
        return collectionMapTable;
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
        this.listParameter.remove(coefficient);
    }

    public void addCoefficient(Coefficient coefficient) {
        coefficient.setItem(this);
    }
}
