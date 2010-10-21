Content-Type: multipart/mixed; boundary="===============8606971468749992452=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 1/4] radio settings: allow for more than one property
Date: Thu, 21 Oct 2010 10:55:02 +0200
Message-ID: <C358A26273CF2948B8BCDBA661A581782A7D03A877@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <4CBF73E3.4010904@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8606971468749992452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Please don't mix and match tabs and spaces for indentation

Oops, will fix. For some reason my checkpatch script did not complain about=
 this.

You must be using a script as well. To avoid unnecessary fuss like this, wo=
uld it be possible to integrate it to the oFono tree so everyone would chec=
k their patches using the same thing?

> I prefer you keep the current implementation as it is consistent with
> the rest of ofono core.  The way the rest of the core works =

> is that you
> query each in sequence, then set the the CACHED flag (only one is
> actually required).
> =

> We use a single cached flag to keep the logic simpler and optimize for
> the general case (e.g. UI will query the properties first before
> allowing the user to set them)  While this does lead to us =

> querying some
> attributes unnecessarily in certain extremely unlikely corner cases, I
> believe it is an acceptable compromise.

This was my intention as well but I did it in a different way, as I didn't =
realize there was an existing pattern for it.

My code does actually query all the properties up front but I serialized th=
e driver queries in a different way. I.e., I used a separate CACHED flag fo=
r each property to keep track of whether the value is already valid. Each d=
river callback attempts to create the pending reply. The attempt to create =
the reply either succeeds or triggers a new driver query for another missin=
g property value. This goes on until all the properties are cached and the =
pending reply can be sent.

I now see that the other services use a separate state machine to fetch the=
 properties. That introduces more code than my solution but I guess I can d=
o it that way if you feel it is easier to read.

	MikaL

--===============8606971468749992452==--

