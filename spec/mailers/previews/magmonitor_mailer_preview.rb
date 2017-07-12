class MagmonitorMailerPreview < ActionMailer::Preview

  def confirmation_instructions
    MagmonitorMailer.confirmation_instructions(User.first, "faketoken", {})
  end

  def reset_password_instructions
    MagmonitorMailer.reset_password_instructions(User.first, "faketoken", {})
  end

  def unlock_instructions
    MagmonitorMailer.unlock_instructions(User.first, "faketoken", {})
  end
end
