Content-Type: multipart/mixed; boundary="===============8399193838819254168=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: DUN client for oFono and BlueZ
Date: Mon, 26 Apr 2010 21:35:48 -0500
Message-ID: <201004262135.48696.denkenz@gmail.com>
In-Reply-To: <33AB447FBD802F4E932063B962385B351D9FDF3B@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8399193838819254168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> =

> > 3. plugin/dun.c prototype. A simple prototype for the DUN client.
> =

> Not quite sure whether we need this. Denis suggests to create an Emulator
>  atom in the ofono core. I am now making a prototype to create this atom =
in
>  oFono. The structure is similar to voicecall.c. An emulator manager could
>  create HFP AG, DUN or SPP type emulators. When one is created, other atom
>  get notified and register their interested AT command handers to
>  GAtServer. So in this way, agent server on BlueZ may call oFono
>  CreateEmulator method and pass file descriptor directly to oFono.

Gustavo is working on DUN _client_, the ModemEmulator work is on the DUN =

_server_ roles.  There is a difference ;)

Regards,
-Denis

--===============8399193838819254168==--

