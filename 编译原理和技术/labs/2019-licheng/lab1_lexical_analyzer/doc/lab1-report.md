# Lab1 report

2019.9.21

## Designs & solved problems

**Pattern matching order**

First match comments and `\n`, then special symbols like `+-*/`,`<=`, `,;`. Then match keywords `else, if, int, return, void, while`. Then identifiers and numbers. At last match(and skip) blank characters. If nothing matches, a `.` will do the match and then return error. Most of these orders can be changed without any problem, but certain kinds of pattern must be matched after other kinds. Identifiers should be matched after keywords, or keywords will be match as identifiers. And `==` should be matched before `=`, and `<=` before `<`. 

**Regular expression design**

Most patterns are quite easy, just remember to escape special characters. But I didn't find any specific document that tells me what should be escaped and what shouldn't. So I need to check by hand if any error occurs if I do or do not escape a certain symbol. 

The most difficult patterns is the multiple line comment `/* ... */`. We need to match the beginning and ending `/*` and `*/`, and make sure in the middle no `*/` can occur. But single `*` and `/` and `/*` are legal to occur. My idea is that some other character must appear between a `/` and a `*`. The expression is like(`.` means characters except `*` and `/` but include `\n`; escaping `\` is omitted) **`/* (*?.+/?)* */`**. But this cannot handle the case in which `/` appears first in the middle of comment. So the final result: **`/* (/? .* *? .+ /?)* */`**. 

*[Notice 2020.4] this expression may be wrong!*

**Location counter**

I spent most of the time on this. 

To count the locations(lines and columns) of lexemes, a global counter should be updated when a pattern is matched. Manually update counters by hand in each match like `{colume+=2; return IF;}` is quite annoying, it'll be better if I only need to write the counting code once. I searched on the Internet and found something called `bison-location` which seems to require another bison file, and I failed to get it work. But I found a macro called `YY_USER_ACTION` which is called automatically when a character is matched, and this is also used in that bison method. So I just copied the counting code from stackoverflow and modified it to work with my program: instead of using the `yylloc` variable maintained by bison, I use my own structure to count. Maybe a more elegant way is possible. 

**List files in directory**

To get all `cminus` files in the `testcase/` directory, I used the `opendir` and `readdir` functions. File extension is checked to determine whether this is a `cminus` file. 

I modified some parts of the code given by TAs to make the structure clearer, like moving `suffix` and `extension` string into `main` and pass `extension` as the second parameter of `getAllTestcase()`. 

**Testcase design**

The testcase should include: normal symbols and identifiers, symbols that may cause ambiguity (`[]` and `[`, `<=` and `<`), multi-line comments, multiple comments in one line. Also some error cases like single `!` or other illegal symbols should be tested. 

## Time spent

Some parts is done in fragmentary time, so may not be very accurate.

~0.5h get familiar with the project and what I need to do. 

~0.5h write the main parts

~1h implement the location counter

~1h further debugging and testing (like the regular expression handling comments)

~0.5h other functions(like directory listing)

~0.75h report



