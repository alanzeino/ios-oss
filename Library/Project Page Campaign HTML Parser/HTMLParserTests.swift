@testable import Library
import XCTest

final class HTMLParserTests: TestCase {
  let htmlParser = HTMLParser()

  func testHTMLParser_WithValidNonGIFImage_Success() {
    let viewElements = self.htmlParser.parse(bodyHtml: HTMLParserTemplates.validNonGIFImage.data)

    guard let viewElement = viewElements.first as? ImageViewElement else {
      XCTFail("image view element should be created.")

      return
    }

    XCTAssertEqual(
      viewElement.src,
      "https://ksr-qa-ugc.imgix.net/assets/033/981/078/6a3036d55ab3c3d6f271ab0b5c532912_original.png?ixlib=rb-4.0.2&amp;w=700&amp;fit=max&amp;v=1624426643&amp;auto=format&amp;gif-q=50&amp;lossless=true&amp;s=aaa772a0ea57e4697c14311f1f2e0086"
        .htmlStripped()
    )
    XCTAssertNil(viewElement.href)

    guard let existingCaption = viewElement.caption else {
      XCTFail("image caption should exist")

      return
    }

    XCTAssertTrue(existingCaption.isEmpty)
  }

  func testHTMLParser_WithValidGIFImage_Success() {
    let viewElements = self.htmlParser.parse(bodyHtml: HTMLParserTemplates.validGIFImage.data)

    guard let viewElement = viewElements.first as? ImageViewElement else {
      XCTFail("image view element should be created.")

      return
    }

    XCTAssertEqual(
      viewElement.src,
      "https://ksr-qa-ugc.imgix.net/assets/033/915/794/8dca97fb0636aeb1a4a937025f369e7e_original.gif?ixlib=rb-4.0.2&amp;w=700&amp;fit=max&amp;v=1623894386&amp;auto=format&amp;gif-q=50&amp;q=92&amp;s=cde086d146601f4d9c6fe07e0d93bb84"
        .htmlStripped()
    )
    XCTAssertNil(viewElement.href)

    guard let existingCaption = viewElement.caption else {
      XCTFail("image caption should exist")

      return
    }

    XCTAssertTrue(existingCaption.isEmpty)
  }

  func testHTMLParser_WithValidImageWithCaption_Success() {
    let viewElements = self.htmlParser.parse(bodyHtml: HTMLParserTemplates.validImageWithCaption.data)

    guard let viewElement = viewElements.first as? ImageViewElement else {
      XCTFail("image view element should be created.")

      return
    }

    XCTAssertEqual(
      viewElement.src,
      "https://ksr-qa-ugc.imgix.net/assets/035/418/752/b1fe3dc3ff2aa64161aaf7cd6def0b97_original.jpg?ixlib=rb-4.0.2&amp;w=700&amp;fit=max&amp;v=1635677740&amp;auto=format&amp;gif-q=50&amp;q=92&amp;s=6f32811c554177afaafc447642d83788"
        .htmlStripped()
    )

    XCTAssertNil(viewElement.href)

    guard let existingCaption = viewElement.caption else {
      XCTFail("image caption should exist")

      return
    }

    XCTAssertEqual(existingCaption, "Viktor Pushkarev using lino-cutting to create the cover art.")
  }

  func testHTMLParser_WithValidImageWithCaptionAndLink_Success() {
    let viewElements = self.htmlParser.parse(bodyHtml: HTMLParserTemplates.validImageWithCaptionAndLink.data)

    guard let viewElement = viewElements.first as? ImageViewElement else {
      XCTFail("image view element should be created.")

      return
    }

    XCTAssertEqual(
      viewElement.src,
      "https://ksr-qa-ugc.imgix.net/assets/034/488/736/c35446a93f1f9faedd76e9db814247bf_original.gif?ixlib=rb-4.0.2&amp;w=700&amp;fit=max&amp;v=1628654686&amp;auto=format&amp;gif-q=50&amp;q=92&amp;s=061483d5e8fac13bd635b67e2ae8a258"
        .htmlStripped()
    )

    XCTAssertEqual(
      viewElement.href,
      "https://producthype.co/most-powerful-crowdfunding-newsletter/?utm_source=ProductHype&amp;utm_medium=Banner&amp;utm_campaign=Homi"
        .htmlStripped()
    )

    guard let existingCaption = viewElement.caption else {
      XCTFail("image caption should exist")

      return
    }

    XCTAssertEqual(existingCaption, "Viktor Pushkarev using lino-cutting to create the cover art.")
  }

