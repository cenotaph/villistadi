class ProjectMailer < ApplicationMailer
  
  default from: 'villi.stadi@gmail.com'
 
  def request_to_join(user, project)
    @user = user
    @project = project
    @url = 'http://villistadi.fi/projects/' + @project.slug
    @project.administrators.map(&:email).each do |admin|
      mail(to: admin, subject: "#{user.name} has requested to join #{@project.name}")
    end
  end
  
end
