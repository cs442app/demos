import { initializeApp } 
from 'https://www.gstatic.com/firebasejs/10.5.0/firebase-app.js';

import { getFirestore, collection, query, orderBy, onSnapshot, addDoc } 
from 'https://www.gstatic.com/firebasejs/10.5.0/firebase-firestore.js';


// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyDvN4YTSl48ZWqxFVmyMzTSRv_3RcnEn00",
  authDomain: "cs-442-demos.firebaseapp.com",
  projectId: "cs-442-demos",
  storageBucket: "cs-442-demos.appspot.com",
  messagingSenderId: "680358361752",
  appId: "1:680358361752:web:4b6b36d478ad4c957c2eed",
  measurementId: "G-3WS3PMZ867"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Initialize Firestore
const db = getFirestore(app);
const messagesRef = collection(db, 'messages');


// Function to display messages
function displayMessages() {
    onSnapshot(
        query(
            messagesRef,
            orderBy('timestamp', 'asc')
        ),
        (querySnapshot) => {
            document.getElementById('message-list').innerHTML = '';
            querySnapshot.forEach((doc) => {
                const data = doc.data();
                const messageElement = document.createElement('div');
                messageElement.textContent = `${data.sender}: ${data.text}`;
                document.getElementById('message-list').appendChild(messageElement);
        });
    });
}

// Initial message display
displayMessages();

function sendMessage() {
    const messageInput = document.getElementById('message');
    const messageText = messageInput.value.trim();

    if (messageText !== '') {
        const sender = 'anonymous'; // Hardcoded username
        const timestamp = new Date();

        addDoc(messagesRef, {
            text: messageText,
            sender: sender,
            timestamp: timestamp
        });

        messageInput.value = '';
    }
}

document.getElementById('send').addEventListener('click', sendMessage);

document.getElementById('message').addEventListener('keydown', (event) => {
    if (event.key === 'Enter') {
        sendMessage();
    }
});
