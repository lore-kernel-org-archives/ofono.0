Content-Type: multipart/mixed; boundary="===============1655911076256206606=="
MIME-Version: 1.0
From: Mario Tokarz <mario@tokarz.eu>
Subject: Re: [RFC 3/3] dun_dt: Add baseline for dun_dt plug-in.
Date: Sun, 10 Jul 2011 23:07:23 +0200
Message-ID: <20110710210723.GA3206@mario-laptop>
In-Reply-To: <20110707165932.GA16322@joana>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1655911076256206606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Thu, Jul 07, 2011 at 01:59:32PM -0300 , Gustavo Padovan wrote:
> Hi Mario,
> =

> * Mario Tokarz <mario@tokarz.eu> [2011-07-07 10:45:23 +0200]:
> =

> > From: Mario Tokarz <mario.tokarz@bmw-carit.de>
> > --- /dev/null
> > +++ b/plugins/dun_dt.c
> > @@ -0,0 +1,337 @@
> > +/*
> > + *
> > + *  oFono - Open Source Telephony
> > + *
> > + *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
> > + *  Copyright (C) 2010  ProFUSION embedded systems
> =

> So this is mine as in the original code I wrote. Not from ProFUSION.
> It was part of a Google Summer of Code project.
> =

> 	Copyright (C) 2010 Gustavo Padovan <gustavo@padovan.org>
> =


Ah, ok - sorry for that. I based it on plugins/hfp_hc.c, so maybe the
Copyright Notice would need update on that file as well?

> > +
> > +	strcpy(alias_buf, "DUN ");
> > +	strcat(alias_buf, alias);
> =

> Do you really need tell the user this is a DUN modem? It doesn't care.
> =


Hm, ok. I'll look into that again then. I will be back with an
update. =


Thanks for taking the time to look over that.
Mario

--===============1655911076256206606==--

