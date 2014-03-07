# -*- encoding : utf-8 -*-
class Kobe::DepartmentsController < KobeController
  # layout false

  def index
  end

  def new
      @obj = Department.find(1)
  end

  def create
  end

  def update
  end

  def edit
    @dep = Department.find(1)
  end
end
