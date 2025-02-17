// Fixes an issue where scrolling down on a page, then loading a new page, does not scroll the new page back to the top
document.addEventListener('turbo:load', () => {
  const navEntries = performance.getEntriesByType('navigation');
  const navType = navEntries.length ? navEntries[0].type : 'navigate';

  // Only scroll to top if the navigation wasn’t from history.
  if (navType !== 'back_forward') {
    window.scrollTo(0, 0);
  }
});
