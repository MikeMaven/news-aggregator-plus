//let articlesData = [];
let randomizer = document.getElementById("randomizer");
let articles = document.getElementById("container");
let content = document.getElementById("super-container");
let allArticles = document.getElementById("all-articles");
allArticles.style.display = "none";

let randomArticle = (articles) => {
  return articles[Math.floor(Math.random() * articles.length)];
}

fetch('http://localhost:4567/json')
  .then(response => {
    if (response.ok) {
      return response;
    } else {
      let errorMessage = `${response.status} (${response.statusText})`,
          error = new Error(errorMessage);
      throw(error);
    }
  })
  .then(response => {
return response.text();}
)
  .then(body => {
    let bodyParsed = JSON.parse(body);
    randomizer.addEventListener('click', function(){
      while (articles.firstChild){
        articles.removeChild(articles.firstChild);
      }
      let article = randomArticle(bodyParsed);
      let div = document.createElement("div");
      let h4 = document.createElement("h4");
      let link = document.createElement("a");
      let p = document.createElement("p");
      if (allArticles.style.display === "none"){
        allArticles.style.display = "inline-block";
      }
      link.href = article.url;
      link.innerHTML = article.title;
      h4.appendChild(link);
      p.innerHTML = article.description;
      div.appendChild(h4);
      div.appendChild(p);
      div.classList.add("cell", "small-3");
      div.id = "articles";
      articles.appendChild(div);
    });

    allArticles.addEventListener('click', function(){
      while (articles.firstChild){
        articles.removeChild(articles.firstChild);
      }
      bodyParsed.forEach((article) =>{
        let div = document.createElement("div");
        let h4 = document.createElement("h4");
        let link = document.createElement("a");
        let p = document.createElement("p");
        link.href = article.url;
        link.innerHTML = article.title;
        h4.appendChild(link);
        p.innerHTML = article.description;
        div.appendChild(h4);
        div.appendChild(p);
        div.classList.add("cell", "small-3");
        div.id = "articles";
        articles.appendChild(div);
      });
      if (allArticles.style.display === "inline-block"){
        allArticles.style.display = "none";
      }
    });
  })
  .catch(error => console.error(`Error in fetch: ${error.message}`));
