// Create a file +main.js+ in Parse CloudCode and paste the following content:

var _ = require('underscore');
var Mandrill = require('mandrill');
// Replace the +YOUR_APP_CODE+ with your mandrill app code
Mandrill.initialize('YOUR_APP_CODE');

function htmlEmailText(message) {
  var html_text = "";
  html_text += "<!DOCTYPE html>";
  html_text += "<html>";
  html_text += "<head>";
  html_text += "  <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />";
  html_text += "</head>";
  html_text += "<body>";
  html_text += ("<p><b>Name:</b> " + message.get('name') + "</p>");
  html_text += ("<p><b>Email:</b> " + message.get('email') + "</p>");
  html_text += ("<p><b>Phone:</b> " + message.get('phone') + "</p>");
  html_text += ("<p><b>Referrer:</b> " + message.get('referrer') + "</p>");
  html_text += ("<p><b>Message:</b><br />" + _.escape(message.get('message')).replace(/\n/g, "<br />") + "</p>");
  html_text += "</body>";
  html_text += "</html>";
 
  return html_text;
}
 
function plailEmailText(message) {
  var plain_text = "";
  plain_text += ("Name: " + message.get('name'));
  plain_text += ("Email: " + message.get('email'));
  plain_text += ("Phone: " + message.get('phone'));
  plain_text += ("Referrer: " + message.get('referrer'));
  plain_text += ("Message: " + message.get('message'));
}
 
Parse.Cloud.afterSave("Message", function(request) {
  message = request.object;
  Mandrill.sendEmail({
    message: {
      html: htmlEmailText(message),
      text: plailEmailText(message),
      subject: "[FOTR] Message from " + message.get('name'),
      from_email: 'hi@example.com',
      from_name: message.get('name'),
      to: [
        {
          email: "your@email.address",
          name: "Your name"
        }
      ],
      headers: {
        "Reply-To": message.get('name') + "<" + message.get('email') + ">"
      }
    },
    async: true
  },{
    success: function(httpResponse) {
      console.log(httpResponse);
      response.success("Email sent!");
    },
    error: function(httpResponse) {
      console.error(httpResponse);
      response.error("Uh oh, something went wrong");
    }
  });
});