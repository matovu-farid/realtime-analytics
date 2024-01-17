
# Real-Time Analytics

## Project Overview

This project is a demonstration of a real-time search analytics application, created as part of the Helpjuice Full-Stack Internship Test. The application features a real-time search functionality where users can search for articles, and it captures and displays analytics about these searches.

**Deployed App**: [Real-Time Analytics App](https://realtime-analytics-ae1974cb754c.herokuapp.com/)

**GitHub Repository**: [GitHub - Realtime Analytics](https://github.com/matovu-farid/realtime-analytics.git)

## Features

- Real-time search functionality for articles.
- Analytics dashboard displaying search trends and patterns.
- IP-based user tracking to segregate search data per user.
- Scalable architecture to handle high volumes of requests.
- Optimized for performance and instantaneous search experience.

## Getting Started

### Prerequisites

- Ruby on Rails
- PostgreSQL (or another database as configured)

### Installation

Clone the repository and install the dependencies:

```bash
git clone https://github.com/matovu-farid/realtime-analytics.git
cd realtime-analytics
bundle install
rails db:create db:migrate
```

### Running Locally

To run the application locally:

```bash
rails server
```

Then, navigate to `http://localhost:3000` in your web browser.

## Testing

This application includes a suite of tests to ensure functionality and scalability:

- Run tests using RSpec: `bundle exec rspec`

## Author

👤 **Matovu Farid Nkoba**

- GitHub: [@matovu-farid](https://github.com/matovu-farid)
- Twitter: [@matovu100](https://twitter.com/matovu100)
- LinkedIn: [matovu-farid](https://www.linkedin.com/in/matovu-farid-48b80257)

## Acknowledgments

- Thanks to the Helpjuice team for the opportunity to participate in this challenge.


