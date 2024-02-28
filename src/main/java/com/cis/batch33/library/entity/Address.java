package com.cis.batch33.library.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Entity
@Table(name="address")
@Data
public class Address {
    @Id
    private int addressId;
    private String line1;
    private String line2;
    private String city;
    private String state;
    private Integer zip;
    @OneToMany(mappedBy = "address")
    private List<LibraryMember> members;
}
