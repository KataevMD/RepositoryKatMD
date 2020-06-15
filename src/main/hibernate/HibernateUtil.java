package main.hibernate;

import main.model.*;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;

import java.util.Properties;

public class HibernateUtil {

    private static SessionFactory sessionFactory;
    // Конструктор фабрики сессий
    public static SessionFactory getSessionFactory() {
        if (sessionFactory == null) {
            try {
                Configuration configuration = new Configuration();

                // Hibernate параметры, эквиваленты main.hibernate.cfg.xml's параметрам
                Properties settings = new Properties();
                settings.put(Environment.DRIVER, "com.microsoft.sqlserver.jdbc.SQLServerDriver");
                settings.put(Environment.URL,
                        "jdbc:sqlserver://DESKTOP-18PQ8D9\\SQLEXPRESS;databaseName=UDBofSforTO;integratedSecurity=true;");
                settings.put(Environment.DIALECT, "org.hibernate.dialect.SQLServerDialect");
                settings.put(Environment.SHOW_SQL, "true"); // параметр, выводящий все sql запросы в консоль
                settings.put(Environment.HBM2DDL_AUTO, "update");
                settings.put(Environment.DEFAULT_SCHEMA, "dbo");
                settings.put(Environment.CURRENT_SESSION_CONTEXT_CLASS, "thread");
                configuration.setProperties(settings);
                /*
                 * Передача конфигуратору классов, который он будет воспринимать как сущности
                 */
                configuration.addAnnotatedClass(CollectionMapTable.class);
                configuration.addAnnotatedClass(Chapter.class);
                configuration.addAnnotatedClass(Section.class);
                configuration.addAnnotatedClass(MapTable.class);
                configuration.addAnnotatedClass(Coefficient.class);
                configuration.addAnnotatedClass(ValueCoefficient.class);
                configuration.addAnnotatedClass(Parameter.class);
                configuration.addAnnotatedClass(UsersAdmin.class);
                configuration.addAnnotatedClass(FileMapTable.class);
                configuration.addAnnotatedClass(Formula.class);
                configuration.addAnnotatedClass(TypeTime.class);
                configuration.addAnnotatedClass(TypeMapTable.class);
                configuration.addAnnotatedClass(Discharge.class);
                            // Построение сервиса регистрации с заданной конфигурацией
                ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
                        .applySettings(configuration.getProperties()).build();
                System.out.println("Hibernate Java Config serviceRegistry created");
                sessionFactory = configuration.buildSessionFactory(serviceRegistry);
                return sessionFactory;

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return sessionFactory;
    }

}
