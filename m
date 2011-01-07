Content-Type: multipart/mixed; boundary="===============8415911171840452930=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Fri, 07 Jan 2011 16:38:59 +0100
Message-ID: <AANLkTimj=RQA1W1FsmcLceRN4ZvsFURqo2AyH02=bwdy@mail.gmail.com>
In-Reply-To: <129600E5E5FB004392DDC3FB599660D70106E0FF83@irsmsx504.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8415911171840452930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

Frederic wrote:
> The collision can only occur if the +CGDCONT (or +CGDSCONT) command =C2=
=A0from Ofono is sent at the same time as PDP context activation URC from t=
he modem, and both use the same CID.
>
> But in that case, the modem should not reply "OK" to the PDP context conf=
iguration command, but "ERROR".
> And Ofono should not consider that the PDP configuration command as succe=
ssful.
> Moreover, the "OK" for the context configuration and the context activati=
on URC are sent of the same control channel so they cannot be sent in paral=
lel but only in sequence.
>
> Sjur, is that a correct assumption?

Yes, this sounds about right.
But I think Denis' proposal for using ofono_gprs_set_cid_range(gprs,
<min>, <max>) pretty much solves this issue,
We can use this to reserve the CID used for Initial PDN, and void this
race condition.

Regards,
Sjur

--===============8415911171840452930==--

