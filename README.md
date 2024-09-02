# TEST: Shadowkey test port

The aim of this project is to create a port of The Elder Scrolls Travels: Shadowkey in a Godot Engine.

Contributions are **very welcome**. See [open tasks](https://gitlab.com/testman42/shadowkey-test/-/boards). 

GitLab is good alternative to Microsoft-owned GitHub, but ideally the code would be hosted on some [federated code forge](https://forgefed.org/) like [Forgejo](https://forgejo.org/).
GitLab [has plans](https://gitlab.com/groups/gitlab-org/-/epics/11247) for some [ActivityPub interoperability](https://docs.gitlab.com/ee/development/activitypub/). We will see.

Project is being developed with [Godot 4.3](https://godotengine.org/download/archive/4.3-stable/).

It would be ideal if Shadowkey got a whole engine reimplementation, made with clean-room practices, that would take original files and present them in a more modern way. But development of something like that is beyond my technical skills and my available time.
That is why this is a *port* and not just an engine.

You might notice that project is structured in an interesting way.
That is because I am trying to use a method that is somewhat remeniscent of [Entity Component System](https://en.wikipedia.org/wiki/Entity_component_system).
But Godot does not formally implement such architecture, so I am trying to implement something like it within the constraints the Godot.
And from what I see in the Godot community, quite a few other people are developing projects in a similar way.

This is actually because my ambitions for Godot are a bit bigger.
I am interested in developing a sort of framewok that includes common mechanics of popular game genres, so that Godot community gets a good foundation and templates for creating games of popular genres.
For example, the movement and health mechanics in this project were taken from an Arena Shooter template.

### Useful Links:
* https://en.uesp.net/wiki/Shadowkey:Shadowkey
* https://fire-head.github.io/TESTShadowkeyMapViewer/index.html
* https://fire-head.github.io/testshadowkeyviewer/index.html
* https://fire-head.github.io/testshadowkeyviewer/js/three.min.js
* https://en.uesp.net/wiki/Mod:Shadowkey_File_Formats/Shadowkey_Model_Format
* https://discord.gg/KhxbUWw
* https://en.uesp.net/wiki/Mod:Shadowkey_Emulation_Guide
* https://github.com/EKA2L1/EKA2L1/
