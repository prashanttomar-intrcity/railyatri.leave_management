# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_04_13_115632) do
  create_table "Inverter_Status", primary_key: "serial_no", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "bus_no", limit: 25
    t.datetime "inverter_off_time", precision: nil
    t.datetime "inverter_on_time", precision: nil
    t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "VIDEO", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "BusNo", limit: 50, null: false
    t.string "CamID", limit: 5
    t.date "Date"
    t.string "Filename", limit: 20
    t.string "Time", limit: 20
    t.string "UploadTime", limit: 20
    t.string "VideoStat", limit: 25
    t.index ["BusNo"], name: "idx_BusNo"
    t.index ["Date"], name: "idx_Date"
    t.index ["VideoStat"], name: "idx_VideoStat"
  end

  create_table "abbreviations", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "full_form"
    t.string "short_form"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "active_storage_attachments", charset: "latin1", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "latin1", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.string "content_type"
    t.datetime "created_at", precision: nil, null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "add_role_id_to_users", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "role_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "agent_commission_groups", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.date "commission_date"
    t.string "commission_type", limit: 45
    t.string "commission_value", limit: 45
    t.datetime "created_at", precision: nil
    t.string "name", limit: 45
    t.datetime "updated_at", precision: nil
  end

  create_table "agent_wallet_details", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "activity"
    t.string "added_by"
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.decimal "balance", precision: 10, scale: 2, null: false
    t.string "comment"
    t.datetime "created_at", precision: nil, null: false
    t.integer "event_id"
    t.integer "event_type", default: 0, comment: "Basically for manging the kind of wallet credit"
    t.datetime "expiration_date", precision: nil
    t.boolean "fraud_detected"
    t.boolean "is_expired", default: false
    t.boolean "is_paid_by_wallet", default: false
    t.boolean "is_private", default: true
    t.boolean "is_transferred", default: false
    t.integer "phone_number"
    t.integer "relationship_id"
    t.string "relationship_type"
    t.integer "transaction_id"
    t.string "transaction_type", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id", null: false
    t.index ["expiration_date"], name: "index_user_wallet_details_on_expiration_date"
    t.index ["transaction_id"], name: "idx_transaction_id"
    t.index ["transaction_type", "event_type"], name: "index_user_wallet_details_on_transaction_type_and_event_type"
    t.index ["user_id", "expiration_date"], name: "index_user_wallet_details_on_user_id_and_expiration_date"
  end

  create_table "agent_wallet_recharges", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2
    t.string "collected_by", limit: 45, collation: "utf8mb3_general_ci"
    t.string "comment", limit: 100
    t.datetime "created_at", precision: nil, null: false
    t.string "payment_link"
    t.string "payment_type", limit: 45, default: "online", null: false
    t.string "recharged_by", limit: 45
    t.string "reference_id", limit: 45
    t.integer "ry_agent_id"
    t.boolean "status", default: false
    t.string "transaction_type", limit: 45
    t.string "tx_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "agent_wallets", id: :integer, charset: "latin1", force: :cascade do |t|
    t.decimal "blocked_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "cashback_amount", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", precision: nil, null: false
    t.integer "phone_number"
    t.decimal "refund_amount", precision: 10, scale: 2, default: "0.0"
    t.decimal "total", precision: 10, scale: 2, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "idx_user_wallets_user_id", unique: true
  end

  create_table "alert_categories", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.boolean "status", default: true
    t.string "title"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "alert_suggestions", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "alert_category_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "description"
    t.boolean "status", default: true
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "amenities", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "amenity_name", limit: 100
    t.datetime "created_at", precision: nil, null: false
    t.string "img_url"
    t.integer "status", limit: 1, default: 1
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "announcement_activities", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "announcement_file_id"
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "played_via"
    t.datetime "pushed_on_gold_track", precision: nil
    t.text "reason"
    t.string "requested_by"
    t.date "service_start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.string "used_by", comment: "CrewApp / GoldTrack"
    t.string "used_for", comment: "Play / Download"
    t.index ["bus_service_id", "service_start_date", "used_by"], name: "idx_service_id_date_used_by"
  end

  create_table "announcement_files", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "active_status", default: true, null: false
    t.integer "announcement_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "file_duration"
    t.float "file_size", null: false
    t.string "file_url", null: false
    t.string "language", null: false
    t.text "script", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "uploaded_by", null: false
    t.index ["announcement_id"], name: "idx_announcement_id"
  end

  create_table "announcement_routes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "active_status", default: true, null: false
    t.integer "announcement_file_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "route_city_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["announcement_file_id"], name: "idx_file_id"
    t.index ["route_city_id", "active_status"], name: "idx_route_city_status"
  end

  create_table "announcement_services", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "active_status", default: true, null: false
    t.integer "announcement_file_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "service_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["announcement_file_id"], name: "idx_file_id"
    t.index ["service_id"], name: "idx_service_id"
  end

  create_table "announcements", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "active_status", default: true, null: false
    t.integer "announcement_order", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "created_by", null: false
    t.date "from_date"
    t.string "last_updated_by"
    t.string "title", null: false
    t.date "to_date"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["title"], name: "idx_title"
  end

  create_table "api_response_codes", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "api_name"
    t.string "category"
    t.string "comments"
    t.datetime "created_at", precision: nil, null: false
    t.string "message"
    t.integer "status_code"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["api_name"], name: "index_api_response_codes_on_api_name"
  end

  create_table "app_menu_configurations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "app_name"
    t.datetime "created_at", precision: nil, null: false
    t.string "menu_name"
    t.boolean "menu_visible", default: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["app_name", "menu_name"], name: "idx_app_menu_name"
  end

  create_table "audits", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "action"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "auditable_id"
    t.string "auditable_type"
    t.text "audited_changes"
    t.string "comment"
    t.datetime "created_at", precision: nil
    t.string "remote_address"
    t.string "request_uuid"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.integer "version", default: 0
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "authenticated_users", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "email"
    t.datetime "last_loggedin_at", precision: nil
    t.string "name"
    t.datetime "oauth_expires_at", precision: nil
    t.text "oauth_token"
    t.string "provider"
    t.integer "provider_id"
    t.string "uid"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_authenticated_users_on_email"
    t.index ["provider", "uid"], name: "index_authenticated_users_on_provider_and_uid"
  end

  create_table "average_block_times", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "api_name"
    t.integer "avg_block_time"
    t.text "block_intervals"
    t.datetime "created_at", precision: nil, null: false
    t.integer "from_city_id"
    t.string "from_city_name"
    t.integer "gds_client_id"
    t.string "gds_client_name"
    t.date "import_date"
    t.date "journey_date"
    t.datetime "request_end_time", precision: nil
    t.datetime "request_start_time", precision: nil
    t.integer "to_city_id"
    t.string "to_city_name"
    t.string "total_block_requests", limit: 45
    t.datetime "updated_at", precision: nil, null: false
    t.index ["gds_client_id", "journey_date", "api_name"], name: "idx_client_id_journey_date_api_name"
  end

  create_table "boarding_point_booking_shares", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "boarding_point_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "monthyear"
    t.string "route_name"
    t.string "search_point_name"
    t.string "share_percentage"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.index ["boarding_point_id"], name: "idx_bp_id"
    t.index ["search_point_name"], name: "idx_search_point"
  end

  create_table "boarding_point_captains", charset: "latin1", force: :cascade do |t|
    t.integer "bus_member_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_active", default: true
    t.integer "point_id", null: false
    t.date "service_start_date", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by", limit: 100
    t.index ["bus_member_id"], name: "idx_bus_member_id"
  end

  create_table "boarding_point_image_requests", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "boarding_point_id"
    t.integer "bus_member_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "image_url"
    t.text "reason"
    t.string "request_status"
    t.string "tiny_url"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.index ["boarding_point_id"], name: "idx_boarding_point_id"
  end

  create_table "boarding_points", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "address"
    t.integer "city_id"
    t.integer "cityflo_point_id", comment: "this column name belongs to the column cityflo_point_id of cityflo_points table"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "crew_assistable_point", default: false
    t.integer "disabled_minutes", comment: "disable from scheduled point time"
    t.integer "image_request_id"
    t.string "image_short_url"
    t.text "image_url"
    t.integer "intrcity_lounge_id"
    t.integer "is_new", limit: 1, default: 0
    t.string "landmark"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.string "location"
    t.string "location_short_url"
    t.integer "metro_station_id"
    t.string "name"
    t.integer "operator_id"
    t.integer "parent_id"
    t.string "phone", limit: 10
    t.text "point_guidance_text"
    t.string "point_guidance_video"
    t.string "search_name"
    t.integer "status", limit: 1, default: 1, null: false, comment: "1=active; 0=inactive"
    t.datetime "updated_at", precision: nil, null: false
    t.string "video_short_url"
    t.text "video_url"
    t.index ["city_id"], name: "city_id"
    t.index ["parent_id"], name: "idx_parent_id"
  end

  create_table "booked_seats", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "booking_id"
    t.integer "bus_seat_id"
    t.integer "bus_service_id"
    t.integer "bus_service_route_id"
    t.integer "coupe_seat_id"
    t.string "coupe_seat_name"
    t.datetime "created_at", precision: nil, null: false
    t.float "hold_base_fare", default: 0.0
    t.integer "hold_by"
    t.time "hold_time"
    t.string "hold_type"
    t.integer "is_permanent_hold", limit: 1, default: 0
    t.date "journey_date"
    t.string "seat_no", limit: 11
    t.date "service_start_date"
    t.integer "status", default: 1
    t.date "unhold_date"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["booking_id"], name: "index_booked_seats_on_booking_id"
    t.index ["bus_service_id", "service_start_date"], name: "idx_bus_service_id_service_start_date"
    t.index ["bus_service_route_id"], name: "index_booked_seats_on_bus_service_route_id"
    t.index ["coupe_seat_id"], name: "idx_coupe_seat_id"
  end

  create_table "booking_communications", charset: "latin1", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.boolean "crew_info", default: false, null: false
    t.string "otp_secret_key"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["booking_id"], name: "idx_booking_id"
    t.index ["id"], name: "id_UNIQUE", unique: true
  end

  create_table "booking_details", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "booking_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.text "metro_point_hash"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["booking_id"], name: "idx_booking_id"
  end

  create_table "booking_other_charges", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "booking_id", null: false
    t.string "charges_type", limit: 45
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_refundable", default: true
    t.float "other_charges_amount", default: 0.0
    t.integer "other_charges_type_id", null: false
    t.integer "passenger_detail_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["booking_id"], name: "idx_booking_id"
  end

  create_table "booking_sources", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "app_type", limit: 1
    t.string "booking_mode", limit: 45, collation: "utf8mb3_unicode_ci"
    t.integer "client_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "ecomm_source_id", limit: 1
    t.string "source", limit: 45, collation: "utf8mb3_unicode_ci"
    t.integer "source_id"
    t.string "source_type", limit: 45, collation: "utf8mb3_unicode_ci"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["source_id"], name: "source_id_UNIQUE", unique: true
  end

  create_table "bookings", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "associated_bp_id"
    t.integer "associated_dp_id"
    t.float "auxiliary_amt", default: 0.0, comment: "to store any supported amt, like difference amt after reschedule"
    t.float "backup_seat_fares"
    t.float "base_fare"
    t.integer "block_minute", default: 10
    t.integer "boarding_point_id"
    t.time "boarding_time"
    t.string "booker_phone_no", limit: 45
    t.datetime "booking_date", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.integer "booking_remainder", default: 0
    t.string "booking_source"
    t.integer "booking_source_id"
    t.string "booking_type", limit: 100
    t.integer "bus_master_route_id"
    t.integer "bus_service_id"
    t.string "cancel_by_support"
    t.decimal "cancellation_charge", precision: 6, scale: 2
    t.string "cancellation_policy"
    t.datetime "cancelled_at", precision: nil
    t.integer "cancelled_by"
    t.integer "cityflo_route_slot_id"
    t.integer "client_id"
    t.integer "connected_booking_id"
    t.integer "connected_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "destination_id"
    t.float "discount"
    t.string "discount_type"
    t.date "dropping_date"
    t.integer "dropping_point_id"
    t.time "dropping_time"
    t.string "gds_booking_id"
    t.integer "gds_operator_id", default: 10
    t.float "gst_on_cancellation_charge"
    t.float "gst_percent", default: 5.0
    t.integer "is_cancellable", limit: 1, default: 1, comment: "update against passenger boarding status"
    t.boolean "is_chart_transfer", default: false
    t.integer "is_partial_cancelled", limit: 1
    t.boolean "is_primary_route"
    t.boolean "is_seat_update", default: false
    t.boolean "is_switch_trip", default: false
    t.datetime "journey_date", precision: nil
    t.string "kyc_otp", limit: 16
    t.float "miles_discount_amt"
    t.integer "mirror_service_id"
    t.integer "no_of_passengers"
    t.integer "operator_cancelled", default: 0
    t.float "other_charges_amount"
    t.integer "parent_id"
    t.float "point_charges"
    t.string "qr_image_url"
    t.integer "refund_percentage"
    t.string "refund_reason"
    t.float "refundable_amt", default: 0.0, null: false
    t.integer "reschedule_policy_id"
    t.float "seat_fares"
    t.integer "seat_release_extend_till", default: 5, null: false
    t.float "service_charge"
    t.date "service_start_date"
    t.float "service_tax"
    t.integer "source_id"
    t.string "status", limit: 20
    t.float "taxable_base_fare"
    t.string "tentative_booking_id", limit: 16
    t.text "ticket_comments"
    t.string "ticket_pnr", limit: 20
    t.float "total_fare"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.index ["boarding_point_id"], name: "idx_boarding_point_id"
    t.index ["booking_date", "client_id"], name: "idx_bookings_booking_date_client_id"
    t.index ["bus_service_id"], name: "idx_bus_service_id"
    t.index ["client_id", "journey_date"], name: "idx_bookings_client_id_journey_date"
    t.index ["client_id", "service_start_date"], name: "idx_client_id_service_date"
    t.index ["connected_booking_id"], name: "idx_connected_booking_id"
    t.index ["destination_id"], name: "idx_destination_id"
    t.index ["dropping_point_id"], name: "idx_dropping_point_id"
    t.index ["parent_id"], name: "idx_parent_id"
    t.index ["source_id"], name: "idx_source_id"
    t.index ["tentative_booking_id"], name: "idx_tentative_bid"
    t.index ["ticket_pnr"], name: "idx_bookings_ticket_pnr"
    t.index ["user_id"], name: "user_id"
  end

  create_table "bulk_data_trackings", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "api_name"
    t.integer "api_version", default: 1
    t.integer "boarding_point_id"
    t.string "boarding_point_name"
    t.integer "booking_id"
    t.string "booking_source"
    t.integer "bus_service_id"
    t.integer "bus_service_route_id"
    t.decimal "cancellation_perc", precision: 5, scale: 2
    t.datetime "created_at", precision: nil, null: false
    t.integer "dropping_point_id"
    t.string "dropping_point_name"
    t.text "failed_reason"
    t.integer "from_city_id"
    t.string "from_city_name"
    t.string "gds_booking_id"
    t.integer "gds_client_id"
    t.string "gds_client_name"
    t.boolean "is_cancellable"
    t.boolean "is_success", default: true
    t.date "journey_date"
    t.integer "passenger_size"
    t.string "pnr"
    t.float "refund_amount"
    t.string "remote_ip"
    t.date "request_date"
    t.datetime "request_time", precision: nil
    t.decimal "response_time", precision: 5, scale: 2
    t.boolean "system_calls", default: false
    t.string "tentative_booking_id"
    t.integer "to_city_id"
    t.string "to_city_name"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.string "user_primary_email"
    t.string "user_primary_phone_number"
    t.index ["api_name"], name: "idx_trackings_api_name"
    t.index ["booking_id"], name: "idx_booking_id"
    t.index ["created_at"], name: "idx_created_at"
    t.index ["from_city_id", "to_city_id"], name: "index_trackings_on_from_city_id_and_to_city_id"
    t.index ["gds_booking_id"], name: "idx_gds_booking_id"
    t.index ["gds_client_id"], name: "index_trackings_on_gds_client_id"
    t.index ["gds_client_name"], name: "idx_trackings_gds_client_name"
    t.index ["journey_date"], name: "index_trackings_on_journey_date"
    t.index ["request_date"], name: "index_trackings_on_request_date"
  end

  create_table "bus_amenities", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "amenity_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "gds_bus_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["gds_bus_id"], name: "index_bus_amenities_on_gds_bus_id"
  end

  create_table "bus_and_service_mappings", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.date "from_date", null: false
    t.integer "gds_bus_id"
    t.date "to_date", null: false
    t.datetime "updated_at", precision: nil
  end

  create_table "bus_assist_accesses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "access_changed_at", precision: nil
    t.integer "access_changed_by"
    t.string "access_for"
    t.string "access_status"
    t.string "access_url"
    t.integer "bus_member_id"
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "for_driver"
    t.boolean "for_helper"
    t.date "from_date"
    t.string "reason"
    t.date "to_date"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id"], name: "idx_bus_service_id"
  end

  create_table "bus_assist_accesses_operating_days", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "bus_assist_access_id", null: false
    t.bigint "operating_day_id", null: false
    t.index ["bus_assist_access_id", "operating_day_id"], name: "idx_access_id_op_day_id"
    t.index ["operating_day_id", "bus_assist_access_id"], name: "idx_op_id_access_id"
  end

  create_table "bus_cargo_spaces", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "cargo_space_id"
    t.datetime "created_at", precision: nil
    t.integer "gds_bus_id"
    t.boolean "status", default: true
    t.datetime "updated_at", precision: nil
    t.index ["gds_bus_id"], name: "idx_gds_bus_id"
  end

  create_table "bus_classes", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "name", limit: 50, default: "", null: false
    t.integer "status", limit: 1, default: 1, null: false, comment: "1=active;0=inactive"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["status"], name: "status"
  end

  create_table "bus_gps_locations", charset: "latin1", force: :cascade do |t|
    t.integer "feed_point_id", null: false
    t.integer "sent_data", default: 0
    t.string "sent_data_error", collation: "utf8mb3_unicode_ci"
    t.index ["feed_point_id"], name: "idx_feed_point_id"
  end

  create_table "bus_location_mismatch_alerts", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "alert_count", default: 1
    t.string "alert_status"
    t.integer "bus_member_id"
    t.string "bus_number"
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.text "extra_info"
    t.datetime "notified_at", precision: nil
    t.datetime "responded_at", precision: nil
    t.string "responded_by"
    t.datetime "sent_at", precision: nil
    t.date "service_start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id", "service_start_date"], name: "idx_service_name_date"
  end

  create_table "bus_makers", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "name", limit: 30, default: "", null: false
    t.integer "status", limit: 1, default: 1, null: false, comment: "1=active;0=inactive"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["status"], name: "status"
  end

  create_table "bus_master_routes", id: :integer, charset: "latin1", force: :cascade do |t|
    t.boolean "connected_service", default: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "destination_city_id"
    t.integer "gds_state_id", limit: 1
    t.boolean "is_active", default: true
    t.integer "manager_id"
    t.string "other_charges_type_ids", limit: 45
    t.integer "primary_route_id"
    t.boolean "prime_service", default: false
    t.string "round_route"
    t.integer "route_distance_type", default: 0
    t.integer "source_city_id"
    t.string "state_name"
    t.string "sub_zone", limit: 100
    t.datetime "updated_at", precision: nil, null: false
    t.string "zone"
    t.integer "zone_master_id", limit: 1
    t.index ["source_city_id", "destination_city_id"], name: "idx_route"
  end

  create_table "bus_member_audit_target", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "audit_target"
    t.integer "bus_member_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "bus_member_audit_targets", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "audit_target"
    t.string "audit_type"
    t.integer "bus_member_id"
    t.datetime "created_at", precision: nil
    t.date "from_date"
    t.boolean "is_active"
    t.date "to_date"
    t.datetime "updated_at", precision: nil
    t.string "updated_by"
  end

  create_table "bus_member_extensions", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_member_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "extension"
    t.integer "password"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "bus_member_history", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "bus_member_task_id", null: false
    t.datetime "created_at", precision: nil
    t.string "task"
    t.datetime "updated_at", precision: nil
    t.string "updated_by"
    t.integer "user_id", null: false
    t.string "user_type", limit: 45, null: false
  end

  create_table "bus_member_lounges", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_member_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "lounge_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["id"], name: "idbus_member_lounges_UNIQUE", unique: true
  end

  create_table "bus_member_managers", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "bus_member_id", null: false
    t.datetime "created_at", precision: nil
    t.date "from_date"
    t.integer "manager_id", null: false
    t.column "manager_type", "enum('hr','other')"
    t.date "to_date"
    t.datetime "updated_at", precision: nil
    t.string "updated_by"
    t.index ["bus_member_id", "manager_type"], name: "bus_member_manager_type_id_index"
    t.index ["from_date", "to_date"], name: "from_date_to_date_index"
    t.index ["manager_id"], name: "manager_id_index"
  end

  create_table "bus_member_messages", charset: "latin1", force: :cascade do |t|
    t.integer "card_id"
    t.datetime "created_at", precision: nil, null: false
    t.text "description", collation: "utf8mb3_general_ci"
    t.string "featured_image_url"
    t.string "image_url"
    t.string "images_url", limit: 555
    t.boolean "intrcity_message", default: false
    t.boolean "is_active", default: true
    t.boolean "is_important", default: false
    t.string "message_for"
    t.string "published_by"
    t.text "route_ids"
    t.text "selection_criteria"
    t.string "sent_by"
    t.string "sub_title", limit: 225, collation: "utf8mb3_general_ci"
    t.string "title", collation: "utf8mb3_general_ci"
    t.integer "total_users_sent", default: 0
    t.datetime "updated_at", precision: nil, null: false
    t.text "video_thumbnail"
    t.string "videos_url", limit: 555
    t.string "weburl"
    t.index ["card_id"], name: "index_bus_member_messages_on_card_id"
    t.index ["message_for"], name: "idx_message_for"
  end

  create_table "bus_member_roles", charset: "latin1", force: :cascade do |t|
    t.integer "bus_member_id"
    t.integer "bus_role_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_member_id"], name: "index_on_smart_bus_user_roles_on_user_id"
    t.index ["bus_role_id"], name: "index_on_smart_bus_user_roles_on_role_id"
  end

  create_table "bus_member_routes", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_member_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "route_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "bus_member_service_alert_question_answers", charset: "latin1", force: :cascade do |t|
    t.string "answer"
    t.integer "bus_member_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "question_id"
    t.integer "service_alert_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_member_id"], name: "idx_bus_member_id"
    t.index ["service_alert_id"], name: "idx_service_alert_id"
  end

  create_table "bus_member_service_alert_questions", charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "input_type"
    t.string "question"
    t.string "report_label"
    t.integer "serial_number"
    t.integer "status", limit: 1, default: 1
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "bus_member_service_alerts", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "address"
    t.string "alert_status"
    t.datetime "bus_end_time", precision: nil
    t.integer "bus_member_id"
    t.integer "bus_service_id"
    t.datetime "bus_start_time", precision: nil
    t.text "comment"
    t.datetime "created_at", precision: nil, null: false
    t.text "extra_info", size: :medium
    t.string "image_url"
    t.string "location"
    t.datetime "notify_at", precision: nil
    t.datetime "notify_end_time", precision: nil
    t.datetime "notify_start_time", precision: nil
    t.datetime "prev_notify_at", precision: nil
    t.datetime "reminder_sent_at", precision: nil
    t.date "service_start_date"
    t.datetime "status_changed_at", precision: nil
    t.string "status_changed_by"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_member_id"], name: "index_bus_member_service_alerts_on_bus_member_id"
    t.index ["bus_service_id", "service_start_date"], name: "idx_service_id_date"
  end

  create_table "bus_member_services", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "bus_member_id", null: false
    t.integer "bus_service_id", null: false
    t.datetime "created_at", precision: nil
    t.date "from_date"
    t.date "to_date"
    t.datetime "updated_at", precision: nil
    t.string "updated_by"
    t.index ["bus_member_id"], name: " bus_member_id_index"
    t.index ["bus_service_id"], name: "bus_service_id_index"
  end

  create_table "bus_member_target_routes", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_member_id"
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }, null: false
    t.string "created_by"
    t.integer "route_id"
    t.datetime "updated_at", precision: nil
    t.string "updated_by"
  end

  create_table "bus_member_task_change_logs", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "bus_member_task_id", null: false
    t.datetime "created_at", precision: nil
    t.string "task"
    t.datetime "updated_at", precision: nil
    t.string "updated_by"
    t.integer "user_id", null: false
    t.string "user_type", limit: 45, null: false
  end

  create_table "bus_member_tasks", id: :integer, charset: "latin1", force: :cascade do |t|
    t.boolean "allow_checkin_checkout", default: true
    t.integer "bus_member_id"
    t.string "check_in_address", limit: 250
    t.float "check_in_lang"
    t.float "check_in_lat"
    t.datetime "check_in_time", precision: nil
    t.string "check_out_address", limit: 250
    t.float "check_out_lang"
    t.float "check_out_lat"
    t.datetime "check_out_time", precision: nil
    t.datetime "created_at", precision: nil
    t.date "on_date"
    t.boolean "status", default: true
    t.string "task", limit: 100
    t.datetime "updated_at", precision: nil
  end

  create_table "bus_member_wallet_details", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "activity"
    t.integer "add_on_order_id"
    t.string "added_by"
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.decimal "balance", precision: 10, scale: 2, null: false
    t.integer "bus_member_id", null: false
    t.string "comment"
    t.datetime "created_at", precision: nil, null: false
    t.integer "event_id"
    t.integer "event_type", default: 0, comment: "Basically for manging the kind of wallet credit"
    t.datetime "expiration_date", precision: nil
    t.boolean "fraud_detected"
    t.boolean "is_expired", default: false
    t.boolean "is_paid_by_wallet", default: false
    t.boolean "is_private", default: true
    t.boolean "is_transferred", default: false
    t.integer "otp"
    t.datetime "otp_sent_at", precision: nil
    t.datetime "otp_verified_at", precision: nil
    t.integer "phone_number"
    t.integer "relationship_id"
    t.string "relationship_type"
    t.integer "transaction_id"
    t.string "transaction_type", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_member_id", "created_at"], name: "created_at_index"
    t.index ["bus_member_id"], name: "bus_member_id_index"
    t.index ["transaction_id"], name: "idx_transaction_id"
  end

  create_table "bus_member_wallets", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "bus_member_id", null: false
    t.decimal "cashback_amount", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", precision: nil, null: false
    t.decimal "refund_amount", precision: 10, scale: 2, default: "0.0"
    t.decimal "total", precision: 10, scale: 2, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_member_id"], name: "bus_member_id_UNIQUE", unique: true
    t.index ["bus_member_id"], name: "bus_member_id_index"
  end

  create_table "bus_members", charset: "latin1", force: :cascade do |t|
    t.string "alias_name"
    t.string "app_id"
    t.integer "banker_id"
    t.integer "bus_provider_id"
    t.integer "captain_detail_id"
    t.integer "city_id"
    t.integer "city_sub_region_id"
    t.datetime "created_at", precision: nil
    t.integer "credit_type", default: 0
    t.text "driver_app_details"
    t.string "email"
    t.string "emp_code"
    t.integer "hr_manager_id"
    t.string "hr_role", limit: 45
    t.string "intrcity_brand_ids"
    t.boolean "is_active", default: true, null: false
    t.boolean "is_banker", default: false
    t.boolean "is_money_collector", default: false
    t.integer "manager_id"
    t.string "mobile_number", default: "", null: false
    t.string "name", null: false
    t.text "otp_backup_codes"
    t.string "otp_secret_key"
    t.string "password_digest"
    t.string "profile_image_url"
    t.boolean "show_bus_services", default: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "v_code"
    t.integer "van_provider_id"
    t.integer "verification_code"
    t.datetime "verified_at", precision: nil
    t.index ["banker_id"], name: "idx_banker_id"
    t.index ["bus_provider_id"], name: "idx_bus_provider_id"
    t.index ["hr_role", "is_active"], name: "idx_hr_role"
    t.index ["manager_id"], name: "manager_id"
    t.index ["mobile_number", "is_active"], name: "index_ry_bus_users_on_mobile_number", unique: true
  end

  create_table "bus_occupancy_summaries", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "abhibus_revenue"
    t.integer "abhibus_sold_seat"
    t.integer "average_revenue"
    t.integer "avl_seats"
    t.integer "bus_changed", limit: 1, default: 0
    t.string "bus_dimension", limit: 45
    t.datetime "created_at", precision: nil
    t.integer "flat_price_revenue"
    t.integer "flat_price_sold_seat"
    t.integer "ic_revenue"
    t.integer "ic_sold_seat"
    t.integer "is_electric_bus", limit: 1, default: 0
    t.integer "is_washroom", limit: 1, default: 0
    t.date "journey_date"
    t.integer "net_collection"
    t.integer "net_contribution"
    t.integer "occupancy_per"
    t.integer "offline_revenue"
    t.integer "offline_sold_seat"
    t.integer "ota_revenue"
    t.integer "ota_sold_seat"
    t.integer "redbus_revenue"
    t.integer "redbus_sold_seat"
    t.integer "reserved_cancelled_seat_count"
    t.integer "reserved_seat_count"
    t.integer "reserved_seat_total_revenue"
    t.integer "running_status", limit: 1, default: 0
    t.integer "sector_priced_sold_seat"
    t.integer "service_id", null: false
    t.string "service_name", null: false
    t.string "service_tags"
    t.integer "sold_seat"
    t.integer "target_revenue"
    t.integer "target_revenue_per"
    t.integer "total_revenue"
    t.integer "total_surcharge"
    t.integer "unsold_average_revenue"
    t.integer "unsold_revenue"
    t.integer "unsold_seat"
    t.datetime "updated_at", precision: nil
    t.string "updated_by", limit: 50
    t.index ["service_id", "journey_date"], name: "service_id_journey_date_index"
  end

  create_table "bus_provider_properties", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_active", default: true
    t.string "provider_property"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "bus_provider_tax_rates", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "bus_provider_id", null: false
    t.datetime "created_at", precision: nil
    t.date "from_date", null: false
    t.float "tcs", default: 0.0
    t.float "tds", default: 0.0
    t.date "to_date", null: false
    t.datetime "update_at", precision: nil
    t.string "updated_by"
    t.index ["bus_provider_id", "from_date", "to_date"], name: "bus_provider_id_from_to_date_index"
  end

  create_table "bus_provider_trips", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_provider_id"
    t.datetime "created_at", precision: nil
    t.integer "provider_type", default: 0
    t.boolean "status", default: true
    t.string "trip_name", limit: 225
    t.datetime "updated_at", precision: nil
  end

  create_table "bus_providers", charset: "latin1", force: :cascade do |t|
    t.string "address"
    t.string "app_id"
    t.string "authentication_token"
    t.integer "bus_provider_property_id", default: 1
    t.string "contact", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "email"
    t.string "email_cc"
    t.string "encrypted_password", default: "", null: false
    t.string "gst_no"
    t.string "name"
    t.integer "parent_id"
    t.integer "provider_type_id"
    t.datetime "remember_created_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.string "session_token"
    t.boolean "show_performance_report", default: false
    t.boolean "show_sales_report", default: false
    t.string "state"
    t.integer "state_id"
    t.boolean "status"
    t.datetime "updated_at", precision: nil, null: false
    t.text "visible_reports"
  end

  create_table "bus_providers_old", charset: "latin1", force: :cascade do |t|
    t.string "address"
    t.string "contact"
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.boolean "status"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "bus_roles", charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "roles", collation: "utf8mb3_unicode_ci"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "bus_seat_layouts", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "available_seats"
    t.integer "bus_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "status", limit: 1, default: 1, null: false, comment: "1=active | 0 = inactive"
    t.integer "total_seats"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_id"], name: "idx_bus_id"
  end

  create_table "bus_seating_types", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "name", limit: 10, default: "", null: false
    t.integer "status", limit: 1, default: 1, null: false, comment: "1=active;0=inactive"
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["status"], name: "status"
  end

  create_table "bus_seats", id: :integer, charset: "latin1", force: :cascade do |t|
    t.float "amount"
    t.integer "appositional_seat_id"
    t.string "appositional_seat_no", limit: 45
    t.float "basic_fare", default: 0.0, null: false
    t.integer "bus_seat_legend_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "gds_bus_id"
    t.integer "height", default: 1, null: false
    t.integer "is_agent", limit: 1, default: 0, comment: "1=agent quota | 0 = availble for booking."
    t.boolean "is_available", default: true, null: false, comment: "1=available;0=notavailable"
    t.integer "is_ladies", limit: 1, default: 0
    t.boolean "is_last_seat", default: false
    t.integer "is_ph", limit: 1, default: 0
    t.boolean "is_shared"
    t.float "levy_charges", default: 0.0, null: false
    t.float "net", default: 0.0, null: false
    t.integer "seat_layout_id"
    t.float "seat_length"
    t.string "seat_no", limit: 10, default: ""
    t.string "seat_type", limit: 4, comment: "A=Asile | W = Window | M = Middle"
    t.float "seat_width"
    t.string "seating_type", limit: 50
    t.float "service_charges", default: 0.0, null: false
    t.integer "status", limit: 1, default: 1, null: false, comment: "1=active | 0= inactive"
    t.float "tax", default: 0.0, null: false
    t.float "toll_fee", default: 0.0, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "width", default: 1, null: false
    t.integer "x", null: false
    t.boolean "xl_type", default: false, comment: "calculated on the basis of seat_length, true if >70"
    t.integer "y", null: false
    t.integer "z", default: 0, null: false
    t.index ["seat_layout_id"], name: "idx_seat_layout_id"
  end

  create_table "bus_service_alert_changes", charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_alert_id"
    t.string "column_type"
    t.datetime "created_at", precision: nil, null: false
    t.string "current_value"
    t.string "previous_value"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_alert_id"], name: "index_bus_service_alert_changes_on_bus_service_alert_id"
  end

  create_table "bus_service_alerts", charset: "latin1", force: :cascade do |t|
    t.string "added_by"
    t.integer "alert_status"
    t.string "alert_type"
    t.string "approve_by"
    t.integer "bus_service_id"
    t.string "comment"
    t.datetime "created_at", precision: nil, null: false
    t.text "extra_info"
    t.integer "passengers_count"
    t.integer "point_id"
    t.date "service_start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id", "service_start_date"], name: "idx_service_id_date"
  end

  create_table "bus_service_amenities", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "amenity_id"
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id"], name: "index_bus_service_amenities_on_bus_service_id"
  end

  create_table "bus_service_bookings", charset: "latin1", force: :cascade do |t|
    t.float "add_on_amount"
    t.integer "b2c"
    t.integer "boarding_point"
    t.integer "bus_captain"
    t.bigint "bus_service_id"
    t.float "cancellation_amount"
    t.integer "cancelled_seats"
    t.datetime "created_at", precision: nil, null: false
    t.integer "fill_rate"
    t.integer "icy"
    t.integer "icy_inventory"
    t.float "list_price", comment: "Include GST"
    t.float "list_price_avg_ticket_fare"
    t.float "min_rev_target", comment: "Include GST"
    t.float "net_collection"
    t.float "net_collection_avg_ticket_fare"
    t.float "net_contribution"
    t.integer "net_contribution_rate"
    t.integer "offline_lp_avg_ticket_fare"
    t.integer "offline_nc_avg_ticket_fare"
    t.integer "offline_seats"
    t.integer "online_lp_avg_ticket_fare"
    t.integer "online_nc_avg_ticket_fare"
    t.integer "online_seats"
    t.integer "other_ota"
    t.float "partner_commission"
    t.integer "pay_at_bus"
    t.integer "paytm"
    t.integer "redbus"
    t.integer "repeat_cust"
    t.integer "repeat_cust_rate"
    t.integer "retail"
    t.integer "retail_conveniece_charges"
    t.integer "retail_marketing_cashback_cost"
    t.integer "retail_marketing_coupon_cost"
    t.integer "retail_net_collection"
    t.integer "retail_partner_comm"
    t.date "service_start_date"
    t.integer "sold_seats"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id", "service_start_date"], name: "idx_service_id_start_date"
    t.index ["bus_service_id"], name: "index_bus_service_bookings_on_bus_service_id"
  end

  create_table "bus_service_details", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "return_trip_id"
    t.string "round_route"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "bus_service_halt_days", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.date "from_date", null: false
    t.string "halt_days", null: false
    t.boolean "is_active", default: true, null: false
    t.date "skip_from_date"
    t.date "skip_to_date"
    t.date "to_date", default: "2099-12-31", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id"], name: "idx_bus_service_id"
  end

  create_table "bus_service_mappings", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id"
    t.string "bus_service_name"
    t.datetime "created_at", precision: nil, null: false
    t.date "from_date", null: false
    t.integer "gds_bus_id"
    t.boolean "has_washroom"
    t.boolean "is_active", default: false
    t.integer "master_seat_layout_id"
    t.text "primary_seats_inactive_dates"
    t.text "prime_seat_ids"
    t.time "service_prime_time"
    t.date "to_date", null: false
    t.datetime "updated_at", precision: nil
    t.string "updated_by"
    t.index ["bus_service_id"], name: "idx_bus_service_id"
  end

  create_table "bus_service_operator_details", charset: "latin1", force: :cascade do |t|
    t.integer "allowed_halt_service", limit: 1
    t.float "alternate_minimum_guarantee"
    t.integer "bus_provider_id"
    t.integer "bus_provider_trip_id"
    t.integer "bus_service_id"
    t.float "cargo_commission"
    t.integer "child_bus_provider_id"
    t.text "cost_split"
    t.datetime "created_at", precision: nil
    t.string "day_service_type", limit: 225
    t.string "form_iv_pdf_url"
    t.date "from_date"
    t.string "gds_bus_ids"
    t.integer "gst_group"
    t.float "halt_service_charge"
    t.string "indo_rail_commission"
    t.float "minimum_guarantee"
    t.float "minimum_profit_guarantee"
    t.float "planned_halt_service_charge"
    t.integer "profit_share"
    t.integer "provider_type", default: 0
    t.string "service_running_type"
    t.string "signature_img_url"
    t.float "target_revenue_inc_gst"
    t.date "to_date"
    t.datetime "updated_at", precision: nil
  end

  create_table "bus_service_other_charges", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_master_route_id"
    t.integer "bus_service_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.date "from_date", null: false
    t.boolean "is_active", default: true, null: false
    t.boolean "is_markup", default: false
    t.boolean "is_refundable", default: true
    t.float "other_charges_amount"
    t.integer "other_charges_type_id", null: false
    t.date "to_date", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_master_route_id"], name: "idx_route_id"
    t.index ["bus_service_id", "other_charges_type_id", "from_date", "is_active"], name: "composite_index_bs_charges"
  end

  create_table "bus_service_paths", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id"
    t.integer "city_id"
    t.string "city_name", limit: 50
    t.string "city_type", limit: 3, default: "2", null: false, comment: "Source=SRC | Destination= DES | Via VIA"
    t.datetime "created_at", precision: nil, null: false
    t.decimal "distance_from_source", precision: 10, scale: 3
    t.boolean "important_city", default: false
    t.integer "parent_id"
    t.integer "status", limit: 1, default: 1, null: false, comment: "1=Active | 0=Inactive"
    t.integer "stop_no"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id"], name: "idx_bus_service_id"
    t.index ["city_id"], name: "idx_city_id"
  end

  create_table "bus_service_routes", id: :integer, charset: "latin1", force: :cascade do |t|
    t.boolean "booking_allowed", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "from_path_id"
    t.boolean "is_nearby_route", default: false
    t.boolean "is_primary", default: false
    t.integer "route_id"
    t.integer "service_id"
    t.boolean "status", default: true, null: false
    t.integer "to_path_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["route_id"], name: "idx_route_id"
    t.index ["service_id"], name: "bus_servic_id"
  end

  create_table "bus_services", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "attached_bus_id"
    t.integer "block_before_departure_min", default: 0, comment: "apply this for change the minutes of seat block, before 2 hr of service_start_time "
    t.integer "booking_close_timing", default: 1
    t.integer "bus_master_route_id"
    t.integer "bus_provider_id"
    t.integer "cancellation_policy_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "destination_city_id"
    t.string "destination_city_name", limit: 30
    t.integer "destination_city_sub_region_id", default: 0
    t.integer "dynamic_block_minute", default: 3, comment: "It decides seat block minute on the basis of dynamic_block_hour column"
    t.integer "gds_operator_id", default: 10
    t.boolean "has_manifestation", default: false
    t.integer "intrcity_brand_id", default: 1
    t.integer "is_smart_bus", limit: 1
    t.boolean "is_social_distance", default: false
    t.boolean "is_vbc_service", default: false
    t.boolean "luggage_wa", default: false
    t.integer "mantis_trip_id"
    t.integer "open_booking_days"
    t.string "round_route", limit: 100
    t.string "round_trip_zone", limit: 100
    t.integer "route_booking", limit: 1, default: 0
    t.integer "route_distance_type", default: 0
    t.string "service_name", limit: 100
    t.string "service_name_suffix", limit: 250
    t.integer "service_running_type", default: 0
    t.float "service_tax", default: 5.0
    t.integer "service_time", comment: "Used in listing"
    t.boolean "show_in_crew_app", default: true
    t.integer "source_city_id"
    t.string "source_city_name", limit: 30
    t.integer "source_city_sub_region_id", default: 0
    t.string "state", limit: 100
    t.integer "status", limit: 1, default: 0, null: false
    t.string "sub_zone", limit: 100
    t.string "support_phone_no", limit: 15
    t.text "tags"
    t.datetime "updated_at", precision: nil, null: false
    t.string "zone", limit: 100
    t.index ["bus_master_route_id"], name: "idx_master_route_id"
    t.index ["mantis_trip_id"], name: "idx_bus_services_mantis_trip_id"
    t.index ["source_city_id", "destination_city_id"], name: "idx_source_destination_id"
  end

  create_table "cancellation_policies", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "cancellation_info"
    t.string "cancellation_type", limit: 4
    t.datetime "created_at", precision: nil, null: false
    t.integer "created_by", default: 0, null: false, comment: "0=created by Railyatri, otherwise created by operator with id mentioned in this field"
    t.integer "is_default", limit: 1, default: 0, null: false
    t.string "name", limit: 100
    t.string "rule", comment: "0-1|25,1-2|15,2-24|10,24-720|0"
    t.integer "spot_cancellation_charges"
    t.integer "spot_cancellation_time", default: 0, comment: "Spot Cancellation:Cancellation charges will NOT apply if cancelled with in this time from the issue time"
    t.string "spot_cancellation_type", limit: 15
    t.integer "status", limit: 1, default: 1, null: false, comment: "1=active;0=inactive"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "cancellation_shared_rates", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.date "from_date"
    t.integer "gds_client_id"
    t.string "rate", limit: 45
    t.date "to_date"
    t.datetime "updated_at", precision: nil
    t.index ["gds_client_id"], name: "idx_cancellation_shared_rates_gds_client_id"
  end

  create_table "cancelled_bus_services", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id"
    t.datetime "cancellation_date", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "captain_activities", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "action_status"
    t.integer "addon_order_details_id"
    t.integer "bus_member_message_id"
    t.integer "bus_trip_id"
    t.integer "captain_id"
    t.integer "card_id", null: false
    t.boolean "chargeable", default: false, null: false
    t.text "comment"
    t.datetime "created_at", precision: nil, null: false
    t.text "description", collation: "utf8mb3_general_ci"
    t.boolean "is_active", default: false, null: false
    t.boolean "is_important", default: false
    t.boolean "is_message", default: false
    t.string "item"
    t.string "item_code"
    t.string "notification_status"
    t.integer "quantity", default: 0, null: false
    t.integer "service_id"
    t.date "service_start_date"
    t.integer "status", default: 0, null: false
    t.datetime "submitted_at", precision: nil
    t.integer "submitted_by"
    t.text "topic", collation: "utf8mb3_general_ci"
    t.datetime "updated_at", precision: nil, null: false
    t.string "video_url"
    t.index ["bus_member_message_id"], name: "idx_bus_member_message_id"
    t.index ["bus_trip_id"], name: "idx_bus_trip_id"
    t.index ["captain_id", "service_start_date"], name: "idx_captain_id_date"
    t.index ["card_id"], name: "idx_card_id"
    t.index ["id"], name: "id_UNIQUE", unique: true
    t.index ["item_code"], name: "idx_item_code"
    t.index ["service_id", "service_start_date"], name: "idx_service_id_date"
  end

  create_table "captain_details", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_member_id", null: false
    t.string "city_hubs"
    t.integer "city_id"
    t.datetime "created_at", precision: nil, null: false
    t.date "date_of_joining", null: false
    t.date "date_of_not_reporting"
    t.date "date_of_reporting"
    t.date "date_of_resignation"
    t.string "designation", null: false
    t.string "email"
    t.string "employee_id", limit: 45, null: false
    t.string "employee_mobile_number", limit: 45
    t.string "employee_name"
    t.string "hometown"
    t.date "last_working_date"
    t.string "location", null: false
    t.integer "manager_id"
    t.string "manager_name"
    t.string "official_email"
    t.date "show_cause_issue_date"
    t.string "show_cause_time", limit: 45
    t.string "status"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.integer "years_of_experience"
    t.index ["id"], name: "id_UNIQUE", unique: true
  end

  create_table "captain_requests", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "approved_at", precision: nil
    t.string "approved_by"
    t.integer "bus_member_id"
    t.datetime "created_at", precision: nil, null: false
    t.text "request_details"
    t.string "request_status"
    t.string "request_type"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_member_id"], name: "idx_bus_member_id"
  end

  create_table "card_actions", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "action_name", null: false
    t.integer "action_type"
    t.string "action_url"
    t.integer "card_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "sequence", default: 0, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["card_id"], name: "idx_card_id"
    t.index ["id"], name: "id_UNIQUE", unique: true
  end

  create_table "card_fields", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "card_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "label", null: false
    t.string "name", null: false
    t.integer "sequence", default: 0, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["card_id"], name: "idx_card_id"
    t.index ["id"], name: "id_UNIQUE", unique: true
  end

  create_table "cards", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "applicable_for", null: false
    t.integer "card_type", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "priority", default: 0, null: false
    t.boolean "status", null: false
    t.string "title", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["id"], name: "id_UNIQUE", unique: true
  end

  create_table "cargo_charges", charset: "latin1", force: :cascade do |t|
    t.integer "cargo_id"
    t.decimal "charges_amount", precision: 10, scale: 2
    t.string "charges_type"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["cargo_id"], name: "index_cargo_charges_on_cargo_id"
  end

  create_table "cargo_delivery_details", charset: "latin1", force: :cascade do |t|
    t.string "added_by"
    t.integer "cargo_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "description"
    t.string "request_type"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["cargo_id"], name: "idx_cargo_id"
  end

  create_table "cargo_documents", charset: "latin1", force: :cascade do |t|
    t.integer "cargo_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "document_title"
    t.string "document_type"
    t.string "document_url"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["cargo_id"], name: "idx_cargo_id"
  end

  create_table "cargo_pocs", charset: "latin1", force: :cascade do |t|
    t.integer "cargo_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "mobile_number"
    t.integer "otp"
    t.datetime "otp_sent_at", precision: nil
    t.string "poc_name"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["cargo_id"], name: "index_cargo_pocs_on_cargo_id"
    t.index ["otp"], name: "idx_otp"
  end

  create_table "cargo_spaces", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", precision: nil
    t.integer "height"
    t.integer "length"
    t.string "name"
    t.boolean "status", default: true
    t.datetime "updated_at", precision: nil
    t.integer "width"
  end

  create_table "cargos", charset: "latin1", force: :cascade do |t|
    t.string "added_by"
    t.decimal "advance_from_agent", precision: 10, scale: 2
    t.decimal "agent_commission", precision: 10, scale: 2
    t.decimal "amount", precision: 10, scale: 2
    t.decimal "balance_amount", precision: 10, scale: 2
    t.integer "bus_member_id"
    t.string "bus_number"
    t.integer "bus_provider_id"
    t.integer "bus_service_id"
    t.string "cargo_code"
    t.text "comments"
    t.datetime "created_at", precision: nil, null: false
    t.string "deliver_by_admin"
    t.integer "deliver_by_crew"
    t.integer "delivering_at"
    t.integer "from_city_id"
    t.integer "loading_at"
    t.integer "no_of_item"
    t.decimal "operator_commission", precision: 10, scale: 2
    t.decimal "paid_amount", precision: 10, scale: 2
    t.integer "ry_agent_id"
    t.date "service_start_date"
    t.integer "status", default: 0
    t.integer "to_city_id"
    t.decimal "total_expense", precision: 10, scale: 2
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_member_id"], name: "index_cargos_on_bus_member_id"
    t.index ["ry_agent_id"], name: "index_cargos_on_ry_agent_id"
  end

  create_table "carton_assigned_bus_services", charset: "latin1", force: :cascade do |t|
    t.integer "assigned_lounge_id"
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "lounge_carton_id"
    t.date "service_start_date"
    t.boolean "start_journey", default: true
    t.boolean "status", default: true
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id", "service_start_date"], name: "idx_service_id_and_date"
    t.index ["lounge_carton_id"], name: "idx_carton_id"
  end

  create_table "cctv_users", charset: "latin1", force: :cascade do |t|
    t.string "avatar_url"
    t.datetime "created_at", precision: nil, null: false
    t.string "email", null: false
    t.string "name"
    t.string "provider"
    t.string "uid"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_cctv_users_on_email", unique: true
  end

  create_table "chart_transfer_data", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "booking_id"
    t.boolean "chart_transfer_status"
    t.datetime "created_at", precision: nil, null: false
    t.text "hold_ivr_response"
    t.string "initiated_by", limit: 250
    t.string "ivr_api_status", limit: 100
    t.integer "ivr_reference_id"
    t.text "json_data"
    t.integer "log_status", limit: 1
    t.integer "new_bus_service_id"
    t.date "new_journey_date"
    t.string "new_seat_numbers"
    t.string "new_service_name"
    t.date "new_service_start_date"
    t.integer "passenger_count"
    t.string "pnr", limit: 45
    t.integer "prev_bus_service_id"
    t.date "prev_journey_date"
    t.string "prev_seat_numbers"
    t.string "prev_service_name"
    t.date "prev_service_start_date"
    t.text "requested_params"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.string "user_type", limit: 100, default: "User"
    t.index ["booking_id"], name: "index_chart_transfer_data_on_booking_id"
    t.index ["pnr"], name: "pnr"
    t.index ["user_id"], name: "user_id"
  end

  create_table "checklist_assessments", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "assessed_by"
    t.date "assessment_date"
    t.integer "assessment_id", null: false
    t.integer "assessment_status", limit: 2, default: 0
    t.string "assessment_type", limit: 45, null: false
    t.integer "checklist_category_id", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["assessment_type", "assessment_id", "assessment_status"], name: "relationship_type_id_index"
    t.index ["checklist_category_id"], name: "checklist_category_index"
  end

  create_table "checklist_categories", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "checklist_type", limit: 45
    t.datetime "created_at", precision: nil
    t.string "instructions"
    t.boolean "is_active", default: true
    t.string "name"
    t.integer "parent_id"
    t.integer "sequence_no", limit: 2, default: 0
    t.datetime "updated_at", precision: nil
    t.index ["is_active", "checklist_type"], name: "active_checklist_index"
  end

  create_table "checklist_question_answers", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "answer", null: false
    t.integer "assessment_id", null: false
    t.string "assessment_type", limit: 45, null: false
    t.integer "checklist_question_id", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["assessment_type", "assessment_id"], name: "relation_type_id_index"
    t.index ["checklist_question_id"], name: "question_id_index"
  end

  create_table "checklist_questions", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "checklist_category_id", null: false
    t.datetime "created_at", precision: nil
    t.string "default_value", limit: 45
    t.boolean "is_active", default: true
    t.string "options"
    t.string "question", null: false
    t.string "question_type", limit: 45
    t.integer "sequence_no", limit: 2, default: 0
    t.datetime "updated_at", precision: nil
    t.index ["checklist_category_id", "is_active"], name: "active_category_question_index"
  end

  create_table "cityflo_busnumber_infos", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_active", default: true, null: false
    t.string "lic_plate_num", limit: 50
    t.text "request_params"
    t.integer "route_slot_id", null: false
    t.date "service_start_date", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "van_service_route_id"
    t.index ["route_slot_id"], name: "idx_route_slot_id"
  end

  create_table "cityflo_passengers", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "booking_id", null: false
    t.integer "booking_status", limit: 1
    t.integer "bus_service_id", null: false
    t.string "cf_bus_id", limit: 20, comment: "cityflo bus_num"
    t.integer "cf_dropof_point_id", null: false
    t.integer "cf_pickup_point_id", null: false
    t.integer "cf_ride_id"
    t.string "cf_seat_name", limit: 45
    t.integer "cf_seat_status", limit: 1
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_active", default: true
    t.string "lic_plate_num", limit: 20
    t.integer "passenger_detail_id", null: false
    t.date "service_start_date", null: false
    t.string "tracking_url"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "van_passenger_id"
    t.integer "van_service_route_id"
    t.index ["booking_id"], name: "idx_booking_id"
    t.index ["cf_pickup_point_id"], name: "idx_cf_pickup_point_id"
    t.index ["cf_ride_id"], name: "idx_ride_id"
    t.index ["passenger_detail_id"], name: "idx_passenger_detail_id"
    t.index ["van_passenger_id"], name: "idx_van_passenger_id"
    t.index ["van_service_route_id"], name: "idx_van_service_route_id"
  end

  create_table "cityflo_point_time_slots", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "cityflo_point_id", null: false
    t.integer "cityflo_route_slot_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_active", default: true, null: false
    t.time "point_time", null: false
    t.integer "route_slot_id", null: false
    t.integer "rssi_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["cityflo_point_id"], name: "idx_cityflo_point_id"
    t.index ["route_slot_id"], name: "idx_route_slot_id"
  end

  create_table "cityflo_points", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "city_id"
    t.integer "cityflo_point_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.text "image_url"
    t.integer "is_active", limit: 1, default: 1, null: false, comment: "1=active; 0=inactive"
    t.string "landmark"
    t.float "lat"
    t.float "lng"
    t.string "point_name"
    t.datetime "updated_at", precision: nil, null: false
    t.text "video_url"
    t.index ["cityflo_point_id"], name: "cityflo_point_id", unique: true
  end

  create_table "cityflo_route_slots", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_active", default: true, null: false
    t.integer "route_slot_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["route_slot_id"], name: "idx_route_slot_id"
  end

  create_table "cityflo_trackings", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "api_error"
    t.string "api_name"
    t.text "api_response"
    t.string "api_url"
    t.integer "booking_id"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_success", default: true
    t.date "journey_date"
    t.text "request_params"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "client_financial_details", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "client_id"
    t.datetime "created_at", precision: nil, null: false
    t.float "credit_limit", default: 0.0
    t.string "pan"
    t.string "payment_type"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["client_id"], name: "client_id"
  end

  create_table "communication_messages", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "boarding_point_id"
    t.integer "bus_service_id"
    t.integer "communication_type"
    t.datetime "created_at", precision: nil, null: false
    t.text "pnrs"
    t.date "service_start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id", "service_start_date"], name: "idx_service_id_service_date"
  end

  create_table "connected_service_operating_days", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "cancellation_reason"
    t.datetime "cancelled_at", precision: nil
    t.string "cancelled_by"
    t.integer "connected_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "od_status", limit: 1, default: 1, null: false
    t.date "on_date"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.index ["connected_service_id", "on_date", "od_status"], name: "idx_service_id_on_date_active"
    t.index ["connected_service_id"], name: "service_id"
    t.index ["on_date"], name: "on_date"
  end

  create_table "connected_service_routes", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "booking_allowed", default: false, null: false
    t.integer "bus_master_route_id"
    t.integer "connected_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_active", default: true, null: false
    t.boolean "is_nearby_route", default: false
    t.boolean "is_primary", default: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_master_route_id"], name: "idx_route_id"
    t.index ["connected_service_id"], name: "idx_connected_service_id"
  end

  create_table "connected_services", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "bus_master_route_id"
    t.integer "connected_city_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "first_service_dropping_point_id"
    t.integer "first_service_id", null: false
    t.integer "from_city_id", null: false
    t.integer "halt_minutes", default: 0
    t.boolean "is_active", default: true
    t.string "route_name", comment: "To identify the full service route"
    t.integer "second_service_boarding_point_id"
    t.integer "second_service_id", null: false
    t.integer "to_city_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_master_route_id"], name: "idx_bus_master_route_id"
    t.index ["first_service_id"], name: "idx_source_service_id"
    t.index ["second_service_id"], name: "idx_destination_service_id"
  end

  create_table "coupe_seat_fares", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_route_id"
    t.integer "coupe_seat_id"
    t.datetime "created_at", precision: nil, null: false
    t.decimal "double_occupancy_fare", precision: 10, scale: 2
    t.date "ondate"
    t.decimal "single_occupancy_fare", precision: 10, scale: 2
    t.boolean "status", default: true
    t.datetime "updated_at", precision: nil, null: false
    t.index ["coupe_seat_id", "ondate", "bus_service_route_id"], name: "idx_coupe_seat_id_ondate_route_id"
    t.index ["coupe_seat_id"], name: "index_coupe_seat_fares_on_coupe_seat_id"
  end

  create_table "coupe_seats", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "bus_seat_id"
    t.integer "bus_service_id"
    t.integer "cabin_legend_id"
    t.string "cabin_types"
    t.datetime "created_at", precision: nil, null: false
    t.float "double_occupancy_rate"
    t.integer "gds_bus_id"
    t.string "seat_no"
    t.float "single_occupancy_rate"
    t.boolean "status", default: true
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id"], name: "index_coupe_seats_on_bus_service_id"
  end

  create_table "crew_do_not_disturbs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "bus_member_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "dnd_status"
    t.datetime "end_time", precision: nil
    t.integer "operating_day_id"
    t.string "reason", limit: 500
    t.datetime "start_time", precision: nil
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_member_id", "operating_day_id"], name: "idx_member_id_op_id"
    t.index ["operating_day_id"], name: "idx_op_id"
  end

  create_table "crew_incentive_payout_details", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.float "amount", null: false
    t.integer "bus_member_id"
    t.string "cancel_reason"
    t.integer "child_operator_id"
    t.string "child_operator_name"
    t.datetime "created_at", precision: nil, null: false
    t.integer "crew_incentive_payout_id", null: false
    t.string "crew_mobile_number", limit: 50
    t.string "crew_name", limit: 50
    t.string "incentive_for", null: false
    t.integer "is_active", limit: 1, default: 1, null: false
    t.date "journey_date", null: false
    t.integer "operator_annexure_id"
    t.integer "operator_id", null: false
    t.string "operator_name", limit: 50, null: false
    t.string "role"
    t.integer "run_child_operator_id"
    t.string "run_child_operator_name"
    t.integer "running_operator_id"
    t.string "running_operator_name", limit: 50
    t.string "service_bus_number", limit: 50
    t.integer "service_id", null: false
    t.string "service_name", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by", limit: 50
  end

  create_table "crew_incentive_payouts", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.float "amount_per_trip", null: false
    t.string "cancel_reason"
    t.datetime "created_at", precision: nil, null: false
    t.date "from_date", null: false
    t.string "incentive_for", limit: 50, null: false
    t.integer "is_active", limit: 1, default: 1, null: false
    t.integer "operator_annexure_id"
    t.integer "operator_id", null: false
    t.string "operator_name", null: false
    t.string "region", limit: 45
    t.string "roles", limit: 45, null: false
    t.string "round_route"
    t.string "route_name", limit: 50, null: false
    t.integer "service_id", null: false
    t.string "service_name", null: false
    t.date "to_date", null: false
    t.float "total_amount", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by", limit: 50
  end

  create_table "crew_incentive_policies", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.date "from_date", null: false
    t.string "incentive_policy", null: false
    t.boolean "is_active", default: true
    t.date "to_date", null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
  end

  create_table "distance_calculation_details", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.date "gps_running_date"
    t.date "timetable_date"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.index ["bus_service_id"], name: "index_distance_calculation_details_on_bus_service_id"
  end

  create_table "dummy", id: false, charset: "latin1", force: :cascade do |t|
    t.date "from_date"
    t.integer "gds_client_id"
    t.string "rate", limit: 45
    t.date "to_date"
  end

  create_table "dynamic_flat_price_services", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_active", default: true
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "eta_gps_routes", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.boolean "active", default: true
    t.datetime "created_at", precision: nil, null: false
    t.bigint "eta_service_id"
    t.datetime "gps_time", precision: nil
    t.decimal "latitude", precision: 12, scale: 8
    t.decimal "longitude", precision: 12, scale: 8
    t.integer "si_no"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["eta_service_id"], name: "idx_eta_service_id"
  end

  create_table "eta_routes", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.boolean "active", default: true
    t.integer "boarding_point_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "eta_gps_route_id"
    t.bigint "eta_service_id"
    t.decimal "nearest_gps_distance", precision: 8, scale: 4
    t.integer "nearest_gps_si_no"
    t.datetime "nearest_gps_time", precision: nil
    t.integer "service_point_id"
    t.string "service_point_name"
    t.datetime "service_point_sch_time", precision: nil
    t.integer "service_point_si_no"
    t.string "service_point_type"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["eta_service_id"], name: "idx_eta_service_id"
  end

  create_table "eta_services", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.boolean "active", default: true
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "imported_by"
    t.datetime "imported_time", precision: nil
    t.date "service_start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id"], name: "idx_bus_service_id"
  end

  create_table "false_fill_masters", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "activated_days", default: 15
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "ff_seat_percentage"
    t.integer "ff_seat_total"
    t.boolean "is_active"
    t.integer "rotation_hour", limit: 1
    t.integer "total_seats"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id", "is_active"], name: "composite_index_ffm"
  end

  create_table "false_fill_seat_details", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "added_through"
    t.datetime "created_at", precision: nil, null: false
    t.integer "false_fill_seat_id"
    t.string "ff_seat_ids"
    t.string "ff_seat_names"
    t.string "stress_seat_ids"
    t.string "stress_seat_names"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["false_fill_seat_id"], name: "composite_index_seat_fares"
  end

  create_table "false_fill_seats", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "false_fill_master_id"
    t.string "ff_seat_ids"
    t.string "ff_seat_names", limit: 251
    t.date "ff_start_date"
    t.datetime "ff_start_time", precision: nil
    t.boolean "is_active"
    t.date "service_start_date", null: false
    t.string "stress_seat_ids", comment: "This is for sciative keys display_seat"
    t.string "stress_seat_names"
    t.text "stress_seat_params"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_through"
    t.index ["bus_service_id", "service_start_date", "is_active"], name: "composite_index_ff_seats"
  end

  create_table "food_stop_operator_share_details", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.decimal "amount", precision: 15, scale: 2
    t.integer "bus_service_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.date "from_date", null: false
    t.integer "operator_id", null: false
    t.integer "rest_id", null: false
    t.string "rest_name"
    t.string "share_type", limit: 45
    t.integer "share_value"
    t.boolean "status"
    t.date "to_date", null: false
    t.datetime "updated_at", precision: nil
    t.index ["bus_service_id", "rest_id", "operator_id"], name: "bus_service_rest_Id_index"
  end

  create_table "gds_bus_child_bus_providers", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "bus_provider_id", null: false
    t.datetime "created_at", precision: nil
    t.date "from_date", null: false
    t.integer "gds_bus_id", null: false
    t.boolean "is_active", default: true
    t.date "to_date", null: false
    t.datetime "updated_at", precision: nil
    t.index ["gds_bus_id", "bus_provider_id", "is_active"], name: "gds_bus_id_bus_provider_id_index"
  end

  create_table "gds_buses", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "ac", limit: 1, default: 0, null: false, comment: "1=AC;0=NON_AC"
    t.boolean "aqi_enabled", default: false
    t.integer "bus_class"
    t.integer "bus_class_id"
    t.string "bus_name"
    t.integer "bus_provider_id"
    t.string "bus_tags"
    t.text "bus_type_ids"
    t.string "bus_type_title"
    t.datetime "created_at", precision: nil, null: false
    t.string "gps_device_imei"
    t.integer "gps_device_provider"
    t.boolean "has_emergency_exit", default: false
    t.integer "has_washroom", limit: 1, default: 0
    t.integer "maker_id"
    t.integer "master_seat_layout_id"
    t.integer "operator_id", null: false
    t.date "registration_date"
    t.string "registration_no", limit: 25, default: "", null: false
    t.integer "seating_type"
    t.integer "status", limit: 1, default: 1, null: false, comment: "1=active;0=inactive"
    t.boolean "unlisted_bus", default: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "vehicle_id"
    t.index ["bus_provider_id"], name: "idx_bus_provider_id"
    t.index ["master_seat_layout_id"], name: "idx_bus_master_seat_layout_id"
    t.index ["registration_no"], name: "idx_registration_no"
  end

  create_table "gds_cities", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "city_hubs"
    t.integer "city_id", null: false
    t.string "city_name", limit: 150, null: false
    t.integer "state_id"
    t.string "zone", limit: 50
    t.integer "zone_id"
  end

  create_table "gds_city_sub_regions", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "city_id", null: false
    t.datetime "created_at", precision: nil
    t.boolean "is_active", default: true
    t.string "region", limit: 100, null: false
    t.datetime "updated_at", precision: nil
    t.index ["city_id", "is_active"], name: "city_id_index"
  end

  create_table "gds_client_booking_base_commissions", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "from_count"
    t.date "from_date"
    t.integer "gds_client_id"
    t.boolean "is_active", default: true
    t.decimal "rate", precision: 6, scale: 2
    t.integer "to_count"
    t.date "to_date"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["gds_client_id"], name: "idx_gds_client_id"
  end

  create_table "gds_client_commission_rates", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.date "from_date", null: false
    t.integer "gds_client_id"
    t.float "rate", default: 0.0
    t.date "to_date", default: "2999-12-31", null: false
    t.datetime "updated_at", precision: nil
  end

  create_table "gds_client_discounts", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "booking_date", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.decimal "discount_amount", precision: 10, scale: 2
    t.decimal "discount_percentage", precision: 10, scale: 2
    t.decimal "effective_list_price", precision: 10, scale: 2
    t.integer "gds_client_id"
    t.string "gds_client_name"
    t.date "journey_date"
    t.string "pnr"
    t.date "service_start_date"
    t.decimal "total_fare", precision: 10, scale: 2
    t.decimal "total_fare_gds", precision: 10, scale: 2
    t.datetime "updated_at", precision: nil, null: false
    t.integer "uploaded_file_id"
    t.index ["pnr"], name: "pnr_UNIQUE", unique: true
    t.index ["uploaded_file_id"], name: "index_gds_client_discounts_on_uploaded_file_id"
  end

  create_table "gds_client_feedback_urls", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "feedback_url", null: false
    t.integer "gds_client_id", null: false
    t.string "pnr", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["gds_client_id"], name: "idx_gds_client_id"
    t.index ["pnr"], name: "idx_pnr"
  end

  create_table "gds_client_tcs_rates", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.float "rate", default: 1.0
    t.datetime "updated_at", precision: nil
  end

  create_table "gds_client_tds_rates", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.date "from_date", null: false
    t.integer "gds_client_id"
    t.float "rate", default: 0.0
    t.date "to_date", default: "2999-12-31", null: false
    t.datetime "updated_at", precision: nil
  end

  create_table "gds_client_wallet_details", id: :integer, charset: "latin1", force: :cascade do |t|
    t.decimal "amount", precision: 15, scale: 2, default: "0.0"
    t.integer "booking_id"
    t.float "cancellation_shared_amt"
    t.string "comment"
    t.float "commission_amt", default: 0.0, comment: "gds_clients.commission_rate * booking.base_fare"
    t.datetime "created_at", precision: nil, null: false
    t.float "discount_amt", default: 0.0
    t.string "discount_type"
    t.integer "event_id"
    t.string "event_type", limit: 100
    t.integer "gds_client_id"
    t.float "gst_on_cancellation_charge"
    t.float "gst_on_cancellation_shared_amt", default: 0.0
    t.float "gst_on_commission", default: 0.0
    t.float "miles_discount_amt"
    t.decimal "net_amount", precision: 19, scale: 2, default: "0.0"
    t.integer "refund_id"
    t.decimal "refundable_amt", precision: 15, scale: 2, default: "0.0", comment: "stores refundable amount of bookings table"
    t.string "seat_names"
    t.decimal "slab_based_commission_amount", precision: 11, scale: 2
    t.float "tcs_amt", default: 0.0, comment: "1% of base fare"
    t.float "tds_amt", default: 0.0, comment: "gds_clients.tds_rate * commission_amt"
    t.integer "transaction_id"
    t.string "txn_type", limit: 45
    t.datetime "updated_at", precision: nil, null: false
    t.index ["booking_id"], name: "idx_booking_id"
    t.index ["gds_client_id"], name: "idx_client_id"
  end

  create_table "gds_client_wallet_recharges", id: :integer, charset: "latin1", force: :cascade do |t|
    t.float "amount"
    t.string "collected_by"
    t.string "comment"
    t.datetime "created_at", precision: nil, null: false
    t.integer "gds_client_id"
    t.string "payment_link"
    t.string "payment_type"
    t.string "reference_id"
    t.string "transaction_type"
    t.string "txn_id"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.index ["gds_client_id"], name: "gds_client_id"
    t.index ["user_id"], name: "user_id"
  end

  create_table "gds_client_wallets", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "gds_client_id"
    t.decimal "net_amount", precision: 19, scale: 2
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "gds_clients", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "authentication_token"
    t.string "block_mirror_service_ids"
    t.text "block_service_ids"
    t.text "communication_emails"
    t.string "company_name"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "credit_commission", default: false
    t.string "email"
    t.boolean "is_btob", default: false
    t.boolean "is_mirror_service_blocked", default: false
    t.boolean "is_slab_based_commision", default: false
    t.string "phone_no"
    t.string "ry_client_id"
    t.string "secret_key"
    t.integer "status", default: 0
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "gds_constants", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "common_name"
    t.datetime "created_at", precision: nil, null: false
    t.string "data_description"
    t.string "image_url"
    t.string "internal_name"
    t.boolean "is_active", default: true
    t.string "key_validation"
    t.string "short_description"
    t.string "short_name"
    t.string "type"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "gds_countries", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "country_name", limit: 150, null: false
    t.string "short_name", limit: 3, null: false
  end

  create_table "gds_event_details", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.date "effective_date"
    t.text "event_data", null: false
    t.string "event_name"
    t.integer "gds_event_id"
    t.datetime "updated_at", precision: nil, null: false
    t.string "user_email"
    t.integer "user_id"
  end

  create_table "gds_events", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "event_description"
    t.string "event_name", null: false
    t.string "event_type", limit: 45
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "gds_group_members", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "accessible_id", null: false
    t.string "accessible_type", null: false
    t.datetime "created_at", precision: nil
    t.datetime "end_date", precision: nil
    t.integer "gds_group_id", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "start_date", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "gds_groups", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "group_name"
    t.boolean "group_status", default: true, null: false
    t.datetime "updated_at", precision: nil
  end

  create_table "gds_images", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "image_name"
    t.string "image_url"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "gds_operation_bus_gps_updates", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gds_operation_bus_service_run_eta", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "gps_time", precision: nil
    t.decimal "nearest_gps_distnace", precision: 8, scale: 4
    t.string "point_name"
    t.string "point_type"
    t.datetime "sch_time", precision: nil
    t.integer "service_point_id"
    t.date "service_start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id", "service_start_date"], name: "idx_service_id_start_date"
  end

  create_table "gds_operators", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "city", limit: 30
    t.integer "city_id"
    t.float "commisions", default: 0.0, null: false
    t.string "country", limit: 30
    t.datetime "created_at", precision: nil, null: false
    t.date "dob"
    t.string "email", limit: 60
    t.string "first_name", limit: 50
    t.string "gds_operator_id", default: "", null: false
    t.string "last_name", limit: 50
    t.string "organisation_name"
    t.string "pan", limit: 10
    t.string "phone", limit: 10
    t.integer "rescheduled_before_hour"
    t.decimal "rescheduled_charges", precision: 6, scale: 2
    t.float "service_tax"
    t.boolean "services_reschedulable", default: false
    t.string "state", limit: 30, default: ""
    t.integer "state_id"
    t.integer "status", default: 0, null: false, comment: "1=active;0=inactive"
    t.string "street_address"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "email"
    t.index ["gds_operator_id"], name: "gds_operator_id"
    t.index ["gds_operator_id"], name: "idx_gds_operator_id"
  end

  create_table "gds_random_numbers", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "random_number"
    t.integer "status", default: 0
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "used_at", precision: nil
    t.index ["random_number"], name: "index_gds_random_numbers_on_random_number"
    t.index ["status"], name: "index_gds_random_numbers_on_status"
  end

  create_table "gds_states", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "country_id", default: 1, null: false
    t.string "state_name", limit: 30, null: false
  end

  create_table "group_cancellation_policies", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "cancellable_id", null: false
    t.string "cancellable_type", null: false
    t.integer "cancellation_policy_id", null: false
    t.datetime "created_at", precision: nil
    t.date "end_date"
    t.boolean "is_active", default: true, null: false
    t.date "start_date"
    t.datetime "updated_at", precision: nil
  end

  create_table "gst_service_mappings", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "gst_type", limit: 100
    t.integer "gst_type_id", null: false
    t.date "ondate"
    t.string "remarks"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "hold_seat_details", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "error", limit: 1000
    t.text "extra_info"
    t.string "hold_type"
    t.datetime "holded_at", precision: nil
    t.string "holded_by"
    t.string "holded_source"
    t.string "reason", limit: 1000
    t.datetime "released_at", precision: nil
    t.string "released_by"
    t.string "released_source"
    t.string "seat_no"
    t.date "service_start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id", "service_start_date"], name: "service_id_service_date"
  end

  create_table "ic_trackings", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "api_name"
    t.integer "api_version", default: 1
    t.integer "boarding_point_id"
    t.string "boarding_point_name"
    t.integer "booking_id"
    t.string "booking_source"
    t.integer "bus_service_id"
    t.integer "bus_service_route_id"
    t.decimal "cancellation_perc", precision: 5, scale: 2
    t.datetime "created_at", precision: nil, null: false
    t.integer "dropping_point_id"
    t.string "dropping_point_name"
    t.text "failed_reason"
    t.integer "from_city_id"
    t.string "from_city_name"
    t.string "gds_booking_id"
    t.integer "gds_client_id"
    t.string "gds_client_name"
    t.boolean "is_cancellable"
    t.boolean "is_success", default: true
    t.date "journey_date"
    t.integer "passenger_size"
    t.string "pnr"
    t.float "refund_amount"
    t.string "remote_ip"
    t.date "request_date"
    t.datetime "request_time", precision: nil
    t.decimal "response_time", precision: 5, scale: 2
    t.boolean "system_calls", default: false
    t.string "tentative_booking_id"
    t.integer "to_city_id"
    t.string "to_city_name"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.string "user_primary_email"
    t.string "user_primary_phone_number"
    t.index ["from_city_id", "to_city_id"], name: "index_trackings_on_from_city_id_and_to_city_id"
    t.index ["gds_booking_id"], name: "idx_gds_booking_id"
    t.index ["gds_client_id"], name: "index_trackings_on_gds_client_id"
    t.index ["journey_date"], name: "index_trackings_on_journey_date"
    t.index ["request_date"], name: "index_trackings_on_request_date"
  end

  create_table "idp_services", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.date "from_date", null: false
    t.boolean "is_active", default: true
    t.date "to_date", null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "intrcity_brands", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "brand_name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "intrcity_lounge_amenities", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "amenity_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "intrcity_lounge_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "intrcity_lounge_media", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "intrcity_lounge_id"
    t.string "media_url"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "intrcity_lounges", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "address"
    t.integer "city_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "landmark"
    t.float "lat"
    t.float "lng"
    t.string "location_url"
    t.string "lounge_operator_internal_name"
    t.string "manager"
    t.integer "manager_id"
    t.string "manager_phone"
    t.string "name"
    t.integer "status", limit: 1, default: 1, null: false, comment: "1=active; 0=inactive"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["city_id"], name: "city_id"
  end

  create_table "jwt_blacklists", charset: "latin1", force: :cascade do |t|
    t.datetime "exp", precision: nil, null: false
    t.string "jti", null: false
    t.index ["jti"], name: "index_jwt_blacklists_on_jti"
  end

  create_table "log_states", charset: "latin1", force: :cascade do |t|
    t.string "change_by"
    t.string "comment", limit: 1000, collation: "utf8mb4_unicode_ci"
    t.datetime "created_at", precision: nil, null: false
    t.string "event_name"
    t.string "from_state"
    t.integer "stateable_id"
    t.string "stateable_type"
    t.string "to_state"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["stateable_type", "stateable_id"], name: "idx_stateable"
  end

  create_table "lounge_admins", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_member_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.date "date", null: false
    t.integer "lounge_id", null: false
    t.boolean "status", default: true
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_member_id"], name: "index_lounge_admins_on_bus_member_id"
    t.index ["lounge_id"], name: "index_lounge_admins_on_operating_day_id"
  end

  create_table "lounge_carton_details", charset: "latin1", force: :cascade do |t|
    t.string "added_by"
    t.integer "balance_stock", default: 0
    t.string "comment"
    t.datetime "created_at", precision: nil, null: false
    t.integer "in_damage", default: 0
    t.integer "in_return", default: 0
    t.integer "in_stock", default: 0
    t.string "item_code"
    t.integer "lounge_carton_id"
    t.integer "sold_out", default: 0
    t.boolean "status", default: true
    t.integer "unaccounted", default: 0
    t.datetime "updated_at", precision: nil, null: false
    t.index ["lounge_carton_id"], name: "index_lounge_carton_deatils_on_lounge_carton_id"
  end

  create_table "lounge_cartons", charset: "latin1", force: :cascade do |t|
    t.string "assigned_code"
    t.integer "assigned_to", default: 0
    t.integer "balance_qty", default: 0
    t.datetime "created_at", precision: nil, null: false
    t.string "created_by"
    t.integer "damaged_qty", default: 0
    t.integer "lounge_id"
    t.integer "returned_qty", default: 0
    t.integer "sold_qty", default: 0
    t.integer "status", default: 0
    t.integer "total_qty", default: 0
    t.integer "unaccounted_qty", default: 0
    t.datetime "updated_at", precision: nil, null: false
    t.index ["lounge_id"], name: "index_lounge_cartons_on_lounge_id"
  end

  create_table "lounge_file_accesses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.boolean "deleted"
    t.integer "file_id"
    t.integer "lounge_id"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.index ["file_id"], name: "idx_file_id"
    t.index ["lounge_id"], name: "idx_lounge_id"
  end

  create_table "lounge_files", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "content_type"
    t.datetime "created_at", precision: nil, null: false
    t.integer "duration"
    t.float "file_size"
    t.boolean "published"
    t.string "title"
    t.datetime "updated_at", precision: nil, null: false
    t.string "uploaded_by"
    t.string "url"
  end

  create_table "lounge_inventories", charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "in_stock", default: 0
    t.string "item_code"
    t.integer "lounge_id"
    t.boolean "status", default: true
    t.datetime "updated_at", precision: nil, null: false
    t.index ["lounge_id"], name: "index_lounge_inventories_on_lounge_id"
  end

  create_table "lounge_inventory_details", charset: "latin1", force: :cascade do |t|
    t.string "comment"
    t.datetime "created_at", precision: nil, null: false
    t.integer "in_stock"
    t.string "item_code"
    t.string "item_lot_no"
    t.integer "lounge_id"
    t.integer "net_stock", default: 0
    t.string "stock_type"
    t.string "supply_by"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "warehouse_id"
    t.index ["lounge_id", "item_code"], name: "idx_lounge_id_item_code"
    t.index ["lounge_id"], name: "index_lounge_inventory_details_on_lounge_id"
  end

  create_table "lounge_lots", charset: "latin1", force: :cascade do |t|
    t.string "comment"
    t.datetime "created_at", null: false
    t.integer "product_id"
    t.integer "qty"
    t.datetime "updated_at", null: false
    t.integer "warehouse_consignment_id"
    t.string "warehouse_lot_id", limit: 15
    t.integer "warehouse_return_detail_id"
  end

  create_table "master_mirror_services", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.boolean "booking_on_master_service_only", default: true
    t.boolean "chart_xfers_status"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_active", default: false
    t.text "master_booking_desc"
    t.integer "master_service_id"
    t.integer "mirror_service_id"
    t.datetime "schedule_chart_xfers_at", precision: nil
    t.date "service_start_date", null: false
    t.datetime "stop_and_schedule_chart_xfers_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "updated_by"
    t.string "updated_reason"
    t.index ["master_service_id"], name: "idx_master_service_id"
    t.index ["mirror_service_id"], name: "idx_mirror_service_id"
    t.index ["service_start_date"], name: "idx_service_start_date"
  end

  create_table "master_route_other_charges", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "bus_master_route_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_active", default: true, null: false
    t.string "other_charges_type_ids", limit: 50, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_master_route_id", "is_active"], name: "composite_index_dates"
    t.index ["bus_master_route_id"], name: "idx_route_id"
  end

  create_table "master_seat_layouts", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_seating_type_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "left_side_rows"
    t.integer "levels"
    t.text "raw_seat_layout"
    t.integer "right_side_rows"
    t.text "seat_layout"
    t.integer "seaters"
    t.integer "semi_sleepers"
    t.integer "sleepers"
    t.integer "status"
    t.string "title"
    t.integer "total_seats"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "vehicle_type", default: 0, comment: "0 For Bus Seat Layout, 1 for van seat layout"
  end

  create_table "member_offline_targets", id: :integer, charset: "latin1", force: :cascade do |t|
    t.decimal "agent_fill_target", precision: 10, scale: 2
    t.integer "agent_rev_target"
    t.integer "asp"
    t.integer "buses_no"
    t.decimal "central_rev_contribution", precision: 10, scale: 2
    t.datetime "created_at", precision: nil
    t.decimal "d2c_fill_target", precision: 10, scale: 2
    t.decimal "d2c_rev_target", precision: 10, scale: 2
    t.integer "daily_invt"
    t.integer "daily_revenue_target"
    t.date "from_date"
    t.decimal "offline_fill_target", precision: 10, scale: 2
    t.decimal "offline_rev_target", precision: 10, scale: 2
    t.boolean "offline_targets_type", default: false
    t.string "route", limit: 45
    t.integer "row_id"
    t.string "service_name"
    t.date "to_date"
    t.datetime "updated_at", precision: nil
  end

  create_table "message_routes", charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "message_id"
    t.integer "route_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["message_id"], name: "index_message_routes_on_message_id"
    t.index ["route_id"], name: "index_message_routes_on_route_id"
  end

  create_table "metro_api_trackings", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "api_error_count", default: 0
    t.string "api_name"
    t.json "api_response"
    t.integer "api_status", default: 0
    t.string "api_url"
    t.bigint "booking_id"
    t.datetime "call_api_at", precision: nil
    t.integer "city_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "metro_operator_id"
    t.integer "point_type"
    t.json "request_params"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["booking_id", "call_api_at", "api_status"], name: "idx_booking_status_call_api"
    t.index ["booking_id"], name: "idx_booking"
  end

  create_table "metro_operators", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "metro_stations", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "city_id"
    t.json "colour_rgb_code"
    t.datetime "created_at", precision: nil, null: false
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.string "metro_system", limit: 45
    t.string "state", limit: 45
    t.string "station_code", limit: 45
    t.json "station_colour_name"
    t.string "station_name"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["city_id"], name: "idx_city_id"
    t.index ["city_id"], name: "index_metro_stations_on_city_id"
  end

  create_table "mirror_service_blocked_clients", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "gds_client_id"
    t.boolean "is_blocked", default: true
    t.integer "master_mirror_service_id"
    t.datetime "updated_at", precision: nil
    t.string "updated_by"
    t.index ["gds_client_id"], name: "idx_client_id"
    t.index ["master_mirror_service_id"], name: "idx_mm_service_id"
  end

  create_table "money_collections", charset: "latin1", force: :cascade do |t|
    t.integer "amount"
    t.datetime "approved_at", precision: nil
    t.string "approved_by"
    t.integer "collection_status"
    t.integer "collection_type"
    t.string "comment", limit: 1000
    t.datetime "created_at", precision: nil, null: false
    t.string "document_url", limit: 1000
    t.string "mobile_number"
    t.integer "otp"
    t.datetime "otp_sent_at", precision: nil
    t.datetime "otp_verified_at", precision: nil
    t.bigint "receiver_id"
    t.string "receiver_type"
    t.bigint "sender_id"
    t.string "sender_type"
    t.string "transaction_type"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["receiver_type", "receiver_id"], name: "index_money_collections_on_receiver_type_and_receiver_id"
    t.index ["sender_type", "sender_id"], name: "index_money_collections_on_sender_type_and_sender_id"
  end

  create_table "monthly_upgrade_annexures", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.float "advance_deduction"
    t.float "already_paid_amount"
    t.integer "approved", limit: 1, default: 0
    t.integer "booked_seat"
    t.integer "bus_provider_trip_id"
    t.float "commission_amount"
    t.float "commission_per"
    t.string "commission_slab"
    t.datetime "created_at", precision: nil, null: false
    t.float "defective_seats_deduction"
    t.float "expense_deduction"
    t.date "from_date"
    t.float "net_amount"
    t.float "net_collection"
    t.float "net_collection_exc_gst"
    t.integer "operator_id"
    t.string "operator_name"
    t.float "os_deduction"
    t.float "other_addition"
    t.float "other_deduction"
    t.float "payable_amount"
    t.float "penalty_deduction"
    t.string "prorated_commission_slab"
    t.float "prorated_target_slab"
    t.integer "provider_type", default: 0
    t.string "receipt_url"
    t.datetime "sent_on", precision: nil
    t.string "service_ids", collation: "utf8mb3_general_ci"
    t.float "standing_fee"
    t.integer "status", default: 1
    t.float "target_slab"
    t.float "tcs"
    t.float "tds"
    t.date "to_date"
    t.float "total_amount"
    t.integer "trip_count"
    t.string "trip_name", collation: "utf8mb3_general_ci"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "nearby_cities", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "city_id"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_active", default: true
    t.integer "near_city_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "nps_survey_data", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "about_exprience", collation: "utf8mb3_unicode_ci"
    t.integer "booking_source", default: 0, null: false, comment: "1-Others, 2-Paytm, 3-Intrcity_android, 4-Intrcity_ios, 5-intrcity_windows, 6-intrcity_mweb, 7-intrcity_desktopweb, 8-intrcity_others, 9-ry_android, 10-ry_ios, 11-ry_windows, 12-ry_mweb, 13-ry_desktopweb, 14-ry_others "
    t.string "bus_number", collation: "utf8mb3_unicode_ci"
    t.string "bus_operator", collation: "utf8mb3_unicode_ci"
    t.string "bus_route", collation: "utf8mb3_unicode_ci"
    t.string "bus_time", collation: "utf8mb3_unicode_ci"
    t.integer "common_survey_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "date", precision: nil
    t.string "destination_city_id", collation: "utf8mb3_unicode_ci"
    t.datetime "doj", precision: nil
    t.integer "ecomm"
    t.text "improve_services", collation: "utf8mb3_unicode_ci"
    t.boolean "mentis"
    t.text "other_improve_services", collation: "utf8mb3_unicode_ci"
    t.string "pnr", collation: "utf8mb3_unicode_ci"
    t.integer "primary_route_id"
    t.integer "rating"
    t.integer "service_id", default: 0, null: false, comment: "0-no service id found in smart_bus_trips"
    t.boolean "smartbus"
    t.string "source_city_id", collation: "utf8mb3_unicode_ci"
    t.boolean "status"
    t.string "trip_id"
    t.datetime "updated_at", precision: nil, null: false
    t.string "user_email", collation: "utf8mb3_unicode_ci"
    t.integer "user_id"
    t.string "user_mobile", collation: "utf8mb3_unicode_ci"
    t.string "user_name", collation: "utf8mb3_unicode_ci"
    t.index ["booking_source"], name: "booking_source"
    t.index ["service_id"], name: "service_id"
  end

  create_table "nps_survey_responses", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "eight_rating_count", default: 0
    t.integer "five_rating_count", default: 0
    t.integer "four_rating_count", default: 0
    t.text "needs_improvement"
    t.integer "nine_rating_count", default: 0
    t.integer "one_rating_count", default: 0
    t.date "service_start_date"
    t.integer "seven_rating_count", default: 0
    t.integer "six_rating_count", default: 0
    t.integer "ten_rating_count", default: 0
    t.integer "three_rating_count", default: 0
    t.text "top_five_liked"
    t.integer "total_survey_count"
    t.integer "two_rating_count", default: 0
    t.datetime "updated_at", precision: nil, null: false
    t.integer "zero_rating_count", default: 0
  end

  create_table "offline_booking_target_achievements", id: :integer, charset: "latin1", force: :cascade do |t|
    t.decimal "bp_list_price", precision: 15, scale: 2, default: "0.0"
    t.decimal "bp_net_sales", precision: 15, scale: 2, default: "0.0"
    t.decimal "bp_seat_count", precision: 10
    t.decimal "cb_list_price", precision: 15, scale: 2, default: "0.0"
    t.decimal "cb_net_sales", precision: 15, scale: 2, default: "0.0"
    t.decimal "cb_seat_count", precision: 10
    t.datetime "created_at", precision: nil, null: false
    t.decimal "dc_list_price", precision: 15, scale: 2, default: "0.0"
    t.decimal "dc_net_sales", precision: 15, scale: 2, default: "0.0"
    t.decimal "dc_seat_count", precision: 10
    t.integer "manager_id"
    t.string "partner_agency"
    t.string "partner_city"
    t.integer "partner_id"
    t.string "partner_manager"
    t.string "partner_mobile"
    t.string "partner_poc"
    t.date "service_start_date"
    t.decimal "total_list_price", precision: 15, scale: 2, default: "0.0"
    t.decimal "total_net_sales", precision: 15, scale: 2, default: "0.0"
    t.decimal "total_seat_count", precision: 10
    t.datetime "updated_at", precision: nil, null: false
    t.string "week_year"
  end

  create_table "offline_booking_targets", id: :integer, charset: "latin1", force: :cascade do |t|
    t.decimal "bp_target_per", precision: 6, scale: 2, default: "0.0"
    t.integer "bus_service_id"
    t.decimal "cb_target_per", precision: 6, scale: 2, default: "0.0"
    t.datetime "created_at", precision: nil, null: false
    t.decimal "daily_bp_rev_target", precision: 15, scale: 2, default: "0.0"
    t.decimal "daily_cb_rev_target", precision: 15, scale: 2, default: "0.0"
    t.decimal "daily_dc_rev_target", precision: 15, scale: 2, default: "0.0"
    t.integer "daily_invt"
    t.decimal "daily_rev_target", precision: 15, scale: 2, default: "0.0"
    t.decimal "daily_total_rev_target", precision: 15, scale: 2, default: "0.0"
    t.decimal "dc_target_per", precision: 6, scale: 2, default: "0.0"
    t.integer "intrcity_brand_id"
    t.integer "manager_id"
    t.string "manager_name"
    t.decimal "monthly_bp_rev_target", precision: 15, scale: 2, default: "0.0"
    t.decimal "monthly_cb_rev_target", precision: 15, scale: 2, default: "0.0"
    t.decimal "monthly_dc_rev_target", precision: 15, scale: 2, default: "0.0"
    t.integer "monthly_invt"
    t.decimal "monthly_rev_target", precision: 15, scale: 2, default: "0.0"
    t.decimal "monthly_total_rev_target", precision: 15, scale: 2, default: "0.0"
    t.string "round_route"
    t.string "round_trip_zone"
    t.string "route"
    t.integer "route_id"
    t.string "service_name"
    t.date "service_start_date"
    t.string "source_city", limit: 245
    t.string "state"
    t.string "sub_zone"
    t.decimal "total_target_per", precision: 6, scale: 2, default: "0.0"
    t.datetime "updated_at", precision: nil, null: false
    t.string "zone"
  end

  create_table "offline_targets", id: :integer, charset: "latin1", force: :cascade do |t|
    t.decimal "agent_fill_target", precision: 10, scale: 2
    t.integer "agent_rev_target"
    t.integer "asp"
    t.integer "buses_no"
    t.decimal "central_rev_contribution", precision: 10, scale: 2
    t.datetime "created_at", precision: nil
    t.decimal "d2c_fill_target", precision: 10, scale: 2
    t.decimal "d2c_rev_target", precision: 10, scale: 2
    t.integer "daily_invt"
    t.integer "daily_revenue_target"
    t.date "from_date"
    t.decimal "offline_fill_target", precision: 10, scale: 2
    t.decimal "offline_rev_target", precision: 10, scale: 2
    t.string "offline_target_type", limit: 20
    t.integer "target_id"
    t.string "target_name"
    t.string "target_type", limit: 100
    t.date "to_date"
    t.datetime "updated_at", precision: nil
  end

  create_table "ondc_booking_settlements", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "bap_id", null: false
    t.float "counterparty_diff_amount"
    t.string "counterparty_recon_status", limit: 45
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.float "diff_amount"
    t.string "invoice_no"
    t.text "message"
    t.string "message_id", null: false
    t.integer "ondc_booking_id"
    t.float "order_amount"
    t.string "order_id", null: false
    t.float "payment_amount"
    t.string "payment_collected_by", limit: 45
    t.string "payment_status", limit: 45
    t.string "payment_transaction_id"
    t.string "payment_type", limit: 45
    t.string "recon_status", limit: 45
    t.float "settlement_amount"
    t.string "settlement_id"
    t.text "settlement_order"
    t.string "settlement_reference_no"
    t.string "transaction_id", null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
  end

  create_table "ondc_bookings", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "bap_id"
    t.float "base_fare"
    t.string "booking_status", limit: 45
    t.float "buyer_finder_fee_amount"
    t.string "buyer_finder_fee_type", limit: 45
    t.float "buyer_finder_fee_value"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.string "gds_block_key"
    t.string "gds_booking_id"
    t.text "order_json", size: :long
    t.float "payment_amount"
    t.string "payment_collected_by", limit: 45
    t.string "payment_status", limit: 45
    t.string "payment_transaction_id"
    t.string "payment_type", limit: 45
    t.float "service_charge"
    t.float "service_tax"
    t.float "settlement_amount"
    t.datetime "settlement_at", precision: nil
    t.string "settlement_status", limit: 45
    t.string "settlement_window", limit: 45
    t.string "ticket_pnr", limit: 45
    t.float "total_fare"
    t.string "transaction_id"
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
  end

  create_table "open_gds_available_trips", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "destination", limit: 105
    t.integer "destination_city_id"
    t.date "doj"
    t.text "gds_response"
    t.string "gds_trip_id", limit: 45
    t.string "nxs_trip_id"
    t.integer "operator_id"
    t.string "source", limit: 105
    t.integer "source_city_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["gds_trip_id"], name: "idx_gds_available_trips_gds_trip_id"
    t.index ["nxs_trip_id"], name: "nxs_trip_id"
  end

  create_table "open_gds_clients", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "alias_name"
    t.string "company_name"
    t.datetime "created_at", precision: nil, null: false
    t.integer "gds_client_id", limit: 1
    t.string "operator_alias_names"
    t.string "opg_client_id"
    t.boolean "opg_client_status", default: true
    t.integer "opg_operator_id"
    t.string "opg_secret_key"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "operating_days", id: :integer, charset: "latin1", force: :cascade do |t|
    t.decimal "booked_seats_amount", precision: 15, scale: 2
    t.integer "booked_seats_count"
    t.boolean "booking_stopped", default: false
    t.datetime "booking_stopped_at", precision: nil
    t.text "call_divert"
    t.string "cancellable_type"
    t.string "cancellation_reason"
    t.integer "cancellation_type"
    t.datetime "cancelled_at", precision: nil
    t.integer "cancelled_by"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "dont_send_luggage_wa"
    t.integer "dstn_service_point_id"
    t.text "extra_info"
    t.date "from_date"
    t.integer "has_gst", limit: 1, default: 1, comment: "By this column we decide whether gst_option is applicable ?"
    t.boolean "is_cancelled", default: false
    t.boolean "is_mirror_service", default: false
    t.date "on_date"
    t.integer "service_id"
    t.integer "src_service_point_id"
    t.integer "status", limit: 1, default: 1, null: false, comment: "1=Enable | 0= disable"
    t.date "to_date"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.index ["service_id", "on_date"], name: "idx_operating_days_service_id_on_date"
    t.index ["service_id"], name: "service_id"
  end

  create_table "operation_report_recipients", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "cc_email"
    t.datetime "created_at", precision: nil, null: false
    t.text "recipient_email", null: false
    t.string "report_name", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["id"], name: "id_UNIQUE", unique: true
  end

  create_table "operator_advances", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "added_by"
    t.decimal "amount", precision: 10, scale: 2, default: "0.0"
    t.datetime "approved_at", precision: nil
    t.string "approved_by"
    t.string "approver_email"
    t.integer "bus_provider_id"
    t.integer "child_bus_provider_id"
    t.datetime "created_at", precision: nil
    t.string "event"
    t.integer "operator_annexure_id"
    t.text "remarks"
    t.integer "status", default: 0
    t.date "transaction_date"
    t.string "transaction_type", limit: 45
    t.datetime "updated_at", precision: nil
    t.string "updated_by"
  end

  create_table "operator_annexures", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.float "advance_deduction"
    t.text "advance_deduction_text"
    t.float "advance_mg_deduction"
    t.text "advance_mg_deduction_text"
    t.integer "approved", default: 0
    t.integer "booked_seat"
    t.integer "bus_provider_trip_id"
    t.float "cargo_adjustment_deduction"
    t.text "cargo_adjustment_deduction_text"
    t.float "cargo_share_addition"
    t.text "cargo_share_addition_text"
    t.integer "child_operator_id"
    t.string "child_operator_name"
    t.datetime "created_at", precision: nil, null: false
    t.float "defective_seats_deduction"
    t.float "expense_deduction"
    t.text "expense_deduction_text", collation: "utf8mb3_general_ci"
    t.float "fastag_adjustment_deduction"
    t.text "fastag_adjustment_deduction_text"
    t.float "food_stop_share"
    t.date "from_date"
    t.float "indo_rail_commission"
    t.float "invoice_deduction"
    t.float "liquiconnect_adjustment_deduction"
    t.text "liquiconnect_adjustment_deduction_text"
    t.float "manual_halt_charge_addition"
    t.text "manual_halt_charge_addition_text"
    t.float "manual_penalty_deduction"
    t.text "manual_penalty_deduction_text"
    t.float "match_existing_mg_addition"
    t.text "match_existing_mg_addition_text"
    t.float "match_existing_mg_deduction"
    t.text "match_existing_mg_deduction_text"
    t.float "mg"
    t.float "mg_profit"
    t.float "net_amount"
    t.float "net_collection"
    t.float "net_collection_exc_gst"
    t.integer "operator_id"
    t.string "operator_name"
    t.float "operator_share"
    t.float "os_deduction"
    t.text "os_deduction_text"
    t.float "other_addition"
    t.text "other_addition_text"
    t.float "other_deduction"
    t.string "other_deduction_text"
    t.float "penalty_deduction"
    t.float "penalty_reversal_addition"
    t.text "penalty_reversal_addition_text"
    t.integer "provider_type", default: 0
    t.string "receipt_url"
    t.float "refund_addition"
    t.text "refund_addition_text"
    t.float "refund_deduction"
    t.text "refund_deduction_text"
    t.float "round_trip_count"
    t.datetime "sent_on", precision: nil
    t.float "staff_incentive"
    t.float "standing_fee"
    t.integer "status", default: 1
    t.float "tcs"
    t.float "tds"
    t.date "to_date"
    t.float "total_amount"
    t.string "trip_name", collation: "utf8mb3_general_ci"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by", default: "system"
    t.float "van_cost_deduction"
    t.text "van_cost_deduction_text"
    t.float "van_mg_amount", default: 0.0
  end

  create_table "operator_bus_providers", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_provider_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "gds_operator_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "operator_cities", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "city_id"
    t.string "city_name"
    t.datetime "created_at", precision: nil, null: false
    t.integer "gds_state_id"
    t.integer "operator_id"
    t.string "state_name"
    t.integer "status", limit: 1, default: 1, null: false, comment: "1=active;0=inactive"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["city_id"], name: "idx_city_id"
    t.index ["operator_id"], name: "op_id"
  end

  create_table "operator_expenses", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "added_by"
    t.datetime "approved_at", precision: nil
    t.string "approved_by"
    t.string "approver_email"
    t.integer "bus_provider_id"
    t.integer "child_bus_provider_id"
    t.string "comment", limit: 1000
    t.float "cost_per_unit"
    t.float "cost_per_unit_ex_gst"
    t.datetime "created_at", precision: nil
    t.string "event"
    t.date "expense_date"
    t.float "gst_amount"
    t.string "invoice_url"
    t.integer "operator_annexure_id"
    t.integer "operator_product_id"
    t.integer "quantity"
    t.text "remarks"
    t.integer "status", default: 0
    t.float "total_cost"
    t.float "total_cost_ex_gst"
    t.string "transaction_type", limit: 45
    t.datetime "updated_at", precision: nil
    t.string "updated_by"
  end

  create_table "operator_invoices", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.float "advance_deduction"
    t.float "advance_mg_deduction"
    t.datetime "created_at", precision: nil, null: false
    t.integer "day1_trip"
    t.float "day1_trip_fare"
    t.integer "day2_trip"
    t.float "day2_trip_fare"
    t.integer "day3_trip"
    t.float "day3_trip_fare"
    t.integer "day4_trip"
    t.float "day4_trip_fare"
    t.integer "day5_trip"
    t.float "day5_trip_fare"
    t.integer "day6_trip"
    t.float "day6_trip_fare"
    t.integer "day7_trip"
    t.float "day7_trip_fare"
    t.date "from_date"
    t.float "invoice_deduction"
    t.float "mg"
    t.float "mg_profit"
    t.float "net_amount"
    t.integer "operator_id"
    t.string "operator_name"
    t.float "operator_share"
    t.float "os_deduction"
    t.float "other_addition"
    t.float "penalty_deduction"
    t.string "receipt_url"
    t.datetime "sent_on", precision: nil
    t.string "service_id"
    t.string "service_route"
    t.float "standing_fee"
    t.integer "status", default: 1
    t.float "tcs"
    t.float "tds"
    t.date "to_date"
    t.float "total_amount"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "operator_pay_receipts", charset: "latin1", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.timestamp "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.text "email_send_to"
    t.date "from_date"
    t.integer "operator_id", null: false, comment: "0-only if operator name is only found"
    t.string "operator_name", null: false
    t.text "receipt_url"
    t.date "to_date"
    t.boolean "type_of_receipt", default: true, comment: "1-settlement_receipt"
    t.timestamp "updated_at", default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }, null: false
  end

  create_table "operator_payout_details", charset: "latin1", force: :cascade do |t|
    t.integer "booked_seat"
    t.string "bus_number"
    t.datetime "created_at", precision: nil, null: false
    t.integer "extra_seats_bought_from_operator", default: 0
    t.float "extra_seats_bought_total_amt", default: 0.0
    t.integer "extra_seats_sold_to_operator", default: 0
    t.float "extra_seats_sold_total_amt", default: 0.0
    t.integer "inventory_operator"
    t.integer "inventory_ry"
    t.float "invoice_deduct_amount", default: 0.0, null: false
    t.date "journey_date"
    t.integer "list_price"
    t.decimal "minimum_gurantee", precision: 8, scale: 2
    t.integer "net_collection"
    t.string "operator_display_name", default: "", null: false, comment: "To show operator registered name"
    t.string "operator_email", default: "", null: false, comment: "Add only operator email to send emails"
    t.float "operator_fill_rate"
    t.integer "operator_id", default: 0, null: false
    t.string "operator_name"
    t.boolean "payment_status", default: false
    t.float "penalty_amt", default: 0.0
    t.integer "service_id", default: 0, null: false, comment: "0-for mantis operators"
    t.string "service_name", default: "", comment: "ty_service_id for mantis"
    t.float "standing_fee", default: 0.0
    t.float "total_operator_payout"
    t.integer "total_seats"
    t.string "trip_cancellation_reason"
    t.boolean "trip_status", default: true
    t.datetime "updated_at", precision: nil, null: false
    t.index ["journey_date", "service_id", "service_name"], name: "idx_operator_payout_details_journey_date_service_id_service_name", unique: true
    t.index ["service_id"], name: "idx_operator_payout_details_service_id"
  end

  create_table "operator_products", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "product_name"
    t.integer "status", default: 1
    t.datetime "updated_at", precision: nil
  end

  create_table "operator_service_trips", charset: "latin1", force: :cascade do |t|
    t.float "add_on_amount"
    t.integer "booked_seat"
    t.string "bus_maker"
    t.string "bus_number"
    t.string "bus_types"
    t.float "cancellation_amount"
    t.integer "child_operator_id"
    t.string "child_operator_name"
    t.datetime "created_at", precision: nil, null: false
    t.float "customer_price_inc_gst"
    t.string "day_service_type"
    t.integer "defective_seats"
    t.float "defective_seats_amount"
    t.float "feeder_bus_service_charge_inc_gst"
    t.float "gds_commission"
    t.integer "gst_for_billing"
    t.float "indo_rail_commission"
    t.float "invoice_deduct_amount", default: 0.0, null: false
    t.text "invoice_deduction_comment"
    t.date "journey_date"
    t.float "list_price_inc_gst"
    t.float "minimum_guarantee_for_profit_share"
    t.decimal "minimum_gurantee", precision: 8, scale: 2
    t.float "minimum_profit_guarantee"
    t.float "net_amount"
    t.float "net_collection"
    t.float "net_collection_exc_gst"
    t.integer "operator_annexure_id"
    t.float "operator_fill_rate"
    t.integer "operator_id", default: 0, null: false
    t.string "operator_name"
    t.integer "provider_type", default: 0
    t.string "round_route"
    t.string "run_bus_number"
    t.integer "run_child_operator_id"
    t.string "run_child_operator_name"
    t.integer "run_operator_id"
    t.string "run_operator_name"
    t.integer "service_id", default: 0, null: false
    t.string "service_name", default: ""
    t.float "standing_fee", default: 0.0
    t.float "target_revenue_inc_gst"
    t.float "tcs"
    t.float "tds"
    t.float "toll_amount"
    t.integer "total_seats"
    t.integer "trip_id"
    t.string "trip_name"
    t.boolean "trip_status", default: true
    t.datetime "updated_at", precision: nil, null: false
    t.string "zone"
    t.index ["journey_date", "service_id"], name: "idx_operator_service_trips_journey_date_service_id", unique: true
    t.index ["service_id"], name: "idx_operator_service_trips_service_id"
  end

  create_table "operator_service_van_trips", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "bus_member_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "operator_service_trip_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "van_cost_type", limit: 45, null: false
    t.integer "van_id", null: false
    t.float "van_minimum_gurantee", null: false
    t.string "van_number", limit: 55, null: false
    t.integer "van_provider_agreement_id", null: false
    t.integer "van_provider_id", null: false
    t.string "van_provider_name", null: false
    t.string "van_provider_type", null: false
    t.integer "van_service_route_mapping_id", null: false
    t.string "van_service_type", limit: 55, null: false
    t.date "van_start_date"
    t.float "van_trip_cost_per_trip", default: 0.0, null: false
    t.boolean "van_trip_status", null: false
  end

  create_table "operator_shops", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "city", limit: 30
    t.string "country", limit: 30
    t.datetime "created_at", precision: nil, null: false
    t.string "description"
    t.string "landmark"
    t.float "lat"
    t.float "lng"
    t.string "name"
    t.integer "operator_id"
    t.string "phone", limit: 11, default: ""
    t.string "state", limit: 30
    t.integer "status", limit: 1, default: 1, null: false, comment: "1=active;0=inactive"
    t.string "street_address"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["operator_id"], name: "operator_id"
  end

  create_table "other_charges_types", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "charges_mode", limit: 10, default: "flat", comment: "flat or percentage"
    t.string "charges_type", limit: 100, null: false
    t.boolean "client_base_change", default: true
    t.datetime "created_at", precision: nil, null: false
    t.string "gds_client_ids", comment: "client ids will be in string"
    t.boolean "is_active", default: true
    t.boolean "is_markup", default: false, comment: "add 5 percent gst on it"
    t.boolean "is_refundable"
    t.integer "max_limit"
    t.integer "rate_or_amount"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by", limit: 100
    t.date "valid_from", null: false
    t.date "valid_to", null: false
  end

  create_table "passenger_captain_communications", charset: "latin1", force: :cascade do |t|
    t.integer "comm_type"
    t.datetime "created_at", precision: nil, null: false
    t.string "pnr"
    t.string "status"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "passenger_captain_messages", charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "message_type"
    t.string "pnr"
    t.string "send_by"
    t.integer "smart_bus_trip_passenger_id"
    t.text "text"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "passenger_details", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "address"
    t.integer "age"
    t.float "backup_seat_fare"
    t.datetime "backup_seat_fare_date", precision: nil
    t.string "boarding_status"
    t.integer "booking_id"
    t.string "booking_type", limit: 100
    t.integer "bus_seat_id"
    t.string "cabin_type", limit: 45
    t.datetime "cancelled_at", precision: nil
    t.string "cancelled_by"
    t.float "cancelled_charge"
    t.string "country_code", limit: 45, default: "+91"
    t.integer "coupe_seat_id"
    t.string "coupe_seat_name"
    t.datetime "created_at", precision: nil, null: false
    t.string "email"
    t.float "fare"
    t.string "gender", limit: 20
    t.string "id_number"
    t.string "id_type"
    t.boolean "is_coupe_seat_copy", default: false
    t.boolean "is_shared"
    t.string "iso_code", limit: 45, default: "IN"
    t.string "main_passenger"
    t.float "other_charges_amount"
    t.string "passenger_name", limit: 100
    t.string "phone_no", limit: 50
    t.float "point_charges"
    t.float "refunded_amount"
    t.text "seat_comments"
    t.float "seat_discount", default: 0.0
    t.float "seat_fare"
    t.datetime "seat_fare_date", precision: nil
    t.string "seat_fare_source_email"
    t.string "seat_legend"
    t.string "seat_no", limit: 10
    t.string "seat_short_legend", limit: 45
    t.float "seat_total_fare", default: 0.0
    t.float "service_tax", default: 0.0
    t.integer "status", limit: 1, comment: "['BLOCKED', 'CONFIRMED', 'CANCELLED', 'UNBLOCKED', 'HOLD', 'NOTREPORTED', 'RESERVED', 'RELEASED', 'RESCHEDULED']"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["booking_id"], name: "idx_booking_id"
    t.index ["booking_id"], name: "index_passenger_details_on_booking_id"
    t.index ["bus_seat_id"], name: "idx_bus_seat_id"
    t.index ["bus_seat_id"], name: "index_passenger_details_on_bus_seat_id"
    t.index ["coupe_seat_id"], name: "idx_coupe_seat_id"
    t.index ["status"], name: "idx_status"
  end

  create_table "passenger_logs", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "booking_id"
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.text "json", size: :long
    t.integer "log_status", limit: 1
    t.string "new_seat_numbers"
    t.string "new_service_name"
    t.integer "passenger_detail_id"
    t.string "pnr", limit: 45
    t.string "seat_numbers"
    t.date "service_start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.string "user_type", limit: 100, default: "User"
    t.index ["booking_id"], name: "idx_booking_id"
    t.index ["passenger_detail_id"], name: "index_passenger_logs_on_passenger_detail_id"
    t.index ["user_id"], name: "user_id"
  end

  create_table "penalties", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "allowed_user_values"
    t.datetime "created_at", precision: nil
    t.boolean "default", default: false
    t.string "default_penalty_for", limit: 45
    t.text "description"
    t.string "exemption_type", limit: 45
    t.integer "exemption_value"
    t.string "journey_status", limit: 45
    t.string "name"
    t.integer "parent_id"
    t.string "penalty_code", limit: 45
    t.string "penalty_on", limit: 45
    t.string "penalty_on_type", limit: 45
    t.decimal "penalty_on_value", precision: 15, scale: 2
    t.string "penalty_tag"
    t.string "penalty_type", limit: 45
    t.string "penalty_value"
    t.boolean "status", default: true
    t.string "suggestive_value"
    t.datetime "updated_at", precision: nil
    t.index ["parent_id"], name: "parent_id_index"
  end

  create_table "penalty_reasons", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_active", default: false
    t.string "penalty_type"
    t.string "tag_name"
    t.string "tag_value"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "permission_lists", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "menu_id"
    t.string "name"
    t.integer "permission_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["permission_id"], name: "permission_id"
  end

  create_table "permission_roles", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_create"
    t.boolean "is_delete"
    t.boolean "is_read"
    t.boolean "is_update"
    t.integer "permission_id"
    t.integer "permission_list_id"
    t.integer "role_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["permission_id"], name: "permission_id"
    t.index ["role_id"], name: "role_id"
  end

  create_table "permissions", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "action"
    t.string "controller_name"
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.integer "permission_list_id"
    t.string "permission_type"
    t.string "subject_class"
    t.string "ui_actions"
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "verified", default: false
  end

  create_table "point_image_videos", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "boarding_point_id"
    t.string "category", limit: 100
    t.datetime "created_at", precision: nil, null: false
    t.text "desc"
    t.boolean "is_active", default: true, null: false
    t.text "long_url"
    t.string "media_type", limit: 45
    t.string "short_url"
    t.integer "sl_no"
    t.string "thumbnail"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["boarding_point_id"], name: "index_point_image_videos_on_boarding_point_id"
  end

  create_table "point_search_names", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "boarding_point_ids"
    t.integer "city_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "is_active", limit: 1, default: 1, null: false, comment: "1=active;0=inactive"
    t.string "point_name", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["point_name"], name: "point_name"
  end

  create_table "points_metro_stations", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "boarding_point_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "metro_station_id"
    t.integer "point_metro_distance", default: 0
    t.datetime "updated_at", precision: nil, null: false
    t.index ["boarding_point_id", "metro_station_id"], name: "idx_point_metro_station", unique: true
    t.index ["boarding_point_id"], name: "index_points_metro_stations_on_boarding_point_id"
    t.index ["metro_station_id"], name: "index_points_metro_stations_on_metro_station_id"
  end

  create_table "premium_price_categories", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.float "gold_amt"
    t.boolean "is_active", default: true
    t.date "on_date", null: false
    t.float "platinum_amt"
    t.string "seating_type"
    t.float "silver_amt"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.index ["bus_service_id", "on_date"], name: "composite_index_premium_price_categories"
  end

  create_table "products", charset: "latin1", force: :cascade do |t|
    t.string "attr1", limit: 50
    t.string "attr2", limit: 50
    t.datetime "created_at", null: false
    t.string "created_by"
    t.string "description"
    t.string "image"
    t.boolean "is_active", default: true
    t.boolean "is_sample", default: false
    t.string "name"
    t.decimal "price", precision: 8, scale: 2
    t.string "product_ownership"
    t.string "product_type"
    t.string "sku"
    t.datetime "updated_at", null: false
  end

  create_table "push_data", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "client_name"
    t.datetime "created_at", precision: nil, null: false
    t.string "error"
    t.string "push_type"
    t.text "request_params"
    t.text "request_response"
    t.string "ticket_pnr", limit: 45
    t.datetime "updated_at", precision: nil, null: false
    t.string "url"
    t.index ["client_name"], name: "index_push_data_on_client_name"
    t.index ["push_type"], name: "idx_push_type"
    t.index ["ticket_pnr"], name: "idx_pnr"
  end

  create_table "push_services", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id"
    t.integer "counter"
    t.datetime "created_at", precision: nil, null: false
    t.string "error"
    t.text "extra_info"
    t.integer "from_city_id"
    t.string "from_city_name"
    t.boolean "is_primary"
    t.date "journey_date"
    t.datetime "processed_at", precision: nil
    t.string "push_source"
    t.string "push_status", default: "Requested"
    t.date "request_date"
    t.datetime "request_time", precision: nil
    t.integer "to_city_id"
    t.string "to_city_name"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["journey_date"], name: "index_push_services_on_journey_date"
    t.index ["request_date", "from_city_id", "to_city_id"], name: "idx_request_date_from_to_city_id"
  end

  create_table "push_services_data", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "client_name"
    t.datetime "created_at", precision: nil, null: false
    t.string "error"
    t.string "push_type"
    t.text "request_params"
    t.text "request_response"
    t.datetime "updated_at", precision: nil, null: false
    t.string "url"
    t.index ["client_name"], name: "index_client_name"
  end

  create_table "quota_seat_requests", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "bus_registration_no"
    t.datetime "created_at", precision: nil, null: false
    t.date "end_date"
    t.date "original_end_date"
    t.text "remarks"
    t.string "request_type", default: "BLOCKED"
    t.text "seat_image_url"
    t.string "seat_no"
    t.string "service_ids"
    t.date "start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.string "user_type"
    t.index ["bus_registration_no"], name: "index_quota_seat_requests_on_bus_registration_no"
  end

  create_table "quota_seats", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "appositional_seat_id"
    t.string "appositional_seat_no", limit: 10
    t.integer "booking_id"
    t.integer "bus_master_route_id"
    t.integer "bus_seat_id", null: false
    t.integer "bus_service_id", null: false
    t.integer "bus_service_route_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "gds_operator_id", null: false
    t.integer "is_agent", limit: 1, default: 0
    t.integer "is_ladies", limit: 1, default: 0
    t.integer "is_male", limit: 1, default: 0
    t.integer "is_ph", limit: 1, default: 0
    t.integer "mblock", limit: 1, default: 0, comment: "Mirror Block"
    t.date "ondate"
    t.integer "quota_seat_request_id"
    t.string "quota_type", limit: 50
    t.text "remarks"
    t.string "seat_no", limit: 10
    t.date "service_start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.index ["bus_service_id", "service_start_date"], name: "index_quota_seats_on_bus_service_id_and_service_start_date"
  end

  create_table "random_numbers", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "random_number"
    t.integer "status", default: 0
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "used_at", precision: nil
    t.index ["random_number"], name: "idx_random_number"
    t.index ["status"], name: "index_random_numbers_on_status"
  end

  create_table "reimbursement_details", charset: "latin1", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2
    t.string "bill_number"
    t.datetime "created_at", precision: nil, null: false
    t.date "from_date"
    t.integer "reimbursement_id"
    t.string "remarks"
    t.string "started_from"
    t.date "to_date"
    t.integer "travelled_km"
    t.string "travelled_to"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["reimbursement_id"], name: "index_reimbursement_id"
  end

  create_table "reimbursement_documents", charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "document_title"
    t.string "document_url"
    t.integer "reimbursement_detail_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["reimbursement_detail_id"], name: "index_reimbursement_detail_id"
  end

  create_table "reimbursements", charset: "latin1", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2
    t.integer "approver_id"
    t.integer "bus_member_id"
    t.integer "claim_type"
    t.datetime "created_at", precision: nil, null: false
    t.integer "status", default: 0
    t.datetime "updated_at", precision: nil, null: false
    t.index ["approver_id"], name: "indx_approver_id"
    t.index ["bus_member_id"], name: "indx_bus_member_id"
  end

  create_table "remarks", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "comment"
    t.datetime "created_at", precision: nil, null: false
    t.integer "resource_id"
    t.string "resource_type"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["resource_id"], name: "resource_id"
    t.index ["resource_type"], name: "resource_type"
  end

  create_table "reschedule_policies", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.date "end_date"
    t.integer "gds_operator_id"
    t.integer "rescheduled_before_hour"
    t.decimal "rescheduled_charges", precision: 6, scale: 2
    t.date "start_date"
    t.boolean "status", default: true
    t.datetime "updated_at", precision: nil, null: false
    t.index ["gds_operator_id"], name: "index_reschedule_policies_on_gds_operator_id"
  end

  create_table "roles", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "gds_operator_id"
    t.string "name"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "route_base_fares", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_master_route_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "fare_for", limit: 1
    t.boolean "fare_status", default: true
    t.date "on_date", null: false
    t.float "seater_fare"
    t.float "shared_sleeper_fare"
    t.float "single_sleeper_fare"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.integer "yearmonth"
    t.index ["bus_master_route_id", "on_date", "fare_for", "fare_status"], name: "composite_index_route_base_fares"
  end

  create_table "route_benchmarkings", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "banchmark_time"
    t.datetime "created_at", precision: nil
    t.integer "destination_point_id"
    t.integer "route_id"
    t.integer "source_point_id"
    t.datetime "updated_at", precision: nil
    t.string "updated_by"
  end

  create_table "route_benchmarks", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "benchmark_minutes"
    t.integer "benchmark_service_id"
    t.datetime "created_at", precision: nil
    t.string "destination_entry"
    t.integer "destination_point_id"
    t.integer "distance_in_km"
    t.integer "route_id"
    t.string "source_exit"
    t.integer "source_point_id"
    t.datetime "updated_at", precision: nil
    t.string "updated_by"
  end

  create_table "route_channel_revnue_targets", id: :integer, charset: "latin1", force: :cascade do |t|
    t.decimal "bp_target_per_of_offline", precision: 10, scale: 2, comment: "bp = boarding point"
    t.decimal "cb_target_per_of_offline", precision: 10, scale: 2, comment: "cb = commission based"
    t.datetime "created_at", precision: nil
    t.decimal "dc_target_per_of_offline", precision: 10, scale: 2, comment: "dc = direct customer\n"
    t.date "from_date"
    t.integer "icy"
    t.integer "offline"
    t.integer "online"
    t.integer "ota"
    t.string "route", null: false
    t.integer "route_id"
    t.date "to_date"
    t.integer "total"
    t.datetime "updated_at", precision: nil
  end

  create_table "route_minimum_fares", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "destination_city_id"
    t.float "seater_fare"
    t.date "service_start_date", null: false
    t.float "shared_sleeper_fare"
    t.float "single_sleeper_fare"
    t.integer "source_city_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["source_city_id", "destination_city_id", "service_start_date"], name: "composite_index_route_minimum_fares"
  end

  create_table "route_offline_target", id: :integer, default: nil, charset: "latin1", force: :cascade do |t|
    t.integer "buses_no"
    t.datetime "created_at", precision: nil
    t.integer "daily_invt"
    t.integer "daily_revenue_target"
    t.date "from_date"
    t.integer "monthly_invt"
    t.integer "monthly_revenue_target"
    t.string "route", limit: 45
    t.integer "route_id"
    t.date "to_date"
    t.datetime "updated_at", precision: nil
  end

  create_table "route_offline_targets", id: :integer, charset: "latin1", force: :cascade do |t|
    t.decimal "agent_fill_target", precision: 10, scale: 2
    t.integer "agent_rev_target"
    t.integer "asp"
    t.integer "buses_no"
    t.decimal "central_rev_contribution", precision: 10, scale: 2
    t.datetime "created_at", precision: nil
    t.decimal "d2c_fill_target", precision: 10, scale: 2
    t.decimal "d2c_rev_target", precision: 10, scale: 2
    t.integer "daily_invt"
    t.integer "daily_revenue_target"
    t.date "from_date"
    t.decimal "offline_fill_target", precision: 10, scale: 2
    t.decimal "offline_rev_target", precision: 10, scale: 2
    t.string "route", limit: 45
    t.integer "route_id"
    t.integer "service_id", default: 0
    t.string "service_name"
    t.string "target_type", limit: 15
    t.date "to_date"
    t.datetime "updated_at", precision: nil
  end

  create_table "route_revnue_targets", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "agent_rev_target"
    t.string "aps", limit: 45
    t.integer "asp"
    t.integer "central_rev_contribution"
    t.datetime "created_at", precision: nil
    t.integer "d2c_rev_target"
    t.date "from_date"
    t.integer "icy"
    t.integer "monthly_seat_count"
    t.integer "net_sale"
    t.integer "offline"
    t.integer "offline_rev_target"
    t.integer "online"
    t.integer "ota"
    t.string "route", null: false
    t.integer "route_id"
    t.date "to_date"
    t.integer "total"
    t.datetime "updated_at", precision: nil
  end

  create_table "ry_agent_bookings", charset: "latin1", force: :cascade do |t|
    t.float "agent_commission", default: 0.0
    t.float "agent_surcharge", default: 0.0
    t.string "booked_by"
    t.integer "booked_by_agent_id"
    t.float "booking_discount"
    t.integer "bus_trip_id"
    t.integer "commission_type", limit: 1, default: 1
    t.datetime "created_at", precision: nil, null: false
    t.integer "new_bus_trip_id", comment: "New bus trip id in case of new booking with respect current booking"
    t.integer "payment_transaction_id"
    t.integer "railyatri_user_id"
    t.integer "reserved_by"
    t.integer "state", default: 0
    t.boolean "status", default: false
    t.float "tout_commission"
    t.boolean "tout_commission_reversed", default: false, null: false
    t.boolean "tout_commission_transfered", default: false, null: false
    t.integer "tout_id"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
  end

  create_table "ry_agent_commissions", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.text "commission_details"
    t.datetime "created_at", precision: nil, null: false
    t.integer "route_id"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
  end

  create_table "ry_agent_profiles", charset: "latin1", force: :cascade do |t|
    t.text "address", null: false, collation: "utf8mb3_general_ci"
    t.float "agent_commission"
    t.string "agent_poc", limit: 45
    t.string "agent_type"
    t.integer "city_id"
    t.integer "commission_type", limit: 1, default: 1
    t.datetime "created_at", precision: nil, null: false
    t.string "mobile_number"
    t.string "pan_card_no", limit: 45
    t.integer "poc_id"
    t.string "travel_agency_name", limit: 45
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
  end

  create_table "ry_agents", charset: "latin1", force: :cascade do |t|
    t.integer "agent_group_id"
    t.boolean "approved", default: false
    t.integer "authentication_token"
    t.datetime "created_at", precision: nil, null: false
    t.decimal "credit_limit", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "current_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.string "first_name"
    t.integer "gds_operator_id", default: 10
    t.integer "gender", default: 1
    t.boolean "is_manager", default: false
    t.string "last_name"
    t.datetime "last_sign_in_at", precision: nil
    t.string "last_sign_in_ip"
    t.integer "manager_id"
    t.string "mobile", limit: 45
    t.string "otp_secret_key", limit: 45
    t.integer "poc_id"
    t.string "provider", limit: 45
    t.datetime "remember_created_at", precision: nil
    t.string "remember_token", limit: 45
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.boolean "show_commission", default: false
    t.integer "sign_in_count", default: 0, null: false
    t.string "uid", limit: 45
    t.datetime "updated_at", precision: nil, null: false
    t.string "user_type", limit: 45
    t.index ["approved"], name: "index_ry_agents_on_approved"
    t.index ["email"], name: "index_ry_agents_on_email", unique: true
    t.index ["mobile"], name: "mobile_UNIQUE", unique: true
    t.index ["reset_password_token"], name: "index_ry_agents_on_reset_password_token", unique: true
    t.index ["user_type"], name: "index_ry_agents_on_user_type"
  end

  create_table "ry_bus_users", charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "mobile_number", default: "", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["mobile_number"], name: "index_ry_bus_users_on_mobile_number", unique: true
  end

  create_table "seat_attribute_backups", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "agent_id"
    t.integer "bus_seat_id"
    t.integer "bus_service_id"
    t.integer "coupe_seat_id"
    t.datetime "created_at", precision: nil, null: false
    t.float "day_10_fare"
    t.float "day_11_fare"
    t.float "day_12_fare"
    t.float "day_13_fare"
    t.float "day_14_fare"
    t.float "day_15_fare"
    t.float "day_16_fare"
    t.float "day_17_fare"
    t.float "day_18_fare"
    t.float "day_19_fare"
    t.float "day_1_fare"
    t.float "day_20_fare"
    t.float "day_21_fare"
    t.float "day_22_fare"
    t.float "day_23_fare"
    t.float "day_24_fare"
    t.float "day_25_fare"
    t.float "day_26_fare"
    t.float "day_27_fare"
    t.float "day_28_fare"
    t.float "day_29_fare"
    t.float "day_2_fare"
    t.float "day_30_fare"
    t.float "day_31_fare"
    t.float "day_3_fare"
    t.float "day_4_fare"
    t.float "day_5_fare"
    t.float "day_6_fare"
    t.float "day_7_fare"
    t.float "day_8_fare"
    t.float "day_9_fare"
    t.date "end_date"
    t.text "fare"
    t.integer "gds_bus_id"
    t.integer "is_agent"
    t.integer "is_ladies"
    t.integer "is_ph"
    t.integer "route_id"
    t.integer "seat_attribute_tracking_id"
    t.string "seat_no", limit: 11
    t.date "start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "yearmonth"
    t.index ["bus_seat_id"], name: "idx_bus_seat_id"
    t.index ["bus_service_id"], name: "idx_bus_service_id"
    t.index ["coupe_seat_id"], name: "idx_coupe_seat_id"
    t.index ["route_id"], name: "idx_route_id"
  end

  create_table "seat_attribute_trackings", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.date "end_date"
    t.text "error_message"
    t.integer "gds_bus_id"
    t.boolean "is_success", default: true
    t.text "request_params", size: :long
    t.date "start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.index ["bus_service_id"], name: "idx_bus_service_id"
    t.index ["gds_bus_id"], name: "idx_gds_bus_id"
    t.index ["is_success"], name: "idx_yearmonth"
  end

  create_table "seat_attributes", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "agent_id"
    t.integer "bus_seat_id"
    t.integer "bus_service_id"
    t.integer "coupe_seat_id"
    t.datetime "created_at", precision: nil, null: false
    t.float "day_10_fare"
    t.float "day_11_fare"
    t.float "day_12_fare"
    t.float "day_13_fare"
    t.float "day_14_fare"
    t.float "day_15_fare"
    t.float "day_16_fare"
    t.float "day_17_fare"
    t.float "day_18_fare"
    t.float "day_19_fare"
    t.float "day_1_fare"
    t.float "day_20_fare"
    t.float "day_21_fare"
    t.float "day_22_fare"
    t.float "day_23_fare"
    t.float "day_24_fare"
    t.float "day_25_fare"
    t.float "day_26_fare"
    t.float "day_27_fare"
    t.float "day_28_fare"
    t.float "day_29_fare"
    t.float "day_2_fare"
    t.float "day_30_fare"
    t.float "day_31_fare"
    t.float "day_3_fare"
    t.float "day_4_fare"
    t.float "day_5_fare"
    t.float "day_6_fare"
    t.float "day_7_fare"
    t.float "day_8_fare"
    t.float "day_9_fare"
    t.date "end_date"
    t.text "fare"
    t.integer "gds_bus_id"
    t.integer "is_agent"
    t.integer "is_ladies"
    t.integer "is_ph"
    t.integer "route_id"
    t.integer "seat_attribute_tracking_id"
    t.string "seat_no", limit: 11
    t.date "start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "yearmonth"
    t.index ["bus_seat_id"], name: "idx_bus_seat_id"
    t.index ["bus_service_id"], name: "idx_bus_service_id"
    t.index ["coupe_seat_id"], name: "idx_coupe_seat_id"
    t.index ["route_id"], name: "idx_route_id"
    t.index ["yearmonth", "bus_service_id", "route_id"], name: "idx_yearmonth_service_route_id"
  end

  create_table "seat_counts", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "available_seats"
    t.integer "blocked_seats"
    t.integer "booked_seats"
    t.integer "bus_service_id"
    t.integer "cancelled_seats"
    t.datetime "created_at", precision: nil, null: false
    t.text "female_available_seats"
    t.date "journey_date"
    t.date "service_start_date"
    t.integer "status", default: 1
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id", "journey_date"], name: "idx_service_id_doj"
    t.index ["journey_date"], name: "idx_journey_date"
  end

  create_table "seat_fare_and_charges", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.float "base_fare"
    t.integer "bus_seat_id"
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.float "display_base_fare"
    t.float "display_gst"
    t.integer "gds_bus_id"
    t.float "gst"
    t.float "inclusive_charges_amt"
    t.text "inclusive_charges_hash"
    t.text "inclusive_charges_hash_value"
    t.float "markup_charges_amt"
    t.text "markup_charges_hash"
    t.text "markup_charges_hash_value"
    t.date "on_date", null: false
    t.integer "route_id"
    t.string "seat_no", limit: 11
    t.string "seating_type", limit: 45
    t.float "total_seat_fare"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.integer "yearmonth"
    t.index ["bus_service_id", "gds_bus_id", "bus_seat_id", "route_id", "on_date"], name: "composite_index_seat_fares"
    t.index ["yearmonth"], name: "idx_yearmonth"
  end

  create_table "seat_fares", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "activated_at", precision: nil
    t.integer "activation_hour", limit: 1
    t.float "allotted_flat_fare"
    t.boolean "allow_dynamic_fare", default: false
    t.float "backup_fare"
    t.float "backup_flat_fare"
    t.integer "bus_seat_id"
    t.integer "bus_service_id"
    t.integer "coupe_seat_id"
    t.datetime "created_at", precision: nil, null: false
    t.float "fare"
    t.float "flat_fare"
    t.integer "gds_bus_id"
    t.float "gold_fare"
    t.boolean "is_enabled", default: true
    t.boolean "is_tt_flat_fare"
    t.date "on_date", null: false
    t.float "platinum_fare"
    t.boolean "premium_fare_status", default: true
    t.integer "route_id"
    t.string "seat_no", limit: 11
    t.string "seating_type"
    t.float "silver_fare"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.integer "yearmonth"
    t.index ["bus_service_id", "gds_bus_id", "bus_seat_id", "route_id", "on_date"], name: "composite_index_seat_fares"
    t.index ["bus_service_id", "gds_bus_id", "route_id", "on_date", "bus_seat_id"], name: "composite_index_service_bus_route_date_seat_id"
  end

  create_table "seat_flat_prices", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "agent_id"
    t.integer "bus_seat_id"
    t.integer "bus_service_id"
    t.integer "coupe_seat_id"
    t.datetime "created_at", precision: nil, null: false
    t.float "day_10_fare"
    t.float "day_11_fare"
    t.float "day_12_fare"
    t.float "day_13_fare"
    t.float "day_14_fare"
    t.float "day_15_fare"
    t.float "day_16_fare"
    t.float "day_17_fare"
    t.float "day_18_fare"
    t.float "day_19_fare"
    t.float "day_1_fare"
    t.float "day_20_fare"
    t.float "day_21_fare"
    t.float "day_22_fare"
    t.float "day_23_fare"
    t.float "day_24_fare"
    t.float "day_25_fare"
    t.float "day_26_fare"
    t.float "day_27_fare"
    t.float "day_28_fare"
    t.float "day_29_fare"
    t.float "day_2_fare"
    t.float "day_30_fare"
    t.float "day_31_fare"
    t.float "day_3_fare"
    t.float "day_4_fare"
    t.float "day_5_fare"
    t.float "day_6_fare"
    t.float "day_7_fare"
    t.float "day_8_fare"
    t.float "day_9_fare"
    t.date "end_date"
    t.text "fare"
    t.integer "gds_bus_id"
    t.integer "is_agent"
    t.integer "is_ladies"
    t.integer "is_ph"
    t.integer "route_id"
    t.string "seat_no", limit: 11
    t.date "start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "yearmonth"
    t.index ["bus_seat_id"], name: "idx_bus_seat_id"
    t.index ["bus_service_id"], name: "idx_bus_service_id"
    t.index ["coupe_seat_id"], name: "idx_coupe_seat_id"
    t.index ["route_id"], name: "idx_route_id"
  end

  create_table "seat_metadata", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_seat_id"
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "gds_constant_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id"], name: "idx_service_id"
    t.index ["gds_constant_id"], name: "idx_gds_constant_id"
  end

  create_table "seat_metadata_descriptions", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "description"
    t.boolean "is_active", default: true, null: false
    t.integer "seat_metadata_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["seat_metadata_id"], name: "idx_seat_metadata_id"
  end

  create_table "seat_metadata_images", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "image_url"
    t.boolean "is_active", default: true
    t.integer "seat_metadata_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["seat_metadata_id"], name: "idx_seat_metadata_id"
  end

  create_table "senior_captain", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "created_at"
    t.integer "crew_checklist_catagory_id"
    t.integer "id"
    t.integer "input_type"
    t.integer "is_active"
    t.integer "is_child"
    t.text "name"
    t.text "parent_checklist_crew_sub_category_id"
    t.text "parent_question_value"
    t.integer "question_score"
    t.integer "question_stage"
    t.integer "score"
    t.integer "score_category_id"
    t.text "updated_at"
  end

  create_table "service_amenities", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "amenity_name", limit: 100
    t.datetime "created_at", precision: nil, null: false
    t.string "img_url"
    t.integer "status", limit: 1, default: 1
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "service_bus_number_histories", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_number_id"
    t.integer "bus_provider_id"
    t.string "bus_registration_no", limit: 45
    t.string "bus_service_name"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "has_washroom"
    t.integer "master_seat_layout_id"
    t.integer "operating_day_id"
    t.integer "service_bus_number_id"
    t.time "service_prime_time"
    t.boolean "status", default: false
    t.integer "total_seats"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by", limit: 100
    t.string "updated_reason"
    t.index ["bus_number_id"], name: "index_service_bus_numbers_on_bus_number_id"
    t.index ["operating_day_id"], name: "index_service_bus_numbers_on_operating_day_id"
  end

  create_table "service_bus_numbers", id: :integer, charset: "latin1", force: :cascade do |t|
    t.boolean "aqi_enabled", default: false
    t.integer "bus_number_id"
    t.integer "bus_provider_id"
    t.string "bus_registration_no", limit: 45
    t.string "bus_service_name"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "has_emergency_exit", default: false
    t.boolean "has_washroom"
    t.integer "master_seat_layout_id"
    t.integer "operating_day_id"
    t.time "service_prime_time"
    t.boolean "status", default: false
    t.integer "total_seats"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by", limit: 100
    t.string "updated_reason"
    t.index ["bus_number_id"], name: "index_service_bus_numbers_on_bus_number_id"
    t.index ["operating_day_id"], name: "index_service_bus_numbers_on_operating_day_id"
  end

  create_table "service_captains", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "alternate_bus_member_id"
    t.integer "bus_member_id"
    t.float "check_in_lang"
    t.float "check_in_lat"
    t.datetime "check_in_time", precision: nil
    t.float "check_out_lang"
    t.float "check_out_lat"
    t.datetime "check_out_time", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.integer "from_city_id"
    t.integer "from_point_id"
    t.boolean "on_duty"
    t.integer "operating_day_id"
    t.integer "service_id"
    t.integer "to_city_id"
    t.integer "to_point_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["operating_day_id"], name: "idx_operating_day_id"
  end

  create_table "service_crews", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_member_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "operating_day_id"
    t.integer "service_point_id"
    t.boolean "status", default: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["operating_day_id"], name: "index_service_crews_on_operating_day_id"
  end

  create_table "service_delay_infos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "current_delay"
    t.string "delay_at_location"
    t.integer "delay_minutes"
    t.string "delay_reason"
    t.text "extra_info"
    t.datetime "notified_at", precision: nil
    t.integer "operating_day_id"
    t.string "submitted_by"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["operating_day_id"], name: "idx_operating_day_id"
  end

  create_table "service_drivers", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_member_id"
    t.datetime "created_at", precision: nil, null: false
    t.text "extra_data"
    t.integer "operating_day_id"
    t.boolean "status", default: true
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_member_id"], name: "index_service_drivers_on_bus_member_id"
    t.index ["operating_day_id"], name: "index_service_drivers_on_operating_day_id"
  end

  create_table "service_food_stop_deposits", charset: "latin1", force: :cascade do |t|
    t.integer "amount"
    t.string "comment"
    t.datetime "created_at", precision: nil, null: false
    t.date "deposit_date"
    t.string "deposit_status"
    t.float "document_size"
    t.string "document_url"
    t.string "payment_mode"
    t.string "pymnt_transaction_id"
    t.integer "rest_id"
    t.string "rest_name"
    t.datetime "status_changed_at", precision: nil
    t.string "status_changed_by"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.date "updated_on"
    t.index ["rest_id", "deposit_date"], name: "idx_rest_id_date"
  end

  create_table "service_food_stop_revenues", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "bus_number", limit: 45
    t.integer "bus_service_id", null: false
    t.string "bus_service_name"
    t.integer "child_operator_id"
    t.string "child_operator_name"
    t.datetime "created_at", precision: nil
    t.decimal "gross_amount", precision: 15, scale: 2
    t.decimal "irb_share", precision: 15, scale: 2
    t.decimal "irb_share_gst", precision: 15, scale: 2
    t.boolean "is_paid", default: false, null: false
    t.integer "operator_annexure_id"
    t.integer "operator_id"
    t.string "operator_name"
    t.decimal "operator_share", precision: 15, scale: 2
    t.decimal "operator_share_gst", precision: 15, scale: 2
    t.string "poc"
    t.string "poc_email", limit: 225
    t.string "poc_name"
    t.text "remarks"
    t.integer "rest_id", null: false
    t.string "rest_name"
    t.column "revenue_status", "enum('valid','invalid')", default: "valid", null: false
    t.string "route"
    t.integer "run_child_operator_id"
    t.string "run_child_operator_name"
    t.integer "run_operator_id"
    t.string "run_operator_name"
    t.boolean "service_disrupted", default: false
    t.date "service_start_date", null: false
    t.datetime "updated_at", precision: nil
    t.string "updated_by"
    t.string "zone"
    t.index ["bus_service_id", "service_start_date", "operator_id", "rest_id"], name: "service_rest_operator_index"
  end

  create_table "service_helpers", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_member_id"
    t.datetime "created_at", precision: nil, null: false
    t.text "extra_data"
    t.integer "operating_day_id"
    t.boolean "status", default: true
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_member_id"], name: "index_service_helpers_on_bus_member_id"
    t.index ["operating_day_id"], name: "index_service_helpers_on_operating_day_id"
  end

  create_table "service_location_bays", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "boarding_point_id"
    t.integer "bus_service_id"
    t.datetime "comms_sent_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.string "location_info"
    t.text "other_info"
    t.string "requested_by"
    t.date "service_start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id", "service_start_date"], name: "idx_service_id_date"
  end

  create_table "service_lost_found_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "bus_service_id"
    t.string "collected_from"
    t.datetime "created_at", precision: nil, null: false
    t.string "image_url"
    t.boolean "is_found", default: true
    t.string "item_description"
    t.string "item_location"
    t.text "other_info"
    t.date "service_start_date"
    t.string "submitted_by"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id", "service_start_date"], name: "idx_service_id_date"
  end

  create_table "service_managers", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_member_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "operating_day_id"
    t.integer "service_id"
    t.integer "status", limit: 1, default: 0
    t.datetime "updated_at", precision: nil, null: false
    t.index ["operating_day_id"], name: "idx_operating_day_id"
  end

  create_table "service_manifestations", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "boarding_point_id"
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "dropoff_point_id"
    t.integer "sm_status", limit: 1, default: 0, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id"], name: "idx_bus_service_id"
  end

  create_table "service_penalties", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "added_by"
    t.decimal "amount", precision: 15, scale: 2, default: "0.0"
    t.integer "bus_member_id"
    t.string "bus_number"
    t.integer "bus_provider_id"
    t.integer "bus_service_id", null: false
    t.integer "child_bus_provider_id"
    t.text "comment"
    t.datetime "created_at", precision: nil
    t.boolean "email_sent", default: false
    t.decimal "initial_amount", precision: 15, scale: 2, default: "0.0"
    t.boolean "is_free", default: false, null: false
    t.boolean "is_paid", default: false, null: false
    t.integer "journey_completed_perc"
    t.integer "operator_annexure_id"
    t.string "optional_recipients"
    t.string "pdf_url"
    t.date "penalty_applicable_date"
    t.integer "penalty_id", null: false
    t.integer "send_email", limit: 1, default: 1
    t.integer "service_penalty_request_id"
    t.date "service_start_date", null: false
    t.boolean "status", default: true, null: false
    t.datetime "updated_at", precision: nil
    t.index ["penalty_applicable_date"], name: "penalty_applicable_date_index"
    t.index ["service_start_date"], name: "service_start_date_index"
  end

  create_table "service_penalty_images", charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "image_url"
    t.integer "service_penalty_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "service_penalty_requests", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "approved_at", precision: nil
    t.integer "approved_by"
    t.integer "bus_member_id"
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "email_sent_at", precision: nil
    t.text "extra_info"
    t.text "notification_info"
    t.string "penalty_tag"
    t.string "requested_status"
    t.date "service_start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id", "service_start_date"], name: "idx_service_id_service_date"
  end

  create_table "service_point_charges", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "bus_service_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_active", default: true, null: false
    t.boolean "is_refundable", default: true
    t.boolean "is_seat_wise", default: true
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id", "is_active"], name: "composite_index_charges"
  end

  create_table "service_point_disables", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "operating_day_id"
    t.integer "point_id"
    t.integer "service_point_id"
    t.boolean "status", default: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["operating_day_id"], name: "index_service_point_disables_on_operating_day_id"
  end

  create_table "service_point_partial_cancels", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "operating_day_id"
    t.integer "service_point_id"
    t.boolean "status", default: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "service_points", id: :integer, charset: "latin1", force: :cascade do |t|
    t.float "chargeable_amount"
    t.integer "city_id"
    t.integer "connected_boarding_point_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "day_count", default: 0
    t.time "disable_at"
    t.decimal "distance_between_point", precision: 12, scale: 3
    t.decimal "distance_from_source", precision: 12, scale: 3
    t.json "hide_to", comment: "gds_client_id or RY Platform source id"
    t.boolean "is_chargeable", default: false
    t.integer "is_prime", limit: 1, default: 0, null: false, comment: "1=prime | 0=not prime"
    t.boolean "is_van_dropoff", default: false
    t.text "metro_point_hash"
    t.integer "point_id"
    t.time "point_time"
    t.integer "point_type", comment: "BP=boarding Point | DP = droping point | S=source | D=destination"
    t.integer "rest_id"
    t.integer "service_id"
    t.integer "service_route_master_id"
    t.integer "si_no"
    t.integer "status", limit: 1, default: 1, null: false, comment: "1=active | 0=inactive"
    t.string "ticket_process"
    t.integer "transfer_point_id", comment: "van_to_bus and bus_to_van transfer point"
    t.string "travel_guide"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["point_id"], name: "idx_point_id"
    t.index ["point_type"], name: "idx_point_type"
    t.index ["service_id"], name: "service_id"
    t.index ["service_route_master_id"], name: "idx_srm_id"
  end

  create_table "service_route_masters", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id"
    t.integer "bus_service_other_charge_id"
    t.integer "cityflo_route_slot_id"
    t.datetime "created_at", precision: nil, null: false
    t.date "from_date", null: false
    t.boolean "is_active", default: true
    t.boolean "only_time_change", default: false
    t.date "to_date", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.index ["bus_service_id"], name: "idx_bus_service_id"
  end

  create_table "service_seat_bookings", charset: "latin1", force: :cascade do |t|
    t.integer "LSH_booked"
    t.float "LSH_lp"
    t.integer "LSH_non_premium_seats_booked"
    t.integer "LSH_non_premium_seats_total"
    t.integer "LSH_normal_seats_booked"
    t.integer "LSH_normal_seats_total"
    t.integer "LSH_premium_seats_booked"
    t.integer "LSH_premium_seats_total"
    t.integer "LSH_seats"
    t.integer "LSH_sector_booked_seat"
    t.integer "LSH_total_booked_last_seat"
    t.integer "LSH_total_last_seat"
    t.integer "LSS_booked"
    t.float "LSS_lp"
    t.integer "LSS_non_premium_seats_booked"
    t.integer "LSS_non_premium_seats_total"
    t.integer "LSS_normal_seats_booked"
    t.integer "LSS_normal_seats_total"
    t.integer "LSS_premium_seats_booked"
    t.integer "LSS_premium_seats_total"
    t.integer "LSS_seats"
    t.integer "LSS_sector_booked_seat"
    t.integer "LSS_total_booked_last_seat"
    t.integer "LSS_total_last_seat"
    t.integer "ST_booked"
    t.float "ST_lp"
    t.integer "ST_non_premium_seats_booked"
    t.integer "ST_non_premium_seats_total"
    t.integer "ST_normal_seats_booked"
    t.integer "ST_normal_seats_total"
    t.integer "ST_premium_seats_booked"
    t.integer "ST_premium_seats_total"
    t.integer "ST_seats"
    t.integer "ST_sector_booked_seat"
    t.integer "ST_total_booked_last_seat"
    t.integer "ST_total_last_seat"
    t.integer "USH_booked"
    t.float "USH_lp"
    t.integer "USH_non_premium_seats_booked"
    t.integer "USH_non_premium_seats_total"
    t.integer "USH_normal_seats_booked"
    t.integer "USH_normal_seats_total"
    t.integer "USH_premium_seats_booked"
    t.integer "USH_premium_seats_total"
    t.integer "USH_seats"
    t.integer "USH_sector_booked_seat"
    t.integer "USH_total_booked_last_seat"
    t.integer "USH_total_last_seat"
    t.integer "USS_booked"
    t.float "USS_lp"
    t.integer "USS_non_premium_seats_booked"
    t.integer "USS_non_premium_seats_total"
    t.integer "USS_normal_seats_booked"
    t.integer "USS_normal_seats_total"
    t.integer "USS_premium_seats_booked"
    t.integer "USS_premium_seats_total"
    t.integer "USS_seats"
    t.integer "USS_sector_booked_seat"
    t.integer "USS_total_booked_last_seat"
    t.integer "USS_total_last_seat"
    t.integer "booked_last_seat"
    t.integer "booked_seats"
    t.float "booked_seats_lp"
    t.string "bus_maker"
    t.bigint "bus_service_id"
    t.string "bus_type"
    t.datetime "created_at", precision: nil, null: false
    t.integer "destination_city_id", default: 0
    t.integer "has_washroom", limit: 1, default: 0
    t.integer "intrcity_brand_id", default: 1
    t.float "minimum_rev_target"
    t.float "net_contribution"
    t.string "operator"
    t.string "round_route"
    t.string "round_trip_zone", limit: 225
    t.string "route"
    t.string "service_name"
    t.date "service_start_date"
    t.integer "source_city_id", default: 0
    t.string "state"
    t.string "sub_zone"
    t.integer "total_last_seat"
    t.integer "total_seats"
    t.boolean "trip_status", default: true
    t.datetime "updated_at", precision: nil, null: false
    t.string "zone"
  end

  create_table "service_seat_quota", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "service_standing_fees", id: :integer, charset: "latin1", force: :cascade do |t|
    t.decimal "amount", precision: 15, scale: 2, default: "0.0"
    t.datetime "approved_at", precision: nil
    t.string "approved_by"
    t.string "bus_number"
    t.integer "bus_provider_id"
    t.integer "bus_service_id"
    t.integer "child_bus_provider_id"
    t.text "comment"
    t.datetime "created_at", precision: nil
    t.boolean "is_paid", default: false, null: false
    t.integer "operating_day_id", null: false
    t.integer "operator_annexure_id"
    t.date "service_start_date"
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", precision: nil
  end

  create_table "service_van_captains", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_member_id"
    t.float "check_in_lang"
    t.float "check_in_lat"
    t.datetime "check_in_time", precision: nil
    t.float "check_out_lang"
    t.float "check_out_lat"
    t.datetime "check_out_time", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.integer "from_city_id"
    t.integer "operating_day_id"
    t.integer "to_city_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "sessions", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "data", size: :long
    t.string "session_id", null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "share_documents", charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "doc_url"
    t.string "name"
    t.text "service_ids"
    t.boolean "status", default: true
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "smart_bus_crew_checklist_catagories", charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_active"
    t.string "name"
    t.integer "sequence", default: 0, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "smart_bus_crew_checklist_inputs", charset: "latin1", force: :cascade do |t|
    t.text "answer"
    t.text "comment"
    t.datetime "created_at", precision: nil, null: false
    t.integer "crew_checklist_sub_catagory_id"
    t.integer "crew_duty_id"
    t.integer "input_type", comment: "0 for text, \n1 for numeric, \n2 for boolean,\n3 for radio, \n4 for checkbox, \n5 for date, \n6 for rating, \n7 for dropdown, \n8 for textarea"
    t.integer "score"
    t.integer "score_category_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["crew_duty_id"], name: "idx_crew_duty_id"
  end

  create_table "smart_bus_crew_checklist_sub_catagories", charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "crew_checklist_catagory_id"
    t.integer "input_type", comment: "0 for text,\n1 for numeric,\n2 for boolean,\n3 for radio,\n4 for checkbox,\n5 for date,\n6 for rating,\n7 for dropdown,\n8 for textarea"
    t.text "intervals"
    t.boolean "is_active"
    t.boolean "is_child"
    t.string "name"
    t.integer "parent_checklist_crew_sub_category_id"
    t.text "parent_question_value"
    t.integer "question_score"
    t.integer "question_stage", comment: "0 for pre_boarding, \n1 for mid_journey, \n2 for post_arrival"
    t.integer "score"
    t.integer "score_category_id"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "smart_bus_crew_checklist_sub_catagory_question_values", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "crew_checklist_sub_catagory_id", null: false
    t.boolean "is_commentable"
    t.datetime "updated_at", precision: nil, null: false
    t.string "value"
  end

  create_table "smart_bus_crew_duties", charset: "latin1", force: :cascade do |t|
    t.integer "bus_detail_id"
    t.text "check_in_detail", collation: "utf8mb3_general_ci"
    t.datetime "completed_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "duty_at", precision: nil
    t.date "journey_date"
    t.string "location"
    t.integer "question_stage", comment: "0 for pre_boarding, \n1 for mid_journey, \n2 for post_arrival"
    t.integer "ry_bus_user_id"
    t.integer "service_id"
    t.integer "status"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["journey_date"], name: "idx_journey_date"
    t.index ["service_id"], name: "idx_service_id"
  end

  create_table "smart_bus_crew_report_issue_catagories", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "abbreviation", limit: 45
    t.boolean "active"
    t.datetime "created_at", precision: nil, null: false
    t.integer "issue_for", default: 0, null: false
    t.string "name"
    t.integer "sequence", default: 0, null: false
    t.datetime "updated_at", precision: nil, null: false, comment: "0 for bus \n1 for lounge"
  end

  create_table "smart_bus_crew_report_issue_sub_catagories", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.boolean "active"
    t.datetime "created_at", precision: nil, null: false
    t.integer "crew_report_issue_catagory_id"
    t.string "name"
    t.integer "option_for", default: 0, null: false, comment: "0 for Captain \n1 for Customer\n2 for Captain & Customer"
    t.integer "resolution_window", default: 0, null: false, comment: "Resolution Window (in Days)"
    t.integer "responsible", default: 0, null: false, comment: "0 for IntrCity\n1 for Operator"
    t.integer "sequence", default: 0, null: false
    t.datetime "updated_at", precision: nil, null: false, comment: "Resolution Window (in Days)"
  end

  create_table "smart_bus_geo_fence_detectors", charset: "latin1", force: :cascade do |t|
    t.string "bus_number", collation: "utf8mb3_unicode_ci"
    t.datetime "created_at", precision: nil, null: false
    t.date "journey_date"
    t.integer "service_id"
    t.integer "service_poi_timing_id"
    t.integer "status"
    t.decimal "triggering_location_latitude", precision: 10, scale: 6
    t.decimal "triggering_location_longitude", precision: 10, scale: 6
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "smart_bus_goldseat_alerts", charset: "latin1", force: :cascade do |t|
    t.string "alert_duration"
    t.datetime "alert_generation", precision: nil
    t.integer "alert_id"
    t.string "alert_info"
    t.string "alert_location"
    t.string "alert_type"
    t.integer "boarding_point_id"
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "description"
    t.integer "gds_bus_id"
    t.string "imei"
    t.float "latitude"
    t.float "longitude"
    t.date "service_start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.string "vehicle_name"
    t.string "vehicle_no"
    t.index ["boarding_point_id"], name: "idx_boarding_point_id"
    t.index ["bus_service_id"], name: "idx_service_id"
    t.index ["created_at"], name: "idx_created_at"
    t.index ["gds_bus_id"], name: "idx_gds_bus_id"
    t.index ["service_start_date"], name: "idx_service_start_date"
  end

  create_table "smart_bus_goldseat_feed_points", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.boolean "ac"
    t.string "battery_type"
    t.bigint "bearing"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "device_tagged"
    t.float "distance"
    t.string "door1"
    t.string "door2"
    t.string "door3"
    t.string "door4"
    t.float "fuel"
    t.integer "gds_bus_id", null: false
    t.datetime "gold_track_datetime", precision: nil
    t.boolean "gps"
    t.boolean "ign"
    t.string "input_1"
    t.string "input_2"
    t.boolean "journey_active"
    t.datetime "last_update_utc", precision: nil
    t.decimal "latitude", precision: 12, scale: 9
    t.string "location"
    t.decimal "longitude", precision: 12, scale: 9
    t.float "odometer"
    t.string "poi"
    t.boolean "power"
    t.datetime "reported_at", precision: nil
    t.integer "sent_data", default: 0
    t.string "sent_data_error"
    t.string "sos"
    t.float "speed"
    t.string "status"
    t.float "temperature"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["created_at"], name: "idx_created_at"
    t.index ["gds_bus_id", "reported_at"], name: "idx_bus_id_reported_at"
    t.index ["gds_bus_id"], name: "idx_gds_bus_id"
  end

  create_table "smart_bus_goldseat_feed_points_29122020", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.boolean "ac"
    t.string "battery_type"
    t.bigint "bearing"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "device_tagged"
    t.float "distance"
    t.string "door1"
    t.string "door2"
    t.string "door3"
    t.string "door4"
    t.float "fuel"
    t.integer "gds_bus_id", null: false
    t.boolean "gps"
    t.boolean "ign"
    t.string "input_1"
    t.string "input_2"
    t.boolean "journey_active"
    t.datetime "last_update_utc", precision: nil
    t.float "latitude"
    t.string "location"
    t.float "longitude"
    t.float "odometer"
    t.string "poi"
    t.boolean "power"
    t.datetime "reported_at", precision: nil
    t.integer "sent_data", default: 0
    t.string "sent_data_error"
    t.string "sos"
    t.float "speed"
    t.string "status"
    t.float "temperature"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["gds_bus_id"], name: "idx_gds_bus_id"
  end

  create_table "smart_bus_goldseat_feed_points_old", charset: "latin1", force: :cascade do |t|
    t.boolean "ac"
    t.string "battery_type"
    t.bigint "bearing"
    t.bigint "bus_detail_id"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "device_tagged"
    t.float "distance"
    t.string "door1"
    t.string "door2"
    t.string "door3"
    t.string "door4"
    t.float "fuel"
    t.boolean "gps"
    t.boolean "ign"
    t.string "input_1"
    t.string "input_2"
    t.boolean "journey_active"
    t.datetime "last_update_utc", precision: nil
    t.float "latitude"
    t.string "location"
    t.float "longitude"
    t.float "odometer"
    t.string "poi"
    t.boolean "power"
    t.datetime "reported_at", precision: nil
    t.string "sos"
    t.float "speed"
    t.string "status"
    t.float "temperature"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_detail_id"], name: "index_goldseat_feed_points_on_smart_bus_bus_detail_id"
  end

  create_table "smart_bus_goldseat_pois", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "city_name"
    t.integer "poi_address_category_id"
    t.string "poi_address_category_name"
    t.string "poi_description"
    t.integer "poi_id"
    t.float "poi_latitude"
    t.float "poi_longitude"
    t.string "poi_name"
    t.integer "poi_tolerance"
    t.integer "status", limit: 1, default: 0, null: false
    t.string "street1"
    t.integer "zipcode"
  end

  create_table "smart_bus_locations", charset: "latin1", force: :cascade do |t|
    t.float "accuracy"
    t.string "bus_number", collation: "utf8mb3_unicode_ci"
    t.integer "cell_id"
    t.datetime "created_at", precision: nil, null: false
    t.date "journey_date"
    t.integer "lac"
    t.float "latitude"
    t.float "longitude"
    t.integer "mcc"
    t.integer "mnc"
    t.string "provider", collation: "utf8mb3_unicode_ci"
    t.integer "service_id"
    t.float "speed"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.index ["created_at"], name: "idx_created_at"
  end

  create_table "smart_bus_messages", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "action"
    t.datetime "created_at", precision: nil, null: false
    t.text "description", null: false
    t.integer "event_id"
    t.string "message_name", default: ""
    t.integer "message_type", default: 0, null: false
    t.integer "sequence", default: 1, null: false
    t.boolean "status", default: false, null: false
    t.string "title", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "v_code", default: 0
    t.integer "vehicle_type", default: 0, null: false
    t.index ["id"], name: "id_UNIQUE", unique: true
  end

  create_table "smart_bus_operator_payouts", charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "extra_seats_bought"
    t.float "extra_seats_bought_amt"
    t.integer "extra_seats_sold"
    t.float "extra_seats_sold_amt"
    t.float "incentive_amt"
    t.float "min_guarantee_amt"
    t.date "payout_date"
    t.float "penalty_amt"
    t.bigint "service_id"
    t.boolean "service_state"
    t.float "total_amt"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["service_id"], name: "index_smart_bus_operator_payouts_on_service_id"
  end

  create_table "smart_bus_reasons", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "active", limit: 1, default: 0
    t.string "cancellation_type"
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.integer "point_type", default: 0, comment: "0 for source\n1 for intermediate\n2 for destination"
    t.integer "reason_for_boarding_status", default: 0, null: false
    t.integer "reason_type", default: 0, null: false, comment: "0 for crew\n1 for passenger"
    t.string "suggestion"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "smart_bus_reported_issue_status_reports", charset: "latin1", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "issue_id", null: false
    t.datetime "resolution_date", precision: nil, null: false
    t.integer "status", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "updated_by", null: false
    t.string "updated_type", limit: 45
    t.index ["issue_id"], name: "idx_issue_id"
  end

  create_table "smart_bus_reported_issues", charset: "latin1", force: :cascade do |t|
    t.string "bus_number", limit: 45
    t.datetime "created_at", precision: nil, null: false
    t.text "issue_details", collation: "utf8mb4_unicode_ci"
    t.date "journey_date"
    t.integer "lounge_id"
    t.text "media"
    t.integer "nps_survey_data_id"
    t.string "pnr"
    t.datetime "reported_at", precision: nil
    t.boolean "reported_by_passenger", default: false, null: false, comment: "0 for false(reported by login crew member) and 1 for true(reported by passenger)"
    t.integer "resourceable_id"
    t.string "resourceable_type"
    t.string "seat_number"
    t.integer "service_id"
    t.integer "smart_bus_crew_report_issue_sub_catagory_id"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "updated_by"
    t.string "updated_type"
    t.index ["bus_number"], name: "idx_bus_number"
    t.index ["lounge_id"], name: "idx_lounge_id"
  end

  create_table "smart_bus_run_infos", charset: "latin1", force: :cascade do |t|
    t.datetime "arrival_time", precision: nil
    t.boolean "cap_arr_loc", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "delay_min"
    t.text "delay_reason"
    t.datetime "departure_time", precision: nil
    t.date "journey_date"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.text "location_object"
    t.integer "poi_id"
    t.string "point_name"
    t.datetime "point_time", precision: nil
    t.integer "point_type", default: 0, comment: "0 for source 1 for intermediate and 2 for destination"
    t.integer "ry_bus_user_id"
    t.integer "service_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["id"], name: "id_UNIQUE", unique: true
  end

  create_table "smart_bus_score_categories", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_active"
    t.string "name"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "smart_bus_service_pair_contribution_details", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "bus_type"
    t.float "contribution_ic_per_trip"
    t.float "contribution_to_ic"
    t.float "contribution_to_ic_per"
    t.datetime "created_at", precision: nil, null: false
    t.float "fill_per"
    t.float "final_cost"
    t.float "final_cost_per_trip"
    t.boolean "is_active", default: true
    t.string "month_year", limit: 45
    t.float "net_revenue"
    t.float "net_revenue_per_trip"
    t.float "non_ticketing_revenue"
    t.float "non_ticketing_revenue_per_trip"
    t.string "operator", limit: 100
    t.float "operator_share"
    t.float "operator_share_per_trip"
    t.string "round_route", limit: 100
    t.float "round_trips"
    t.integer "seats_inventory"
    t.integer "seats_sold"
    t.text "service_pair"
    t.string "state", limit: 100
    t.string "sub_zone", limit: 100
    t.float "ticketing_revenue"
    t.float "ticketing_revenue_per_trip"
    t.datetime "updated_at", precision: nil, null: false
    t.string "zone", limit: 45
    t.index ["month_year", "zone", "round_route"], name: "year_month_round_route_index"
  end

  create_table "smart_bus_tout_routes", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "route_id"
    t.integer "smart_bus_tout_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["id"], name: "id_UNIQUE", unique: true
    t.index ["route_id"], name: "route_id"
    t.index ["smart_bus_tout_id"], name: "smart_bus_tout_id"
  end

  create_table "smart_bus_touts", charset: "latin1", force: :cascade do |t|
    t.boolean "active", default: false, null: false, comment: "0 for inactive and 1 for active"
    t.integer "city_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "mobile_number", limit: 45, null: false
    t.string "name", null: false
    t.integer "otp"
    t.datetime "otp_sent_at", precision: nil
    t.datetime "otp_verified_at", precision: nil
    t.datetime "updated_at", precision: nil, null: false
    t.index ["id"], name: "id_UNIQUE", unique: true
    t.index ["mobile_number"], name: "mobile_number_UNIQUE", unique: true
  end

  create_table "smartbus_trackings", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "api_error"
    t.string "api_name"
    t.text "api_response"
    t.string "api_url"
    t.integer "booking_id"
    t.string "client_name"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_success", default: true
    t.text "request_params"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["booking_id"], name: "idx_booking_id"
  end

  create_table "smartclub_calenders", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "blockable_id"
    t.string "blockable_type"
    t.datetime "created_at", precision: nil
    t.boolean "is_active", default: true, null: false
    t.datetime "updated_at", precision: nil
    t.date "user_journey_date"
  end

  create_table "sms_contents", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", precision: nil, null: false
    t.string "label"
    t.boolean "status"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["label"], name: "label"
  end

  create_table "state_changes", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "changer_id"
    t.string "changer_type"
    t.datetime "created_at", precision: nil, null: false
    t.string "current_state"
    t.string "previous_state"
    t.string "reason"
    t.integer "resourcable_id"
    t.string "resourcable_type"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["resourcable_type", "resourcable_id"], name: "index_state_changes_on_resourcable_type_and_resourcable_id"
  end

  create_table "support_call_details", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_service_id"
    t.integer "call_disposition_id"
    t.datetime "call_time", precision: nil
    t.string "comment"
    t.datetime "created_at", precision: nil, null: false
    t.string "disposition"
    t.string "phone_no"
    t.string "pnr"
    t.string "recording_url"
    t.date "service_start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.string "username"
  end

  create_table "tags", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "tag_name"
    t.string "tag_type", limit: 45
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "temp_mapped_seats", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_seat_id"
    t.string "bus_seat_no", limit: 50
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "mapped_seat_id"
    t.string "mapped_seat_no", limit: 50
    t.date "service_start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id"], name: "idx_bus_service_id"
    t.index ["service_start_date"], name: "idx_service_start_date"
  end

  create_table "temp_table", primary_key: "col1", id: :integer, default: nil, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "col10", limit: 45
    t.integer "col2"
    t.string "col3", limit: 45
    t.string "col4", limit: 45
    t.string "col5", limit: 45
    t.string "col6", limit: 45
    t.string "col7", limit: 45
    t.string "col8", limit: 45
    t.string "col9", limit: 45
  end

  create_table "tracking_details", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.text "request_json"
    t.text "response_json"
    t.integer "tracking_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["tracking_id"], name: "index_tracking_details_on_tracking_id"
  end

  create_table "tracking_fare_requests", id: :integer, charset: "latin1", force: :cascade do |t|
    t.text "bus_seat_ids"
    t.integer "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.float "flat_fares"
    t.integer "gds_bus_id"
    t.text "route_ids"
    t.text "seat_fares"
    t.text "seat_nos"
    t.date "service_start_date", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.index ["bus_service_id"], name: "idx_bus_service_id"
    t.index ["service_start_date"], name: "idx_service_start_date"
  end

  create_table "trackings", charset: "latin1", force: :cascade do |t|
    t.string "api_name"
    t.integer "api_version", default: 1
    t.integer "boarding_point_id"
    t.string "boarding_point_name"
    t.integer "booking_id"
    t.string "booking_source"
    t.integer "bus_service_id"
    t.integer "bus_service_route_id"
    t.decimal "cancellation_perc", precision: 5, scale: 2
    t.datetime "created_at", precision: nil, null: false
    t.integer "dropping_point_id"
    t.string "dropping_point_name"
    t.text "failed_reason"
    t.integer "from_city_id"
    t.string "from_city_name"
    t.string "gds_booking_id"
    t.integer "gds_client_id"
    t.string "gds_client_name"
    t.boolean "is_cancellable"
    t.boolean "is_success", default: true
    t.date "journey_date"
    t.integer "passenger_size"
    t.string "pnr"
    t.float "refund_amount"
    t.string "remote_ip"
    t.date "request_date"
    t.datetime "request_time", precision: nil
    t.decimal "response_time", precision: 5, scale: 2
    t.boolean "system_calls", default: false
    t.string "tentative_booking_id"
    t.integer "to_city_id"
    t.string "to_city_name"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.string "user_primary_email"
    t.string "user_primary_phone_number"
    t.index ["from_city_id", "to_city_id"], name: "index_trackings_on_from_city_id_and_to_city_id"
    t.index ["gds_booking_id"], name: "idx_gds_booking_id"
    t.index ["gds_client_id"], name: "index_trackings_on_gds_client_id"
    t.index ["journey_date"], name: "index_trackings_on_journey_date"
    t.index ["request_date"], name: "index_trackings_on_request_date"
  end

  create_table "translated_words", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "converted_from"
    t.string "converted_word"
    t.datetime "created_at", precision: nil, null: false
    t.string "from_lang"
    t.boolean "in_use"
    t.string "to_lang"
    t.datetime "updated_at", precision: nil, null: false
    t.string "word"
    t.index ["word", "to_lang"], name: "idx_word_to_lang"
  end

  create_table "unsold_service_seats", charset: "latin1", force: :cascade do |t|
    t.bigint "bus_service_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "destination_id"
    t.string "route"
    t.decimal "route_distance", precision: 10, scale: 3
    t.string "service_name"
    t.date "service_start_date"
    t.integer "source_id"
    t.string "sub_route"
    t.integer "unsold_seat_count"
    t.string "unsold_seats"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bus_service_id"], name: "idx_bus_service_id"
    t.index ["service_start_date"], name: "idx_service_start_date"
    t.index ["sub_route"], name: "idx_route"
  end

  create_table "uploaded_files", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "comment"
    t.datetime "created_at", precision: nil, null: false
    t.string "file_content_type"
    t.string "file_name"
    t.float "file_size"
    t.string "file_url", limit: 1000
    t.datetime "processed_at", precision: nil
    t.integer "status"
    t.datetime "updated_at", precision: nil, null: false
    t.string "uploaded_by"
  end

  create_table "users", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "client_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "email"
    t.string "last_login"
    t.integer "operator_id"
    t.string "password_digest"
    t.string "role"
    t.integer "role_id"
    t.boolean "status", default: true, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["client_id"], name: "idx_client_id"
    t.index ["operator_id"], name: "idx_operator_id"
    t.index ["role_id"], name: "idx_role_id"
  end

  create_table "van_available_seats", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "available_seats", null: false
    t.integer "booked_seats", null: false
    t.string "bus_service_ids", null: false
    t.datetime "created_at", precision: nil, null: false
    t.text "disable_point_response"
    t.text "disabled_point_ids"
    t.boolean "is_active", default: true
    t.string "master_seat_layout_ids", null: false
    t.text "point_ids"
    t.string "point_type", limit: 45
    t.date "service_start_date", null: false
    t.integer "total_seats", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "van_route_service_group_id"
    t.string "van_service_route_ids", null: false
  end

  create_table "van_operating_days", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "cancellation_reason"
    t.datetime "cancelled_at", precision: nil
    t.string "cancelled_by"
    t.datetime "created_at", precision: nil, null: false
    t.integer "od_status", limit: 1, default: 1, null: false
    t.date "on_date"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by"
    t.integer "van_route_id"
    t.index ["on_date"], name: "on_date"
    t.index ["van_route_id", "on_date", "od_status"], name: "idx_van_route_id_on_date_active"
    t.index ["van_route_id"], name: "van_route_id"
  end

  create_table "van_passengers", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "boarding_point_id", null: false
    t.integer "booking_id", null: false
    t.integer "booking_status", limit: 1, null: false
    t.integer "bus_service_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "dropping_point_id", null: false
    t.boolean "is_active", default: true
    t.integer "passenger_detail_id", null: false
    t.string "point_type", limit: 50
    t.date "service_start_date", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "van_registration_no", limit: 20
    t.integer "van_route_service_group_id"
    t.integer "van_service_route_id"
    t.index ["booking_id"], name: "idx_booking_id"
    t.index ["van_route_service_group_id"], name: "idx_vrsg_id"
    t.index ["van_service_route_id"], name: "idx_vsr_id"
  end

  create_table "van_provider_agreements", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "additional_per_trip", null: false
    t.date "agreement_end_date"
    t.date "agreement_start_date", null: false
    t.string "cost_type", limit: 45, null: false
    t.datetime "created_at", precision: nil, null: false
    t.float "distance_km", null: false
    t.float "emi", null: false
    t.integer "free_halt", null: false
    t.float "fuel_cost", null: false
    t.float "fuel_mileage", null: false
    t.float "fuel_price", null: false
    t.float "fuel_qty", null: false
    t.boolean "is_active", null: false
    t.float "minimum_guarantee", null: false
    t.integer "minimum_trip", null: false
    t.float "others", null: false
    t.string "payout_cycle", limit: 45, null: false
    t.float "planned_halt_charge", null: false
    t.string "registration_no", limit: 50, null: false
    t.float "staff_payment", null: false
    t.float "tax", null: false
    t.float "tyres_maint", null: false
    t.integer "up_to_trips", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by", limit: 100, null: false
    t.integer "van_id", null: false
    t.integer "van_provider_id", null: false
    t.string "van_provider_type", limit: 45, null: false
    t.string "van_service_type", limit: 45, null: false
  end

  create_table "van_providers", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "address"
    t.string "contact_no", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "email"
    t.string "gst_no"
    t.string "other_nos", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "vp_name"
    t.boolean "vp_status"
  end

  create_table "van_route_crews", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "bus_member_id"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "crew_status", default: false
    t.string "crew_type", limit: 50
    t.date "on_date"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by", limit: 100
    t.integer "vrs_group_id"
    t.index ["bus_member_id", "on_date"], name: "composite_idx_member_on_date"
    t.index ["bus_member_id"], name: "idx_bus_member_id"
    t.index ["vrs_group_id", "on_date"], name: "composite_idx_vrs_on_date"
    t.index ["vrs_group_id"], name: "idx_vrs_group_id"
  end

  create_table "van_route_service_groups", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_member_id"
    t.string "bus_service_ids", null: false
    t.datetime "created_at", precision: nil, null: false
    t.float "feeder_van_service_charge"
    t.date "from_date"
    t.boolean "is_active", default: true, null: false
    t.boolean "is_feeder_van_service", default: false
    t.text "request_params"
    t.string "time_frame"
    t.date "to_date"
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by", limit: 100, null: false
    t.string "van_registration_no", limit: 45, null: false
    t.string "vs_route_ids", null: false
    t.index ["bus_member_id"], name: "idx_bus_member_id"
    t.index ["van_registration_no"], name: "idx_van_no"
  end

  create_table "van_run_infos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "arr_dep_time", precision: nil
    t.integer "bus_member_id"
    t.boolean "cap_arr_loc", default: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "delay_min"
    t.text "delay_reason"
    t.decimal "latitude", precision: 10, scale: 6
    t.text "location_object"
    t.decimal "longitude", precision: 10, scale: 6
    t.integer "point_id"
    t.string "point_name"
    t.datetime "point_time", precision: nil
    t.integer "point_type"
    t.date "service_start_date"
    t.datetime "updated_at", precision: nil, null: false
    t.string "van_registration_no"
    t.integer "vrs_group_id"
    t.index ["van_registration_no", "service_start_date"], name: "idx_registration_no_service_date"
    t.index ["vrs_group_id", "service_start_date"], name: "idx_assign_id_service_date"
  end

  create_table "van_service_route_mappings", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "bus_member_id"
    t.float "cost_per_trip"
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_active", default: true
    t.integer "master_seat_layout_id", null: false
    t.date "on_date"
    t.boolean "running_status", default: true
    t.datetime "updated_at", precision: nil, null: false
    t.string "van_registration_no", limit: 50
    t.integer "van_route_service_group_id", null: false
    t.integer "van_service_route_id", null: false
    t.index ["master_seat_layout_id"], name: "idx_master_seat_layout_id"
    t.index ["on_date"], name: "idx_on_date"
    t.index ["van_registration_no"], name: "idx_van_registration_no"
    t.index ["van_route_service_group_id"], name: "idx_vrsg_id"
    t.index ["van_service_route_id"], name: "idx_van_service_route_id"
  end

  create_table "van_service_route_paths", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "service_point_id"
    t.integer "stop_no"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "van_service_route_id"
    t.boolean "vp_status", default: true, null: false
    t.index ["service_point_id"], name: "idx_service_point_id"
    t.index ["van_service_route_id"], name: "idx_van_service_route_id"
  end

  create_table "van_service_routes", id: :integer, charset: "latin1", force: :cascade do |t|
    t.boolean "block_excess_booking", default: false
    t.integer "cityflo_route_slot_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "dropoff_point_id", null: false
    t.boolean "is_pickup", default: true
    t.integer "pickup_point_id", null: false
    t.integer "service_route_master_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "vp_status", default: true, null: false
    t.index ["dropoff_point_id"], name: "idx_dropoff_point_id"
    t.index ["pickup_point_id"], name: "idx_point_id"
  end

  create_table "vans", id: :integer, charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.boolean "is_ac", default: false, null: false, comment: "1=AC;0=NON_AC"
    t.boolean "is_feeder", default: false
    t.integer "master_seat_layout_id"
    t.string "registration_no", limit: 25, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "van_agreement", default: false, null: false
    t.integer "van_provider_id"
    t.boolean "van_status", default: true, null: false, comment: "1=active;0=inactive"
    t.integer "vehicle_id"
    t.index ["registration_no"], name: "registration_no_index"
  end

  create_table "vbc_service_durations", id: :integer, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "activated_by", limit: 250, null: false
    t.integer "bus_service_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "deactivated_by", limit: 250
    t.date "from_date", null: false
    t.boolean "is_active", default: true
    t.boolean "on_demand_vbc", default: false
    t.date "to_date", null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "vehicle_docs", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "fas_tag_issuer_by", limit: 100
    t.string "fas_tag_no", limit: 20
    t.date "fitness_valid_upto"
    t.string "fleet_code", limit: 100
    t.string "insurance_url"
    t.date "insurance_valid_upto"
    t.string "insurer", limit: 100
    t.date "puc_valid_upto"
    t.string "rc_url"
    t.date "road_tax_valid_upto"
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }, null: false
    t.bigint "vehicle_id", null: false, unsigned: true
    t.index ["vehicle_id"], name: "fk_vehicle_docs_vehicle"
  end

  create_table "vehicle_feed_points", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.boolean "ac"
    t.datetime "created_at", precision: nil, null: false
    t.float "distance"
    t.string "feed_source", null: false
    t.float "fuel"
    t.datetime "gold_track_datetime", precision: nil
    t.boolean "gps"
    t.boolean "ign"
    t.float "latitude"
    t.string "location"
    t.float "longitude"
    t.float "odometer"
    t.string "poi"
    t.boolean "power"
    t.datetime "reported_at", precision: nil
    t.integer "sent_data", default: 0
    t.string "sent_data_error"
    t.string "sos"
    t.float "speed"
    t.string "status"
    t.float "temperature"
    t.datetime "updated_at", precision: nil, null: false
    t.string "vehicle_no", null: false
    t.string "vehicle_type", null: false
    t.index ["vehicle_no", "reported_at"], name: "idx_vehicle_no_reported_at"
  end

  create_table "vehicle_image_videos", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.text "description"
    t.string "media_type", limit: 30, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" }, null: false
    t.string "url", null: false
    t.bigint "vehicle_id", null: false, unsigned: true
    t.index ["media_type"], name: "idx_media_type"
    t.index ["vehicle_id"], name: "idx_vehicle_id"
  end

  create_table "vehicle_peripherals", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "air_freshner", limit: 1, default: 0
    t.integer "aqi_filters", limit: 1, default: 0
    t.integer "aqi_monitor", limit: 1, default: 0
    t.integer "berth_ad_unit", limit: 1, default: 0
    t.string "captain_seat", limit: 50
    t.integer "cctv_installed", limit: 1, default: 0
    t.datetime "created_at", precision: nil, null: false
    t.integer "gps_installed", limit: 1, default: 0
    t.integer "seat_ad_unit", limit: 1, default: 0
    t.string "telematics_provider", limit: 50
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "vehicle_id", null: false, unsigned: true
    t.integer "washroom_poster", limit: 1, default: 0
    t.index ["vehicle_id"], name: "uniq_vehicle_peripherals_vehicle_id", unique: true
  end

  create_table "vehicle_safeties", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "adas", limit: 1, default: 0
    t.integer "camera_count", default: 0
    t.datetime "created_at", precision: nil, null: false
    t.integer "dmas", limit: 1, default: 0
    t.integer "emergency_exit_door_count", default: 0
    t.integer "emergency_hammer_count", default: 0
    t.integer "escape_roof_hatch", limit: 1, default: 0
    t.integer "fdss", limit: 1, default: 0
    t.integer "fire_extinguisher", limit: 1, default: 0
    t.date "fire_extinguisher_valid_upto"
    t.integer "first_aid_kit", limit: 1, default: 0
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "vehicle_id", null: false, unsigned: true
    t.index ["vehicle_id"], name: "uniq_vehicle_safeties_vehicle_id", unique: true
  end

  create_table "vehicle_specifications", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "ac_company", limit: 50
    t.string "ac_type", limit: 30
    t.string "air_suspension", limit: 100
    t.boolean "amplifier", default: false
    t.string "berth_shared_dimension", limit: 20
    t.string "berth_single_dimension", limit: 20
    t.boolean "calf_support_seat", default: false
    t.string "charger_type", limit: 100
    t.datetime "created_at", precision: nil, null: false
    t.json "curtains"
    t.boolean "fog_lights", default: false
    t.boolean "is_ac", default: false
    t.string "partition_type", limit: 50
    t.string "pillow", limit: 20
    t.boolean "reading_lights", default: false
    t.string "seat_headroom", limit: 20
    t.string "seat_layout", limit: 45
    t.string "seat_type", limit: 50
    t.integer "seats_count"
    t.integer "shared_count"
    t.integer "singles_count"
    t.boolean "speakers", default: false
    t.string "speed_lock", limit: 30
    t.integer "total_seats"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "vehicle_id", null: false, unsigned: true
    t.boolean "washroom"
    t.string "washroom_category", limit: 30
    t.string "washroom_position", limit: 50
    t.json "washroom_type"
    t.boolean "washroom_water_level_indicator", default: false
    t.string "waste_disposal_type", limit: 30
    t.string "water_tank_position", limit: 30
    t.float "water_tank_volume"
    t.index ["vehicle_id"], name: "fk_vehicle_specifications_vehicle"
  end

  create_table "vehicles", id: { type: :bigint, unsigned: true }, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "body_builder", limit: 50
    t.string "bs_type", limit: 20
    t.string "bus_type", limit: 45
    t.string "chassis_number", limit: 50
    t.decimal "claimed_fuel_efficiency", precision: 5, scale: 2
    t.datetime "created_at", precision: nil, null: false
    t.string "engine_number", limit: 50
    t.string "fuel_type", limit: 20
    t.string "make", limit: 50
    t.date "manufacturing_rc_at"
    t.string "model", limit: 50
    t.integer "operator_id"
    t.string "registration_number", limit: 50
    t.date "registration_rc_at"
    t.integer "status", limit: 1, default: 0, null: false
    t.string "temp_number", limit: 50
    t.datetime "updated_at", precision: nil, null: false
    t.string "updated_by", limit: 100
    t.string "vehicle_category", limit: 30
    t.string "vehicle_type", limit: 50
    t.index ["registration_number"], name: "idx_registration_number"
    t.index ["temp_number"], name: "idx_temp_number"
  end

  create_table "vendors", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "contact_person_name"
    t.date "contract_end_date"
    t.date "contract_start_date"
    t.datetime "created_at", precision: nil
    t.string "email"
    t.string "name"
    t.boolean "status", default: false, null: false
    t.datetime "updated_at", precision: nil
    t.index ["id"], name: "id_UNIQUE", unique: true
  end

  create_table "warehouse_consignments", charset: "latin1", force: :cascade do |t|
    t.string "added_by", limit: 45
    t.string "awb_no", limit: 45
    t.string "comment"
    t.string "consignment_no", limit: 50
    t.string "courier_partner", limit: 45
    t.datetime "created_at", null: false
    t.integer "from_warehouse_id"
    t.integer "lounge_id"
    t.text "memo"
    t.string "out_to", limit: 10
    t.string "po_no", limit: 25
    t.column "status", "enum('initialized','in_progress','complete','in_transit','received','discarded')", default: "initialized"
    t.string "stock_type", limit: 10
    t.integer "to_warehouse_id"
    t.datetime "updated_at", null: false
    t.integer "warehouse_id"
  end

  create_table "warehouse_inventories", charset: "latin1", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "is_inactive", default: false, null: false
    t.integer "product_id"
    t.string "quantity"
    t.boolean "status", default: true
    t.datetime "updated_at", null: false
    t.integer "warehouse_id"
  end

  create_table "warehouse_inventory_details", charset: "latin1", force: :cascade do |t|
    t.string "batch_serial_no", limit: 30
    t.string "comment"
    t.datetime "created_at", null: false
    t.date "expiry"
    t.float "price"
    t.integer "product_id"
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.string "warehouse_lot_id", limit: 30
    t.index ["product_id"], name: "index_warehouse_inventory_details_on_product_id"
    t.index ["product_id"], name: "warehouse_product"
  end

  create_table "warehouse_lots", charset: "latin1", force: :cascade do |t|
    t.string "batch_serial_no", limit: 15
    t.integer "boxes", default: 0
    t.string "comment"
    t.integer "consignment_id"
    t.datetime "created_at"
    t.date "expiry"
    t.boolean "is_inactive", default: false, null: false
    t.string "lot_no"
    t.integer "piece_per_box", default: 0
    t.decimal "price", precision: 5, scale: 2
    t.integer "product_id"
    t.column "sent_to_lounge", "enum('no','added','sent')", default: "no"
    t.boolean "status", default: false
    t.integer "total_qty", default: 0
    t.integer "total_qty_remaining", default: 0
    t.datetime "updated_at"
  end

  create_table "warehouse_return_details", charset: "latin1", force: :cascade do |t|
    t.string "comment"
    t.datetime "created_at", null: false
    t.integer "damaged", default: 0, null: false
    t.integer "expired", default: 0, null: false
    t.integer "in_stock", default: 0, null: false
    t.integer "in_stock_remaining", default: 0, null: false
    t.string "item_code"
    t.integer "item_qty"
    t.integer "item_remaining", default: 0
    t.integer "product_id"
    t.column "return_type", "enum('in_stock','damaged','expired')", default: "in_stock", null: false
    t.datetime "updated_at", null: false
    t.integer "warehouse_return_id"
  end

  create_table "warehouse_return_stock", charset: "latin1", force: :cascade do |t|
    t.string "added_by", limit: 75
    t.string "added_to_warehouse_by", limit: 100
    t.string "comment", limit: 100
    t.datetime "created_at", null: false
    t.integer "damaged", default: 0, null: false
    t.integer "expired", default: 0, null: false
    t.integer "in_stock", default: 0, null: false
    t.integer "product_id", default: 1, null: false
    t.boolean "status", default: false, null: false
    t.datetime "updated_at", null: false
    t.integer "warehouse_return_detail_id", null: false
    t.integer "warehouse_return_id", null: false
  end

  create_table "warehouse_returns", charset: "latin1", force: :cascade do |t|
    t.string "comment"
    t.datetime "created_at", null: false
    t.integer "lounge_id"
    t.string "returned_by"
    t.integer "total_returned_qty", default: 0
    t.datetime "updated_at", null: false
    t.integer "warehouse_id"
  end

  create_table "warehouse_users", charset: "latin1", force: :cascade do |t|
    t.string "avatar_url", limit: 100
    t.datetime "created_at", null: false
    t.string "email"
    t.string "encrypted_password", default: "25d55ad283aa400af464c76d713c07ad"
    t.string "name"
    t.string "provider"
    t.string "uid"
    t.datetime "updated_at", null: false
  end

  create_table "warehouses", charset: "latin1", force: :cascade do |t|
    t.string "address"
    t.integer "city_id"
    t.string "city_name"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "google_map_url"
    t.string "landmark"
    t.float "lat"
    t.float "lng"
    t.integer "lounge_id"
    t.integer "manager_id"
    t.string "manager_name"
    t.string "manager_phone"
    t.string "name"
    t.boolean "status", default: true
    t.datetime "updated_at", null: false
  end

  create_table "webhook_end_points", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "client_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "events"
    t.string "secret_key"
    t.string "target_url", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["client_id"], name: "index_webhook_end_points_on_client_id"
  end

  create_table "zone_masters", id: :integer, charset: "latin1", force: :cascade do |t|
    t.boolean "is_active", default: true, null: false
    t.integer "parent_id"
    t.string "zone", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "booked_seats", "bookings", name: "__fk_rails_944bd5eed8"
  add_foreign_key "bus_amenities", "gds_buses"
  add_foreign_key "bus_service_amenities", "bus_services"
  add_foreign_key "operator_shops", "gds_operators", column: "operator_id", name: "operator_id", on_delete: :cascade
  add_foreign_key "passenger_details", "bookings", name: "__fk_rails_a652d3c4d7"
  add_foreign_key "point_image_videos", "boarding_points"
  add_foreign_key "smart_bus_goldseat_feed_points_old", "smart_bus_bus_details", column: "bus_detail_id"
  add_foreign_key "smart_bus_operator_payouts", "smart_bus_services", column: "service_id"
  add_foreign_key "vehicle_docs", "vehicles", name: "fk_vehicle_docs_vehicle", on_delete: :cascade
  add_foreign_key "vehicle_image_videos", "vehicles", name: "fk_vehicle_image_videos_vehicle", on_delete: :cascade
  add_foreign_key "vehicle_peripherals", "vehicles", name: "fk_vehicle_peripherals_vehicle", on_delete: :cascade
  add_foreign_key "vehicle_safeties", "vehicles", name: "fk_vehicle_safeties_vehicle", on_delete: :cascade
  add_foreign_key "vehicle_specifications", "vehicles", name: "fk_vehicle_specifications_vehicle", on_delete: :cascade
end
