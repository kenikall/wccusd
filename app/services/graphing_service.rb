class GraphingService
  def all_graph(surveys)
    all_graph = empty_hash("all")

    surveys.each do |survey|
      user = User.find(survey.user_id)
      next if !user.is_student?
      all_graph = calculate_survey(all_graph, survey)
    end

    all_graph = convert_to_percentages(all_graph)
  end

  def gender_graph(surveys)
    male_graph = empty_hash("male")
    female_graph = empty_hash("female")

    surveys.each do |survey|
      user = User.find(survey.user_id)
      next if !user.is_student?
      if user.gender == "M"
        male_graph = calculate_survey(male_graph, survey)
      else
        female_graph = calculate_survey(female_graph, survey)
      end
    end
    [male_graph, female_graph].each do |gender_graph|
      gender_graph = convert_to_percentages(gender_graph)
    end
    return [male_graph, female_graph]
  end

  def grade_graph(surveys)
    freshman_graph = empty_hash('freshman')
    sophmore_graph = empty_hash('sophomore')
    junior_graph = empty_hash('junior')
    senior_graph = empty_hash('senior')
    post_senior_graph = empty_hash('post senior')

    surveys.each do |survey|
      user = User.find(survey.user_id)
      next if !user.is_student?
      if user.grade == 9
        freshman_graph = calculate_survey(freshman_graph, survey)
      elsif user.grade == 10
        sophmore_graph = calculate_survey(sophmore_graph, survey)
      elsif user.grade == 11
        junior_graph = calculate_survey(junior_graph, survey)
      elsif user.grade == 12
        senior_graph = calculate_survey(senior_graph, survey)
      else
        post_senior_graph = calculate_survey(post_senior_graph, survey)
      end
    end

    [freshman_graph, sophmore_graph, junior_graph, senior_graph, post_senior_graph].each do |grade_graph|
      grade_graph = convert_to_percentages(grade_graph) if grade_graph[:count] > 0
    end

    return [freshman_graph, sophmore_graph, junior_graph, senior_graph, post_senior_graph]
  end

  def ethnicity_graph(surveys)
    ethnic_hash = ethnicities()

    surveys.each do |survey|
      user = User.find(survey.user_id)
      next if !user.is_student?
      puts ethnic_hash[user.ethnicity]
      calculate_survey(ethnic_hash[user.ethnicity], survey)
    end

    ethnic_hash.each do |name, survey_hash|
      if survey_hash[:count] > 0
        survey_hash = convert_to_percentages(survey_hash)
      end
    end
    ethnic_hash.values
  end

  def pathway_graph(surveys)
    pathway_hash = pathways()

    surveys.each do |survey|
      user = User.find(survey.user_id)
      next if !user.is_student?
      calculate_survey(pathway_hash[user.pathway], survey)
    end

    pathway_hash.each do |name, survey_hash|
      if survey_hash[:count] > 0
        survey_hash = convert_to_percentages(survey_hash)
      end
    end
    pathway_hash.values
  end

private
  def empty_hash(title = "")
    {
      title: title,
      count: 0,
      question1: 0,
      question2: 0,
      question3: 0,
      question4: 0,
      q1no: 0,
      q2no: 0,
      q3no: 0,
      q4no: 0,
      q1percentage: 0,
      q2percentage: 0,
      q3percentage: 0,
      q4percentage: 0
    }
  end

  def calculate_survey(graph_hash, survey)
    graph_hash[:count] += 1.0
    graph_hash[:question1] += 1.0 if survey.question1 == "yes"
    graph_hash[:question2] += 1.0 if survey.question2 == "yes"
    graph_hash[:question3] += 1.0 if survey.question3 == "yes"
    graph_hash[:question4] += 1.0 if survey.question4 == "yes"
    return graph_hash
  end

  def convert_to_percentages(graph_hash)
    graph_hash[:q1percentage] = (graph_hash[:question1]/graph_hash[:count]*100).round
    graph_hash[:q2percentage] = (graph_hash[:question2]/graph_hash[:count]*100).round
    graph_hash[:q3percentage] = (graph_hash[:question3]/graph_hash[:count]*100).round
    graph_hash[:q4percentage] = (graph_hash[:question4]/graph_hash[:count]*100).round
    graph_hash[:q1no] = (graph_hash[:count] - graph_hash[:question1]).round
    graph_hash[:q2no] = (graph_hash[:count] - graph_hash[:question2]).round
    graph_hash[:q3no] = (graph_hash[:count] - graph_hash[:question3]).round
    graph_hash[:q4no] = (graph_hash[:count] - graph_hash[:question4]).round
    graph_hash[:question1] = graph_hash[:question1].round
    graph_hash[:question2] = graph_hash[:question2].round
    graph_hash[:question3] = graph_hash[:question3].round
    graph_hash[:question4] = graph_hash[:question4].round
    return graph_hash
  end

  def ethnicities
    {
      "American Indian or Alaskan Native" => empty_hash("American Indian or Alaskan Native"),
      "Chinese" => empty_hash("Chinese"),
      "Japanese" => empty_hash("Japanese"),
      "Korean" => empty_hash("Korean"),
      "Vietnamese" => empty_hash("Vietnamese"),
      "Asian Indian" => empty_hash("Asian Indian"),
      "Laotian" => empty_hash("Laotian"),
      "Cambodian" => empty_hash("Cambodian"),
      "Hmong" => empty_hash("Hmong"),
      "Other Asian" => empty_hash("Other Asian"),
      "Hawaiian" => empty_hash("Hawaiian"),
      "Guamanian" => empty_hash("Guamanian"),
      "Samoan" => empty_hash("Samoan"),
      "Tahitian" => empty_hash("Tahitian"),
      "Other Pacific Islander" => empty_hash("Other Pacific Islander"),
      "Filipino" => empty_hash("Filipino"),
      "Hispanic/Latino" => empty_hash("Hispanic/Latino"),
      "Black or African American" => empty_hash("Black or African American"),
      "White" => empty_hash("White"),
      "undefined" => empty_hash("Undefined"),
    }
  end

  def pathways
    {
      "IT" => empty_hash("IT"),
      "Welding" => empty_hash("Welding"),
      "Performing Arts" => empty_hash("Performing Arts"),
      "Engineering" => empty_hash("Engineering"),
      "Law" => empty_hash("Law"),
      "Performing Arts Production" => empty_hash("Performing Arts Production"),
    }
  end
end
