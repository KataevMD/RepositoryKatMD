package main.model;


import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "section")
public class Section {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "section_id", updatable = false, nullable = false)
    private Long section_id;

    @Column(name = "nameSection")
    private String nameSection;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "chapter_id")
    private Chapter chapter;

    @OneToMany(mappedBy = "section", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<MapTable> listMapTable;

    public void setItem(Chapter chapter)
    {
        if (this.chapter != null)
            this.chapter.internalRemoveSection(this);
        this.chapter = chapter;
        if (chapter != null)
            chapter.internalAddSection(this);
    }

    public void internalAddMapTable(MapTable mapTable) {
        this.listMapTable.add(mapTable);
    }

    public void internalRemoveMapTable(MapTable mapTable) {
        this.listMapTable.remove(mapTable);
    }

    public void addMapTable(MapTable mapTable) {
        mapTable.setItem(this);
    }

    public Long getSection_id() {
        return section_id;
    }

    public void setSection_id(Long section_id) {
        this.section_id = section_id;
    }

    public String getNameSection() {
        return nameSection;
    }

    public void setNameSection(String nameSection) {
        this.nameSection = nameSection;
    }

    public Chapter getChapter() {
        return chapter;
    }

    public void setChapter(Chapter chapter) {
        this.chapter = chapter;
    }

    public List<MapTable> getListMapTable() {
        return listMapTable;
    }

    public void setListMapTable(List<MapTable> listMapTable) {
        this.listMapTable = listMapTable;
    }
}
