// Performance
user_pref("gfx.webrender.all", true);
user_pref("nglayout.initialpaint.delay", 0);
user_pref("content.notify.interval", 100000);
user_pref("browser.cache.disk.enable", true);

// Disable telemetry
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);

// Disable Pocket and sponsored content
user_pref("extensions.pocket.enabled", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);

// Compact UI
user_pref("browser.compactmode.show", true);
user_pref("browser.uidensity", 1);

// Disable animations
user_pref("toolkit.cosmeticAnimations.enabled", false);

// Smooth scrolling tuning
user_pref("general.smoothScroll.msdPhysics.enabled", true);

// Disable prefetch (saves bandwidth)
user_pref("network.prefetch-next", false);
user_pref("network.dns.disablePrefetch", true);

// New tab = blank
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.startup.homepage", "about:blank");
