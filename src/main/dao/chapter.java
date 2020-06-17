package main.dao;

import main.hibernate.HibernateUtil;
import main.model.*;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.Iterator;
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

    public static Chapter findChaptersById(Long chapter_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List<Chapter> chapters;
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Chapter> criteria = builder.createQuery(Chapter.class);
        Root<Chapter> root = criteria.from(Chapter.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("chapter_id"), chapter_id));

        session.beginTransaction();
        chapters = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();

        Iterator<Chapter> it = chapters.iterator();
        return it.next();
    }

    public static Section findSectionById(Long section_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List<Section> sections;
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Section> criteria = builder.createQuery(Section.class);
        Root<Section> root = criteria.from(Section.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("section_id"), section_id));

        session.beginTransaction();
        sections = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();

        Iterator<Section> it = sections.iterator();
        return it.next();
    }


    public static boolean rewriteChapter(String nameChapter, Long chapter_id) {
        Chapter chapter = findChaptersById(chapter_id);
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        if (chapter != null) {
            chapter.setNameChapter(nameChapter);
            session.getTransaction().begin();
            session.update(chapter);
            session.getTransaction().commit();
            session.close();
            return true;
        }
        session.close();
        return false;
    }

    public static boolean rewriteSection(String nameSection, Long section_id) {
        Section section = findSectionById(section_id);
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        if (section != null) {
            section.setNameSection(nameSection);
            session.getTransaction().begin();
            session.update(section);
            session.getTransaction().commit();
            session.close();
            return true;
        }
        session.close();
        return false;
    }

    public static void createChapter(Long collection_id, String nameChapter) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();

        CollectionMapTable collectionMapTable = collMapTable.findCollectionMapTableById(collection_id);;

        Chapter chapter = new Chapter();
        chapter.setNameChapter(nameChapter);
        chapter.setCollectionMapTable(collectionMapTable);

        session.beginTransaction();
        session.merge(chapter);
        session.getTransaction().commit();
        session.close();
    }

    public static void createSection(Long chapter_id, String nameSection) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();

        Chapter chapter = main.dao.chapter.findChaptersById(chapter_id);

        Section section = new Section();
        section.setNameSection(nameSection);
        section.setChapter(chapter);

        session.beginTransaction();
        session.merge(section);
        session.getTransaction().commit();
        session.close();
    }

    public static boolean deleteChapterById(Long chapter_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Chapter chapter = findChaptersById(chapter_id);
        if (chapter != null) {
            session.getTransaction().begin();
            session.delete(chapter);
            session.getTransaction().commit();
            session.close();
            return true;
        }
        session.close();
        return false;
    }

    public static boolean deleteSectionById(Long section_id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Section section = findSectionById(section_id);
        if (section != null) {
            session.getTransaction().begin();
            session.delete(section);
            session.getTransaction().commit();
            session.close();
            return true;
        }
        session.close();
        return false;
    }
}
