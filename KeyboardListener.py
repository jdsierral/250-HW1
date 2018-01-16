import tkinter as tk

exit = False
def keypress(event):
    if (event.char == "q"):
        exit = True
    elif (event.char == "a"):
        print("hola")


root = tk.Tk()
root.bind_all('<Key>', keypress)
root.withdraw()
root.mainloop()
