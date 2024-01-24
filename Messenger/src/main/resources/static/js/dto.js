import {encrypt} from "./primary_encryprion.js";


function initJSON() {
    var JSON = {
        "login": document.getElementById("nickname").value,
        "password": encrypt(document.getElementById("password").value),
        "name": document.getElementById("name").value,
        "surname": document.getElementById("surname").value
    };
    return JSON;
}

export function sendPostRequest(urlData, jsondata) {
    return fetch("http://localhost:8080" + urlData, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(jsondata)
        // body: JSON.stringify(json)
    })
        .then(response => response.json())
        // .then(response => console.log(JSON.stringify(response)));
}