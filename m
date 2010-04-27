Content-Type: multipart/mixed; boundary="===============8991035659998505923=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: Re: DUN client for oFono and BlueZ
Date: Mon, 26 Apr 2010 23:19:34 -0300
Message-ID: <20100427021934.GJ12813@vigoh>
In-Reply-To: <33AB447FBD802F4E932063B962385B351D9FDF3B@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8991035659998505923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

* Zhang, Zhenhua <zhenhua.zhang@intel.com> [2010-04-27 10:14:38 +0800]:

> Hi Padovan,
> =

> Gustavo F. Padovan wrote:
> > Hi all,
> > =

> > I'm starting the DUN Client implementation for the Linux
> > Stack. DUN is the Bluetooth dial-up network profile. It makes
> > possible share internet connection between two Bluetooth
> > devices. That is my Google Summer of Code project for this year.
> > =

> > Here follows a simple, and possible not complete, roadmap:
> > =

> > 1. Put send_method_call() and send_method_call_with_reply() on
> > gdbus: those functions are very useful for DBus operations.
> > You can send a DBus message just calling them with the right
> > parameters. Patch for that work already on the mailing list.
> >
> > 2. Create a bluetooth.c file with the bluetooth helpers. oFono
> > plugins for HFP, DUN and SAP will be able to share the same
> > bluetooth code to access BlueZ stuff. This is a ongoing work.
> =

> Is this bluetooth.c like a utility to watch BlueZ status, watch adapter c=
hange and signals? If I understand correctly, every plugin like HFP, DUN, S=
AP will add status callback for different event.

Exactly, that's the idea.

> =

> > 3. plugin/dun.c prototype. A simple prototype for the DUN client.
> =

> Not quite sure whether we need this. Denis suggests to create an Emulator=
 atom in the ofono core. I am now making a prototype to create this atom in=
 oFono.
> The structure is similar to voicecall.c. An emulator manager could create=
 HFP AG, DUN or SPP type emulators. When one is created, other atom get not=
ified and register their interested AT command handers to GAtServer. So in =
this way, agent server on BlueZ may call oFono CreateEmulator method and pa=
ss file descriptor directly to oFono.

If I understood correctly the Emulator will be useful for the DUN
Gateway side. Right?
Right now I'm going to work on the DUN Client.

> =

> > 4. Agent server on BlueZ. This one is very similar to the HFP
> > Agent server. At the end of the DUN agent project I plan to
> > merge the both agent servers. SAP will take advantage of that merge
> > too. =

> > =

> > 5. oFono DUN agent. Implement the agent handling for DUN.
> =

> Actually, my original prototype is quite simliar with yours. DUN, HFP and=
 SPP are implemented as plugins. See my previous patches in the mailing lis=
t for details.

In my mind that will be similar to the HFP agent implementation I did
inside oFono.

> =

> > 6. AT command parser and PPP stack integration with DUN. The
> > biggest task, where the core of the project is.
> =

> GAtServer and PPP are already there. We still need to add DUN specific co=
mmand and callbacks.
> =

> > 7. ConnMan integration. Setup of the NAT and Internet Connections.
> > =


Regards,

-- =

Gustavo F. Padovan
http://padovan.org

--===============8991035659998505923==--

