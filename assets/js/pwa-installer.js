/**
 * PWA Installation Handler
 * Manages the installation prompt and provides user feedback
 */

let deferredPrompt;
let installButton;

// Wait for DOM to be ready
document.addEventListener('DOMContentLoaded', () => {
  initPWAInstaller();
});

/**
 * Initialize PWA installer functionality
 */
function initPWAInstaller() {
  // Create install button
  createInstallButton();
  
  // Listen for beforeinstallprompt event
  window.addEventListener('beforeinstallprompt', (e) => {
    console.log('[PWA] Install prompt available');
    
    // Prevent the default mini-infobar from appearing
    e.preventDefault();
    
    // Store the event for later use
    deferredPrompt = e;
    
    // Show the install button
    if (installButton) {
      installButton.style.display = 'block';
      installButton.setAttribute('aria-hidden', 'false');
    }
  });

  // Listen for app installed event
  window.addEventListener('appinstalled', () => {
    console.log('[PWA] App installed successfully');
    
    // Hide the install button
    if (installButton) {
      installButton.style.display = 'none';
      installButton.setAttribute('aria-hidden', 'true');
    }
    
    // Clear the deferred prompt
    deferredPrompt = null;
    
    // Show success message
    showInstallMessage('App installed successfully!', 'success');
  });

  // Check if already installed
  if (window.matchMedia('(display-mode: standalone)').matches) {
    console.log('[PWA] Running in standalone mode');
    // Hide install button if already installed
    if (installButton) {
      installButton.style.display = 'none';
      installButton.setAttribute('aria-hidden', 'true');
    }
  }
}

/**
 * Create and inject the install button into the DOM
 */
function createInstallButton() {
  // Check if button already exists
  if (document.getElementById('pwa-install-button')) {
    installButton = document.getElementById('pwa-install-button');
    return;
  }

  // Create button element
  installButton = document.createElement('button');
  installButton.id = 'pwa-install-button';
  installButton.className = 'pwa-install-button d-print-none';
  installButton.style.display = 'none'; // Hidden by default
  installButton.setAttribute('aria-label', 'Install this app on your device');
  installButton.setAttribute('aria-hidden', 'true');
  
  // Button content
  installButton.innerHTML = `
    <i class="fas fa-download" aria-hidden="true"></i>
    <span>Install App</span>
  `;
  
  // Add click event listener
  installButton.addEventListener('click', handleInstallClick);
  
  // Inject into body
  document.body.appendChild(installButton);
}

/**
 * Handle install button click
 */
async function handleInstallClick() {
  if (!deferredPrompt) {
    console.log('[PWA] No install prompt available');
    return;
  }

  // Hide the install button
  installButton.style.display = 'none';
  installButton.setAttribute('aria-hidden', 'true');

  // Show the install prompt
  deferredPrompt.prompt();

  // Wait for the user's response
  const { outcome } = await deferredPrompt.userChoice;
  console.log(`[PWA] User response: ${outcome}`);

  if (outcome === 'accepted') {
    showInstallMessage('Installing app...', 'info');
  } else {
    // Show button again if user dismissed
    installButton.style.display = 'block';
    installButton.setAttribute('aria-hidden', 'false');
    showInstallMessage('Installation cancelled', 'info');
  }

  // Clear the deferred prompt
  deferredPrompt = null;
}

/**
 * Show installation status message
 * @param {string} message - Message to display
 * @param {string} type - Message type (success, error, info)
 */
function showInstallMessage(message, type = 'info') {
  // Create message element
  const messageEl = document.createElement('div');
  messageEl.className = `pwa-install-message pwa-message-${type}`;
  messageEl.setAttribute('role', 'status');
  messageEl.setAttribute('aria-live', 'polite');
  messageEl.textContent = message;
  
  // Inject into body
  document.body.appendChild(messageEl);
  
  // Trigger animation
  setTimeout(() => {
    messageEl.classList.add('show');
  }, 100);
  
  // Remove after 3 seconds
  setTimeout(() => {
    messageEl.classList.remove('show');
    setTimeout(() => {
      messageEl.remove();
    }, 300);
  }, 3000);
}

/**
 * Register service worker
 */
if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker
      .register('/service-worker.js')
      .then((registration) => {
        console.log('[PWA] Service Worker registered:', registration.scope);
        
        // Check for updates periodically
        setInterval(() => {
          registration.update();
        }, 60000); // Check every minute
        
        // Listen for updates
        registration.addEventListener('updatefound', () => {
          const newWorker = registration.installing;
          
          newWorker.addEventListener('statechange', () => {
            if (newWorker.state === 'installed' && navigator.serviceWorker.controller) {
              // New service worker available
              showUpdateNotification();
            }
          });
        });
      })
      .catch((error) => {
        console.error('[PWA] Service Worker registration failed:', error);
      });
  });
}

/**
 * Show update notification when new version is available
 */
function showUpdateNotification() {
  const notification = document.createElement('div');
  notification.className = 'pwa-update-notification';
  notification.setAttribute('role', 'alert');
  notification.setAttribute('aria-live', 'assertive');
  
  notification.innerHTML = `
    <div class="pwa-update-content">
      <p>A new version is available!</p>
      <button id="pwa-update-button" class="pwa-update-btn">
        Update Now
      </button>
      <button id="pwa-dismiss-button" class="pwa-dismiss-btn" aria-label="Dismiss update notification">
        <i class="fas fa-times" aria-hidden="true"></i>
      </button>
    </div>
  `;
  
  document.body.appendChild(notification);
  
  // Handle update button click
  document.getElementById('pwa-update-button').addEventListener('click', () => {
    navigator.serviceWorker.getRegistration().then((registration) => {
      if (registration && registration.waiting) {
        registration.waiting.postMessage({ type: 'SKIP_WAITING' });
        window.location.reload();
      }
    });
  });
  
  // Handle dismiss button click
  document.getElementById('pwa-dismiss-button').addEventListener('click', () => {
    notification.remove();
  });
  
  // Show notification
  setTimeout(() => {
    notification.classList.add('show');
  }, 100);
}