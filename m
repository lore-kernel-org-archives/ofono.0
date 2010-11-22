Content-Type: multipart/mixed; boundary="===============4366886536280823539=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [isi-voicecall-fix PATCHv3 2/6] isi/voicecall: fix status
 reporting
Date: Mon, 22 Nov 2010 18:09:12 +0200
Message-ID: <AANLkTin3+7yTxJq8WPELPBV=oLhe-m2nizrbkXN=AABp@mail.gmail.com>
In-Reply-To: <4CEA7ACA.8070703@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4366886536280823539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> +enum clcc_status {
>> + =C2=A0 =C2=A0 CLCC_STATUS_ACTIVE =3D 0,
>> + =C2=A0 =C2=A0 CLCC_STATUS_HOLD =3D 1,
>> + =C2=A0 =C2=A0 CLCC_STATUS_DIALING =3D 2,
>> + =C2=A0 =C2=A0 CLCC_STATUS_ALERTING =3D 3,
>> + =C2=A0 =C2=A0 CLCC_STATUS_INCOMING =3D 4,
>> + =C2=A0 =C2=A0 CLCC_STATUS_WAITING =3D 5,
>> + =C2=A0 =C2=A0 CLCC_STATUS_DISCONNECTED =3D 6, /* Nonstandard */
>> +};
>
> Please follow M11 completely here, particularly the tabs before the value=
s.

You mean M11 preference? If you want something, be explicit, do not prefer.

I laud your goal to improve the coding style within oFono - and it
even might be best to do that step-by-step and avoid large patches
just to fix the style - but I'm lazy typist and I usually just kill
and yank pieces of code, like this one from from "src/common.h" patch
a78b3629, authored by some Denis Kenzior.

The current codebase contains a lot of code in outdated style and
copy'n'paste coding just does not cut it, it would be ++good to have a
custom checkpatch that would show the style problems without tedious
and error-prone manual inspection. I'd do that myself but my perl-fu
is bit rusty.

>> + =C2=A0 =C2=A0 memcpy(number->number, call->address, sizeof number->num=
ber);
>
> Please watch out for the sizeof usage.

This needs an entry in doc/codingstyle.txt.

>> + =C2=A0 =C2=A0 case CALL_STATUS_IDLE:
>> + =C2=A0 =C2=A0 case CALL_STATUS_TERMINATED:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isi_call_disconnected(ovc, c=
all);
>
> Is the break statement missing here?

Hm? Where? Between IDLE and TERMINATED?

-- =

Pekka.Pessi mail at nokia.com

--===============4366886536280823539==--

