Content-Type: multipart/mixed; boundary="===============4065418427065905152=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 16/18] isimodem: sms updated with wgmodem2.5
Date: Thu, 17 Feb 2011 12:30:04 +0200
Message-ID: <AANLkTinUpj_z4tvAVGnTjKERL-_rJ1h28XB3NUKUd85y@mail.gmail.com>
In-Reply-To: <4D5BE385.9030906@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4065418427065905152==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

2011/2/16 Andreas WESTIN <andreas.westin@stericsson.com>:
>> This UICC stuff seems to be leftovers form patch 8/18.
>
> Well they are related to SMS, debug prints. But yes they are also UICC. Do
> you want them in patch 8 ?

That would be my preference. That is, a patch to bring in the PN_UICC
codepoints and debugs, then separate patches for implementations using
those new codepoints.

> PN_SIM client is created in the UICC client verify callback if it fails, =
do
> we not get a response to that callback even if UICC fails ?

Ah, right.

Cheers,
Aki

--===============4065418427065905152==--

