package com.cis.batch33.library.model;

import com.cis.batch33.library.entity.LibraryMember;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;

import java.util.Date;

@Data
public class CheckoutDTO {
    private Integer id;
    private Long isbn;
    private Date checkoutDate;
    private Date dueDate;
    private boolean isReturned;
}
