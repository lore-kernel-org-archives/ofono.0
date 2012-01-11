Content-Type: multipart/mixed; boundary="===============1135949302955540815=="
MIME-Version: 1.0
From: Deng, Ying An <ying.an.deng@intel.com>
Subject: RE: [PATCH_v0 2/3] huawei: Add modem type detection
Date: Wed, 11 Jan 2012 13:42:15 +0000
Message-ID: <688E999A39D0DD478D9CFCDC485D64820FC91725@SHSMSX151.ccr.corp.intel.com>
In-Reply-To: <4F0AB677.8070508@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1135949302955540815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>
>Right, I see this is easier do to how I you submitted it :)
>However, I have a dongle EC1261 that is bugged because:
>         - when I send ATI, the capabilities line is returned with
>"+GCAP +GCAP:" prefix
>         - when I send AT+GCAP, the prefix is "+GCAP:"
>
>Unless the manufacturer fixes this issue, we won't be able to support
>this dongle...
>

Hi,
The modem returns following lines after ATI command:

Manufacturer: +GMI: HUAWEI TECHNOLOGIES CO., LTD
Model: EC1261
Revision: +CGMR:11.102.11.00.45
ESN: +GSN:80c55faf
+GCAP: +GCAP: +CIS707-A,CIS-856-A,+MS, +ES, +DS, +FCLASS

So you can see, it is still with prefix "+GCAP:", although there's another =
"+GCAP:", but it does not impact the string search operation.

--===============1135949302955540815==--

