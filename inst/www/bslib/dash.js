// dashboard-nav.bs5.js
(function ($, window, document) {
  "use strict";

  const NS = ".dash";
  const RESIZE_DELAY_MS = 50;

  const SEL = {
    toggle: "#sidebarToggle",
    sidebar: "#sidebar",
    sidebarClose: "#sidebarClose",
    sidebarBackdrop: ".app-sidebar-backdrop",
    sidebarMenu: "#sidebarMenu",
    navItem: "[data-nav-to]"
  };
  const MOBILE_BREAKPOINT_PX = 992; // Bootstrap lg
  let updateTabItemsHandlerBound = false;

  // Remembers the element that opened the overlay so focus can return to it
  // when the overlay closes.
  let $lastFocusBeforeOverlay = null;

  function isMobileViewport() {
    return window.matchMedia(`(max-width: ${MOBILE_BREAKPOINT_PX - 0.02}px)`).matches;
  }

  function ensureBackdrop() {
    let $bd = $(SEL.sidebarBackdrop);
    if (!$bd.length) {
      $bd = $('<div class="app-sidebar-backdrop"></div>').appendTo(document.body);
    }
    return $bd;
  }

  function openMobileSidebar() {
    const $sidebar = $(SEL.sidebar);
    if (!$sidebar.length) return;
    $lastFocusBeforeOverlay = $(document.activeElement);
    $sidebar.addClass("is-open").attr("aria-hidden", "false");
    ensureBackdrop().addClass("is-visible");
    document.body.style.overflow = "hidden";
    // Move keyboard focus into the overlay so Esc/Tab work intuitively.
    window.requestAnimationFrame(function () {
      const closeEl = document.querySelector(SEL.sidebarClose);
      if (closeEl) closeEl.focus();
    });
  }

  function closeMobileSidebar() {
    const $sidebar = $(SEL.sidebar);
    if (!$sidebar.length) return;
    const wasOpen = $sidebar.hasClass("is-open");
    $sidebar.removeClass("is-open").attr("aria-hidden", "true");
    $(SEL.sidebarBackdrop).removeClass("is-visible");
    document.body.style.overflow = "";
    if (!wasOpen) return;
    // Restore focus to whatever element triggered the overlay (typically the
    // burger toggle). Fall back to the toggle if the original element is
    // gone or no longer focusable.
    const $restore = $lastFocusBeforeOverlay && $lastFocusBeforeOverlay.length
      ? $lastFocusBeforeOverlay
      : $(SEL.toggle);
    $lastFocusBeforeOverlay = null;
    if ($restore.length && typeof $restore[0].focus === "function") {
      $restore[0].focus();
    }
  }

  function escapeSelector(value) {
    if ($.escapeSelector) {
      return $.escapeSelector(value);
    }

    return String(value).replace(/([ #;?%&,.+*~':"!^$[\]()=>|/@])/g, "\\$1");
  }

  function resizeBurst() {
    window.dispatchEvent(new Event("resize"));
    setTimeout(() => window.dispatchEvent(new Event("resize")), RESIZE_DELAY_MS);
  }

  function showBootstrapTab($container, value) {
    let el =
      $container.find(`a[data-bs-toggle="tab"][data-value="${value}"]`)[0] ||
      $container.find(`a[data-toggle="tab"][data-value="${value}"]`)[0];

    if (!el) return false;

    if (window.bootstrap?.Tab) {
      window.bootstrap.Tab.getOrCreateInstance(el).show();
      return true;
    }

    $(el).trigger("click");
    return true;
  }

  function getHiddenTabset(tabsetId) {
    if (tabsetId) {
      const $tabset = $(`ul.shiny-tab-input#${escapeSelector(tabsetId)}`);
      if ($tabset.length) {
        return $tabset;
      }
    }

    return $("ul.shiny-tab-input" + SEL.sidebarMenu);
  }

  function getSidebarSections(menuId) {
    if (menuId) {
      const $sections = $(".sidebar-nav-sections").filter(function () {
        const $section = $(this);
        return $section.attr("data-input-id") === menuId || $section.attr("id") === menuId;
      }).first();
      if ($sections.length) {
        return $sections;
      }
    }

    return $(SEL.sidebar).find(".sidebar-nav-sections").first();
  }

  function setActiveSidebarItem($sections, value) {
    if (!$sections.length || !value) return;

    const $item = $sections.find(`[data-nav-to="${value}"]`).first();
    if (!$item.length) return;

    $sections.find(".nav-link.active").removeClass("active");
    $item.addClass("active");
  }

  function syncSidebarInput(menuId, value) {
    if (!menuId || !value) return;

    if (window.Shiny?.setInputValue) {
      window.Shiny.setInputValue(menuId, value, { priority: "event" });
      return;
    }

    if (window.Shiny?.onInputChange) {
      window.Shiny.onInputChange(menuId, value);
    }
  }

  function syncSidebarFromTabset(tabsetId, value) {
    if (!tabsetId || !value) return;

    const $sections = $(SEL.sidebar).find(
      `.sidebar-nav-sections[data-tabset-id="${tabsetId}"]`
    ).first();

    if (!$sections.length) return;

    const menuId = $sections.attr("data-input-id") || $sections.attr("id");
    setActiveSidebarItem($sections, value);
    syncSidebarInput(menuId, value);
  }

  function getActiveTabValue($tabset) {
    if (!$tabset?.length) return null;

    const $active = $tabset
      .find(".nav-link:not(.dropdown-toggle).active, .dropdown-menu .dropdown-item.active")
      .first();

    if (!$active.length) return null;
    return $active.attr("data-value") || $.trim($active.text()) || null;
  }

  function triggerSidebarNavigation(menuId, value) {
    if (!value) return false;

    const $sections = getSidebarSections(menuId);
    if (!$sections.length) return false;

    const $item = $sections.find(`[data-nav-to="${value}"]`).first();
    if (!$item.length) return false;

    $item.trigger("click");
    return true;
  }

  function activateInitialSelections() {
    $(".sidebar-nav-sections").each(function () {
      const $sections = $(this);
      const $active = $sections
        .find(".nav-link.active[data-nav-to]")
        .first();
      if (!$active.length) return;

      const value = $active.data("nav-to");
      if (!value) return;

      const tabsetId = $sections.attr("data-tabset-id");
      const menuId = $sections.attr("data-input-id") || $sections.attr("id");

      showBootstrapTab(getHiddenTabset(tabsetId), value);
      syncSidebarInput(menuId, value);
    });
  }

  function registerUpdateTabItemsHandler() {
    if (updateTabItemsHandlerBound || !window.Shiny?.addCustomMessageHandler) {
      return;
    }

    window.Shiny.addCustomMessageHandler("bslibdash-update-tab-items", function (message) {
      const menuId = message?.menuId;
      const tabsetId = message?.tabsetId;
      const selected = message?.selected;
      if (!selected) return;

      // Reuse the exact click path so class toggling matches manual behavior.
      if (triggerSidebarNavigation(menuId, selected)) return;

      const $sections = getSidebarSections(menuId);
      setActiveSidebarItem($sections, selected);
      showBootstrapTab(getHiddenTabset(tabsetId), selected);
      syncSidebarInput(menuId, selected);
      resizeBurst();
    });

    updateTabItemsHandlerBound = true;
  }

  $(function () {
    const $doc = $(document);
    const $toggle = $(SEL.toggle);
    const $sidebar = $(SEL.sidebar);

    $toggle.off("click" + NS).on("click" + NS, function (e) {
      e.preventDefault();
      if (isMobileViewport()) {
        if ($sidebar.hasClass("is-open")) {
          closeMobileSidebar();
        } else {
          openMobileSidebar();
        }
      } else {
        $sidebar.toggleClass("is-collapsed");
        resizeBurst();
      }
    });

    // Mobile close button
    $doc.off("click" + NS, SEL.sidebarClose).on("click" + NS, SEL.sidebarClose, function (e) {
      e.preventDefault();
      closeMobileSidebar();
    });

    // Backdrop click closes the sidebar
    $doc.off("click" + NS, SEL.sidebarBackdrop).on("click" + NS, SEL.sidebarBackdrop, function () {
      closeMobileSidebar();
    });

    // Esc closes the mobile sidebar
    $doc.off("keydown" + NS).on("keydown" + NS, function (e) {
      if (e.key === "Escape" && $sidebar.hasClass("is-open")) {
        closeMobileSidebar();
      }
    });

    // Auto-close a nav click on mobile so users see the page they picked
    $doc.off("click" + NS + "-mobnav", SEL.navItem)
        .on("click" + NS + "-mobnav", SEL.navItem, function () {
          if (isMobileViewport()) {
            closeMobileSidebar();
          }
        });

    // Close the overlay when crossing back to desktop so it doesn't get stuck.
    // The desktop is-collapsed rail styling only applies at >=lg via CSS, so
    // we don't need to manage that class here. Guard on is-open so we don't
    // run close logic when the overlay was never open. Always reset
    // aria-hidden to "false" on desktop so the sidebar remains accessible to
    // screen readers even if it was previously closed on mobile (which sets
    // aria-hidden="true").
    $(window).off("resize" + NS + "-bp").on("resize" + NS + "-bp", function () {
      if (isMobileViewport()) return;
      const $sidebar = $(SEL.sidebar);
      if ($sidebar.hasClass("is-open")) {
        closeMobileSidebar();
      }
      $sidebar.attr("aria-hidden", "false");
    });

    // Suppress sidebar transitions while the user is actively resizing the
    // window. Crossing the lg breakpoint swaps in/out the mobile media-query
    // rules (transform: translateX(-100%) + transition), which would
    // otherwise replay the slide animation on every crossing. Synthetic
    // resizes from resizeBurst() are skipped via isTrusted so the desktop
    // collapse width transition is preserved.
    let resizeSuppressTimer = null;
    $(window).off("resize" + NS + "-suppress").on("resize" + NS + "-suppress", function (e) {
      if (e.originalEvent && !e.originalEvent.isTrusted) return;
      document.body.classList.add("is-resizing");
      if (resizeSuppressTimer) clearTimeout(resizeSuppressTimer);
      resizeSuppressTimer = setTimeout(function () {
        document.body.classList.remove("is-resizing");
        resizeSuppressTimer = null;
      }, RESIZE_DELAY_MS * 4);
    });

    $doc.off("click" + NS, SEL.navItem).on("click" + NS, SEL.navItem, function (e) {
      e.preventDefault();

      const $item = $(this);
      const value = $item.data("nav-to");
      const $sections = $item.closest(".sidebar-nav-sections");
      const menuId = $sections.attr("data-input-id") || $sections.attr("id");
      const tabsetId = $sections.attr("data-tabset-id");
      if (!value) return;

      setActiveSidebarItem($sections, value);
      showBootstrapTab(getHiddenTabset(tabsetId), value);
      syncSidebarInput(menuId, value);
      resizeBurst();
    });

    $doc
      .off("shown.bs.tab" + NS, "ul.shiny-tab-input a[data-bs-toggle=\"tab\"], ul.shiny-tab-input a[data-toggle=\"tab\"]")
      .on("shown.bs.tab" + NS, "ul.shiny-tab-input a[data-bs-toggle=\"tab\"], ul.shiny-tab-input a[data-toggle=\"tab\"]", function () {
        const $link = $(this);
        const value = $link.data("value");
        const tabsetId = $link.closest("ul.shiny-tab-input").attr("id");
        syncSidebarFromTabset(tabsetId, value);
      });

    $doc
      .off("change" + NS, "ul.shiny-tab-input")
      .on("change" + NS, "ul.shiny-tab-input", function () {
        const $tabset = $(this);
        const tabsetId = $tabset.attr("id");
        const value = getActiveTabValue($tabset);
        syncSidebarFromTabset(tabsetId, value);
      });

    registerUpdateTabItemsHandler();
    $doc.off("shiny:connected" + NS).on("shiny:connected" + NS, function () {
      registerUpdateTabItemsHandler();
    });

    activateInitialSelections();
    $doc.off("shiny:sessioninitialized" + NS).on("shiny:sessioninitialized" + NS, function () {
      activateInitialSelections();
    });

    resizeBurst();
  });

})(jQuery, window, document);
