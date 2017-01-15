Feature: Check Routes have correct permissions

  Scenario Outline: Non Signed in has access to public website pages
    Given I am not authenticated
    And I visit <page>
    Then the response code should be <allowed>

    Examples:
      | page                             | allowed |
      | /welcome                         | true    |
      | /join                            | true    |
      | /photos                          | true    |
      | /eagle                           | true    |
      | /troop_calendar                  | true    |
      | /users/sign_in                   | true    |
      | /users/password/new              | true    |
      | /users/password/edit             | false   |
      | /users/sign_up                   | true    |
      | /users/edit                      | false   |
      | /users/confirmation/new          | true    |
      | /users/confirmation              | true    |
      | /users/unlock                    | true    |
      | /users/unlock/new                | true    |
      | /articles                        | false   |
      | /articles/new                    | false   |
      | /articles/1/edit                 | false   |
      | /scouts                          | false   |
      | /scouts/new                      | false   |
      | /scouts/1/edit                   | false   |
      | /requirements                    | false   |
      | /requirements/new                | false   |
      | /requirements/1/edit             | false   |
      | /scout_requirements              | false   |
      | /scout_requirements/new          | false   |
      | /scout_requirements/1/edit       | false   |
      | /scout_positions/1/edit          | false   |
      | /scout_positions/new             | false   |
      | /scout_positions/1/edit          | false   |
      | /scout_trainings                 | false   |
      | /scout_trainings/new             | false   |
      | /scout_trainings/1/edit          | false   |
      | /scout_rank_histories/new        | false   |
      | /scout_rank_histories/1/edit     | false   |
      | /scout_merit_badges              | false   |
      | /scout_merit_badges/new          | false   |
      | /scout_merit_badges/1/edit       | false   |
      | /scout_awards                    | false   |
      | /scout_awards/new                | false   |
      | /scout_awards/1/edit             | false   |
      | /scout_events                    | false   |
      | /scout_events/new                | false   |
      | /scout_events/1/edit             | false   |
      | /youth_awards                    | false   |
      | /youth_awards/new                | false   |
      | /youth_awards/1/edit             | false   |
      | /youth_award_requirements        | false   |
      | /youth_award_requirements/new    | false   |
      | /youth_award_requirements/1/edit | false   |
      | /positions                       | false   |
      | /positions/new                   | false   |
      | /positions/1/edit                | false   |
      | /ranks                           | false   |
      | /ranks/new                       | false   |
      | /ranks/1/edit                    | false   |
      | /patrols                         | false   |
      | /patrols/new                     | false   |
      | /patrols/1/edit                  | false   |
      | /relationships                   | false   |
      | /relationships/new               | false   |
      | /relationships/1/edit            | false   |
      | /adults                          | false   |
      | /adults/new                      | false   |
      | /adults/1/edit                   | false   |
      | /adult_positions/new             | false   |
      | /adult_positions/1/edit          | false   |
      | /adult_vehicles/new              | false   |
      | /adult_events                    | false   |
      | /adult_events/new                | false   |
      | /vehicles                        | false   |
      | /vehicles/new                    | false   |
      | /vehicles/1/edit                 | false   |
      | /notifications                   | false   |
      | /notifications/new               | false   |
      | /notifications/1/edit            | false   |
      | /event_locations                 | false   |
      | /event_locations/new             | false   |
      | /event_locations/1/edit          | false   |
      | /events/new                      | false   |
      | /events/1/edit                   | false   |
      | /categories                      | false   |
      | /categories/new                  | false   |
      | /categories/1/edit               | false   |
      | /categories/check_category       | false   |
      | /reports/scout_detail_report     | false   |
      | /reports/patrol_report           | false   |
      | /reports/event_attendance_report | false   |
      | /reports/ypt_report              | false   |
      | /admin/users                     | false   |
      | /admin/users/1/edit              | false   |
      | /admin/file_uploads              | false   |
      | /admin/file_uploads/new          | false   |

  Scenario Outline: Signed in has access to proper pages
    Given I am not authenticated
    And I goto the login page
    And I enter valid confirmed credentials
    And I visit <page>
    Then the response code should be <allowed>

    Examples:
      | page                         | allowed |
      | /welcome                     | true    |
      | /join                        | true    |
      | /photos                      | true    |
      | /eagle                       | true    |
      | /troop_calendar              | true    |
      | /articles                    | true    |
      | /articles/new                | false   |
      | /articles/1/edit             | false   |
      | /scouts                      | false   |
      | /scouts/new                  | false   |
      | /scouts/1/edit               | false   |
      | /scouts/1                    | true    |
      | /requirements/new            | false   |
      | /requirements/1/edit         | false   |
      | /scout_requirements          | false   |
      | /scout_requirements/new      | false   |
      | /scout_requirements/1/edit   | false   |
      | /scout_positions             | false   |
      | /scout_positions/new         | false   |
      | /scout_positions/1/edit      | false   |
      | /scout_positions/1.js        | true    |
      | /scout_positions/1           | true    |
      | /scout_trainings             | false   |
      | /scout_trainings/new         | false   |
      | /scout_trainings/1/edit      | false   |
      | /scout_trainings/1.js        | true    |
      | /scout_trainings/1           | true    |
      | /scout_rank_histories/new    | false   |
      | /scout_rank_histories/1/edit | false   |
      | /scout_merit_badges          | false   |
      | /scout_merit_badges/new      | false   |
      | /scout_merit_badges/1/edit   | false   |
      | /scout_merit_badges/1.js     | true    |
      | /scout_merit_badges/1        | true    |
