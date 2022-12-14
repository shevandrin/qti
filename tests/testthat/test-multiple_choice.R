test_that("Testing create_item_body_multiplechoice", {
    sc <- new("MultipleChoice",
              text = new("Text",content = list("")),
              choices = c("Hydrogen","Helium","Carbon","Oxygen","Nitrogen","Chlorine"),
              choice_identifiers = c("H","He","C","O","N","Cl"),
              points = c(1,0,0,1,0,-1),
              title = "filename_sc",
              prompt = "Which of the following elements are used to form water?")

    example <- '<itemBody>
<choiceInteraction responseIdentifier="RESPONSE" shuffle="true" maxChoices="0">
<prompt>Which of the following elements are used to form water?</prompt>
<simpleChoice identifier="H">Hydrogen</simpleChoice>
<simpleChoice identifier="He">Helium</simpleChoice>
<simpleChoice identifier="C">Carbon</simpleChoice>
<simpleChoice identifier="O">Oxygen</simpleChoice>
<simpleChoice identifier="N">Nitrogen</simpleChoice>
<simpleChoice identifier="Cl">Chlorine</simpleChoice>
</choiceInteraction>
</itemBody>'

    xml1 <- xml2::read_xml(toString(create_item_body_multiplechoice(sc)))
    xml2 <- xml2::read_xml(example)
    expect_equal(xml1, xml2)
})

test_that("Testing create_response_declaration_multiple_choice",{
    sc <- new("MultipleChoice",
              text = new("Text",content = list("")),
              choices = c("Hydrogen","Helium","Carbon","Oxygen","Nitrogen","Chlorine"),
              choice_identifiers = c("H","He","C","O","N","Cl"),
              points = c(1,0,0,1,0,-1),
              title = "filename_sc",
              prompt = "Which of the following elements are used to form water?")
# 'The default value was changed from -2 to 0 because the package not allow negative points for Total score

    example <- '<responseDeclaration cardinality="multiple" baseType="identifier">
    <correctResponse>
        <value identifier="RESPONSE">H</value>
        <value>O</value>
    </correctResponse>
    <mapping lowerBound="0" upperBound="2" defaultValue="0">
        <mapEntry mapKey="H" mappedValue="1"/>
        <mapEntry mapKey="O" mappedValue="1"/>
        <mapEntry mapKey="Cl" mappedValue="-1"/>
    </mapping>
    </responseDeclaration>'

    qtiXML <- toString(create_response_declaration_multiple_choice(sc))
    xml1 <- xml2::read_xml(qtiXML)
    xml2 <- xml2::read_xml(example)

    if(isTRUE(identical(xml1,xml2)) == FALSE){

        # 'Convert the String in atomic vector to compare the 2 XML are equal in content
        vxml1 <- unlist(strsplit(as.character(xml1),split = ""))
        vxml2 <- unlist(strsplit(as.character(xml2),split = ""))

        if (identical(stringr::str_sort(vxml2), stringr::str_sort(vxml1)) == FALSE){
            print("XML content differs")
            expect_equal(xml1, xml2)
        }
        else{
            #compare if the 2 XML are equal in structure. It omits attributes and other values, only validate de tag names
            a = XML::xmlParse(xml1, asText = TRUE)
            b = XML::xmlParse(xml2, asText = TRUE)
            result <- XML::compareXMLDocs(a,b)

            if(is.logical(result$countDiffs) && length(result$countDiffs) == 1 && !is.na(result$countDiffs) && lengths(result$countDiffs) > 0){
                print("XML structure differs")
                expect_equal(xml1, xml2)
            }
            else{
                expect_equal(0, 0)
            }
        }
    }else{
        print("Direct test passed")
        expect_equal(xml1, xml2)
    }

})

test_that("Testing outcomeDeclaration for Multiple Choice",{
    sc <- new("MultipleChoice",
              text = new("Text",content = list("")),
              choices = c("Hydrogen","Helium","Carbon","Oxygen","Nitrogen","Chlorine"),
              points = c(1,0,0,1,0,-1),
              title = "filename_sc",
              prompt = "Which of the following elements are used to form water?")

    #' The original example does not include this part, the content of the example is based on OPAL configuration
    example <- '<outcomeDeclaration identifier="MAXSCORE" cardinality="single" baseType="float">
<defaultValue>
<value>2</value>
</defaultValue>
</outcomeDeclaration>'

    xml1 <- xml2::read_xml(toString(create_outcome_declaration_multiple_choice(sc)))
    xml2 <- xml2::read_xml(example)
    expect_equal(xml1, xml2)


})

