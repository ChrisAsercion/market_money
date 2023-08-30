class Api::V0::VendorsController < ApplicationController
  def index
    begin
      market = Market.find(params[:market_id])
      vendors = market.vendors
      render json: VendorSerializer.new(vendors)
    rescue ActiveRecord::RecordNotFound => error
      error_response = {
        "errors": [
            {
                "detail": error.message
            }
        ]
        }
    render json: error_response, status: :not_found
    end
  end

  def show
    
    begin
      render json: VendorSerializer.new(Vendor.find(params[:id]))
    rescue ActiveRecord::RecordNotFound => error
      error_response = {
        "errors": [
            {
                "detail": error.message
            }
        ]
        }
    render json: error_response, status: :not_found
    end
  end

  def create
    vendor = Vendor.new(vendor_params)

    if vendor.save 
      render json: VendorSerializer.new(vendor), status: :created
    else 
      render json: { errors: vendor.errors.full_messages }, staus: :unprocessable_entity
    end
  end

  def update
    begin
      vendor = Vendor.find(params[:id])
      
      if vendor.update(vendor_params)
        render json: VendorSerializer.new(vendor), status: :ok
      else
        render json: { errors: vendor.errors.full_messages }, staus: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound => error
      error_response = {
        "errors": [
            {
                "detail": error.message
            }
        ]
        }
    render json: error_response, status: :not_found
    end
  end

  def destroy
    begin
      vendor = Vendor.find(params[:id])
      
      vendor.markets.clear
      vendor.market_vendors.clear
      vendor.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound => error
      error_response = {
        "errors": [
            {
                "detail": error.message
            }
        ]
        }
    render json: error_response, status: :not_found
    end
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end