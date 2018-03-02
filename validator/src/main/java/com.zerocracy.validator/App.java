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

import java.util.List;
import org.cactoos.list.ListOf;

/**
 * App entry point.
 *
 * @author Kirill (g4s8.public@gmail.com)
 * @version $Id$
 * @since 0.1
 * @todo #255:30min App is not implemented. It should parse command line
 *  arguments: one is XML path another is XSL path, apply this XSL to XML
 *  and print transformed XML to the output.
 * @todo #255:30min App should be started in Rakefile for each XSL file in
 *  datum like in 'xsl' goal. Also it should be compiled before and tested
 *  in Rultor merge.
 */
public final class App implements Runnable {
    /**
     * App arguments.
     */
    private final List<String> args;

    /**
     * Ctor.
     * @param arguments App arguments
     */
    private App(final List<String> arguments) {
        this.args = arguments;
    }

    @Override
    public void run() {
        throw new UnsupportedOperationException("#run()");
    }

    public static void main(String[] args) {
        new App(new ListOf<>(args)).run();
    }
}
