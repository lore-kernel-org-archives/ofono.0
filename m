Content-Type: multipart/mixed; boundary="===============9088396183779468924=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Sat, 04 Dec 2010 01:02:56 +0100
Message-ID: <1291420976.4795.113.camel@aeonflux>
In-Reply-To: <AANLkTim7GyxfbDttWSuUraSDdRXgcWKT-Fq3odZ1C1EN@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9088396183779468924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> The only thing I would change here are the names. It's customary to
> avoid repeating the interface name in the signal or method, but of
> course the problem here is then what to call these. Maybe just Get()
> and Changed()? ;-)
> =

> Oh, and you probably should have included a short description of what
> this plugin is for (I forgot to mention this before).
> =

> The thinking behind this plugin is that timed in MeeGo wants to get
> the information, and a D-Bus API is a fine way to accomplish this.

where is this timed running? I prefer the plugin just send a D-Bus
message to the timed directly instead of a Get/Changed API kind of
thing.

Doing it this way looks highly complicated to me and doesn't serve any
purpose if timed and ofonod are both using the D-Bus system bus.

Regards

Marcel



--===============9088396183779468924==--

