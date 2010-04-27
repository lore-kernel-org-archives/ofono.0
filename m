Content-Type: multipart/mixed; boundary="===============6231027247376298698=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: Re: DUN client for oFono and BlueZ
Date: Tue, 27 Apr 2010 03:35:33 -0300
Message-ID: <20100427063533.GA30819@vigoh>
In-Reply-To: <8739yhsa92.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6231027247376298698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

* Kalle Valo <kalle.valo@canonical.com> [2010-04-27 09:03:05 +0300]:

> "Gustavo F. Padovan" <gustavo@padovan.org> writes:
> =

> > Hi all,
> =

> Hello Gustavo,
> =

> > I'm starting the DUN Client implementation for the Linux Stack. DUN is
> > the Bluetooth dial-up network profile. It makes possible share internet
> > connection between two Bluetooth devices. That is my Google Summer of C=
ode
> > project for this year.
> =

> Excellent, I'm eagerly waiting for this. I hate cables =3D)
> =

> As soon as you have something working, please do send patches so that
> people can test it.
> =

> > 4. Agent server on BlueZ. This one is very similar to the HFP Agent ser=
ver. At
> > the end of the DUN agent project I plan to merge the both agent servers=
. SAP
> > will take advantage of that merge too.
> >
> > 5. oFono DUN agent. Implement the agent handling for DUN.
> =

> Sorry, I'm not familiar with HFP Agent, but what will this agent
> actually do on a DUN connection

The agent can request a RFCOMM connection and receive the RFCOMM channel
via DBus fd-passing. The the DUN plugin can do the handshake.

> =

> > 6. AT command parser and PPP stack integration with DUN. The biggest ta=
sk,
> > where the core of the project is.
> >
> > 7. ConnMan integration. Setup of the NAT and Internet Connections.
> =

> Why NAT is needed? I guess only for connection sharing.

No idea yet, I guess Denis told me about the NAT, but that will be the last=
 part
of the project, so I'm not caring about it now. I have to check on my
irc logs.


-- =

Gustavo F. Padovan
http://padovan.org

--===============6231027247376298698==--

