Content-Type: multipart/mixed; boundary="===============0771925144227664548=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Bj=C3=B8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH 7/8] sierra: Support CDMA modems
Date: Tue, 05 Mar 2013 22:45:15 +0100
Message-ID: <87obexo710.fsf@nemi.mork.no>
In-Reply-To: <20130305193619.GK11149@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0771925144227664548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Forest Bond <forest@alittletooquiet.net> writes:

> Anyway, I notice that one of the ports appears to be QCDM.  It appears th=
at QCDM
> support is partially implemented in oFono?  But I don't know QCDM at all.=
  Can
> we use it to do netreg?

What kind of Sierra device is this?  And what vid is it using?

I ask because I have only seen QCDM ports active on Sierra devices
in firmware modes with rmnet/qmi_wwan interfaces.  In which case you
should have QMI support.

> If not, I could probably implement (partial) CnS support at some point.  =
I'm
> just not sure I will have time to do it right away.

And those modes do not have any CnS ports.


Bj=C3=B8rn

--===============0771925144227664548==--

