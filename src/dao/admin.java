package dao;

import hibernate.HibernateUtil;
import model.MapTable;
import model.UsersAdmin;
import org.apache.commons.codec.digest.DigestUtils;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.Iterator;
import java.util.List;

public class admin {
    private static List<UsersAdmin> usersAdminList = null;

    public static String getHash(String password) {
        return DigestUtils.sha512Hex(password);
    }

    public static UsersAdmin findByUserNameAndPassword(String login, String password) {

        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        List<UsersAdmin> usersAdmins;

        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<UsersAdmin> criteria = builder.createQuery(UsersAdmin.class);
        Root<UsersAdmin> root = criteria.from( UsersAdmin.class );
        criteria.select( root );
        criteria.where( builder.equal( root.get("login"), login ), builder.equal(root.get("password"), password) );

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
    public static List<UsersAdmin> FindAdmins(){
        SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();

        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<UsersAdmin> criteria = builder.createQuery(UsersAdmin.class);
        Root<UsersAdmin> root = criteria.from( UsersAdmin.class );
        criteria.select( root );

        session.beginTransaction();
        usersAdminList = session.createQuery(criteria).getResultList();
        session.getTransaction().commit();
        session.close();
        if(!usersAdminList.isEmpty()){
            return usersAdminList;
        }
        return null;
    }
}
