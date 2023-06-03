from selenium import webdriver

# Set up Firefox WebDriver
driver = webdriver.Firefox()

# Open the webpage
driver.get("http://discworld.starturtle.net/lpc/secure/finger.c?player=geryon")

# Find the element containing the desired information
element = driver.find_element_by_xpath("//p[contains(text(), 'First logged on Mon Sep 20 03:50:55 2004')]/following-sibling::p[1]")

# Get the text content of the element
text = element.text

# Print the extracted line
print(text)

# Close the browser
driver.quit()
