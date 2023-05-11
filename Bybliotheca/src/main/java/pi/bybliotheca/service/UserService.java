package pi.bybliotheca.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pi.bybliotheca.entity.Book;
import pi.bybliotheca.entity.User;
import pi.bybliotheca.repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository repository;

    public User saveUser(User user) {
        return repository.save(user);
    }

    public String deleteUser(int id) {
        repository.deleteById(id);
        return "User removed" + id;
    }

    public User updateUser(User user) { //no he puesto el dni porque me parecería un poco raro poder cambiar eso
        User existingUser = repository.findById(user.getId()); //orElse(null)?
        existingUser.setEmail(user.getEmail());
        existingUser.setPassword(user.getPassword());
        existingUser.setName(user.getName());
        existingUser.setSurname(user.getSurname());
        return repository.save(existingUser);
    }

    public User getUserById(int id) {
        return repository.findById(id); //orElse(null)?
    }

    public User getUserByFullname(String name, String surname) {
        return repository.findByFullname(name,surname);
    }
}
