package main.model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "collectionMapTable")
public class CollectionMapTable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "collection_id", updatable = false, nullable = false)
    private Long collection_id;

    @Column(name = "nameCollectionMapTable")
    private String nameCollectionMapTable;

    @OneToMany(mappedBy = "collectionMapTable", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<MapTable> listMapTable;

    public Long getCollection_id() {
        return collection_id;
    }

    public void setCollection_id(Long collection_id) {
        this.collection_id = collection_id;
    }

    public String getNameCollectionMapTable() {
        return nameCollectionMapTable;
    }

    public void setNameCollectionMapTable(String nameCollectionMapTable) {
        this.nameCollectionMapTable = nameCollectionMapTable;
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
}
