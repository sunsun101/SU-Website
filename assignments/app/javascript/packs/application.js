// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require jquery
//= require jquery_ujs
//= require jquery-fileupload/basic
// import Rails from "@rails/ujs";
// import Turbolinks from "turbolinks";
// import * as ActiveStorage from "@rails/activestorage";
// import "channels";
require("jquery");
require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
import "@fortawesome/fontawesome-free/js/all.min.js";
import "mdb-ui-kit/js/mdb.min.js";
import "@fortawesome/fontawesome-free/css/all.min.css";
import "mdb-ui-kit/css/mdb.min.css";
import "styles/application.scss";
import "packs/mdb.js";
import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css";
import "packs/custom.js";

// Rails.start();
// Turbolinks.start();
// ActiveStorage.start();
import "controllers";