Feature: User can link child and parent term statuses.

    Background:
        Given a running site
        And demo languages
        Given a Spanish book "Hola" with content:
            Gato gatos gatito perro.


    Scenario: Can link child and single parent term.
        When I click "Gato" and edit the form:
            translation: cat
            status: 3
        Then the reading pane shows:
            Gato (3)/ /gatos/ /gatito/ /perro/.

        When I click "gatos" and edit the form:
            parents: [ 'Gato' ]
            follow_parent: true
            status: 4
        Then the reading pane shows:
            Gato (4)/ /gatos (4)/ /gatito/ /perro/.

        When I click "Gato" and press hotkey "2"
        Then the reading pane shows:
            Gato (2)/ /gatos (2)/ /gatito/ /perro/.

        When I click "gatito" and edit the form:
            parents: [ 'Gato' ]
        Then the reading pane shows:
            Gato (2)/ /gatos (2)/ /gatito (2)/ /perro/.

        When I click "gatos" and press hotkey "5"
        Then the reading pane shows:
            Gato (5)/ /gatos (5)/ /gatito (5)/ /perro/.


    Scenario: Linking multiple parents breaks status updating.
        When I click "Gato" and edit the form:
            translation: cat
            status: 3
        Then the reading pane shows:
            Gato (3)/ /gatos/ /gatito/ /perro/.

        When I click "gatos" and edit the form:
            parents: [ 'Gato' ]
            follow_parent: true
            status: 4
        Then the reading pane shows:
            Gato (4)/ /gatos (4)/ /gatito/ /perro/.

        When I click "gatos" and edit the form:
            parents: [ 'Gato', 'perro' ]
            follow_parent: true
            status: 2
        Then the reading pane shows:
            Gato (4)/ /gatos (2)/ /gatito/ /perro (2)/.

        When I click "gatos" and press hotkey "1"
        Then the reading pane shows:
            Gato (4)/ /gatos (1)/ /gatito/ /perro (2)/.