// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
//= require flatpickr

document.addEventListener("DOMContentLoaded", function () {
  flatpickr(".form-datepickr", {
    altInput: true,
    altFormat: "j F Y",
    maxDate: new Date(),
  });
});
