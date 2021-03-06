# frozen_string_literal: true

class GraphController < ApplicationController
  def format
    graphing_service = GraphingService.new
    surveys = Survey.where(event_id: params[:event_id])
    if params[:property] == "Gender"
      render json: graphing_service.gender_graph(surveys).to_json
    elsif params[:property] == "Grade"
      render json: graphing_service.grade_graph(surveys).to_json
    elsif params[:property] == "Ethnicity"
      render json: graphing_service.ethnicity_graph(surveys).to_json
    elsif params[:property] == "Pathway"
      render json: graphing_service.pathway_graph(surveys).to_json
    else
      render json: graphing_service.all_graph(surveys).to_json
    end
  end
end