#      | /scout_awards                    | false   |
#      | /scout_awards/new                | false   |
#      | /scout_awards/1/edit             | false   |
#      | /scout_events                    | false   |
#      | /scout_events/new                | false   |
#      | /scout_events/1/edit             | false   |
#      | /youth_awards                    | false   |
#      | /youth_awards/new                | false   |
#      | /youth_awards/1/edit             | false   |
#      | /youth_award_requirements        | false   |
#      | /youth_award_requirements/new    | false   |
#      | /youth_award_requirements/1/edit | false   |
#      | /positions                       | false   |
#      | /positions/new                   | false   |
#      | /positions/1/edit                | false   |
#      | /ranks                           | false   |
#      | /ranks/new                       | false   |
#      | /ranks/1/edit                    | false   |
#      | /patrols                         | false   |
#      | /patrols/new                     | false   |
#      | /patrols/1/edit                  | false   |
#      | /relationships                   | false   |
#      | /relationships/new               | false   |
#      | /relationships/1/edit            | false   |
#      | /adults                          | false   |
#      | /adults/new                      | false   |
#      | /adults/1/edit                   | false   |
#      | /adult_positions/new             | false   |
#      | /adult_positions/1/edit          | false   |
#      | /adult_vehicles/new              | false   |
#      | /adult_events                    | false   |
#      | /adult_events/new                | false   |
#      | /vehicles                        | false   |
#      | /vehicles/new                    | false   |
#      | /vehicles/1/edit                 | false   |
#      | /notifications                   | false   |
#      | /notifications/new               | false   |
#      | /notifications/1/edit            | false   |
#      | /event_locations                 | false   |
#      | /event_locations/new             | false   |
#      | /event_locations/1/edit          | false   |
#      | /events/new                      | false   |
#      | /events/1/edit                   | false   |
#      | /categories                      | false   |
#      | /categories/new                  | false   |
#      | /categories/1/edit               | false   |
#      | /categories/check_category       | false   |
#      | /reports/scout_detail_report     | false   |
#      | /reports/patrol_report           | false   |
#      | /reports/event_attendance_report | false   |
#      | /reports/ypt_report              | false   |
#      | /admin/users                     | false   |
#      | /admin/users/1/edit              | false   |
#      | /admin/file_uploads              | false   |
#      | /admin/file_uploads/new          | false   |

