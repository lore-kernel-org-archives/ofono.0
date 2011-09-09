Content-Type: multipart/mixed; boundary="===============6627493995186825899=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: How to set access technology for CDMA modem
Date: Fri, 09 Sep 2011 07:36:24 +0000
Message-ID: <ED4DEEB78293B34A9D0EAC02A474A46E0211CE@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <CE59C043D0EC3349B2BF41C0EC72229B12D2638B83@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6627493995186825899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>Here we got problem with CDMA dongle (CDMA2000/EVDO/HSIA), in Windows dial=
er we can >select the network type as following: Netconnect +, High speed 1=
x or HYBRID.
>I assume Netconnect+ stands for CDMA2000, and High Speed 1x stands for CDM=
A EVFDO >1x. =


>And the dialer will show in an icon to tell what mode is select or can be =
supported >currently. If select an unsupported type, it could fail to conne=
ct to the network.

>But when trying to modify the radio access technology in ofono, I cannot s=
ee the >according options, what is there is GSM, UMTS, ANY, etc.
>Could anybody tell me how to issue the script set-tech-reference to force =
ofono to >work in desired network type?

oFono CDMA support is not complete, and RAT (Radio Access Technology) is no=
t supported yet, so you cannot configure this.

Regards,

Bertrand
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============6627493995186825899==--

