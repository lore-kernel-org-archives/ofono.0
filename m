Content-Type: multipart/mixed; boundary="===============7986388009785154068=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH_v0 1/3] doc: Add RoamingAllowed property
Date: Fri, 02 Dec 2011 12:09:11 +0200
Message-ID: <7737754.vMuGffl7lN@hector>
In-Reply-To: <4ED51917.9010808@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7986388009785154068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le Mardi 29 Novembre 2011 11:40:39 ext Denis Kenzior a =C3=A9crit :
> > +		boolean RoamingAllowed [readwrite]
> > +
> > +			Contains whether data roaming is allowed.  In the off
> > +			setting, if the packet radio registration state
> > +			indicates that the modem is roaming, oFono will
> > +			automatically shutdown connection and no further
> > +			connection establishment will be possible.
> > +
> =

> I'm still not convinced this is really needed.  Can you discuss a
> specific usecase you are trying to take care of here?

I do not know CDMA but I do not see why this would be needed at all at the =

ConnectionManager atom level. If this is about pricing, it should probably =
be =

a per-context property instead, both for CDMA and GSM.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/


--===============7986388009785154068==--

