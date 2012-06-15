Content-Type: multipart/mixed; boundary="===============0602549967073024136=="
MIME-Version: 1.0
From: Gustavo Padovan <gustavo@padovan.org>
Subject: Re: oFono DUN server issue
Date: Thu, 14 Jun 2012 23:58:29 -0300
Message-ID: <20120615025829.GB3538@joana>
In-Reply-To: <4FDA65D8.3020608@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0602549967073024136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

* Denis Kenzior <denkenz@gmail.com> [2012-06-14 17:29:44 -0500]:

> Hi Gustavo,
> =

> >>Likely the culprit is this line inside __dundee_bluetooth_init
> >>
> >>         err =3D bluetooth_register_uuid(DUN_GW_UUID,&dun_profile);
> >>
> >>It should probably use the UUID of the DUN client, not the gateway.
> >
> >We actually don't have an client uuid for DUN, and we need to put the se=
rver
> >uuid here in order to find the remote DUN Gateways.
> >Other than that he reported an issue in oFono, so how can dundee interfe=
re on
> >it?
> =

> I'm just speculating, but the problem here is that both dundee and
> the modem emulator are registering the DUN service.  Unfortunately
> dundee is implementing the client role and modem emulator is
> implementing the server role.

They aren't, DUN server register a server, through
bluetooth_register_server(), there is no UUID on this. Only DUN Service
register itself as DUN on BlueZ.

> =

> Perhaps dundee does not need to register an SDP record at all.  I'm
> too lazy to dig out the DUN spec.

It doesn't need because it doesn't have one. We use DUN_GW_UUID here because
we want plugins/bluetooth.c to notify us when a DUN_GW device appears so th=
en
we can use or DUN Client (dundee) to connect to it.

HFP does the same, in the Handsfree side we register for the UUID of the
Gateway side because you want to know about new HFP  gateways on the system.

	Gustavo

--===============0602549967073024136==--

