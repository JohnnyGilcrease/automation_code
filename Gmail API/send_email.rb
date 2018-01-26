require "gmail"

gmail = Gmail.connect("john@twinenginelabs.com", "568020jeG!")
#gmail = Gmail.connect(:xoauth2, "john@twinenginelabs.com", "4/hFy6TbFsMfG9yzSU0HIc9Io6_f9ASXTPLi-5ssoBiro")

email = gmail.compose do
  to "johngilcreasemusic@gmail.com"
  subject "Twin Engine Labs Proposal!"
  body "Working with Gmail API is amaizng!
  Please click the link and fill out the info!
  https://johneg.wufoo.com/forms/mbhsfm00ay4nw7/"
end
gmail.deliver(email)
gmail.logout