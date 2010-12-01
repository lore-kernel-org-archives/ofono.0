Content-Type: multipart/mixed; boundary="===============2003345490060384114=="
MIME-Version: 1.0
From: Simon LETHBRIDGE <simon.lethbridge@stericsson.com>
Subject: RE: [PATCH] doc: Add Location Services API
Date: Wed, 01 Dec 2010 14:35:39 +0100
Message-ID: <B4268AAFAFA3E244B5B0641D5914917048BCFBFACD@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <201011261811.59836.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2003345490060384114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

> >
> > Would it make sense to add a ResetStoredInfo signal to the DBUS API
> for
> > implementation in a modem specific way?
> =

> Yes. There are no standard commands for that and it is very much needed
> for
> conformance testing.
> =

> However, I would have thought that this was an issue between the
> automatic
> test equipment and the (Linux) positioning engine. In this case, what
> business
> does oFono and the modem have there? =


The assistance data reset command is received via control plane signalling =
for the 3GPP performance tests.

Regards,

Simon

--===============2003345490060384114==--

