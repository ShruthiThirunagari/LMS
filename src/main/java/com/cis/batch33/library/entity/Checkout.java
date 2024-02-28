package com.cis.batch33.library.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Table(name="checkout")
@Data
public class Checkout {
    @Id
    private Integer id;
    private Long isbn;
    @ManyToOne
    @JoinColumn(name = "member_id")
    private LibraryMember libraryMember;
    private Date checkoutDate;
    private Date dueDate;
    private boolean isReturned;

}
