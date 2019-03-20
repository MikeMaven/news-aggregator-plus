fetch('http://localhost:4567/articles-data.json')
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
  console.log(response);
return response.text();}
)
  .then(body => {
    console.log("The body of the response from the fetch call:");
    console.log(body);
    let bodyParsed = JSON.parse(body);
    console.log("The same body in a much more readable format:");
    console.log(bodyParsed);
    // your code here
  })
  .catch(error => console.error(`Error in fetch: ${error.message}`));
