class CarsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_car, only: %i[show edit update destroy]

  def index
    @cars = Car.all
    @cars = @cars.where(fueltype: params[:fueltype]) if params[:fueltype].present?
    @cars = @cars.where(gearbox: params[:gearbox]) if params[:gearbox].present?
    @cars = @cars.where(bodytype: params[:bodytype]) if params[:bodytype].present?
  end

  def show
    @fueltypes = Car.fueltypes.keys
    @bodytypes = Car.bodytypes.keys
    @gearboxes = Car.gearboxes.keys
  end

  def new
    @car = Car.new
    @brands = Brand.all
    @dealers = Dealer.all
    if params[:brand_id].present?
      @models = Model.where(brand_id: params[:brand_id])
    else
      @models = Model.all
    end

    respond_to do |format|
      format.html 
      format.json { render json: @models }
    end

    @fueltypes = Car.fueltypes.keys
    @bodytypes = Car.bodytypes.keys
    @gearboxes = Car.gearboxes.keys
  end

  def edit
    @fueltypes = Car.fueltypes.keys
    @bodytypes = Car.bodytypes.keys
    @gearboxes = Car.gearboxes.keys
  end

  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to car_url(@car), notice: "Car was successfully created." }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to car_url(@car), notice: "Car was successfully updated." }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @car.destroy

    respond_to do |format|
      format.html { redirect_to cars_url, notice: "Car was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_car
      @car = Car.find(params[:id])
    end

    def car_params
      params.require(:car).permit(:name, :fueltype, :bodytype, :gearbox, :price, :photo, :model_id, :dealer_id,
                                  model_attributes: :brand_id)
    end
  end
