import { Socket } from 'phoenix';

let socket = new Socket('/socket', {
  params: { token: window.userToken, email: window.email },
});

socket.connect();

const chatRoomTitle = document.getElementById('chat-room-title');

if (chatRoomTitle) {
  const chatRoomName = chatRoomTitle.dataset.chatRoomName;
  const channel = socket.channel(`chat_room:${chatRoomName}`, {});
  const messagesForm = document.getElementById('new-message-form');
  const messageInput = document.getElementById('message');
  const messagesContainer = document.querySelector("[data-role='messages']");

  messagesForm.addEventListener('submit', (event) => {
    event.preventDefault();
    channel.push('new_message', { body: messageInput.value });
    event.target.reset();
  });

  channel.on('new_message', (payload) => {
    const messageItem = document.createElement('li');
    messageItem.dataset.role = 'message';
    messageItem.innerText = `${payload.author}: ${payload.body}`;
    messagesContainer.appendChild(messageItem);
  });

  channel.join();
}

export default socket;
