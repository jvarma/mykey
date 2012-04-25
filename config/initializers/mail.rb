  ActionMailer::Base.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "mykey.herokuapp.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: "izebrg@gmail.com",
    password: "scorpio1971"
  }