package com.cis.batch33.library.service;

import com.cis.batch33.library.model.Member;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Service
public class MemberService {

    private Map<Long, Member> memberMap = new HashMap<>();

    // Create a member
    public Member createMember(Member member) {
        Long memberId = generateMemberId();
        member.setMemberId(memberId);
        memberMap.put(memberId, member);
        return member;
    }

    // Get a member by ID
    public Member getMember(Long memberId) {
        return memberMap.get(memberId);
    }

    // Update a member
    public Member updateMember(Long memberId, Member updatedMember) {
        if (memberMap.containsKey(memberId)) {
            updatedMember.setMemberId(memberId);
            memberMap.put(memberId, updatedMember);
            return updatedMember;
        }
        return null; // Member not found
    }

    // Delete a member
    public void deleteMember(Long memberId) {
        memberMap.remove(memberId);
    }

    // Generate a random member ID
    private Long generateMemberId() {
        return new Random().nextLong();
    }
}
