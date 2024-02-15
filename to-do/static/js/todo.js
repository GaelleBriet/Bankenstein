const app = {
  init() {
    app.addListenersToAction();
  },

  addListenersToAction() {
    const totoContentElms = document.querySelectorAll(".totoContent");

    for (const totoContentElm of totoContentElms) {
      totoContentElm.addEventListener("dblclick", app.handleClickContentTodo);
    }
  },

  handleClickContentTodo(event) {
    const todoContentElm = event.currentTarget;
    const formElm = todoContentElm.closest(".box").querySelector("form");
    todoContentElm.classList.add("is-hidden");
    formElm.classList.remove("is-hidden");
  }
};


document.addEventListener("DOMContentLoaded", app.init);
