#### Escape Sequences

You can use a \ to escape characters | eg.
\\# Hello world
#### Headings

Writing a heading is something you can do by typing #, # being heading 1 and ###### being heading 6, and everything in between. You can also use = below or - below to get heading 1 and 2 respectively | eg.

\# Heading 1
or
Heading 1
\=

#### Bold And Italic

In order to bold text, either put \** or \__ before and after the phrase | eg.

\*\*Bold Text\*\* | \*Italicized Text\* | \*\*\*Both***
   **Bold Text**     |   *Italicized Text*  |      ***Both***

#### Block-quotes

Put a > in front of a paragraph, you can nest them too | eg.
\> hi
\> > hi again

> hi 
> > hi again


#### Code

To notate code use a backtick (\`). to make a block, use 3 (\`\`\`) | eg.

\`vim test.c\`
`vim test.c`

```
for(int i = 0; i < 12; i++) {
	print("erm wts");
}
```

#### Divider
to make a divider, put 3 _ by themselves | eg.
\_\_\_
___

#### Links
To make a link, type the text in a \[\] bracket, immidiately followed by the link you want to include. To link Notes, use two \[\[\]\], and type in the Note you want to link, or nothing if the note doesn't exist | eg.

\[Google](https://google.com)
[Google](https://google.com)
\[\[erm wtf]] (makes a note)


#### Images
To add an image, add an exclamation mark (`!`), followed by alt text in brackets, and the path or URL to the image asset in parentheses. You can optionally add a title in quotation marks after the path or URL | eg.

\!\[The San Juan Mountains are beautiful!](/assets/images/san-juan-mountains.jpg "San Juan Mountains")

