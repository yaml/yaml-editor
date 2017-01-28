package org.yaml.editor;

import org.junit.Test;

import java.io.ByteArrayInputStream;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;

import static org.junit.Assert.assertEquals;

public class Snake2JsonTest {

    private void checkConversion(final String input, final String expected) {
        final StringWriter sw = new StringWriter();
        new Snake2Json().yamlToJson(new ByteArrayInputStream(input.getBytes(StandardCharsets.UTF_8)), sw);
        assertEquals(expected, sw.toString());
    }

    @Test
    public void simpleIntArray() {
        checkConversion("- 1\n- 2\n- 3", "[1,2,3]");
    }

    @Test
    public void simpleStringArray() {
        checkConversion("- a\n- bc\n- def", "[\"a\",\"bc\",\"def\"]");
    }

    @Test
    public void simpleStringToBoolMap() {
        checkConversion("first: true\nsecond: false", "{\"first\":true,\"second\":false}");
    }

    @Test
    public void complexStructure() {
        checkConversion("- [1, null, ]\n- {a: b}", "[[1,null],{\"a\":\"b\"}]");
    }
}
