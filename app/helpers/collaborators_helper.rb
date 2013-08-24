module CollaboratorsHelper
  def show_options?(member)
    member.user.find(current_user).owner
  end
end
