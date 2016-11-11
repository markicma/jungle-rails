class OrderMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def receipt_email(order)
    @order = order
    @products = Product.joins(:line_items).where('line_items.order_id' => order.id).select('products.name, line_items.quantity, line_items.item_price_cents, line_items.total_price_cents')
    mail(to: @order.email, subject: "Jungle Receipt for order ##{@order.id}")
  end
end
