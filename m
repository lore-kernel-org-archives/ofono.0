Content-Type: multipart/mixed; boundary="===============8138128049385597056=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/11] stkutil: Add SMS-PP Data Download envelope builder
Date: Mon, 07 Jun 2010 15:25:47 +0200
Message-ID: <AANLkTinl5yPOoPOjNlSZaT_ezsyinZlZYYR1MRvOJKAu@mail.gmail.com>
In-Reply-To: <201006031032.52536.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8138128049385597056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 3 June 2010 17:32, Denis Kenzior <denkenz@gmail.com> wrote:
>> > - When SMS is delivered, it is delivered in tpdu form, e.g. sc_address=
 +
>> > deliver pdu. =C2=A0To obtain the sc_address, we need to decode the del=
iver
>> > tpdu anyway.
>> > - Before we know this is an SMS-PP download, we must check the dcs / p=
id.
>> > =C2=A0In order to check those, we must again decode the tpdu.
>> > - SMS sc_address can actually be non-numeric. =C2=A0In that case the S=
MS-PP
>> > download should simply be dropped.
>>
>> This means we have to decode the PDU, but re-encoding it is still an
>> overhead having access to the TPDU.
>
> Fair enough, I don't really feel strongly either way. =C2=A0However, enco=
ding is
> quite fast and we have to re-encode the sc_address in a different format =
anyway
> because of the weird sc_addr encoding rules.

I'll send a new patch using struct sms_deliver (this way api enforces
the correct type of pdu is supplied).

>
>>
>> > - Consistency with Send SMS proactive command.
>>
>> Ok, makes sense.
>
> One thing that comes to mind is that we might have to modify sms_encode()=
 with
> the capability to skip encoding the sc_address field. =C2=A0Otherwise our=
 pdu will
> have some extra crap in the beginning.
>
>>
>> >> +
>> >> +/* Returns TRUE on success */
>> >> +ofono_bool_t stk_pdu_from_envelope(const struct stk_envelope *envelo=
pe,
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char *=
pdu, unsigned int
>> >> size, + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned=
 char **out_pdu,
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int *o=
ut_size);
>> >
>> > This part just looks ugly. =C2=A0Can't we hide the details of char buf=
[512]
>> > somewhere inside stk_pdu_from_envelope?
>>
>> By that do you mean using a static buffer? =C2=A0I'll send a patch for
>> that. =C2=A0I prefer a static buffer for the PDUs but thought you had
>> argued against it :)
>
> Don't recall :) =C2=A0I think in this case it is ok, or you can always ma=
ke the
> function re-entrant safe by making the buf argument in/out.
>
> e.g.
>
> char buf[512];
> char *out =3D buf;
>
> func(foo, bar, &out);

The nice thing about static buffer is the users don't have to worry
about how many bytes to reserve.  It would also allow dropping 90% of
the length checks which are then only defensive coding.

Regards,
Andrew

--===============8138128049385597056==--

