Content-Type: multipart/mixed; boundary="===============3873955279248915353=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: Qualcomm Gobi 2000 Modem Issues
Date: Thu, 07 Apr 2011 16:42:35 +0100
Message-ID: <A782C372B9527D44AB20BF45FEEBB14F75BFED041B@irsmsx503.ger.corp.intel.com>
In-Reply-To: <BANLkTimhdWZCh-BFhs5OLRUyVreU6ufJPA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3873955279248915353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>test/activate-context
>Error activating /gobi0/context1: org.ofono.Error.NotImplemented:
>Implementation not provided
>
>If you could give me a little assisting on where to look, maybe I
>would be able to contribute patches, too.

This second issue looks like an issue reported a couple of days ago.

Can you please check in oFono logs if there is not something like this:

ofonod[2329]: drivers/atmodem/gprs-context.c:at_gprs_context_probe()
ofonod[2329]: Missing support for TUN/TAP devices

And if so, it means that your kernel doesn't have support for TUN enabled.

Regards,

Bertrand.
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


--===============3873955279248915353==--

