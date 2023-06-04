document.addEventListener("DOMContentLoaded", function() {
  
  var navLinks = document.querySelectorAll("nav a");
  navLinks.forEach(function(link) {
    link.addEventListener("click", navigateToSection);
  });
});

// Function to handle navigation when a link is clicked
function navigateToSection(event) {
  event.preventDefault(); // Prevent the default link behavior
  var target = event.target.getAttribute("href"); // Get the target section ID
  var section = document.querySelector(target); // Find the corresponding section
  section.scrollIntoView({ behavior: "smooth" }); // Scroll to the section
}
