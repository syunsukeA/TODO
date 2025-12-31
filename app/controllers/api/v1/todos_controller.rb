module Api
  module V1
    class TodosController < BaseController
      def create
        todo = Todo.new(todo_params)

        if todo.save
          render json: { id: todo.id, created_at: todo.created_at }, status: :created
        else
          render json: { errors: todo.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def todo_params
        params.permit(:title)
      end
    end
  end
end
