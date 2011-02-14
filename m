Content-Type: multipart/mixed; boundary="===============6702170335035896144=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: RE: [PATCH] Enable hs 2330 MBM modem
Date: Mon, 14 Feb 2011 10:45:55 +0800
Message-ID: <B32E3D5F1713054290B4FF257B89C51A29DEF646DF@shsmsx502.ccr.corp.intel.com>
In-Reply-To: <1296206207.1520.165.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6702170335035896144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> >+			g_str_has_suffix(desc, "Data Modem") ||

> I think this should be "Module Data Modem".

This is confusing part, with my test with this modem on MeeGo image, the Mo=
dule Data Modem doesn't work and only Data Modem works.

So I think it should be ok.

Thanks =

Zhigang



_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono

--===============6702170335035896144==--

