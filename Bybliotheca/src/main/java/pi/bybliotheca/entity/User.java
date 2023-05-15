package pi.bybliotheca.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.List;

@Data
@NoArgsConstructor
@Entity
@Table(name = "USERS")
public class User {

    @Id
    @GeneratedValue
    private int id;
    private String username;
    private String dni;
    private String email;
    private String password;
    private String name;
    private String surname;
    private String role;

    private String token;
    private int active;
    private int deleted;

    public User(String username, String dni, String email, String password, String name, String surname) {
        this.username = username;
        this.dni = dni;
        this.email = email;
        this.password = password;
        this.name = name;
        this.surname = surname;
        this.role = "USER";
        this.token = token;
        this.active = 0;
        this.deleted = 0;
    }
}