  func testHTMLParser_WithValidVideoHigh_Success() {
    let viewElements = self.htmlParser.parse(bodyHtml: HTMLParserTemplates.validVideoHigh.data)

    guard let viewElement = viewElements.first as? VideoViewElement else {
      XCTFail("video view element should be created.")

      return
    }

    XCTAssertEqual(
      viewElement.sourceUrl,
      "https://v.kickstarter.com/1642030675_192c029616b9f219c821971712835747963f13cc/assets/035/455/706/2610a2ac226ce966cc74ff97c8b6344d_h264_high.mp4"
        .htmlStripped()
    )

    XCTAssertEqual(
      viewElement.thumbnailUrl,
      "https://dr0rfahizzuzj.cloudfront.net/assets/035/455/706/2610a2ac226ce966cc74ff97c8b6344d_h264_high.jpg?2021"
    )

    XCTAssertEqual(viewElement.seekPosition, 0)
  }

  func testHTMLParser_WithValidVideo_Success() {
    let viewElements = self.htmlParser.parse(bodyHtml: HTMLParserTemplates.validVideo.data)

    guard let viewElement = viewElements.first as? VideoViewElement else {
      XCTFail("video view element should be created.")

      return
    }

    XCTAssertEqual(
      viewElement.sourceUrl,
      "https://v.kickstarter.com/1642030675_192c029616b9f219c821971712835747963f13cc/assets/035/455/706/2610a2ac226ce966cc74ff97c8b6344d_h264_base.mp4"
        .htmlStripped()
    )

    XCTAssertEqual(
      viewElement.thumbnailUrl,
      "https://dr0rfahizzuzj.cloudfront.net/assets/035/455/706/2610a2ac226ce966cc74ff97c8b6344d_h264_high.jpg?2021"
    )

    XCTAssertEqual(viewElement.seekPosition, 0)
  }

  func testHTMLParser_WithExternalSource_Success() {
    let viewElements = self.htmlParser.parse(bodyHtml: HTMLParserTemplates.validIFrame.data)

    guard let viewElement = viewElements.first as? ExternalSourceViewElement else {
      XCTFail("external source view element should be created.")

      return
    }

    XCTAssertEqual(
      viewElement.iFrameContent,
      "<iframe width=\"100%\" height=\"200\" src=\"https://www.youtube.com/embed/GcoaQ3LlqWI?start=8&amp;feature=oembed&amp;wmode=transparent\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>"
    )
  }

  func testHTMLParser_WithTextHeadline_Success() {
    let viewElements = self.htmlParser.parse(bodyHtml: HTMLParserTemplates.validHeaderText.data)

    guard let viewElement = viewElements.first as? TextViewElement else {
      XCTFail("text view element should be created.")

      return
    }

    guard viewElement.components.count == 1 else {
      XCTFail()

      return
    }

    XCTAssertEqual(
      viewElement.components[0].text,
      "Please participate in helping me finish my film! Just pick a level in the right hand column and click to donate — it only takes a minute."
    )
    XCTAssertNil(viewElement.components[0].link)
    XCTAssertEqual(viewElement.components[0].styles, [TextComponent.TextStyleType.header])
  }

