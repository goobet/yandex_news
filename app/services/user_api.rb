class UserApi
  def topic
    { title: 'Кто здесь?',
      text: 'Все здесь, а ты?',
      date: Time.zone.now,
      expire: Time.zone.now + 1.minute }
  end
end
