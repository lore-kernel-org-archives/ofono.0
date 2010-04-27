Content-Type: multipart/mixed; boundary="===============0463996836834678887=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: DUN client for oFono and BlueZ
Date: Tue, 27 Apr 2010 09:03:05 +0300
Message-ID: <8739yhsa92.fsf@potku.valot.fi>
In-Reply-To: <20100427012059.GG12813@vigoh>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0463996836834678887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

"Gustavo F. Padovan" <gustavo@padovan.org> writes:

> Hi all,

Hello Gustavo,

> I'm starting the DUN Client implementation for the Linux Stack. DUN is
> the Bluetooth dial-up network profile. It makes possible share internet
> connection between two Bluetooth devices. That is my Google Summer of Code
> project for this year.

Excellent, I'm eagerly waiting for this. I hate cables =3D)

As soon as you have something working, please do send patches so that
people can test it.

> 4. Agent server on BlueZ. This one is very similar to the HFP Agent serve=
r. At
> the end of the DUN agent project I plan to merge the both agent servers. =
SAP
> will take advantage of that merge too.
>
> 5. oFono DUN agent. Implement the agent handling for DUN.

Sorry, I'm not familiar with HFP Agent, but what will this agent
actually do on a DUN connection?

> 6. AT command parser and PPP stack integration with DUN. The biggest task,
> where the core of the project is.
>
> 7. ConnMan integration. Setup of the NAT and Internet Connections.

Why NAT is needed? I guess only for connection sharing.

-- =

Kalle Valo

--===============0463996836834678887==--

