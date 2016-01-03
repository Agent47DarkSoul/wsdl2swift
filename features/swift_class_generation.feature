Feature: Simple swift class generation

  Generate class with properties from wsdl file

  Scenario: WSDL file with single type
    Background:
      Given a file named "sample.wsdl" with:
      """
      <?xml version="1.0" encoding="UTF-8"?>
      <wsdl:definitions targetNamespace="http://excursion.ws.com/Excursion/" xmlns:apachesoap="http://xml.apache.org/xml-soap" xmlns:impl="http://excursion.ws.com/Excursion/" xmlns:intf="http://excursion.ws.com/Excursion/" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:wsdlsoap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
        <wsdl:types>
          <schema targetNamespace="http://excursion.ws.com/Excursion/" xmlns="http://www.w3.org/2001/XMLSchema">
            <complexType name="AuthenticateOperationBody">
              <sequence>
                <element name="userName" type="xsd:string"/>
                <element name="password" type="xsd:string"/>
                <element name="CID" nillable="true" type="xsd:string"/>
              </sequence>
            </complexType>
          </schema>
        </wsdl:types>
      </wsdl:definitions>
      """

    When I successfully run `wsdl2swift sample.wsdl`
    Then the output should contain:
      """
      Generating swift files...
      """
    And the file named "AuthenticateOperationBody.swift" should exist
    And the file "AuthenticateOperationBody.swift" should contain:
      """
      import Foundation
      import AEXML

      class AuthenticateOperationBody {
          var userName : String
          var password : String
          var cID : String?

          init(userName: String, password: String, cID: String? = "") {
              self.userName = userName
              self.password = password
              self.cID = cID
          }

          func xmlNode(tagName: String? = "Body") -> AEXMLELement {
              let node = AEXMLELement(tagName)

              node.addChild("userName", value: self.userName)
              node.addChild("password", value: self.password)
              node.addChild("CID", value: self.cID)

              return node
          }
      }

      """
