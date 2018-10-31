Content-Type: multipart/mixed; boundary="===============3335903054610979331=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH] new gemalto plugin
Date: Wed, 31 Oct 2018 16:16:35 -0500
Message-ID: <b7408a62-0231-3416-89ce-68b1010678eb@gmail.com>
In-Reply-To: <CAKSBH7Fij7KHtPdkd5x2KXx3joCt7kH4S3VdfMwZCB96omsOiw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3335903054610979331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> Thank you for the explanation. Is the glib going to be removed
> completely then, or both will coexist?
> =


oFono is a large project, so eradicating use of glib cannot happen =

overnight.  For the foreseeable future we will have both coexist.  I =

will start 'encouraging' people to start using ell instead of glib. =

Especially for new code that does not depend on GAtChat, etc.

> Denis pointed that the atom-configuration tests can be done in the
> atoms themselves, except that then I am asked to maintain my own atom
> when I want to add more than a couple lines (see the lte atom story).
> Nevertheless this is an excellent suggestion to reduce the complexity
> in the plugin.

You will end up writing many of your own atom drivers anyway.  voicecall =

for example.  For others we will figure this out, I've some ideas I need =

to play with.

> =

> Often MBIM can be turned on or off or changed for some other interface
> for the same (Gemalto) modem, depending on the application wishes, so
> if the plugin is split, all its settings are just duplicated.
> =


This also implies having the modem reconfigure itself on the USB =

interface, no?  E.g. a hot-unplug and hot-plug.  I doubt many users will =

be doing this anyway.

If you're worried about duplicating vendor specific API code between =

multiple modem drivers, then don't.  This code can be shared easily and =

I've already given you a few ideas.

Regards,
-Denis

--===============3335903054610979331==--

