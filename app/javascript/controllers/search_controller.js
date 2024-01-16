import { Controller } from "@hotwired/stimulus"
import { post, get } from '@rails/request.js'

export default class extends Controller {
  static targets = ["log", "searches", "analytics"];
  connect() {
    this.debouncedSaveSearch = this.debounce(this.saveSearch, 500);
    this.deque = [];
  }
  

  log(event) {
    this.logTarget.textContent = event.target.value;
    this.search(event.target.value);
  }
  search(text) {
    if (this.deque.length && this.deque[this.deque.length - 1].startsWith(text)) return;
    while (this.deque.length && text.startsWith(this.deque[this.deque.length - 1]) && this.deque[this.deque.length - 1].length !== text.length) {
      this.deque.pop();
    }
    this.deque.push(text);

    this.debouncedSaveSearch();
  }
  optimisticUpdate(text) {
    this.searchesTarget.innerHTML = this.searchesTarget.innerHTML + `<li>${text}</li>`
  }
  async saveSearch() {
    if (this.deque.length == 0) return;

    const text = this.deque[0]
    this.deque.shift()

    if (text.length == 0) return;
    this.optimisticUpdate(text)
    try {
      const response = await post('searches/save', {
        body: JSON.stringify({ text: text }),
        contentType: "application/json",

        responseKind: "html"
      });

      if (!response.ok) {
        throw new Error('Network response was not ok');
      } else {
        response.text.then((body) => {
          this.searchesTarget.innerHTML = body;
          this.logTarget.textContent = '';
          this.updateAnalytics();
        })

      }



    } catch (error) {
      console.error('There has been a problem with your fetch operation:', error);
    }
    this.debouncedSaveSearch();

  }
 updateAnalytics(){
    get('searches/analytics', {
      responseKind: "html"
    }).then((response) => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      } else {
        response.text.then((body) => {
          this.analyticsTarget.innerHTML = body;
        })

      }
    }).catch((error) => {
      console.error('There has been a problem with your fetch operation:', error);
    });

  }
  debounce(func, wait) {
    let timeout;
    return function(...args) {
      const context = this;
      clearTimeout(timeout);
      timeout = setTimeout(() => {
        func.apply(context, args);
      }, wait);
    };
  }



}

