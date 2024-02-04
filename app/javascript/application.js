// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
//= require flatpickr
//= require select2

document.addEventListener("DOMContentLoaded", function () {
  flatpickr(".form-datepickr", {
    altInput: true,
    altFormat: "j F Y",
    maxDate: new Date(),
  });
  $("select[multiple]").select2();
});
