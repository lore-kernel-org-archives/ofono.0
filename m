Content-Type: multipart/mixed; boundary="===============4899112680242142596=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 5/6] GPRS: document bearer property
Date: Thu, 20 Jan 2011 10:26:14 +0200
Message-ID: <201101201026.14790.remi.denis-courmont@nokia.com>
In-Reply-To: <AANLkTintNFsNHsBRxc=W=vAVW0knZ-4wSj_YKS0hAjwd@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4899112680242142596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thursday 20 January 2011 10:06:50 ext Aki Niemi, you wrote:
> Hi R=C3=A9mi,
> =

> 2011/1/19 R=C3=A9mi Denis-Courmont <remi.denis-courmont@nokia.com>:
> > ---
> >  doc/connman-api.txt |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> > =

> > diff --git a/doc/connman-api.txt b/doc/connman-api.txt
> > index 22e02e5..13f622c 100644
> > --- a/doc/connman-api.txt
> > +++ b/doc/connman-api.txt
> > @@ -77,6 +77,16 @@ Properties   boolean Attached [readonly]
> >                        be available, e.g. receiving SMS over packet rad=
io
> >                        or network initiated PDP activation.
> > =

> > +               string Bearer [readonly, optional]
> > +
> > +                       Contains the data bearer technology as reported
> > by the +                       GPRS service registration (if known).
> > +
> > +                       Possible values are:
> > +                       "gsm", "edge", "umts", "hsdpa", "hsupa",
> > +                       "hspa" (HSDPA and HSUPA at the same time) and
> > +                       "lte"
> > +
> =

> Should this also report 'none'? At least CPSB can report that a
> context is idle, i.e., no bearer associated with it.

Right.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============4899112680242142596==--

