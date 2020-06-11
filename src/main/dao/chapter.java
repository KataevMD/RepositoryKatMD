package main.dao;

import main.hibernate.HibernateUtil;
import main.model.Chapter;
import main.model.MapTable;
import main.model.Section;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import java.util.List;

public class chapter {

    public static List<Chapter> findChaptersByIdColl(Long id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        List<Chapter> chapters = session.createQuery("from Chapter c where c.collectionMapTable.collection_id=" + id).getResultList();
        session.getTransaction().commit();
        session.close();
        if (!chapters.isEmpty()) {
            return chapters;
        }
        return null;
    }

    public static List<Section> findSectionByIdChapter(Long id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        List<Section> sections = session.createQuery("from Section s where s.chapter.chapter_id=" + id).getResultList();
        session.getTransaction().commit();
        session.close();
        if (!sections.isEmpty()) {
            return sections;
        }
        return null;
    }

    public static List<Section> findSectionByListIdChapter(Long chapters_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        List<Section> sections = session.createQuery("from Section s where s.chapter.chapter_id in " + chapters_id).getResultList();
        session.getTransaction().commit();
        session.close();
        if (!sections.isEmpty()) {
            return sections;
        }
        return null;
    }
}
