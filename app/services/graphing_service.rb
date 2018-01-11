class GraphingService

  def all_graph(surveys)
    all_graph = {
      question1: 0,
      question2: 0,
      question3: 0,
      question4: 0
    }
    converted_percent = (1/surveys.length.to_f*100)
    puts '+-+-+-'
    puts converted_percent
    surveys.each do |survey|
      user = User.find(survey.user_id)
      next if !user.is_student?
      all_graph[:question1] += converted_percent if survey.question1 == "yes"
      all_graph[:question2] += converted_percent if survey.question2 == "yes"
      all_graph[:question3] += converted_percent if survey.question3 == "yes"
      all_graph[:question4] += converted_percent if survey.question4 == "yes"
    end
    all_graph[:question1] = all_graph[:question1].round
    all_graph[:question2] = all_graph[:question2].round
    all_graph[:question3] = all_graph[:question3].round
    all_graph[:question4] = all_graph[:question4].round
    puts all_graph
    all_graph
  end

  def gender_graph(surveys)
    gender_graph = {}
    converted_percent = (1/surveys.length*100).round
    surveys.each do |survey|
      user = User.find(survey.user_id)
      next if !user.is_student?
      gender_graph[user.gender] = Hash.new(0) unless gender_graph[user.gender]
      gender_graph[user.gender][:question1] += converted_percent if survey.question1 == "yes"
      gender_graph[user.gender][:question2] += converted_percent if survey.question1 == "yes"
      gender_graph[user.gender][:question3] += converted_percent if survey.question1 == "yes"
      gender_graph[user.gender][:question4] += converted_percent if survey.question1 == "yes"
    end
  end

  def grade_graph(surveys)
    grade_graph = {}
    converted_percent = (1/surveys.length*100).round
    surveys.each do |survey|
      user = User.find(survey.user_id)
      next if !user.is_student?
      grade_graph[user.grade] = Hash.new(0) unless grade_graph[user.grade]
      grade_graph[user.grade][:question1] += converted_percent if survey.question1 == "yes"
      grade_graph[user.grade][:question2] += converted_percent if survey.question1 == "yes"
      grade_graph[user.grade][:question3] += converted_percent if survey.question1 == "yes"
      grade_graph[user.grade][:question4] += converted_percent if survey.question1 == "yes"
    end
  end

  def ethnicity_graph(surveys)
    ethnicity_graph = {}
    converted_percent = (1/surveys.length*100).round
    surveys.each do |survey|
      user = User.find(survey.user_id)
      next if !user.is_student?
      ethnicity_graph[user.ethnicity] = Hash.new(0) unless ethnicity_graph[user.ethnicity]
      ethnicity_graph[user.ethnicity][:question1] += converted_percent if survey.question1 == "yes"
      ethnicity_graph[user.ethnicity][:question2] += converted_percent if survey.question1 == "yes"
      ethnicity_graph[user.ethnicity][:question3] += converted_percent if survey.question1 == "yes"
      ethnicity_graph[user.ethnicity][:question4] += converted_percent if survey.question1 == "yes"
    end
  end

  def pathway(surveys)
    pathway_graph = {}
    converted_percent = (1/surveys.length*100).round
    surveys.each do |survey|
      user = User.find(survey.user_id)
      next if !user.is_student?
      pathway_graph[user.pathway] = Hash.new(0) unless pathway_graph[user.pathway]
      pathway_graph[user.pathway][:question1] += converted_percent if survey.question1 == "yes"
      pathway_graph[user.pathway][:question2] += converted_percent if survey.question1 == "yes"
      pathway_graph[user.pathway][:question3] += converted_percent if survey.question1 == "yes"
      pathway_graph[user.pathway][:question4] += converted_percent if survey.question1 == "yes"
    end
  end
end
