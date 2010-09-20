Content-Type: multipart/mixed; boundary="===============7435727960320927710=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 2/2] huawei: fix online logic
Date: Tue, 21 Sep 2010 02:09:55 +0900
Message-ID: <1285002595.20811.37.camel@localhost.localdomain>
In-Reply-To: <20100920124033.12498.3545.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7435727960320927710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> The recently introduced online support to huawei didn't work with my
> Huawei E1552. The problem was that with command AT+CFUN=3D1;+CFUN=3D5
> the modem didn't initialise the sim state properly.
> =

> To fix this I changed the logic so that CFUN=3D5 is called only after the=
 sim
> state has switched to a valid state. Now my Huawei E1552 works with connm=
an
> again.
> =

> PIN locked SIMs still won't work. The problem is that it takes some time =
for
> the sim state to go to a valid state:
> =

> Sep 20 15:01:57 dell-m520 ofonod[12451]: Pcui:< \r\n+CPIN: READY\r\n\r\nO=
K\r\n
> [...]
> Sep 20 15:02:00 dell-m520 ofonod[12451]: huawei: invalid sim state in pos=
t online (0)
> [...]
> Sep 20 15:02:01 dell-m520 ofonod[12451]: Pcui:< \r\n^SIMST:1\r\n
> =

> I don't know why it takes so long to get a valid state.
> =

> There is also another issue, in "cold start" case the phonebook
> initialisation fails:
> =

> Sep 20 14:34:24 dell-m520 ofonod[11939]: Pcui:> AT+CPBS=3D?\r
> Sep 20 14:34:24 dell-m520 ofonod[11939]: Pcui:< \r\n+CME ERROR: SIM busy\=
r\n
> =

> But in "warm start" it seems to work:
> =

> Sep 20 14:38:59 dell-m520 ofonod[12091]: Pcui:> AT+CPBS=3D?\r
> Sep 20 14:38:59 dell-m520 ofonod[12091]: Pcui:< \r\n+CPBS: ("SM","EN","ON=
")\r\n\r\nOK\r\n
> =

> I consider this as a minor issue and didn't investigate it at all.
> ---
>  plugins/huawei.c |   77 +++++++++++++++++++++++++++++++++++++-----------=
------
>  1 files changed, 53 insertions(+), 24 deletions(-)

patch has been applied.

Regards

Marcel



--===============7435727960320927710==--

