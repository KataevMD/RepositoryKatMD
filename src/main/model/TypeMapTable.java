package main.model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "typeMapTable")
public class TypeMapTable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "typeMap_id", updatable = false, nullable = false)
    private Long type_id;

    @Column(name = "nameTypeMap")
    private String nameType;

    @OneToMany(mappedBy = "typeMapTable")
    private List<MapTable> listMapTable;

    public Long getType_id() {
        return type_id;
    }

    public void setType_id(Long type_id) {
        this.type_id = type_id;
    }

    public String getNameType() {
        return nameType;
    }

    public void setNameType(String nameType) {
        this.nameType = nameType;
    }

    public List<MapTable> getListMapTable() {
        return listMapTable;
    }

    public void setListMapTable(List<MapTable> mapTable) {
        this.listMapTable = mapTable;
    }

    public void internalAddMapTable(MapTable mapTable) {
        this.listMapTable.add(mapTable);
    }

    public void internalRemoveMapTable(MapTable mapTable) {
        this.listMapTable.remove(mapTable);
    }

    public void addMapTable(MapTable mapTable) {
        mapTable.setTypeMap(this);
    }

}
