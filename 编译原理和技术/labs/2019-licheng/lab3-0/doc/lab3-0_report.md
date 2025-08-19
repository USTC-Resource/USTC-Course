## lab3-0 Report

Yimin Gu

PB17000002

### Requirements

In my understanding, this lab breaks into three main parts: 

- Setup environment: Compile LLVM, setup auto-completion plugins, ...
- Translate C(minus) to LLVM IR by hand. 
- Translate by CPP

### My implementation

#### Environment setup

As I've compiled LinuxFromScratch before, I think the compiling process should not be difficult for me. But as I met a problem(described below), the process turns out to be painful, I have to use single thread despite my (relatively) powerful laptop, and the compiling needs more than 3 hours. 

About auto-completion plugins, I use [CoC](https://github.com/neoclide/coc.nvim) for C++ and [TabNine](https://github.com/zxqfl/TabNine) for other code in (N)Vim. It "makes my neovim as smart as VSCode". I also used `rhysd/vim-llvm` for LLVM IR syntax highlighting. 

#### Manual translation

**assign**

This is quite simple, only one basic block(`entry`). Just allocate a i32 memory unit save the number 1 to it, load to a register, and return the value in the register. 

```
	%0 = alloca i32
	store i32 1, i32* %0
	%1 = load i32, i32* %0
	ret i32 %1
```

**if**

The if program has three basic blocks: `entry`, `trueBB` and `falseBB`. The `trueBB` and `fasleBB` just return a certain value, same as the **assign** case. 

And the `entry` block setup two variables, compare them, and do a conditional jump with the `br` command. 

Compare and save the compare result: 

```
  %4 = icmp sgt i32 %2, %3
```

Conditional jump using the result of the compare:

```
  br i1 %4, label %trueBB, label %falseBB
```

**while**

While is actually the same as **if**, only with some extra conditional jump. 

My solution is: 

```
while(condition)
	something
others
```

translates to: 

```
if(condition) goto trueBB else goto endd
trueBB:
	something
	if(condition) goto trueBB else goto endd
endd:
	others
```

There are multiple ways to do this, and later I found that a simpler way is turn **if** to :

```
trueBB:
	if(!condition) goto endd
	something
	goto trueBB
endd:
	others
```

which only need to write `condition` once. 

**call**

In **call** I need to define another function. And other parts are the same as the main function. And it can be inferred that function arguments are in `%0, %1, ...`

#### CPP translation

As I already wrote the manual translation code, turning these code into LLVM code is not difficult. 

The process is: 

New module and function => create basic blocks => set insert point => builder.Createxxx => go on to next insert point => ... => end => print output

The only difficult points is the **call** program. In TA's code a vector is used as function call argument type and `function->arg_begin(), function->arg_end()` are used to get arguments. But there is only one argument in the call program. So using a simple TYPE32 as argument type is enough and the `function->arg_begin()` will contain the argument. 

By the way, I found that only `<llvm/IR/IRBuilder.h>` is required, other header files are not needed. 

### Difficulties, solved and unsolved

Before actual coding, I spent several hour just to make the editor plugin working. Finally I found CoC satisfying, though I still need to manually write a `compile_commands.json` to let the plugin know where are the header files. 

A small problem is the ID of registers in IR must be continuous: you can't use `%2` when `%1` is not in use. This makes coding a little harder: if I want to add a register at the first of the program, many register IDs need to be changed. 

**An unsolved problem**

I met a problem when compiling LLVM. My configuration is: 

Compiling instructions are the same as TA's LLVM debug. Using 16 threads at beginning, 2 threads at the last stage. Interrupted several times(including force reboot) during compiling. Then the **compiling** succeeded but **installation** failed: I got the error same as [this](https://stackoverflow.com/questions/39887926/llvm-clang-installation-fails):   `file INSTALL cannot find "/home/user_dir/src/llvm/build/bin/clang".`

But I didn't find any solution. This happened **twice**. 

Then I compile with single thread `make install` without `-jN`, and everything works fine, no problem occurred. I don't know what's going on. 

### Summary

First, I've never compiled such a big and resource hungry program. And the time spent on compiling and setting up editor plugins is nearly as long as time spent on actual coding. So I think next time I should focus on code itself instead of spending infinite amount time on tweaking editors. 

Also, this lab makes me feel more confident when dealing with assembly-like code and low level coding. 