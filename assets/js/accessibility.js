/**
 * Accessibility Enhancement Script
 * Provides keyboard navigation, focus management, and screen reader support
 */

(function() {
  'use strict';

  // Initialize when DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initAccessibility);
  } else {
    initAccessibility();
  }

  /**
   * Main initialization function
   */
  function initAccessibility() {
    console.log('[A11y] Initializing accessibility features...');
    
    // Add skip to content link
    addSkipToContentLink();
    
    // Enhance keyboard navigation
    enhanceKeyboardNavigation();
    
    // Add focus indicators
    addFocusIndicators();
    
    // Enhance button accessibility
    enhanceButtons();
    
    // Add ARIA live regions
    addLiveRegions();
    
    // Handle reduced motion preference
    handleReducedMotion();
    
    // Announce page changes to screen readers
    announcePageLoad();
    
    console.log('[A11y] Accessibility features initialized');
  }

  /**
   * Add skip to content link for keyboard users
   */
  function addSkipToContentLink() {
    const skipLink = document.createElement('a');
    skipLink.href = '#main-content';
    skipLink.className = 'skip-to-content';
    skipLink.textContent = 'Skip to main content';
    skipLink.setAttribute('aria-label', 'Skip to main content');
    
    // Insert at the beginning of body
    document.body.insertBefore(skipLink, document.body.firstChild);
    
    // Handle click
    skipLink.addEventListener('click', (e) => {
      e.preventDefault();
      const mainContent = document.querySelector('.main-wrapper') || document.querySelector('main');
      if (mainContent) {
        mainContent.setAttribute('tabindex', '-1');
        mainContent.focus();
        mainContent.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    });
  }

  /**
   * Enhance keyboard navigation throughout the site
   */
  function enhanceKeyboardNavigation() {
    // Add keyboard support for custom interactive elements
    const interactiveElements = document.querySelectorAll('[onclick]:not(button):not(a)');
    
    interactiveElements.forEach((element) => {
      // Make it focusable
      if (!element.hasAttribute('tabindex')) {
        element.setAttribute('tabindex', '0');
      }
      
      // Add keyboard event listener
      element.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' || e.key === ' ') {
          e.preventDefault();
          element.click();
        }
      });
    });

    // Trap focus in modals (if any are added in the future)
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape') {
        closeModals();
      }
    });

    // Add keyboard shortcuts
    document.addEventListener('keydown', (e) => {
      // Alt + P: Print
      if (e.altKey && e.key === 'p') {
        e.preventDefault();
        const printButton = document.querySelector('.print-button');
        if (printButton) printButton.click();
      }
      
      // Alt + D: Download PDF
      if (e.altKey && e.key === 'd') {
        e.preventDefault();
        const pdfButton = document.querySelector('.pdf-button');
        if (pdfButton) pdfButton.click();
      }
    });
  }

  /**
   * Add visible focus indicators for keyboard navigation
   */
  function addFocusIndicators() {
    // Track if user is using keyboard
    let isUsingKeyboard = false;

    document.addEventListener('keydown', (e) => {
      if (e.key === 'Tab') {
        isUsingKeyboard = true;
        document.body.classList.add('keyboard-navigation');
      }
    });

    document.addEventListener('mousedown', () => {
      isUsingKeyboard = false;
      document.body.classList.remove('keyboard-navigation');
    });

    // Ensure all interactive elements are focusable
    const links = document.querySelectorAll('a');
    links.forEach((link) => {
      if (!link.hasAttribute('tabindex') && link.href) {
        link.setAttribute('tabindex', '0');
      }
    });
  }

  /**
   * Enhance buttons with proper ARIA attributes
   */
  function enhanceButtons() {
    // Print button
    const printButton = document.querySelector('.print-button');
    if (printButton) {
      printButton.setAttribute('aria-label', 'Print resume (Alt+P)');
      printButton.setAttribute('title', 'Print resume (Alt+P)');
    }

    // PDF button
    const pdfButton = document.querySelector('.pdf-button');
    if (pdfButton) {
      pdfButton.setAttribute('aria-label', 'Download PDF resume (Alt+D)');
      pdfButton.setAttribute('title', 'Download PDF resume (Alt+D)');
      
      // Add loading state handling
      const originalGeneratePDF = window.generatePDF;
      if (originalGeneratePDF) {
        window.generatePDF = function() {
          pdfButton.setAttribute('aria-busy', 'true');
          pdfButton.disabled = true;
          
          const originalText = pdfButton.innerHTML;
          pdfButton.innerHTML = '<i class="fas fa-spinner fa-spin" aria-hidden="true"></i>Generating...';
          
          // Call original function
          originalGeneratePDF.call(this);
          
          // Reset after delay
          setTimeout(() => {
            pdfButton.setAttribute('aria-busy', 'false');
            pdfButton.disabled = false;
            pdfButton.innerHTML = originalText;
            announceToScreenReader('PDF generated successfully');
          }, 3000);
        };
      }
    }
  }

  /**
   * Add ARIA live regions for dynamic content announcements
   */
  function addLiveRegions() {
    // Create polite live region for non-critical updates
    const politeLiveRegion = document.createElement('div');
    politeLiveRegion.id = 'polite-live-region';
    politeLiveRegion.className = 'sr-only';
    politeLiveRegion.setAttribute('aria-live', 'polite');
    politeLiveRegion.setAttribute('aria-atomic', 'true');
    document.body.appendChild(politeLiveRegion);

    // Create assertive live region for critical updates
    const assertiveLiveRegion = document.createElement('div');
    assertiveLiveRegion.id = 'assertive-live-region';
    assertiveLiveRegion.className = 'sr-only';
    assertiveLiveRegion.setAttribute('aria-live', 'assertive');
    assertiveLiveRegion.setAttribute('aria-atomic', 'true');
    document.body.appendChild(assertiveLiveRegion);
  }

  /**
   * Announce message to screen readers
   * @param {string} message - Message to announce
   * @param {string} priority - 'polite' or 'assertive'
   */
  function announceToScreenReader(message, priority = 'polite') {
    const liveRegionId = priority === 'assertive' ? 'assertive-live-region' : 'polite-live-region';
    const liveRegion = document.getElementById(liveRegionId);
    
    if (liveRegion) {
      // Clear previous message
      liveRegion.textContent = '';
      
      // Set new message after a brief delay to ensure it's announced
      setTimeout(() => {
        liveRegion.textContent = message;
      }, 100);
      
      // Clear after announcement
      setTimeout(() => {
        liveRegion.textContent = '';
      }, 3000);
    }
  }

  /**
   * Handle user's reduced motion preference
   */
  function handleReducedMotion() {
    const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)');
    
    function updateMotionPreference(e) {
      if (e.matches) {
        document.body.classList.add('reduce-motion');
        console.log('[A11y] Reduced motion enabled');
      } else {
        document.body.classList.remove('reduce-motion');
      }
    }
    
    // Check initial preference
    updateMotionPreference(prefersReducedMotion);
    
    // Listen for changes
    prefersReducedMotion.addEventListener('change', updateMotionPreference);
  }

  /**
   * Announce page load to screen readers
   */
  function announcePageLoad() {
    const pageTitle = document.title || 'Online CV';
    setTimeout(() => {
      announceToScreenReader(`${pageTitle} loaded`, 'polite');
    }, 1000);
  }

  /**
   * Close any open modals (utility function for future use)
   */
  function closeModals() {
    const modals = document.querySelectorAll('[role="dialog"][aria-hidden="false"]');
    modals.forEach((modal) => {
      modal.setAttribute('aria-hidden', 'true');
      modal.style.display = 'none';
    });
  }

  // Expose utility function globally
  window.announceToScreenReader = announceToScreenReader;

})();