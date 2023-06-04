// Backend server endpoint URL
const backendUrl = 'http://example.com/api';

// Function to handle registration form submission
function submitRegistrationForm(event) {
  event.preventDefault(); // Prevent the form from submitting normally

  // Get form data
  const form = document.getElementById('registrationForm');
  const formData = new FormData(form);

  // Send POST request to the backend
  fetch(`${backendUrl}/register`, {
    method: 'POST',
    body: formData
  })
  .then(response => response.json())
  .then(data => {
    // Handle the response from the backend
    console.log(data);
    // Update the UI or perform any necessary actions
  })
  .catch(error => {
    // Handle any errors that occur during the request
    console.error('Error:', error);
  });
}

// Wait for the DOM to be loaded
document.addEventListener('DOMContentLoaded', function() {
  // Add submit event listener to the registration form
  const registrationForm = document.getElementById('registrationForm');
  registrationForm.addEventListener('submit', submitRegistrationForm);
});
