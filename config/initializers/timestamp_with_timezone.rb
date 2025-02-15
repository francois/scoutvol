require "active_record/connection_adapters/postgresql_adapter"

# Use "timestamp with time zone" (timestamptz for short) columns for datetime
ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.datetime_type = :timestamptz
