package tasks.filtering_rules;

import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.SortedSet;
import java.util.TreeSet;

/**
 * This program filters out rules and writes the result to XML file.
 * The result contains one rule record for every rule name.
 * Rules are provided in a XML input file.
 *
 * @author Tatiana Savonik
 */
public class FilterXML extends DefaultHandler {

    private final SortedSet<Rule> rules = new TreeSet<>();
    private final String outputFile = "basics%ssrc%smain%sresources%sfiltered_rules.xml".replace("%s", File.separator);
    
    /**
     * Writes rules from the list to xml file.
     */
    protected void writeXml() {
        System.out.println("file recording  started...");
        File outputFile = new File(this.outputFile);
        try {
            BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile));
            writer.write("<rules>\n");
            for (Rule rule : rules) {
                writer.write(String.format("<rule name=\"%s\" type=\"%s\" weight=\"%s\"/>\n",
                        rule.getName(), rule.getType(), rule.getWeight()));
            }
            writer.write("</rules>");
            writer.close();
            System.out.println("file recording  finished.");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * Receives notification of the beginning of an element, if elements qualified name is "rule",
     * creates object Rule and adds to list of rules.
     */
    @Override
    public void startElement(String uri, String localName, String qName, Attributes attributes) {
        if ("rule".equalsIgnoreCase(qName)) {
            String name = attributes.getValue("name");
            String type = attributes.getValue("type");
            int weight = Integer.parseInt(attributes.getValue("weight"));
            Rule entryRule = new Rule(name, type, weight);
            addToRules(entryRule);
        }
    }

    /**
     * Checks if rules contains rule with same name,
     * if doesn't contain adds rule to list, else leaves a higher priority rule.
     */
    private void addToRules(Rule entryRule) {
        for (Rule rule : rules) {
            if (entryRule.getName().equals(rule.getName())) {
                if (entryRule.compareTo(rule) > 0) {
                    rules.remove(rule);
                    rules.add(entryRule);
                }
                return;
            }
        }
        rules.add(entryRule);
    }

    /**
     * Displays the attributes of the rules in the list to the terminal.
     */
    protected void printXml() {
        System.out.println("<rules>");
        for (Rule rule : rules) {
            System.out.print(String.format("<rule name=\"%s\" type=\"%s\" weight=\"%s\"/>\n",
                    rule.getName(), rule.getType(), rule.getWeight()));
        }
        System.out.println("</rules>");
    }
}


