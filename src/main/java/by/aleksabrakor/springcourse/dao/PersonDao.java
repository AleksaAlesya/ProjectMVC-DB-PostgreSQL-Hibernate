package by.aleksabrakor.springcourse.dao;

import by.aleksabrakor.springcourse.models.Person;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Component
public class PersonDao {
    private final SessionFactory sessionFactory;

    @Autowired
    public PersonDao(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Transactional(readOnly = true) // помечаем, если данные не изменяют, только читают
    public List<Person> index() {
        Session session = sessionFactory.getCurrentSession();

        return session.createQuery("select p from Person p", Person.class)
                .getResultList();
    }

    @Transactional(readOnly = true)
    public Person getById(int personId) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Person.class, personId);
    }

    @Transactional
    public void save(Person person) {
        Session session = sessionFactory.getCurrentSession();
        session.save(person);
    }

    @Transactional
    public void update(Person personUpdate, int id) {
        Session session = sessionFactory.getCurrentSession();
        Person person = session.get(Person.class, id);
        person.setName(personUpdate.getName());
        person.setAge(personUpdate.getAge());
        person.setEmail(personUpdate.getEmail());
        person.setAddress(personUpdate.getAddress());
    }

    @Transactional
    public void deleteById(int id) {
        Session session = sessionFactory.getCurrentSession();
        session.remove(session.get(Person.class, id));
    }

    @Transactional
    public Optional<Person> findByEmail(String email, int id) {
        Session session = sessionFactory.getCurrentSession();

        return session.createQuery("select p from Person p WHERE p.email = '" + email + "' AND p.id <> " + id, Person.class)
                .stream().findAny();
    }
}
