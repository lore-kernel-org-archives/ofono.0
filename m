Content-Type: multipart/mixed; boundary="===============2978669081648401706=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: ConnectionContext creation for LTE PDN Connection.
Date: Mon, 29 Nov 2010 17:12:51 +0200
Message-ID: <201011291712.51520.remi.denis-courmont@nokia.com>
In-Reply-To: <81C3A93C17462B4BBD7E272753C10579194E651E30@EXDCVYMBSTM005.EQ1STM.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2978669081648401706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

	Hello,

On Monday 29 November 2010 16:46:43 ext Sjur BRENDELAND, you wrote:
> This raises some questions about the handling of
> ConnectionContexts.
> =

> When a terminal attach to LTE network it would
> normally do an implicit context activation request
> associated to attach request (+CGATT=3D1).

Yeah. So the ConnectionManager cannot be 'Powered' off in LTE.

> When the context activation is completed this will
> result in an event notifying about the activated PDN
> connection according to
> 27.007 10.1.19 Packet Domain event reporting +CGEREP.
> =

> +CGEV: ME PDN ACT <cid>
> =

> At this point we have a "connection context" in the modem.
> =

> The question is then, how should we model this in oFono?
> Should we assume/require that a Connection Context
> already is created by ConnMan and pre-exists in
> oFono (possibly with a flag indicating that this
> represents the initial PDN, or perhaps just taking
> the "internet" ConnectionContext)?

The modem driver ought to know what the default PDN is, and match it to the =

correct oFono primary context. no?

> Or should oFono automatically create a Connection Context?
> =

> Furthermore, should oFono automatically proceed and
> set Active=3Dtrue, bind the connection to a network interface
> and set network interface in state UP,

Definitely not. This would interfere with any other existing IP connection,=
 say =

WiFi.

> or should the ConnectionContext initially set Active=3Dfalse,
> waiting for ConnMan to activate it?

This assumes that the default PDN would be the Internet connection. For dat=
a-
only LTE, this might work. But wouldn't this fail miserably for networks wi=
th =

separate PDN for IMS and Internet?

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============2978669081648401706==--

