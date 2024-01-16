import SearchController from "./search_controller";

describe("SearchController", () => {
  let searchController;

  beforeEach(() => {
    searchController = new SearchController();
  });

  afterEach(() => {
    // Clean up any changes made during the tests
  });

  it("should update the log target and call search method", () => {
    const event = { target: { value: "test" } };
    searchController.log(event);
    expect(searchController.logTarget.textContent).toBe("test");
    // Add more assertions for the search method
  });

  it("should update the searches target with optimistic update", () => {
    const text = "test";
    searchController.optimisticUpdate(text);
    expect(searchController.searchesTarget.innerHTML).toContain(
      `<li>${text}</li>`
    );
  });

  it("should save the search and update the searches target", async () => {
    // Mock the post method and its response
    const mockPost = jest
      .fn()
      .mockResolvedValue({
        ok: true,
        text: jest.fn().mockResolvedValue("mocked response"),
      });
    global.post = mockPost;

    // Mock the debounce method
    jest.spyOn(searchController, "debounce").mockImplementation((func) => func);

    // Call the saveSearch method
    await searchController.saveSearch();

    // Assert that the post method was called with the correct arguments
    expect(mockPost).toHaveBeenCalledWith("searches/save", {
      body: JSON.stringify({ text: "" }),
      contentType: "application/json",
      responseKind: "html",
    });

    // Assert that the searches target was updated
    expect(searchController.searchesTarget.innerHTML).toBe("mocked response");
  });

  it("should update the analytics target", async () => {
    // Mock the get method and its response
    const mockGet = jest
      .fn()
      .mockResolvedValue({
        ok: true,
        text: jest.fn().mockResolvedValue("mocked response"),
      });
    global.get = mockGet;

    // Call the updateAnalytics method
    await searchController.updateAnalytics();

    // Assert that the get method was called with the correct arguments
    expect(mockGet).toHaveBeenCalledWith("searches/analytics", {
      responseKind: "html",
    });

    // Assert that the analytics target was updated
    expect(searchController.analyticsTarget.innerHTML).toBe("mocked response");
  });

  // Add more tests for other methods and scenarios
});