  func testHTMLParser_WithMultipleParagraphsLinksAndStyles_Success() {
    let viewElements = self.htmlParser
      .parse(bodyHtml: HTMLParserTemplates.validParagraphTextWithLinksAndStyles.data)

    guard let textElement1 = viewElements.first as? TextViewElement,
      let textElement2 = viewElements.last as? TextViewElement else {
      XCTFail("text view elements should be created.")

      return
    }

    guard textElement1.components.count == 1 else {
      XCTFail()

      return
    }

    XCTAssertEqual(textElement1.components[0].text, "What about a bold link to that same newspaper website?")
    XCTAssertEqual(textElement1.components[0].link, "http://record.pt/")
    XCTAssertEqual(
      textElement1.components[0].styles,
      [TextComponent.TextStyleType.bold, TextComponent.TextStyleType.link]
    )

    XCTAssertEqual(textElement2.components[0].text, "Maybe an italic one?")
    XCTAssertEqual(textElement2.components[0].link, "http://recordblabla.pt/")
    XCTAssertEqual(
      textElement2.components[0].styles,
      [TextComponent.TextStyleType.emphasis, TextComponent.TextStyleType.link]
    )
  }

  func testHTMLParser_WithParagraphAndStyles_Success() {
    let viewElements = self.htmlParser.parse(bodyHtml: HTMLParserTemplates.validParagraphTextWithStyles.data)

    guard let textElement = viewElements.first as? TextViewElement else {
      XCTFail("text view element should be created.")

      return
    }

    guard textElement.components.count == 2 else {
      XCTFail()

      return
    }

    XCTAssertEqual(
      textElement.components[0].text,
      "This is a paragraph about bacon – Bacon ipsum dolor amet ham chuck short ribs, shank flank cupim frankfurter chicken. Sausage frankfurter chicken ball tip, drumstick brisket pork chop turkey. Andouille bacon ham hock, pastrami sausage pork chop corned beef frankfurter shank chislic short ribs. Hamburger bacon pork belly, drumstick pork chop capicola kielbasa pancetta buffalo pork. Meatball doner pancetta ham ribeye. Picanha ham venison ribeye short loin beef, tail pig ball tip buffalo salami shoulder ground round chicken. Porchetta capicola drumstick, tongue fatback pork pork belly cow sirloin ham hock flank venison beef ribs."
    )
    XCTAssertNil(textElement.components[0].link)
    XCTAssertTrue(textElement.components[0].styles.isEmpty)
    XCTAssertEqual(textElement.components[1].text, "Bold word Italic word")
    XCTAssertNil(textElement.components[1].link)
    XCTAssertEqual(
      textElement.components[1].styles,
      [TextComponent.TextStyleType.emphasis, TextComponent.TextStyleType.bold]
    )
  }

  func testHTMLParser_OfListWithNestedLinks_Success() {
    let sampleLink = "https://www.meneame.net/"
    let viewElements = self.htmlParser.parse(bodyHtml: HTMLParserTemplates.validListWithNestedLinks.data)

    guard let textElement = viewElements.first as? TextViewElement else {
      XCTFail("text view element should be created.")

      return
    }

    guard textElement.components.count == 3 else {
      XCTFail()

      return
    }

    XCTAssertEqual(textElement.components[0].text, "Meneane")
    XCTAssertEqual(textElement.components[0].link, sampleLink)
    XCTAssertEqual(textElement.components[0].styles, [
      TextComponent.TextStyleType.bold,
      TextComponent.TextStyleType.emphasis,
      TextComponent.TextStyleType.link,
      TextComponent.TextStyleType.list
    ])
    XCTAssertEqual(textElement.components[1].text, "Another URL in this list")
    XCTAssertEqual(textElement.components[1].link, sampleLink)
    XCTAssertEqual(textElement.components[1].styles, [TextComponent.TextStyleType.link])
    XCTAssertEqual(textElement.components[2].text, " and some text")
    XCTAssertNil(textElement.components[2].link)
    XCTAssertEqual(textElement.components[2].styles, [TextComponent.TextStyleType.listEnd])
  }
}
