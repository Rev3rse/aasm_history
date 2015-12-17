module AASM
  class Base
    def has_history enabled = true
      @options[:history_enabled] = enabled
      if enabled
        case AasmHistory::PersistanceDeterminator.determine(@klass)
          when :active_record
            configure :history_class, 'StateHistory'
            configure :creator_class, 'AasmHistory::Persistance::ActiveRecordCreator'
            @klass.send :prepend, AasmHistory::Persistance::ActiveRecord
          else
            raise AasmHistory::UnknownPersistanceLayer
        end
      end
    end

    def history_enabled?
      @options[:history_enabled]
    end
  end
end