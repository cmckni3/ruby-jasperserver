Rails.configuration.after_initialize do
  Rails.configuration.jasperserver = {
    test: {
      url: 'http://localhost:3000',
      username: 'username',
      password: 'password'
    }
  }
end
