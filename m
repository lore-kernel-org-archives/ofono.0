Content-Type: multipart/mixed; boundary="===============0511548459540172872=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] Enable hs 2330 MBM modem
Date: Wed, 16 Feb 2011 19:16:46 -0800
Message-ID: <1297912606.2519.22.camel@aeonflux>
In-Reply-To: <B32E3D5F1713054290B4FF257B89C51A29DEF646DF@shsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0511548459540172872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhigan,

> > >+			g_str_has_suffix(desc, "Data Modem") ||
> =

> > I think this should be "Module Data Modem".
> =

> This is confusing part, with my test with this modem on MeeGo image, the =
Module Data Modem doesn't work and only Data Modem works.
> =

> So I think it should be ok.

looks wrong to me. Please get the lsusb -v out for this modem where it
lists the interface strings.

Regards

Marcel



--===============0511548459540172872==--

