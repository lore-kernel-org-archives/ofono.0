Content-Type: multipart/mixed; boundary="===============6590186832363238676=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/4 v2] Network Time plugin
Date: Tue, 21 Dec 2010 06:17:44 -0800
Message-ID: <1292941064.2658.29.camel@aeonflux>
In-Reply-To: <1292916842.10058.5.camel@apaila-ThinkPad-T410>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6590186832363238676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

please do not top-post on this mailing list.

> Could someone review this patch. It has been waiting for review a while
> now. Thanks.

<snip>

> > This series of patches introduces the network time part of the NITZ fea=
ture =

> >  as outlined in 3GPP spec 22.042. The Network Time plugin has two DBUS =

> >  interfaces for client applications: notification signal and polling me=
thod =

> >  call. The time information consists of three dictionary entries: 1) ti=
me and =

> >  date in seconds from epoch (renormalized to time indicatation arrival =
time);
> >  2) daylight saving time; 3) timezone.

I am still saying that the plugin should monitor the presence of timed
and then just send a D-Bus message to timed. That saves us the problem
with the timestamping. And in case timed is not running it should just
set the current time directly.

I really prefer that we don't hand out timestamps over the D-Bus API.
That seems wrong to me.

Regards

Marcel



--===============6590186832363238676==--

