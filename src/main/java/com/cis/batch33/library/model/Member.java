package com.cis.batch33.library.model;

import lombok.Data;

import java.util.List;

@Data
public class Member {

    private long memberId;
    private String firstName;
    private String lastName;
    private String emailAddress;
    private Long phoneNumber;
    private String memberShipLevel;
    private AddressDTO address;
    private List<CheckoutDTO> checkouts;
}