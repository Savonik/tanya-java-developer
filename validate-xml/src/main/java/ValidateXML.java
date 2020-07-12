
import org.xml.sax.SAXException;

import javax.xml.XMLConstants;
import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;
import java.io.File;
import java.io.IOException;

/**
 * @author Tatiana Savonik
 * <p>
 * This programm validate XML file against attached XSD
 */

public class ValidateXML {
    public static void main(String[] args) {

        if (args.length < 2) {
            System.out.println("This programm validate XML file against XSD file. The program receives 2 parameters:\n" +
                    "1 - path to XML file\n2 - path to XSD file");
        }

        File inputFile = new File(args[0]);
        File schemaFile = new File(args[1]);

        if (!inputFile.exists() || !schemaFile.exists()) {
            System.out.println(inputFile.exists() ? "path to XML file exists" : "path to XML file doesn't exist");
            System.out.println(schemaFile.exists() ? "path to XSD file exists" : "path to XSD file doesn't exist");
            return;
        }


        Source xmlFile = new StreamSource(inputFile);

        SchemaFactory factory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
        try {
            Schema schema = factory.newSchema(schemaFile);
            Validator validator = schema.newValidator();
            validator.validate(xmlFile);
            System.out.println(inputFile.getName() + " is valid");
        } catch (SAXException | IOException e) {
            System.out.println(inputFile.getName() + " is invalid");
            e.printStackTrace();
        }
    }
}

