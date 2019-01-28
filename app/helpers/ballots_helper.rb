module BallotsHelper

  def progress_bar_width(amount_available, amount_spent)
    (amount_spent / amount_available.to_f * 100).to_s + "%"
  end

  def remaining_votes(ballot, group)
    if group.approval_voting?
      group.number_votes_per_heading - ballot.investments.by_group(group.id).count
    else
      ballot.formatted_amount_available(ballot.heading_for_group(group))
    end
  end

end