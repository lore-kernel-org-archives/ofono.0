Content-Type: multipart/mixed; boundary="===============8019056837804250016=="
MIME-Version: 1.0
From: Marcel Holtmann <holtmann@linux.intel.com>
Subject: RE: SMS, Packet service and multiplexing
Date: Wed, 13 May 2009 11:54:35 -0700
Message-ID: <1242240875.27899.11.camel@localhost.localdomain>
In-Reply-To: <E49DAF743FB3E9469ED423C0D3DB5F1CA95D70FC@dnce01.ent.ti.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8019056837804250016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikkel,

> > I work on a project where we use a Wavecom modem. We chose to use a =

> > second serial line to handle the PPP stream. If Ofono have working SMS =

> > and packet service multiplexing, we will probably evaluate it use into =
a =

> > next revision of the project product so we can save a serial line.
> =

> Freesmartphone.org does have a 07.10 (27.010) Multiplexer that does the t=
rick of multiplexing.

we are looking at an option to finally put such a multiplexer into the
kernel (where it belongs). The userspace solution generates too many
context switches and introduces latency when we are connecting via EDGE
or UMTS and shuffle a lot of data over that line.

Regards

Marcel



--===============8019056837804250016==--

