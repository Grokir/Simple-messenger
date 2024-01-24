package com.example.test_spring.repository;


import com.example.test_spring.model.Msg;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
@EnableJpaRepositories
public interface MsgRepository extends JpaRepository<Msg, UUID> {
    Optional<Msg> findMsgByTimeMessage(Date time_message);
    Optional<Msg> findMsgById(UUID idMsg);
    @Query(value = """
    SELECT msg."id" 
    FROM msg 
    WHERE msg."id" = :msgId 
    """, nativeQuery = true)
    List<Msg> findAllByChatId(@Param("msgId") UUID msgId);
}
