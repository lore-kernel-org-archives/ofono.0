Content-Type: multipart/mixed; boundary="===============1589086802126121873=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: Unint var with GCC 4.5.2
Date: Mon, 09 May 2011 10:51:31 +0100
Message-ID: <A782C372B9527D44AB20BF45FEEBB14F75C5086F03@irsmsx503.ger.corp.intel.com>
In-Reply-To: <BANLkTik8oN-02pgupcYKPG5bpsbHDfDa7w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1589086802126121873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrzej,

>That one is a bug.  I remember it caught my eye at some point but
>later I forgot about it.  This is more or less how I'd try to fix it:

Thanks for handling this. Your fix looks OK regarding the bug and the unini=
tialized var, but I do not have enough background on oFono and SIM file man=
agement to tell you if everything will works. You should submit this patch =
and let Denis validate it.

Are you using PhoneSim to validate your fix? Or a modem?

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

--===============1589086802126121873==--

