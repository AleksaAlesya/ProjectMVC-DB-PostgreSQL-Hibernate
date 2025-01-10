package by.aleksabrakor.springcourse.util;

import by.aleksabrakor.springcourse.dao.PersonDao;
import by.aleksabrakor.springcourse.models.Person;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Component
public class PersonValidator implements Validator {
    private PersonDao personDao;

    @Autowired
    public PersonValidator(PersonDao personDao) {
        this.personDao = personDao;
    }

    @Override
    public boolean supports(Class<?> clazz) {
        return Person.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        Person person = (Person) target;

        if (personDao.findByEmail(person.getEmail(),person.getId()).isPresent()) {
            errors.rejectValue("email", "", "This email is already take");
        }
    }
}
