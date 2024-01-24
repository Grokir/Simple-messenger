package com.example.test_spring.controller;


import com.example.test_spring.dto.request.ChatRequest;
import com.example.test_spring.dto.request.MsgDelRequest;
import com.example.test_spring.dto.request.MsgRequest;
import com.example.test_spring.dto.request.UsersInChatRequest;
import com.example.test_spring.dto.response.MsgResponse;
import com.example.test_spring.model.Chat;
import com.example.test_spring.service.*;
import lombok.RequiredArgsConstructor;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/chat")
@RequiredArgsConstructor
public class HistoryController {

    private final ChatService chatService;
    private final UsersInChatService usersInChatService;
    private final MsgService msgService;
    private final UserService userService;
    private final HistoryService historyService;


    @PostMapping("/create")
    public ResponseEntity<JSONObject> createChat(@RequestBody ChatRequest chatRequest){
        JSONObject json = new JSONObject();
        json.put("chatId", chatService.createAndRetUUID(chatRequest));
        return new ResponseEntity<>(json, HttpStatus.OK);
    }

    @DeleteMapping("/{chatId}/delete")
    public ResponseEntity<String> deleteChat(@PathVariable String chatId){
        return new ResponseEntity<>("Add record: " + chatService.delete(chatId), HttpStatus.OK);
    }

    @PostMapping("/{chatId}/add_user")
    public ResponseEntity<String> addUser(@RequestBody UsersInChatRequest usersInChatRequest, @PathVariable String chatId){
        usersInChatRequest.setId(UUID.fromString(chatId));
        return new ResponseEntity<>("Add record: " + usersInChatService.addUsers(usersInChatRequest), HttpStatus.OK);
    }

    @DeleteMapping("/{chatId}/delete_user")
    public  ResponseEntity<String> deleteUser(@RequestBody UsersInChatRequest usersInChatRequest, @PathVariable String chatId){
        usersInChatRequest.setId(UUID.fromString(chatId));
        return new ResponseEntity<>("Add record: " + usersInChatService.update(usersInChatRequest), HttpStatus.OK);
    }

    @PostMapping("/{chatId}/add_msg")
    public ResponseEntity<JSONObject> addMsg(@RequestBody MsgRequest msgRequest, @PathVariable String chatId){
        JSONObject jsonResponse = new JSONObject();
//        String decodeMsgText = CryptoService.sendPOST("msgText", msgRequest.getMsgText(), true);
//        msgRequest.setMsgText(decodeMsgText);

        msgRequest.setId(UUID.randomUUID());
        msgRequest.setTimeMessage(LocalDateTime.now());
        if(msgService.create(msgRequest, chatId)) {
            MsgResponse resp = msgService.getReferenceById(msgRequest.getId().toString());
            jsonResponse.put("id", resp.getId());
            jsonResponse.put("userId", resp.getUserId());
            jsonResponse.put("msgText", resp.getMsgText());
            jsonResponse.put("dateDispatch", resp.getDateDispatch());

        }

        return new ResponseEntity<>(jsonResponse, HttpStatus.OK);
    }

    @DeleteMapping("/{chatId}/delete_msg")
    public ResponseEntity<String> deleteSeveralMsg(@RequestBody MsgDelRequest delRequest){
        JSONArray msgArray = delRequest.getMsgIdArray();
        Boolean res = false;
        for(Integer i = 0; i < msgArray.size(); i++){
            res = msgService.delete((String) msgArray.get(i));
        }
        return new ResponseEntity<>("Delete msg: " + res, HttpStatus.OK);
    }


    @GetMapping("/{chatId}/show_all")
    public ResponseEntity<JSONArray> showAllMessages(@PathVariable String chatId){
        return new ResponseEntity<>(msgService.showAllMessages(chatId), HttpStatus.OK);
    }

    @GetMapping("/{chatId}/count_msg")
    public ResponseEntity<JSONObject> countMessages(@PathVariable String chatId){
        JSONObject jsonResp = new JSONObject();
        jsonResp.put("countMsg", msgService.showAllMessages(chatId).size());
        return new ResponseEntity<>(jsonResp, HttpStatus.OK);
    }


    @PostMapping("/get_direct_id")
    public ResponseEntity<JSONObject> getDirectId(@RequestBody UsersInChatRequest usersInChatRequest){
        JSONArray jsonArray = usersInChatRequest.getArrUserId();
        List<Chat> tmp = historyService.getChatList(jsonArray.get(0).toString());
        List<Chat> chats = historyService.getChatList(jsonArray.get(1).toString());
        JSONObject jsonResponse = new JSONObject();
        String id = "";
        if(!tmp.isEmpty() && !chats.isEmpty()) {
            int size = tmp.size() >= chats.size() ? tmp.size() : chats.size();
            for (int i = 0; i < size; i++) {
                if (chats.contains(tmp.get(i)) && tmp.get(i).getTitle_chat().equals("direct")) {
                    id = tmp.get(i).getId_chat().toString();

                    break;
                }
            }
        }

        if(id == ""){
            ChatRequest request = new ChatRequest();
            request.setTitle("direct");
            usersInChatRequest.setId(chatService.createAndRetUUID(request));
            if (usersInChatService.addUsers(usersInChatRequest))
                id = usersInChatRequest.getId().toString();
        }

        jsonResponse.put("chatId", id);
        return new ResponseEntity<>(jsonResponse, HttpStatus.OK);
    }
}
