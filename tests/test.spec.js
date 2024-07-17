// test.js

const { test, expect } = require('@playwright/test');
const backendUrl = 'http://localhost:9090/greet';  // Adjust this to your actual backend endpoint
const frontendUrl = 'http://localhost:8080';  // Adjust this to your actual frontend URL

test('Frontend should display the message from the backend', async ({ page }) => {
  // Fetch the message from the backend
  const backendResponse = await page.request.get(backendUrl);
  const backendData = await backendResponse.json();
  const message = backendData.message;

  console.log("Backend message : " + message);
  // Go to the frontend page
  await page.goto(frontendUrl);

  // Check that the message is displayed on the frontend
  const messageElement = await page.locator('body');
  const messageText = await messageElement.textContent();
  console.log("Frontend message : " + messageText);
  await expect(messageText).toContain(message);

});
