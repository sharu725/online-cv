const puppeteer = require("puppeteer")

const getScreenshot = async () => {
  const browser = await puppeteer.launch()
  const page = await browser.newPage()
  await page.goto("http://localhost:4000/print")
  await page.emulateMediaType('screen');
  await page.waitForTimeout(4000)
  await page.pdf( {
    path: 'cv.pdf',
    scale: 1,
    printBackground: true,
    width: 1240,
    height: 1754} )
  await browser.close()
}

getScreenshot()
