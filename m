Content-Type: multipart/mixed; boundary="===============9124636711671819478=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Allow users to specify dbus name replacement
 behaviour.
Date: Thu, 03 Apr 2014 19:25:29 -0500
Message-ID: <533DFBF9.9050906@gmail.com>
In-Reply-To: <533DFB3F.6080802@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9124636711671819478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

> What we are trying to do is a full stack system testing where the
> individual components that are being tested don't have any modifications
> or adaptations when they are run under test suite.

Okay that sort of makes sense

> =

> The number of modems returned by org.ofono.Manager.GetModems() must
> represent the total number of modems available to the system and thus we
> need to have exactly two modems when testing dual-sim features etc.
> =


Sounds like your system is a bit inflexible, but okay.

> The need to change the number of modems during testing comes from the
> fact that our test suite has the single and multimodem tests together
> and runs them one after another and we need to be able to set up the
> environment appropriately in between individual test cases.
> =


Why don't you simply write a plugin that handles all of this?  E.g.
canonical_tester that creates two modem instances.  If you must insist
on having exactly 1 or 2 modems, then just add a DBus interface to
switch between modes.

Adding a control mechanism for controlling the number of phonesim
instances seems like total overkill.

Regards,
-Denis

--===============9124636711671819478==--

