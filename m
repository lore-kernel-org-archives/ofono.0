Content-Type: multipart/mixed; boundary="===============0010574061785378119=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Thu, 06 Jan 2011 09:53:06 -0800
Message-ID: <1294336386.2501.11.camel@aeonflux>
In-Reply-To: <AANLkTimEnzUrSuJtSJuvUp+vNGANi6rsWgvAnHhb_j0J@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0010574061785378119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> > I thought that we came to the conclusion that CID=3D0 is pretty much a
> > really bad idea. So I would prefer that your modem is actually not using
> > CID=3D0 ever.
> Yea, I know you or Denis said so, but I'm not sure we understood your con=
cern...

I really thought it became pretty much clear during the discussion that
introducing a CID=3D0 that is just special on LTE is a pretty much bad
idea.

As long as CID=3D0 concept does not exist in GSM/UMTS, you should not make
LTE a special case. It will not fit and just makes things utterly
complex for the telephony stack to figure out when contexts are moved
from LTE to  GSM/UMTS.

If CID=3D0 is not valid for GSM/UTMS then you are in big trouble to make
this work properly. And if it is valid, then there is no difference
between it being CID=3D0 or any other CID.

So please step away from the CID=3D0 idea and just give the next free CID
to the network activated context. And per specification the CID start
with 1.

Regards

Marcel



--===============0010574061785378119==--

