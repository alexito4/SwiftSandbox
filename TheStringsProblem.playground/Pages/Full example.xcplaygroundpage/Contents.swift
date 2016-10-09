//: [Previous](@previous)

import Foundation

// returns HTML already scaped!
func imageTag(image: String) -> XML {
    let imageUrl = url(image)
    return xml("<img src=\"\(imageUrl)\">")
}

/**
*  EXAMPLE
*/

struct Article {
    let title: String
    let url: URL
}

struct Share {
    let siteTitle: String
    let url: URL
    let imageTag: XML
}

func shareLinksWithArticle(article: Article) -> XML {
    let title = XML(text: article.title)
    
    func compose(share: Share) -> XML {
        let url = XML(text: share.url.render())
        let siteTitle = XML(text: share.siteTitle)
        // Break it to make the compilar happy or "expression is to complex"
        let a = xml("<a href=\"") + url + xml("\"")
        let b = xml("title=\"") + siteTitle + xml(": \u{201C};") + title + xml("\u{201D}")
        let c = xml(">") + share.imageTag + XML(text: "Image here") + xml("</a>")
        let link: XML = a + b + c
        return link
    }
    
    let noBreakSpace = xml("&#160;")
    
    func join(xmls: [XML], withSeparator separator: XML) -> XML {
        guard xmls.count > 0 else { return XML() }
        guard xmls.count > 1 else { return xmls.first! }
        
        return xmls.dropFirst().reduce(xmls.first!) { (acc, frag) -> XML in
            return acc + noBreakSpace + frag
        }
    }
    
    let xmls = shareSitesWithArticle(article).map(compose)
    
    return join(xmls, withSeparator: noBreakSpace)
}

func shareSitesWithArticle(article: Article) -> [Share] {
    let title = url(article.title)
    let articleUrl = article.url
    return [
        Share(
            siteTitle: "Submit to Reddit.com",
            url: url("http://reddit.com/submit?url=\(articleUrl)&title=\(title)"),
            imageTag: imageTag("reddit.gif")
        ),
        Share(
            siteTitle: "Save to del.icio.us",
            url: url("http://del.icio.us/post?v=2&url=\(articleUrl)&title=\(title)"),
            imageTag: imageTag("delicious.gif"))
    ]
}

let test = Article(
    title: "A type-based solution to the “strings problem”: a fitting end to XSS and SQL-injection holes?",
    url: URL(text: "http://blog.moertel.com/posts/2006-10-18-a-type-based-solution-to-the-strings-problem.html")
)

let result = shareLinksWithArticle(test)
print(result)

//: [Next](@next)
