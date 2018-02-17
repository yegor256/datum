/**
 * Copyright (c) 2016-2018 Zerocracy
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to read
 * the Software only. Permissions is hereby NOT GRANTED to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
package com.zerocracy.validator;

import com.jcabi.xml.XMLDocument;
import com.jcabi.xml.XSLDocument;
import java.io.InputStream;
import org.cactoos.io.ResourceOf;
import org.hamcrest.CoreMatchers;
import org.hamcrest.MatcherAssert;
import org.junit.Test;

/**
 * Test case for {@link XmlTransformed}.
 *
 * @author Kirill (g4s8.public@gmail.com)
 * @version $Id$
 * @since 0.1
 * @checkstyle JavadocMethodCheck (500 lines)
 */
public final class XmlTransformedTest {
    @Test
    public void transformXmlWithXsl() throws Exception {
        try (
            final InputStream xml = new ResourceOf("target.xml").stream();
            final InputStream xsl = new ResourceOf("transform.xsl").stream()
        ) {
            MatcherAssert.assertThat(
                new XmlTransformed(
                    new XMLDocument(xml),
                    XSLDocument.make(xsl)
                ).value().node().getFirstChild().getNodeName(),
                CoreMatchers.equalTo("tritems")
            );
        }
    }
}
