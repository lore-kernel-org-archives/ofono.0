Content-Type: multipart/mixed; boundary="===============6369302314695520132=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: Crash in network-registration.c/creg_notify() when receiving
 unsolicited "+CREG: 0"
Date: Tue, 10 Aug 2010 17:06:53 +0800
Message-ID: <33AB447FBD802F4E932063B962385B3528EA7D50@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <2A84145621092446B6659B8A0F28E26F464DFFBC71@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6369302314695520132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Emmanuel,

Berthier, Emmanuel wrote:
> Hi,
> =

> I use ofono 0.25 and encounter a segmentation fault when
> trying to put the modem OffLine (flight mode).
> =

> The AT command sent to modem is:
> =

> AT+CFUN=3D4
> =

> The modem replies with:
>                OK
>                +CREG=3D0
> =

> Then, in creg_notify(), the user_data points to uninitialized
> (deallocated?) memory and access to =E2=80=9Cnd->vendor=E2=80=9D causes t=
he crash.
> =


I might know where is the problem. We should unregister all notifies from g=
atchat in at_netreg_remove. Same for gprs and other drivers as well. Curren=
tly, we don't do that well. I will send patches soon.

> =

> Effectivelly, user_data pointer is the one set by
> at_creg_set_cb(), and is freed by
> g_at_chat_finish_command()/at_command_destroy().
> =

> So, it seems that ofono does not manage unsolicited +CREG command.
> =

> =

> =

> What=E2=80=99s your feeing?
> =

> =

> =

> Thanks.
> =

> =

> =

> Emmanuel.
> =

> =

> =

> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris, 92196
> Meudon Cedex, France Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 4,572,000 Euros
> =

> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.



Regards,
Zhenhua


--===============6369302314695520132==--

