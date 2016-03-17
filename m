Content-Type: multipart/mixed; boundary="===============2664578095206154535=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 06/11] ubloxmodem: add Toby L2 gprs context driver
Date: Thu, 17 Mar 2016 09:26:42 -0500
Message-ID: <56EABEA2.5010001@gmail.com>
In-Reply-To: <56EA87F5.3090107@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2664578095206154535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

 >>
>> Since this is a two line function, it would be easier to read the code i=
f it is moved into cgact_enable_cb
>>
>> In fact, just sending CGCONTRDP inside cgact_enable_cb would be the simp=
lest.
>
> The next patches will need this as a standalone function. Another line fo=
r reading the router mode ip config will be introduced. And the function wi=
ll be called from 3 places:
> * directly in pri_context_activate (this patch)
> * after authentication command (authentication support patch)
> * from read_settings function (automatic context activation patch)
>

Okay, go ahead with your proposal.

<snip>

>>> +    gcd->cb =3D cb;
>>> +    gcd->cb_data =3D data;
>>> +    memcpy(gcd->apn, ctx->apn, sizeof(ctx->apn));
>>
>> Why do we memcpy the APN into this structure?  If you don't want to make=
 this function too long, then just pass the apn as a parameter to ublox_act=
ivate_ctx.
>>
> The APN will be required by another patch that sends authentication comma=
nd and then sends CGDCONT.
>

Okay, but then logically it should be part of that patch :)

We prefer that data structure members are added on as needed basis.  So =

it becomes much easier to understand what is used how when reviewing =

large patch sets.

This is also useful in e.g. git blame and git show when reviewing what =

was done previously and for what reason.

Regards,
-Denis

--===============2664578095206154535==--

