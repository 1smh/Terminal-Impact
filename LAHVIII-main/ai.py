import google.generativeai as genai

def clear_text_file(filename):
    with open(filename, "w"):
        pass 

genai.configure(api_key="AIzaSyC89R5-zp8_8SmjpzJP1sV_ojJsjKVJsj4")
model = genai.GenerativeModel('gemini-pro')
response = model.generate_content("You must generate a SINGLE black hole using the format: 'Type: [type], Name: [RANDOM 8 CHARACTER STRING OF NUMBERS AND LETTERS]' followed by a newline, Description: (3 words or less) NEWLINE, Age: [AGE]")
with open(r"C:\Users\decla\github\LAHVIII\entries.txt", "w") as w:
    clear_text_file(r"C:\Users\decla\github\LAHVIII\entries.txt")
    w.write(response.text) 