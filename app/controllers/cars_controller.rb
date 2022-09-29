class CarsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_car, only: %i[show edit update destroy]
  before_action :fetch_dealers!
  # GET /cars or /cars.json
  def index
    @cars = Car.all
    @cars = @cars.where(fueltype: params[:fueltype]) if params[:fueltype].present?
    @cars = @cars.where(gearbox: params[:gearbox]) if params[:gearbox].present?
    @cars = @cars.where(bodytype: params[:bodytype]) if params[:bodytype].present?
    @cars = @cars.where(model: params[:model_name]) if params[:model_name].present?
    if params[:searchp] || params[:searchpx] 
      @search_pricen_term = params[:searchp]
      @search_pricex_term = params[:searchpx] 
      @cars = Car.between_range(@search_pricen_term, @search_pricex_term)
  end
  end

  # GET /cars/1 or /cars/1.json
  def show
    @fueltypes = Car.fueltypes.keys
    @bodytypes = Car.bodytypes.keys
    @gearboxes = Car.gearboxes.keys
  end

  # GET /cars/new
  def new
    @car = Car.new
    @brands = Brand.all
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

  # GET /cars/1/edit
  def edit
    @fueltypes = Car.fueltypes.keys
    @bodytypes = Car.bodytypes.keys
    @gearboxes = Car.gearboxes.keys
  end

  # POST /cars or /cars.json
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

  # PATCH/PUT /cars/1 or /cars/1.json
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

  # DELETE /cars/1 or /cars/1.json
  def destroy
    @car.destroy

    respond_to do |format|
      format.html { redirect_to cars_url, notice: "Car was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:name, :fueltype, :bodytype, :gearbox, :price, :photo, :model_id, :dealer_id,
                                  model_attributes: :brand_id)
    end

    def fetch_models!
      @models = Model.all
    end

    def fetch_dealers!
      @dealers = Dealer.all
    end

    def fetch_brands!
      @brands = Brand.all
    end
  end
