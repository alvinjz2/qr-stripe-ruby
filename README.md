# QR-Stripe
This is a simple application that will generate QR Codes for Stripe products, allowing sellers to have customers scan a code to reach the checkout page, instead of typing in a link. 

# How it works
This application uses the Stripe API to generate payment links. In order to generate a link though, you have to create a product first, then create a price for that product, and then finally create a payment link. See [this](https://stripe.com/docs/payment-links/api) for more info.
When the application is run, the user is prompted to enter basic information to create a product and price. These include a product name, the currency, as well as the cost amount. The necessary steps to go from product info to QR Code are handled by the application-- the user doesn't need to worry about this. 

# Usage
1. Clone the repo
2. Replace your Stripe Key within the products controller file or use a .env file
3. Launch the application using `ruby bin/rails server`
4. Go to the `/products/new` route

# List of Planned Updates
- Improved UI
- Add a login system, can then function as a service instead of standalone local app
- Option to download/print the QR Codes
- Ability to input more info specific to the product creation (so more detailed inputs into the Stripe API)
- Create QR codes for existing products
- Ability to print a page of the web-app
