package model;

import javax.persistence.*;
import java.sql.Blob;

@Entity
@Table(name = "fileMapTable")
public class FileMapTable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "file_id", updatable = false, nullable = false)
    private Long file_id;

    @Column(name = "nameFile")
    private String nameFileMapTable;

    @Column(name = "mapTable_id")
    private Long mapTable_id;

    @Column(name = "filePdf")
    private Blob filePDF;



    public Blob getFile() {
        return filePDF;
    }

    public void setFile(Blob filePDF) {
        this.filePDF = filePDF;
    }

    public Long getFile_id() {
        return file_id;
    }

    public void setFile_id(Long file_id) {
        this.file_id = file_id;
    }

    public String getNameFileMapTable() {
        return nameFileMapTable;
    }

    public void setNameFileMapTable(String nameFileMapTable) {
        this.nameFileMapTable = nameFileMapTable;
    }

    public Long getMapTable_id() {
        return mapTable_id;
    }

    public void setMapTable_id(Long mapTable_id) {
        this.mapTable_id = mapTable_id;
    }


}
