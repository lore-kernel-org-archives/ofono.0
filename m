Content-Type: multipart/mixed; boundary="===============2250368132777769953=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Added SQLite history plugin
Date: Wed, 07 Apr 2010 14:33:26 -0500
Message-ID: <201004071433.26967.denkenz@gmail.com>
In-Reply-To: <o2y359c5481004071220j1420a157k7f959b9068d4f79@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2250368132777769953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Niko,
Hi Niko,
> After sending X messages the app goes down for some reason, when comes
> up again there are Y messages in the history plugin becouse Y-X new
> messages arrived.
> =

> Well, I want my app to be able to recover from the downtime using the
> history plugin, and want to avoid to resend the first X messages.
> =

> A simple way to achieve that is adding the id in the IncomingMessage
> signal, so the app is able to store it somewhere every time it
> receives a new message.

I suggest storing this information directly in the history database.  E.g. =

Read / Unread flag.  Ideally the application can access the database =

concurrently to mark the message as Read / Unread.  If not, then some sort =
of =

DBus API will be required.

> =

> When the app start, it simply query the history plugin and start
> processing only messages where id > lastsavedid.

Why not query the database directly?

Regards,
-Denis

--===============2250368132777769953==--

