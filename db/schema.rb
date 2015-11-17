# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151104172603) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignations", force: true do |t|
    t.string   "shipment"
    t.integer  "quantity"
    t.integer  "released"
    t.string   "workOrder"
    t.decimal  "price",        precision: 13, scale: 2
    t.date     "startDate"
    t.date     "endDate"
    t.integer  "navy_id"
    t.integer  "container_id"
    t.integer  "way_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignations", ["container_id"], name: "index_assignations_on_container_id", using: :btree
  add_index "assignations", ["navy_id"], name: "index_assignations_on_navy_id", using: :btree
  add_index "assignations", ["way_id"], name: "index_assignations_on_way_id", using: :btree
  add_index "assignations", ["workOrder"], name: "index_assignations_on_workOrder", unique: true, using: :btree

  create_table "bill_movements", force: true do |t|
    t.integer  "logi_bill_id"
    t.integer  "bill_movement_id"
    t.integer  "type_movement_id"
    t.boolean  "lastChange",                                default: true
    t.decimal  "total",            precision: 13, scale: 2
    t.decimal  "value",            precision: 13, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bill_movements", ["bill_movement_id"], name: "index_bill_movements_on_bill_movement_id", using: :btree
  add_index "bill_movements", ["logi_bill_id"], name: "index_bill_movements_on_logi_bill_id", using: :btree
  add_index "bill_movements", ["type_movement_id"], name: "index_bill_movements_on_type_movement_id", using: :btree

  create_table "boxes", force: true do |t|
    t.string   "name"
    t.decimal  "value",       precision: 13, scale: 2
    t.decimal  "total",       precision: 13, scale: 2
    t.date     "incomeDate"
    t.integer  "outflow_id"
    t.integer  "movement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "boxes", ["movement_id"], name: "index_boxes_on_movement_id", using: :btree
  add_index "boxes", ["outflow_id"], name: "index_boxes_on_outflow_id", using: :btree

  create_table "cars", force: true do |t|
    t.string   "plate"
    t.string   "model"
    t.string   "color"
    t.integer  "driver_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cars", ["driver_id"], name: "index_cars_on_driver_id", using: :btree

  create_table "client_taxes", force: true do |t|
    t.string   "name"
    t.boolean  "iva"
    t.boolean  "reteica"
    t.boolean  "retefuente"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "concepts", force: true do |t|
    t.text     "container"
    t.text     "description"
    t.text     "route"
    t.decimal  "total",       precision: 13, scale: 2
    t.integer  "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "concepts", ["invoice_id"], name: "index_concepts_on_invoice_id", using: :btree

  create_table "containers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dispatches", force: true do |t|
    t.integer  "manifestNumber",     limit: 8
    t.integer  "loadOrder",          limit: 8
    t.decimal  "advance"
    t.decimal  "balance"
    t.date     "deliverDate"
    t.date     "downloadDate"
    t.date     "advanceDate"
    t.date     "paymentBalanceDate"
    t.date     "completeDate"
    t.boolean  "balancePay"
    t.string   "loadConcept"
    t.boolean  "unoccupied"
    t.string   "containerNumber"
    t.integer  "assignation_id"
    t.integer  "car_id"
    t.integer  "driver_id"
    t.integer  "middleman_id"
    t.integer  "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dispatches", ["assignation_id"], name: "index_dispatches_on_assignation_id", using: :btree
  add_index "dispatches", ["car_id"], name: "index_dispatches_on_car_id", using: :btree
  add_index "dispatches", ["driver_id"], name: "index_dispatches_on_driver_id", using: :btree
  add_index "dispatches", ["invoice_id"], name: "index_dispatches_on_invoice_id", using: :btree
  add_index "dispatches", ["middleman_id"], name: "index_dispatches_on_middleman_id", using: :btree

  create_table "drivers", force: true do |t|
    t.string   "name"
    t.string   "lastName"
    t.boolean  "blacklist",                  default: false
    t.boolean  "busy",                       default: false
    t.text     "blacklistComment"
    t.integer  "document",         limit: 8
    t.integer  "cellPhone",        limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", force: true do |t|
    t.decimal  "total"
    t.decimal  "subtotal"
    t.decimal  "iva"
    t.decimal  "retefuente"
    t.decimal  "reteica"
    t.boolean  "paid",            default: false
    t.integer  "idcontable"
    t.integer  "workorder"
    t.integer  "quantity"
    t.date     "expirationDate"
    t.date     "elaborationDate"
    t.date     "eradicateDate"
    t.integer  "assignation_id"
    t.integer  "client_tax_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoices", ["assignation_id"], name: "index_invoices_on_assignation_id", using: :btree
  add_index "invoices", ["client_tax_id"], name: "index_invoices_on_client_tax_id", using: :btree

  create_table "logi_bills", force: true do |t|
    t.string   "name"
    t.integer  "endNumber"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "middlemen", force: true do |t|
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movements", force: true do |t|
    t.integer  "consecutiveNumber"
    t.date     "movementDate"
    t.decimal  "value",             precision: 13, scale: 2
    t.text     "concept"
    t.integer  "logi_bill_id"
    t.integer  "type_movement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movements", ["logi_bill_id"], name: "index_movements_on_logi_bill_id", using: :btree
  add_index "movements", ["type_movement_id"], name: "index_movements_on_type_movement_id", using: :btree

  create_table "navies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outflows", force: true do |t|
    t.decimal  "value",      precision: 13, scale: 2
    t.date     "flowDate"
    t.text     "concept"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parameters", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", force: true do |t|
    t.integer  "outflow_id"
    t.integer  "dispatch_id"
    t.boolean  "lastChange",      default: true
    t.string   "saleDescription"
    t.integer  "saleType"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sales", ["dispatch_id"], name: "index_sales_on_dispatch_id", using: :btree
  add_index "sales", ["outflow_id"], name: "index_sales_on_outflow_id", using: :btree

  create_table "type_movements", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ways", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
