package main.dao;

import main.hibernate.HibernateUtil;
import main.model.UsersAdmin;
import org.apache.commons.codec.digest.DigestUtils;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

public class admin {
    private static List<UsersAdmin> usersAdminList = null;

    public static String getHash(String password) {
        return DigestUtils.sha512Hex(password);
    }

    /**
     * Метод возвращает объект класса UsersAdmin
     * для дальнейшей авторизации пользователя в системе
     *
     * @param login    - логин пользователя
     * @param password - пароль пользователя
     * @return - объект класса UsersAdmin
     */
    public static UsersAdmin findByUserNameAndPassword(String login, String password) {

        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List<UsersAdmin> usersAdmins;

        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<UsersAdmin> criteria = builder.createQuery(UsersAdmin.class);
        Root<UsersAdmin> root = criteria.from(UsersAdmin.class);
        criteria.select(root);
        criteria.where(builder.equal(root.get("login"), login), builder.equal(root.get("password"), password));

        session.beginTransaction();
        usersAdmins = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();

        Iterator<UsersAdmin> it = usersAdmins.iterator();
        UsersAdmin user;
        if (it.hasNext()) {
            user = it.next();
            return user;
        } else {

            return null;
        }
    }

    /**
     * Метод возвращает список объектов класса UsersAdmin
     * для дальнейшего вывода информации на страницу
     */
    public static List<UsersAdmin> FindAdmins(String idUser) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();

        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<UsersAdmin> criteria = builder.createQuery(UsersAdmin.class);
        Root<UsersAdmin> root = criteria.from(UsersAdmin.class);
        criteria.select(root);

        session.beginTransaction();
        usersAdminList = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();
        if (!usersAdminList.isEmpty()) {
            return usersAdminList;
        }
        return null;
    }

    /**
     * Метод возвращает объект класса UsersAdmin
     * для дальнейшей авторизации пользователя в системе
     * @param login - логин пользователя
     * @param passw - пароль пользователя
     * @param firstName - пароль пользователя
     * @param lastName - пароль пользователя
     * @param patronymic - пароль пользователя
     * @ - Результатом являются данные добавленные в БД
     */
    public static void createAdmin(String firstName, String lastName, String patronymic, String passw, String login) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        UsersAdmin usersAdmin = new UsersAdmin();
        usersAdmin.setFirstName(firstName);
        usersAdmin.setLastName(lastName);
        usersAdmin.setLogin(login);
        usersAdmin.setPatronymic(patronymic);
        usersAdmin.setPassword(getHash(passw));
        Date date = new Date();
        usersAdmin.setDateCreat(date);

        session.getTransaction().begin();// Начало транзакции
        session.merge(usersAdmin);// Загрузка объекта usersAdmin класса UsersAdmin в базу данных
        session.getTransaction().commit();// Конец транзакции
        session.close();

    }
    /**
     * Метод возвращает объект класса UsersAdmin
     * для дальнейшей авторизации пользователя в системе
     * @param id - логин пользователя
     * @ - Результатом являются удаленная уч.запись администратора
     */
    public static void deleteAdmin(Long id) {
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        UsersAdmin usersAdmin = new UsersAdmin();
        usersAdmin.setId(id);
        session.getTransaction().begin();
        session.remove(usersAdmin);
        session.getTransaction().commit();
        session.close();

    }
}
