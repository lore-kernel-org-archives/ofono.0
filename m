Content-Type: multipart/mixed; boundary="===============2777076152668402758=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Please comment on callhistory API
Date: Tue, 28 Sep 2010 08:14:44 +0900
Message-ID: <1285629284.9845.18.camel@aeonflux>
In-Reply-To: <4CA123D4.9080500@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2777076152668402758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >> CallHistory hierarchy
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Service : org.ofono
> >> Interface : org.ofono.CallHistory
> >> Object path : [variable prefix]/{modem0,modem1,...}/CallHistory
> > =

> > the object path is wrong here. This should be pretty much on the main /
> > object path. And not on per modem and not in a sub-path.
> > =

> > I really don't think that per modem history makes sense. Denis?
> =

> The idea here is that you can track history by the modem object or more
> likely the IMSI.  Thus when switching SIMs or in dual-sim mode phones,
> the history shown might change depending on the current SIM.

by modem makes no sense. That might change at any time. For example even
if you get a phone replacement. So not really helpful.

The IMSI I can see, but isn't it better then just to include the IMSI
into the report send to the history application. Not that I actually
like sending the IMSI around so much :(

Regards

Marcel



--===============2777076152668402758==--

