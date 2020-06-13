package main.model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "typeTime")
public class TypeTime {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "typeTime_id", updatable = false, nullable = false)
    private Long typeTime_id;

    @Column(name = "nameTypeTime")
    private String nameTypeTime;

    @OneToMany(mappedBy = "typeMapTable")
    private List<MapTable> listMapTable;

    public Long getTypeTime_id() {
        return typeTime_id;
    }

    public void setTypeTime_id(Long typeTime_id) {
        this.typeTime_id = typeTime_id;
    }

    public String getNameTypeTime() {
        return nameTypeTime;
    }

    public void setNameTypeTime(String nameTypeTime) {
        this.nameTypeTime = nameTypeTime;
    }

    public List<MapTable> getListMapTable() {
        return listMapTable;
    }

    public void setListMapTable(List<MapTable> listMapTable) {
        this.listMapTable = listMapTable;
    }

    public void internalAddMapTable(MapTable mapTable) {
        this.listMapTable.add(mapTable);
    }

    public void internalRemoveMapTable(MapTable mapTable) {
        this.listMapTable.remove(mapTable);
    }

    public void addMapTable(MapTable mapTable) {
        mapTable.setTypeTime(this);
    }

}
