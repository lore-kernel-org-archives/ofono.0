Content-Type: multipart/mixed; boundary="===============2665119128132855891=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 0/3] Attach GPRS on demand
Date: Thu, 09 Dec 2010 08:12:51 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC03000F@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <4D008D0A.3090904@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2665119128132855891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > With these patches, GPRS context activation will cause oFono to
> > automatically attempt GPRS attach if the modem is presently =

> detached.
> > =

> =

> Before I look at these patches: Have you considered fixing the attach
> behavior instead?

I'm not quite sure what you mean here. There are many different cases, wher=
e the network can detach a UE from GPRS service. See possible detach causes=
 in 24.008. Currently, oFono does not recover at all. Trying to figure out =
when GPRS is again available can get pretty complicated and the different d=
etach causes require different handling. IMO, the simplest approach by far =
is to retry GPRS attach when someone actually needs a PDP context. =


>  It seems like the approach you're proposing is
> essentially hitting oFono over the head because it isn't =

> doing what you
> want...

Sorry, still confused. What do you mean?

	MikaL

--===============2665119128132855891==--

