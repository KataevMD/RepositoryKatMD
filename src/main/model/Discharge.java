package main.model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "discharge")
public class Discharge {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "discharge_id", updatable = false, nullable = false)
    private Long discharge_id;

    @Column(name = "valueDischarge")
    private String valueDischarge;

    @OneToMany(mappedBy = "discharge")
    private List<MapTable> listMapTable;


    public Long getDischarge_id() {
        return discharge_id;
    }

    public void setDischarge_id(Long discharge_id) {
        this.discharge_id = discharge_id;
    }

    public String getValueDischarge() {
        return valueDischarge;
    }

    public void setValueDischarge(String valueDischarge) {
        this.valueDischarge = valueDischarge;
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
        mapTable.setDisch(this);
    }

}
