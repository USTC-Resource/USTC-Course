#!/usr/bin/env python3
# my simple compression software GUI frontend
# based on tk
# by ustcpetergu

import tkinter as tk
from tkinter import messagebox
from tkinter import filedialog
import subprocess
import sys


window = tk.Tk()
window.geometry('800x600')
window.title("GMyzip - myzip GUI frontend")
# canvas = tk.Canvas(window, height=500, wid=800)
tk.Label(window,
         bg='red',
         text='Welcome to GMyzip, a simple file compression software',
         font=('Consolas', 15)).grid(row=0, sticky=tk.W)
tk.Label(window,
         text='File: ',
         font=('Consolas', 13)).grid(row=1, sticky=tk.W)
entry_val = tk.StringVar()
tk.Entry(window,
         font=('Consolas', 13),
         textvariable=entry_val).grid(row=2, sticky=tk.W)


def choose_file():
    entry_val.set(filedialog.askopenfilename(initialdir='.', title="Select file"))
    # window.filename = filedialog.askopenfilename(initialdir='.', title="Select file")
    pass


btn_choose = tk.Button(window,
                   text='Choose file',
                   bg='green',
                   font=('Consolas', 13),
                   command=choose_file).grid(row=3, sticky=tk.W)
tk.Label(window,
         text='Mode: ',
         font=('Consolas', 13)).grid(row=4, sticky=tk.W)
mode = tk.IntVar()
rb_c = tk.Radiobutton(window,
                      text='Compress',
                      font=('Consolas', 11),
                      variable=mode, value=1
                      ).grid(row=5, sticky=tk.W)
rb_x = tk.Radiobutton(window,
                      text='Extract',
                      font=('Consolas', 11),
                      variable=mode, value=2
                      ).grid(row=6, sticky=tk.W)
tk.Label(window,
         text='Options: ',
         font=('Consolas', 13)).grid(row=7, sticky=tk.W)
isverbose = tk.BooleanVar()
cb_verbose = tk.Checkbutton(window,
                            text='Verbose',
                            font=('Consolas', 11),
                            variable=isverbose,
                            onvalue=True,
                            offvalue=False,
                            ).grid(row=8, sticky=tk.W)
isforce = tk.BooleanVar()
cb_force = tk.Checkbutton(window,
                          text='Overwrite existing',
                          font=('Consolas', 11),
                          variable=isforce,
                          onvalue=True,
                          offvalue=False,
                          ).grid(row=9, sticky=tk.W)
tk.Label(window,
         text='Output: ',
         font=('Consolas', 13)).grid(row=11, sticky=tk.W)
logtext = tk.Text(window,
                  font=('Consolas', 10),
                  height=15,
                  width=80
                  )
logtext.grid(row=12, sticky=tk.W)
logtext.insert(tk.END, "Output shown here.\n")


def run_myzip():
    myzip_exec = './myzip.out'
    cmd_exec = myzip_exec + ' ' + '-'
    if mode.get() == 1:
        cmd_exec += 'c'
    elif mode.get() == 2:
        cmd_exec += 'x'
    else:
        messagebox.showerror('Myzip', 'Select a mode first')
        return
    if isverbose.get():
        cmd_exec += 'v'
    if isforce.get():
        cmd_exec += 'F'
    cmd_exec += 'f '
    cmd_exec += entry_val.get()
    logtext.insert(tk.END, "Executing: " + cmd_exec)
    logtext.insert(tk.END, "\n")
    status, output = subprocess.getstatusoutput(cmd_exec)
    logtext.insert(tk.END, output)
    logtext.insert(tk.END, "\n")
    if status == 0:
        messagebox.showinfo("Myzip", "Done.")
    else:
        messagebox.showerror("Myzip", "Failed. See output for detail")


btn_go = tk.Button(window,
                   text='Go',
                   bg='green',
                   font=('Consolas', 13),
                   command=run_myzip).grid(row=10, sticky=tk.W)
# tk.Label(window,
#          text='Log: ',
#          font=('Consolas', 12)).pack()
window.mainloop()
print('End.')


