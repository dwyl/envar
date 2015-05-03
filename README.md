# retriever

![golden retriever with ball](http://i.imgur.com/mdGD3ZO.jpg)

## Why?

Often in our apps we want to fetch content/resources from other web services
the same way a person would by clicking on links in a web browser.
We can do this using a standard `http.request` (*node.js core*), but many
services don't like it when developers make requests for their content
[***programatically***](http://english.stackexchange.com/questions/12245)
(e.g. Facebook wants you to use their API so they know who is making
  the requests...)
Sometimes we *want* retrieve content *anonymously*.
