Rails.application.config.session_store :active_record_store, key: '_employmate_session'
Rails.application.config.after_initialize do
  ActionDispatch::Session::ActiveRecordStore.session_class = Session
end
