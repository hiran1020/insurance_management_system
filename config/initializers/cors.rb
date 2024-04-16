

 Rails.application.config.middleware.insert_before 0, Rack::Cors do
   allow do
     origins "http://localhost:3000", "http://localhost:3001","http://localhost:5173","https://insurance-management-system-fe.vercel.app/"

     resource "*",
       headers: :any,
       methods: [:get, :post, :put, :patch, :delete, :options, :head]
   end
 end
