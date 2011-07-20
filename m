Content-Type: multipart/mixed; boundary="===============3609787896954465366=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH] CDMA ConnMan API: add username and password for PPP
 authentication.
Date: Wed, 20 Jul 2011 16:57:59 +0100
Message-ID: <568DE01DA537804BA73470071BAC288938F0620D@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1311167871.21109.247.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3609787896954465366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>fair enough. That is enough for me to confirm that it is used in real
>networks. We do not like to add APIs for something that is not used
>anymore only because some specification or RFC says so ;)

I agree.

>Patch has been applied now. However I changed the commit prefix back to
>doc: to make it look cleaner.

Thanks.

>For you two TTY cases. That is normal. Huawei treats the first TTY as
>modem to issue PPP on it. And the second one (PCUI) is used for
>notifications. So yes, oFono needs to open both. You will need the
>second one for network registration updates.

But I think that if you send ATD on a channel, you should receive the CONNE=
CT in the same channel. It's an answer, not a notification.

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


--===============3609787896954465366==--

