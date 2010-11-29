Content-Type: multipart/mixed; boundary="===============1377901499344512394=="
MIME-Version: 1.0
From: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Subject: ConnectionContext creation for LTE PDN Connection.
Date: Mon, 29 Nov 2010 15:46:43 +0100
Message-ID: <81C3A93C17462B4BBD7E272753C10579194E651E30@EXDCVYMBSTM005.EQ1STM.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1377901499344512394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

We have started to investigate LTE impact on oFono, =

specifically how to integrate LTE and initial PDN connection,
and we have some questions regarding this.

This raises some questions about the handling of
ConnectionContexts.

When a terminal attach to LTE network it would
normally do an implicit context activation request
associated to attach request (+CGATT=3D1).
When the context activation is completed this will
result in an event notifying about the activated PDN
connection according to
27.007 10.1.19 Packet Domain event reporting +CGEREP.

+CGEV: ME PDN ACT <cid>

At this point we have a "connection context" in the modem.

The question is then, how should we model this in oFono?
Should we assume/require that a Connection Context
already is created by ConnMan and pre-exists in =

oFono (possibly with a flag indicating that this
represents the initial PDN, or perhaps just taking
the "internet" ConnectionContext)?
Or should oFono automatically create a Connection Context?

Furthermore, should oFono automatically proceed and
set Active=3Dtrue, bind the connection to a network interface
and set network interface in state UP, or should the
ConnectionContext initially set Active=3Dfalse, =

waiting for ConnMan to activate it?


Regards,
Sjur

--===============1377901499344512394==--

