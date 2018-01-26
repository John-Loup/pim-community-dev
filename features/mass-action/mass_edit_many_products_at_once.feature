@javascript
Feature: Mass edit many products at once via a form
  In order to easily organize many products
  As a product manager
  I need to be able to mass edit a selection of products greater than the batch size

  Scenario: Add products to a related group
    Given the "footwear" catalog configuration
    And I change the mass edit batch size to "5"
    And the following products:
      | sku          |
      | kickers      |
      | hiking_shoes |
      | moon_boots   |
      | mars_boots   |
      | uranus_boots |
      | venus_boots  |
      | saturn_boots |
    And I am logged in as "Julia"
    And I am on the products grid
    Given I select rows kickers, hiking_shoes, moon_boots, mars_boots, uranus_boots, venus_boots and saturn_boots
    And I press the "Bulk actions" button
    And I choose the "Add to categories" operation
    And I move on to the choose step
    And I choose the "Add to categories" operation
    And I select the "2014_collection" tree
    And I expand the "2014_collection" category
    And I press the "winter_collection" button
    And I confirm mass edit
    And I wait for the "add_product_value" job to finish
    When I go on the last executed job resume of "add_product_value"
    Then I should see the text "COMPLETED"
    And I should see the text "processed 2"
    And I should see the text "skipped 1"
    When I am on the products grid
    And I open the category tree
    Then I should be able to use the following filters:
      | filter   | operator | value             | result                                                                                    |
      | category |          | winter_collection | kickers, hiking_shoes, moon_boots, mars_boots, uranus_boots, venus_boots and saturn_boots |
