Content-Type: multipart/mixed; boundary="===============2770913605605527401=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] udevng: use huaweicdma driver for olive V-ME101
Date: Thu, 05 Jan 2012 11:17:02 -0800
Message-ID: <1325791022.6454.68.camel@aeonflux>
In-Reply-To: <4F05CA3C.5090005@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2770913605605527401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

> >>   plugins/udevng.c |    3 +--
> >>   1 files changed, 1 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/plugins/udevng.c b/plugins/udevng.c
> >> index be87320..8d478cf 100644
> >> --- a/plugins/udevng.c
> >> +++ b/plugins/udevng.c
> >> @@ -800,11 +800,10 @@ static struct {
> >>   	{ "hso",	"hso"				},
> >>   	{ "gobi",	"qcserial"			},
> >>   	{ "sierra",	"sierra"			},
> >> -	{ "huawei",	"option",	"201e", "2009"	},
> >> +	{ "huaweicdma",	"option",	"201e", "2009"	},
> >>   	{ "huawei",	"cdc_ether",	"12d1"		},
> >>   	{ "huawei",	"option",	"12d1"		},
> >>   	{ "huaweicdma",	"option",	"12d1", "140b"	},
> >> -	{ "huaweicdma", "option",	"201e"		},
> >>   	{ "speedupcdma","option",	"1c9e", "9e00"	},
> >>   	{ "speedup",	"option",	"1c9e"		},
> >>   	{ "speedup",	"option",	"2020"		},
> >
> > the commit message does not explain why you are removing huaweicdma in
> > general for VID 0x201e.
> =

> I've removed the generic configuration of HAIER's modem (0x201e) since =

> there is only one product ID used for the moment by this vendor (seen in =

> the option driver).
> =

> Do I need to only use the generic configuration and removing the =

> specific one to the PID 2009 or either simply add this comment in the =

> commit message?

you could just state this in the commit message. I think it is fine to
do this, but if you do not mention it, how should I know.

Regards

Marcel



--===============2770913605605527401==--

