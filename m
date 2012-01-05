Content-Type: multipart/mixed; boundary="===============4280081992858540310=="
MIME-Version: 1.0
From: Deng, Ying An <ying.an.deng@intel.com>
Subject: RE: [PATCH] udevng: use huaweicdma driver for olive V-ME101
Date: Thu, 05 Jan 2012 02:28:25 +0000
Message-ID: <688E999A39D0DD478D9CFCDC485D64829F31@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <1321619263-28308-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4280081992858540310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch has not been accepted on upstream, but it seriously impacts supp=
ort to VM101 CDMA dongle.
Can anybody help?

>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf
>Of Nicolas Bertrand
>Sent: Friday, November 18, 2011 8:28 PM
>To: ofono(a)ofono.org
>Subject: [PATCH] udevng: use huaweicdma driver for olive V-ME101
>
>---
> plugins/udevng.c |    3 +--
> 1 files changed, 1 insertions(+), 2 deletions(-)
>
>diff --git a/plugins/udevng.c b/plugins/udevng.c
>index be87320..8d478cf 100644
>--- a/plugins/udevng.c
>+++ b/plugins/udevng.c
>@@ -800,11 +800,10 @@ static struct {
> 	{ "hso",	"hso"				},
> 	{ "gobi",	"qcserial"			},
> 	{ "sierra",	"sierra"			},
>-	{ "huawei",	"option",	"201e", "2009"	},
>+	{ "huaweicdma",	"option",	"201e", "2009"	},
> 	{ "huawei",	"cdc_ether",	"12d1"		},
> 	{ "huawei",	"option",	"12d1"		},
> 	{ "huaweicdma",	"option",	"12d1", "140b"	},
>-	{ "huaweicdma", "option",	"201e"		},
> 	{ "speedupcdma","option",	"1c9e", "9e00"	},
> 	{ "speedup",	"option",	"1c9e"		},
> 	{ "speedup",	"option",	"2020"		},
>--
>1.7.4.1
>
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============4280081992858540310==--

