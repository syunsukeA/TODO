module Api
  module V1
    class TodosController < BaseController
      DEFAULT_LIMIT = 20
      MAX_LIMIT = 100

      def create
        todo = Todo.new(todo_params)

        if todo.save
          render json: { id: todo.id, created_at: todo.created_at }, status: :created
        else
          render json: { errors: todo.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def index
        limit = limit_from_params
        todos = Todo.order(created_at: :desc).limit(limit)

        render json: { todos: todos.as_json(only: %i[id title created_at]) }, status: :ok
      rescue ArgumentError, TypeError
        render json: { errors: ["limit must be an integer between 1 and #{MAX_LIMIT}"] }, status: :bad_request
      end

      private

      def todo_params
        params.permit(:title)
      end

      def limit_from_params
        return DEFAULT_LIMIT if params[:limit].nil?

        value = Integer(params[:limit], 10)
        raise ArgumentError if value < 1 || value > MAX_LIMIT

        value
      end
    end
  end
end
