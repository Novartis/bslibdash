(function ($, window, document) {
  "use strict";

  $(function () {

    $(document).on("click", ".fullscreen-toggle", function (e) {
      e.preventDefault();
      e.stopPropagation();

      const $btn  = $(this);
      const $root = $btn.closest(".fullscreen-card, .bslib-card, .card");
      const $enter = $root.find(".bslib-full-screen-enter").last();

      if ($enter.length) {
        $enter.trigger("click");
      }
    });
  });

})(jQuery, window, document);

(function ($, window, document) {
  "use strict";

  $(function () {

    $(document).on("click", ".card-hide-toggle", function (e) {
      e.preventDefault();
      e.stopPropagation();

      const $card = $(this).closest(".fullscreen-card, .bslib-card, .card");

      if (!$card.length) return;

      $card.addClass("d-none");
    });

  });

})(jQuery, window, document);

$(function () {
  $(".bslib-full-screen-enter").addClass("d-none");
  $(document).on("shiny:value shiny:connected", function (e) {
    $(e.target).find(".bslib-full-screen-enter").addClass("d-none");
  });
});
