package main.model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "chapter")
public class Chapter {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "chapter_id", updatable = false, nullable = false)
    private Long chapter_id;

    @Column(name = "nameChapter")
    private String nameChapter;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "collection_id")
    private CollectionMapTable collectionMapTable;

    @OneToMany(mappedBy = "chapter", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Section> listSection;

    public void setItem(CollectionMapTable collectionMapTable)
    {
        if (this.collectionMapTable != null)
            this.collectionMapTable.internalRemoveChapter(this);
        this.collectionMapTable = collectionMapTable;
        if (collectionMapTable != null)
            collectionMapTable.internalAddChapter(this);
    }

    public void internalAddSection(Section section) {
        this.listSection.add(section);
    }

    public void internalRemoveSection(Section section) {
        this.listSection.remove(section);
    }

    public void addSection(Section section) {
        section.setItem(this);
    }

    public Long getChapter_id() {
        return chapter_id;
    }

    public void setChapter_id(Long chapter_id) {
        this.chapter_id = chapter_id;
    }

    public String getNameChapter() {
        return nameChapter;
    }

    public void setNameChapter(String nameChapter) {
        this.nameChapter = nameChapter;
    }

    public CollectionMapTable getCollectionMapTable() {
        return collectionMapTable;
    }

    public void setCollectionMapTable(CollectionMapTable collectionMapTable) {
        this.collectionMapTable = collectionMapTable;
    }

    public List<Section> getListSection() {
        return listSection;
    }

    public void setListSection(List<Section> listSection) {
        this.listSection = listSection;
    }
}
