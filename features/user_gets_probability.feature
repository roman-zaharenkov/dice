Feature: user gets probability

  In order to know chance of getting specific value throwing dices
  As a user
  I want to get probability

  Probability calculated as:

    probability = combinations_count / total_combinations_count,

  where:
    combinations_count - number of combinations which give value
    total_combinations_count - total number of combinations for specific dices count

  Scenario Outline: user gets probability
    Given initialized dice client
    When I ask probability of getting "<value>" from "<dices>" dices
    Then the probability should be close to "<probability>"

    Scenarios: without dices
      | value | dices | probability |
      |     0 |     0 |         0.0 |
      |     1 |     0 |         0.0 |
      |     2 |     0 |         0.0 |

    Scenarios: with 1 dice
      | value | dices | probability |
      |     0 |     1 |         0.0 |
      |     1 |     1 |     0.16667 |
      |     2 |     1 |     0.16667 |
      |     3 |     1 |     0.16667 |
      |     4 |     1 |     0.16667 |
      |     5 |     1 |     0.16667 |
      |     6 |     1 |     0.16667 |
      |     7 |     1 |         0.0 |

    Scenarios: woth 2 dices
      | value | dices | probability |
      |     0 |     2 |         0.0 |
      |     1 |     2 |         0.0 |
      |     2 |     2 |     0.02778 |
      |     3 |     2 |     0.05556 |
      |     4 |     2 |     0.08333 |
      |     5 |     2 |     0.11111 |
      |     6 |     2 |     0.13889 |
      |     7 |     2 |     0.16667 |
      |     8 |     2 |     0.13889 |
      |     9 |     2 |     0.11111 |
      |    10 |     2 |     0.08333 |
      |    11 |     2 |     0.05556 |
      |    12 |     2 |     0.02778 |
      |    13 |     2 |         0.0 |

  Scenario Outline: user specifies incorrect number of arguments
    Given initialized dice client
    When I ask probability and pass incorrect "<number_of_arguments>" arguments
    Then I should get arguments error

    Scenarios: incorrect arguments count
      | number_of_arguments |
      |                   0 |
      |                   1 |
      |                   3 |
      |                   4 |

  Scenario Outline: user specifies incorrect arguments values
    Given initialized dice client
    When I ask probability of getting "<value>" from "<dices>" dices with incorrect arguments
    Then I should get arguments error

    Scenarios: negative arguments
      | value | dices |
      |    -1 |    -2 |
      |    -3 |     5 |
      |     7 |    -4 |

    Scenarios: float arguments
      | value | dices |
      |   1.2 |   2.7 |
      |   9.3 |     1 |
      |     1 |   4.5 |

  Scenario Outline: dice has nice performance
    Given initialized dice client
    When I ask probability of getting "<value>" from "<dices>" dices "<iterations>" times
    Then mean running time should not exceed "<mean>" seconds
    And a standard deviation should not exceed "<standard_deviation>" milliseconds

    Scenarios: negative arguments
      | value | dices | iterations | mean | standard_deviation |
      |   600 |   100 |         10 |  2.0 |                 50 |
      |  1200 |   200 |         10 |  3.5 |                 75 |
      |  1800 |   300 |         10 |  7.0 |                100 |

