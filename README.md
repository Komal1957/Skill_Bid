SkillBid 💼💸
A modern, real-time reverse-bidding freelance marketplace built with Ruby on Rails 8. SkillBid allows clients to post requests and watch freelancers bid in real-time, complete with secure escrow payments and AI-powered descriptions.

🌟 Key Features
- Real-Time Bidding: Watch bids appear instantly using Turbo Streams and Action Cable (No page reload).
- Secure Escrow Payments: Integrated Stripe Checkout to hold funds in escrow until work is completed
- Live Chat: Built-in discussion board for Clients and Freelancers on every request.
- AI-Powered Descriptions: Integrated OpenAI API to auto-generate professional project description
- Role-Based Access Control: Separate workflows for Clients (Posters) and Freelancers (Bidders).
- Background Jobs: Sidekiq + Redis handle email notifications and automated auction closers.
- Modern UI: Clean, responsive dashboard interface built with Tailwind CSS.

🛠 Tech Stack
- Backend: Ruby on Rails 8.0, PostgreSQL, Redis
- Frontend: Hotwire (Turbo, Stimulus), Tailwind CSS
- Background Jobs: Sidekiq
- Payments: Stripe API
- AI: OpenAI API (GPT-3.5-turbo)
- File Storage: Active Storage
- Testing: RSpec (configured but basic)
- Admin Panel: ActiveAdmin

  📋 Prerequisites
Before running this project, ensure you have the following installed:

- Ruby: 3.2 or higher
- Node.js: 18+ (for Javascript assets)
- PostgreSQL: 14+
- Redis: 6+ (Required for Sidekiq & Caching)
- Git

🚀 Installation
- Clone the repository
  git clone https://github.com/your-username/skillbid.gitcd skillbid
- Install Dependencies
   bundle installnpm install
- Setup Database
  rails db:createrails db:migraterails db:seed
- Environment VariablesCreate a .env file in the root directory (copy .env.example if available) and add your API keys:
   STRIPE_SECRET_KEY=sk_test_...STRIPE_PUBLISHABLE_KEY=pk_test_...OPENAI_API_KEY=sk-...


  🏃 How to Run
Because this application uses Background Jobs (Sidekiq) and WebSockets, you need to run three separate processes in different terminal windows.

Terminal 1: Redis Server

- redis-server

Terminal 2: Rails Server
 - rails server

Terminal 3: Sidekiq Worker
- bundle exec sidekiq
Access the application at http://localhost:3000.

🧪 Testing the App
1. Sign Up:
- Register as a Client to post jobs.
- Register as a Freelancer to place bids.
2. Create a Request:
- As a Client, click "Post Request".
- Type a title and see the OpenAI suggestion fill the description.
- Set a budget and deadline.
3. Real-Time Bidding:
- Open the Request page in Chrome.
- Open the same page in Incognito Mode (logged in as Freelancer).
- Place a bid in Incognito. Watch it appear instantly in Chrome.
4. Payments:
- As a Client, click "Fund Project".
- Use Stripe test card: 4242 4242 4242 4242.
- See the status change to "Secured".

📁 Project Structure
- app/controllers/: Contains logic for Requests, Bids, Payments, and AI.
- app/models/: Uses STI for User roles (Client, Freelancer).
- app/javascript/controllers/: Stimulus controllers for the countdown timer and AI suggestions.
- app/jobs/: Background jobs for closing auctions.
- config/initializers/stripe.rb: Stripe configuration.

Outpu---

<img width="943" height="902" alt="image" src="https://github.com/user-attachments/assets/a6cb018a-7ef0-4ebc-8843-ea69191d23bd" />

<img width="1584" height="886" alt="image" src="https://github.com/user-attachments/assets/336dedf0-ef0c-4e21-a5d1-f570d5039448" />


Built with ❤️ using Ruby on Rails


