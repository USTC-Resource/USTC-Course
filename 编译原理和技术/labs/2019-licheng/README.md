# 2019秋李诚老师编译原理Labs

古宜民 17少 (https://github.com/ustcpetergu) 

队友：苏文治，朱凡

 Labs for "Principles and Techniques of Compilers" course by Cheng Li, USTC 2019. 
 `lab1_lexical_analyzer`: Lab1, lexical analyzer, using flex
 `lab2_syntax_analyzer`: Lab2, syntax analyzer, using bison and lab1, from source code to syntax tree
 `lab3-0`: Warmup about LLVM code generation
 `lab3-1`: The main CMinus Compiler: syntax tree to LLVM IR
 `lab3-2`: Source code reading report for LLVM Pass(dce and adce)
 `lab4`: RISC-V machine code generation and execution & LLVM RegAllocFast source code reading

因为2019秋的Labs很多都是基于七位助教提供的框架补充内容/继续开发，很多Tutorial和Instruction均不是我们原创，并且当时项目目录结构就比较混乱，在我们的开发后更加混乱，想要运行代码有一定难度：所以这里在保持一学期项目完整度的情况下尽可能只放了我们原创的内容，包括主代码文件，工作和讨论记录，以及实验报告。

代码文件只能阅读，不具备运行条件。相比之下实验报告参考价值更大一些。每个lab的实验要求在实验报告里有总结。

学期后我整理了lab1、lab2、lab3-1的代码（词法分析，语法分析，语法树到IR）成为一整个可以比较方便地运行和继续开发(立了个flag)的repo，在[ustcpetergu/CminusC](https://github.com/ustcpetergu/CminusC)。Bug肯定是有的，但应该不多了（助教的样例测试分数98/100）。

该学期的课程主页：http://210.45.114.30/gbxu/notice_board/issues


