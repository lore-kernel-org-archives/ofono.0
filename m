Content-Type: multipart/mixed; boundary="===============6793762215412210069=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/11] stkutil: Add SMS-PP Data Download envelope builder
Date: Thu, 03 Jun 2010 11:53:49 +0200
Message-ID: <AANLkTinJEYXi-lWywNEcwo8xufnysHxJEGQL1e4hgeDU@mail.gmail.com>
In-Reply-To: <201006011850.19709.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6793762215412210069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 2 June 2010 01:50, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Andrew,
>
>> Note that the sms_tpdu member could be of type struct sms_deliver, but t=
he
>> users may more often have access to the raw tpdu so there's no point
>> decoding and reencoding it.
>
> Overall patch looks fine, but using a raw pdu is not preferable. =C2=A0Co=
uple of
> reasons:
>
> - When SMS is delivered, it is delivered in tpdu form, e.g. sc_address +
> deliver pdu. =C2=A0To obtain the sc_address, we need to decode the delive=
r tpdu
> anyway.
> - Before we know this is an SMS-PP download, we must check the dcs / pid.=
 =C2=A0In
> order to check those, we must again decode the tpdu.
> - SMS sc_address can actually be non-numeric. =C2=A0In that case the SMS-=
PP
> download should simply be dropped.

This means we have to decode the PDU, but re-encoding it is still an
overhead having access to the TPDU.

> - Consistency with Send SMS proactive command.

Ok, makes sense.

>
>> +
>> +/* Returns TRUE on success */
>> +ofono_bool_t stk_pdu_from_envelope(const struct stk_envelope *envelope,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char *pdu,=
 unsigned int size,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char **out=
_pdu,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int *out_s=
ize);
>>
>
> This part just looks ugly. =C2=A0Can't we hide the details of char buf[51=
2]
> somewhere inside stk_pdu_from_envelope?

By that do you mean using a static buffer?  I'll send a patch for
that.  I prefer a static buffer for the PDUs but thought you had
argued against it :)

Regards

--===============6793762215412210069==--

