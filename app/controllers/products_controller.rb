require 'stripe'
require 'rqrcode'
# Replace with an API key in the .env file
Stripe.api_key = 'sk_test_4eC39HqLyjWDarjtT1zdp7dc'


class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  
  end
  
  def new
    @product = Product.new
  end

  def create
    # Create product
    product = Stripe::Product.create({name: 'Gold Special'})
    product_id = product['id']
    puts product_id
    currency = params[:product][:currency]
    unit_amount = params[:product][:unit_amount]
    name = params[:product][:name]

    # Create price
    price = Stripe::Price.create({
      unit_amount: unit_amount,
      currency: currency,
      product: product_id,
    })
    price_id = price['id']
    
    # Create PaymentLink
    payment_link = Stripe::PaymentLink.create({
      line_items: [
        {
          price: price_id,
          quantity: 1,
        },
      ],
    })
    payment_link_id = payment_link['id']
    payment_link_url = payment_link['url']
    dict = {"product_id": product_id, 
            'price_id': price_id, 
            'name': name, 
            'description': 'placeholder',
            'currency': currency, 
            'unit_amount': unit_amount,
            'payment_link': payment_link_url
           }
    qrcode = RQRCode::QRCode.new(payment_link_url)
    qrcode_src = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 120
    )
    file_path = 'app/assets/images/' + product_id + '.png'
    qrcode_src.save(file_path)
    # qr_file = File.new(file_path, 'w+')
    # qr_file.puts(qrcode_src.to_s)
    # qr_file.close
    # IO.binwrite(file_path, qrcode_src.to_s)
    @product = Product.new(dict)

    if @product.save
      redirect_to @product
    else 
      render :new, status: :unprocessable_entity
    end 
  end

  private 
    def product_params
      params.require(:product).permit(:name, :currency, :unit_amount )
    end 
end
