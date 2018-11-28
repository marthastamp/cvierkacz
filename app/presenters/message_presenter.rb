class MessagePresenter < BasePresenter

    def publication_date
        @model.created_at.strftime("%A")
    end
end