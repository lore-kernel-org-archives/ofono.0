Content-Type: multipart/mixed; boundary="===============8802615893205585463=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFCv2] doc: Proposal for LTE/IMS API
Date: Tue, 08 Feb 2011 17:22:43 +0100
Message-ID: <AANLkTi=Jt0w-UqJ8MtqDae83A6U6baAbzhh6YtR5+mc5@mail.gmail.com>
In-Reply-To: <201102081647.26748.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8802615893205585463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

> > +Service =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0org.ofono
> > +Interface =C2=A0 =C2=A0org.ofono.IpMultimediaSubsystem
> > +Object path =C2=A0[variable prefix]
>
> I guess this is meant to be a modem object path, but it seems the oFono
> documentation is already a bit sloppy on this point.

Yes, this should be the modem object path. I'll fix this in the next patch.

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void Register(string type)
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 Register a IMS Application. It must register
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 with one of the types:
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 "voice", "messaging", "voice_messaging".
>
> I am not very familiar with the underlying protocol... If it really makes
> sense to register both services simultaneously, then I think we should ha=
ve an
> array of strings. Or if there are no benefits, then why bother with
> 'voice_messaging' anyway.

Yes, an array of strings might be a good idea here.

....
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 boolean PreConditionCheck(s=
tring Type, string PeerAddress,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16 PeerPort, =
=C2=A0uint16 LocalPort)
> > +
> That stuff is per context. Should it not be in the context object rather =
than
> in the IMS manager?

oFono should only consider QoS information from the IMS
Default and Dedicated bearers when checking the precondition.

In theory there might be more than one IMS APN for a operator,
but I really don't see this as a real life scenario for this.
If anyone disagrees please speak out and explain...

> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 array{string} PcscfAddresse=
s [readonly]
> Should this be in the context object? The AT command is per CID. Would it=
 make
> any sense for a network to have different P-CSCF based on the bearer?

As mentioned above, I don't see why an operator would ever have more than
one IMS APN. If we only have one IMS APN, then we might as well present
this information here in the IMS API.


Regards,
Sjur

--===============8802615893205585463==--

