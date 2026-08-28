package br.carlos.stock_control.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.aspectj.weaver.ast.Or;

import java.util.ArrayList;
import java.util.List;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private String name;

    @Column
    private String username;

    @Column(name = "password_hash")
    private String passwordHash;

    @Column
    private String role;

    @OneToMany(mappedBy = "seller")
    private List<Order> sales = new ArrayList<>();

    @OneToMany(mappedBy = "customer")
    private List<Order> purchases = new ArrayList<>();

}