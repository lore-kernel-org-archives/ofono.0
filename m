Content-Type: multipart/mixed; boundary="===============2695404353919370649=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Fri, 07 Jan 2011 15:01:31 -0600
Message-ID: <4D277F2B.8070102@gmail.com>
In-Reply-To: <129600E5E5FB004392DDC3FB599660D70106E1003E@irsmsx504.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2695404353919370649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

>>> The collision can only occur if the +CGDCONT (or +CGDSCONT) command  fr=
om Ofono is sent at the same time as PDP >>context activation URC from the =
modem, and both use the same CID.
>>>
>>> But in that case, the modem should not reply "OK" to the PDP context co=
nfiguration command, but "ERROR".
>>> And Ofono should not consider that the PDP configuration command as suc=
cessful.
>>> Moreover, the "OK" for the context configuration and the context activa=
tion URC are sent of the same control
>>> channel so they cannot be sent in parallel but only in sequence.
>>>
>>> Sjur, is that a correct assumption?
>>
>> Yes, this sounds about right.
>> But I think Denis' proposal for using ofono_gprs_set_cid_range(gprs,
>> <min>, <max>) pretty much solves this issue,
>> We can use this to reserve the CID used for Initial PDN, and void this
>> race condition.
> I have to admit that I'm not yet fully comfortable with the solution prop=
osed by Denis. =

> At least as long as we want to keep a on 1:1 mapping between the Ofono CI=
D and the AT CID.
> If I have understood correctly, the Ofono Core is "chosing" a CID =

> and the modem plugin is trying to use the same CID on the AT interface. =

> The way to resolve the race condition as proposed by Denis is to "reserve=
" a range of CIDs
>  for the modem and another range for ofono.
> =

> My concern is that I don't know if this will work for all the modem imple=
mentations.
> My understanding is that an AT+CGDCONT=3D? should return you the list of =
supported CID =

> and not the list of CID that the user/Ofono can use. =


It is up to the driver to set the ranges appropriately based upon its
much more intimate knowledge of the modem firmware.  The drivers that do
not support LTE / network activated contexts can ignore this magic.

> =

> Considering that from a modem standpoint the CID race condition can be re=
solved, =

> some modem implementation may not have reserved a range of CID for their =
own purpose,
> or may not provide a mechanism to reserve a range of CID.
> =


If the CGDCONT race is guaranteed to be solved by the modem
manufacturers, great.  Unfortunately that is not the only race present.
 Hint: The gatchat implementation uses non-blocking IO, select and a
command queue.  So it is fully possible for oFono to reserve a CID, send
out a driver activation request, but receive a network initiated context
activation / default bearer activation before the CGDCONT was even sent.

Having cid ranges that do not overlap seems the safest approach to me
right now.  Unless someone has a better idea...

Regards,
-Denis

--===============2695404353919370649==--

