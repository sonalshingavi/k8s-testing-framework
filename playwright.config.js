// playwright.config.js
module.exports = {
    testDir: 'tests',
    timeout: 30000,
    expect: {
        timeout: 5000,
    },
    fullyParallel: true,
    retries: 1,
    workers: 2,
    reporter: [['html', { outputFolder: 'test-results' }]],
    use: {
        headless: true,
        screenshot: 'only-on-failure',
        video: 'on',
    },
  };
  