Content-Type: multipart/mixed; boundary="===============6847574801321889213=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix gprs provisioning for some SIM (non-USIM) cards
Date: Wed, 16 Oct 2013 17:35:53 -0500
Message-ID: <525F14C9.3020709@gmail.com>
In-Reply-To: <CACM4vuAAmckEbnFWe_S47fsbmJ0iDsvhkvovkVyZZT066KS41A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6847574801321889213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

 >> The MNC can only be one value and that value can even change =

depending on whether you're
>> operating the same SIM in a 2G device or 3G device. So trying length 3 w=
hen in reality it is 2
>> can and most likely will get you into trouble.
>
> I do not think this can happen. For a given MCC, the length of the MNC
> is always the same, or at least that is the recommendation of the ITU.
>

The MNC in the IMSI remains the same, but the network operator MNC can =

change.  For example, T-Mobile used to report its 2G network MCC/MNC as =

310 26 even though its MNC is 260.  Then there are countries that run =

mixed 2 and 3 length MNCs...

Regardless, my main point here is that without properly coded EFad data =

we cannot reliably tell what MNC length to use.

>> I might be convinced to default to MNC length 2 in that case
>>
>
>   I do not think this is a good idea. Taking a look the ITU database,
> countries like USA, Canada, or Colombia have MNC length =3D=3D 3.
>

I said I might be convinced.  If the phase is set and the EFad length is =

3.  The SIMs from NA operators tend to omit EFad completely or populate =

it properly.  Still, the safest approach is that we should not report =

the MNC if the SIM doesn't tell us explicitly.

> As the relationship between MCC and MNC is deterministic, when we know
> the MCC we can directly find out the MNC length. I agree in that
> trying first length 2, then 3 is not very elegant. But if we do not do
> that I see two possible solutions:

It really isn't that clear cut.  For example, check out MCC 405.

>
> 1.- Store a table statically or in a file with the correspondence
> between MCC and MNC length. I foresee maintenance problems with this
> approach.
>
> 2.- Add a function in the provision driver so we can ask for the MNC
> length for a given MCC, which would be invoked when MNC length is not
> found in EFad. The implementation would search in the provisioning DB:
> it could return the length of the first MNC found for that MCC (it
> must be the same for all networks for that MCC).
>
> Opinions on this?

I think you're trying to solve a problem that doesn't need to be solved. =

  Its 2013, I've not seen 2G sims available for ages now.  3G sims =

mandate EFad data to be properly populated.  I really fail to see the =

point, especially breaking the core to do so.

Fallback to manual user provisioning and give the user a list to choose =

from.

Regards,
-Denis


--===============6847574801321889213==--

