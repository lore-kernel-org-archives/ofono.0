Content-Type: multipart/mixed; boundary="===============7129556664100376695=="
MIME-Version: 1.0
From: Joly, Frederic <frederic.joly@intel.com>
Subject: RE: [RFC PATCH] gprs: add function to handle activated context
Date: Fri, 07 Jan 2011 17:52:26 +0000
Message-ID: <129600E5E5FB004392DDC3FB599660D70106E1003E@irsmsx504.ger.corp.intel.com>
In-Reply-To: <AANLkTimj=RQA1W1FsmcLceRN4ZvsFURqo2AyH02=bwdy@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7129556664100376695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

>-----Original Message-----
>From: Sjur Br=C3=A6ndeland [mailto:sjurbren(a)gmail.com] =

>Sent: Friday, January 07, 2011 4:39 PM
>To: ofono(a)ofono.org; Joly, Frederic
>Subject: Re: [RFC PATCH] gprs: add function to handle activated context
>
>Hi Fred,
>
>Frederic wrote:
>>The collision can only occur if the +CGDCONT (or +CGDSCONT) command =C2=
=A0from Ofono is sent at the same time as PDP >>context activation URC from=
 the modem, and both use the same CID.
>>
>> But in that case, the modem should not reply "OK" to the PDP context con=
figuration command, but "ERROR".
>> And Ofono should not consider that the PDP configuration command as succ=
essful.
>> Moreover, the "OK" for the context configuration and the context activat=
ion URC are sent of the same control
>> channel so they cannot be sent in parallel but only in sequence.
>>
>> Sjur, is that a correct assumption?
>
>Yes, this sounds about right.
>But I think Denis' proposal for using ofono_gprs_set_cid_range(gprs,
> <min>, <max>) pretty much solves this issue,
> We can use this to reserve the CID used for Initial PDN, and void this
> race condition.
I have to admit that I'm not yet fully comfortable with the solution propos=
ed by Denis. =

At least as long as we want to keep a on 1:1 mapping between the Ofono CID =
and the AT CID.
If I have understood correctly, the Ofono Core is "chosing" a CID =

and the modem plugin is trying to use the same CID on the AT interface. =

The way to resolve the race condition as proposed by Denis is to "reserve" =
a range of CIDs
 for the modem and another range for ofono.

My concern is that I don't know if this will work for all the modem impleme=
ntations.
My understanding is that an AT+CGDCONT=3D? should return you the list of su=
pported CID =

and not the list of CID that the user/Ofono can use. =


Considering that from a modem standpoint the CID race condition can be reso=
lved, =

some modem implementation may not have reserved a range of CID for their ow=
n purpose,
or may not provide a mechanism to reserve a range of CID.

Maybe members of the list could comment on this?

Thanks,

Fred =

 =

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

--===============7129556664100376695==--

