module QuestionsHelper

  def next1(parts, j, i)
    nq = nil

    current_part = parts[j]
    if current_part.questions[i+1]
      nq = current_part.questions[i+1]
    end

    if nq.nil? && parts[j+1]
      nq = parts[j+1].questions[0]
    end

    nq.id unless nq.nil?
  end
end
