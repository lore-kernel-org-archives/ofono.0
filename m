Content-Type: multipart/mixed; boundary="===============1732265915641765304=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH_v0 2/3] huawei: Add modem type detection
Date: Wed, 11 Jan 2012 15:46:38 +0100
Message-ID: <1326293198.6454.230.camel@aeonflux>
In-Reply-To: <688E999A39D0DD478D9CFCDC485D64820FC91725@SHSMSX151.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1732265915641765304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ying An,

> >Right, I see this is easier do to how I you submitted it :)
> >However, I have a dongle EC1261 that is bugged because:
> >         - when I send ATI, the capabilities line is returned with
> >"+GCAP +GCAP:" prefix
> >         - when I send AT+GCAP, the prefix is "+GCAP:"
> >
> >Unless the manufacturer fixes this issue, we won't be able to support
> >this dongle...
> >
>
> The modem returns following lines after ATI command:
> =

> Manufacturer: +GMI: HUAWEI TECHNOLOGIES CO., LTD
> Model: EC1261
> Revision: +CGMR:11.102.11.00.45
> ESN: +GSN:80c55faf
> +GCAP: +GCAP: +CIS707-A,CIS-856-A,+MS, +ES, +DS, +FCLASS
> =

> So you can see, it is still with prefix "+GCAP:", although there's anothe=
r "+GCAP:", but it does not impact the string search operation.

this is the most hilarious screw-up within a single AT command.

Open your window, take this modem, and throw it out. Nothing can really
help you here. If they did not get this one right, I do not wanna know
what else is broken ;)

Regards

Marcel



--===============1732265915641765304==--

