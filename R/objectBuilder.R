# define class AtimicInline for html formatting newlines and images
#' @importFrom commonmark markdown_html
#' @importFrom htmltools HTML
#' @import yaml

create_content_object <- function(file) {
    file <- readLines(file)
    file <- gsub("<<", "<entry>", file)
    file <- gsub(">>", "</entry>", file)
    h <- HTML(markdown_html(file, hardbreaks = TRUE, smart = TRUE))
    count_all_gaps <- length(unlist(stringr::str_extract_all(h, "<entry>")))
    ids <- make_ids(count_all_gaps, "response")
    end <- unlist(gregexpr("<entry>", h)) - 1L
    begin <- unlist(gregexpr("</entry>", h)) + 8L
    all = sort(c(begin, end, 1, nchar(h)))
    content = list()
    for (i in seq(length(all) - 1)) {
        text_chank <- substring(h, all[i], all[i + 1L] - 1L)
        text_chank <- gsub("\n", "", text_chank)
        if((i %% 2) == 0) {
            text_chank <- create_text_gap_object(text_chank, ids[i / 2])
        }
        content = append(content, text_chank)
    }
    text <- new("Text", content =  content)
}

create_text_gap_object <- function(params, id) {
    params <- stringr::str_sub(params, 9, -9)
    params <- try(yaml::yaml.load(params), silent = TRUE)
    if (is.null(params) | is.character(params) | is.numeric(params)) {
        new("TextGap", response_identifier = id,
            response = params,
            score = 1)
    } else {
        new("TextGap", response_identifier = id, score = 1,
            response = params$content$response,
            alternatives = params$content$alternatives)
    }
}

make_ids <- function(n, type) {
    paste(type, formatC(1:n, flag = "0", width = nchar(n)), sep = "_")
}