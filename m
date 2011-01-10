Content-Type: multipart/mixed; boundary="===============7404899781033045240=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 1/1] Add voice call boolean property for MO/MT distinction
Date: Mon, 10 Jan 2011 17:28:43 +0200
Message-ID: <201101101728.44150.remi.denis-courmont@nokia.com>
In-Reply-To: <AANLkTim0s1MiQvaQkg7-5-RLBQ7NWAkgK=oXzj_38+ZF@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7404899781033045240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Monday 10 January 2011 17:20:13 ext Aki Niemi, you wrote:
> 2011/1/4 R=C3=A9mi Denis-Courmont <remi.denis-courmont@nokia.com>:
> > ---
> >  doc/voicecall-api.txt |    5 +++++
> >  src/voicecall.c       |    6 +++++-
> >  2 files changed, 10 insertions(+), 1 deletions(-)
> > =

> > diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
> > index 4f38e6a..682b46b 100644
> > --- a/doc/voicecall-api.txt
> > +++ b/doc/voicecall-api.txt
> > @@ -92,6 +92,11 @@ Properties   string LineIdentification [readonly]
> >                        Contains the Name Identification information
> > returned by the network, if present.
> > =

> > +               boolean Originated [readonly]
> > +
> > +                       Indicates whether the call was mobile-originated
> > +                       (true) or mobile-terminated (false).
> > +
> =

> This (still) looks good to me. I think it makes the API complete.

I resent it with the doc/ and src/ stuff split anyway.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============7404899781033045240==--

