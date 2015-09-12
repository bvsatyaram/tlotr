---
---
$ ->
  for ele in $('.obscure-email')
    email = "#{ele.dataset.uname}@#{ele.dataset.domain}.#{ele.dataset.extension}"
    ele = $(ele)
    ele.text(email)
    ele.attr('href', "mailto:"+email)