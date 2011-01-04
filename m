Content-Type: multipart/mixed; boundary="===============5857473153549357147=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [RFC PATCHv2 1/4] Automatic provisioning of GPRS context settings
Date: Tue, 04 Jan 2011 10:23:49 +0200
Message-ID: <87k4ilnkkq.fsf@potku.valot.fi>
In-Reply-To: <1294095828.5852.54.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5857473153549357147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> thinking about this a bit more and with the background that there is
> already an existing public database, we might should just enable a
> provision driver inside the oFono core.
>
> Meaning that we can have multiple implementations of different databases
> with just different priorities. Each nicely separated in their own
> plugin and we don't bother the oFono core with where to get the data
> from. So my idea would be that the oFono core just asks to provision a
> new context. If a plugin feels responsible, then it does so. If not then
> it stays empty.

I like the idea. Simple to implement and we get maximum extensibility.

Are you willing to take a plugin into ofono git which would use
mobile-broadband-provider-info database? Or should people maintain the plug=
ins
out of tree?

For me the best would be to have all plugins in ofono tree and
enable/disable them with configure switches.

-- =

Kalle Valo

--===============5857473153549357147==--

