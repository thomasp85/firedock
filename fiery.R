library(fiery)
library(routr)

router <- RouteStack$new()
route <- Route$new()
h <- function(request, response, keys, ...) {
    response$status <- 200L
    response$type <- 'html'
    response$body <- paste0('<h1>Hello ', keys$what, '!</h1>')
    return(FALSE)
}
route$add_handler('get', '/hello/:what/', h)

hFallback <- function(request, response, keys, ...) {
    response$status <- 200L
    response$type <- 'html'
    response$body <- '<h1>I\'m not saying hello to you</h1>'
    return(FALSE)
}
route$add_handler('get', '/*', hFallback)

router$add_route(route, 'main')

app <- Fire$new(host = '0.0.0.0', port = 8080)
app$root <- '/fiery'
app$attach(router)
app$set_logger(logger_console())

app$ignite()