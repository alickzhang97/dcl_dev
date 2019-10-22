# If necessary, uncomment the line below to include explore_source.
# include: "api_testing.model.lkml"

view: orders_derived {
  derived_table: {
    explore_source: order_items {
      column: count { field: orders.count }
      column: id { field: users.id }
      column: created_date { field: orders.created_date }
      column: retail_price { field: products.retail_price }
    }
  }
  dimension: count {
    type: number
  }
  dimension: id {
    type: number
  }
  dimension: created_date {
    type: date
  }
  dimension: retail_price {
    type: number
  }

  dimension: price_condition {
    type: number
    sql: CASE WHEN ${retail_price} < 20 THEN 1.5
         ELSE ${retail_price}
        END;;
  }

  measure: price {
      type: number
      sql: ${price_condition} ;;
    }
}
