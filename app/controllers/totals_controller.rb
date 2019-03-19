class TotalsController < ApplicationController
  def index
    @totals = Total.all

    render("total_templates/index.html.erb")
  end

  def show
    @total = Total.find(params.fetch("id_to_display"))

    render("total_templates/show.html.erb")
  end

  def new_form
    @total = Total.new

    render("total_templates/new_form.html.erb")
  end

  def create_row
    @total = Total.new

    @total.profile_id = params.fetch("profile_id")
    @total.feed_id = params.fetch("feed_id")
    @total.lift_total = params.fetch("lift_total")
    @total.lift_date = params.fetch("lift_date")
    @total.subscription_id = params.fetch("subscription_id")

    if @total.valid?
      @total.save

      redirect_back(:fallback_location => "/totals", :notice => "Total created successfully.")
    else
      render("total_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @total = Total.find(params.fetch("prefill_with_id"))

    render("total_templates/edit_form.html.erb")
  end

  def update_row
    @total = Total.find(params.fetch("id_to_modify"))

    @total.profile_id = params.fetch("profile_id")
    @total.feed_id = params.fetch("feed_id")
    @total.lift_total = params.fetch("lift_total")
    @total.lift_date = params.fetch("lift_date")
    @total.subscription_id = params.fetch("subscription_id")

    if @total.valid?
      @total.save

      redirect_to("/totals/#{@total.id}", :notice => "Total updated successfully.")
    else
      render("total_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row
    @total = Total.find(params.fetch("id_to_remove"))

    @total.destroy

    redirect_to("/totals", :notice => "Total deleted successfully.")
  end
end