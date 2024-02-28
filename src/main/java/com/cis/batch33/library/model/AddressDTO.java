package com.cis.batch33.library.model;

import com.cis.batch33.library.entity.LibraryMember;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.Data;

import java.util.List;

@Data
public class AddressDTO {
    private int addressId;
    private String line1;
    private String line2;
    private String city;
    private String state;
    private Integer zip;
}
