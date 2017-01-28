package org.yaml.editor;

import org.junit.Test;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;

import static org.junit.Assert.assertEquals;

public class Snake2JsonTest {

    private void checkConversion(final String input, final String expected) throws IOException {
        final StringWriter sw = new StringWriter();
        new Snake2Json().yamlToJson(new ByteArrayInputStream(input.getBytes(StandardCharsets.UTF_8)), sw);
        assertEquals(expected, sw.toString());
    }

    @Test
    public void simpleIntArray() throws IOException {
        checkConversion("- 1\n- 2\n- 3", "[1,2,3]\n");
    }

    @Test
    public void simpleStringArray() throws IOException {
        checkConversion("- a\n- bc\n- def", "[\"a\",\"bc\",\"def\"]\n");
    }

    @Test
    public void simpleStringToBoolMap() throws IOException {
        checkConversion("first: true\nsecond: false", "{\"first\":true,\"second\":false}\n");
    }

    @Test
    public void complexStructure() throws IOException {
        checkConversion("- [1, null, ]\n- {a: b}", "[[1,null],{\"a\":\"b\"}]\n");
    }

    @Test
    public void multipleDocuments() throws IOException {
        checkConversion("- a\n---\n- b", "[\"a\"]\n[\"b\"]\n");
    }
}
