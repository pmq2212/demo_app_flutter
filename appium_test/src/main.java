UiAutomator2Options options = new UiAutomator2Options()
        .setUdid('123456')
        .setApp("/home/myapp.apk");
        AndroidDriver driver = new AndroidDriver(
        // The default URL in Appium 1 is http://127.0.0.1:4723/wd/hub
        new URL("http://127.0.0.1:4723"), options
        );
        try {
        WebElement el = driver.findElement(AppiumBy.xpath, "//Button");
        el.click();
        driver.getPageSource();
        } finally {
        driver.quit();
        }