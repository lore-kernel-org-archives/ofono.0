Content-Type: multipart/mixed; boundary="===============4260266733377653825=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 05/18] plugins: add plugin for u8500
Date: Thu, 17 Feb 2011 11:02:52 +0200
Message-ID: <AANLkTinULvgnP3ObsCuC3GN1AJGnZDoh7icc=9qBpnsf@mail.gmail.com>
In-Reply-To: <4D5BECED.6020705@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4260266733377653825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

2011/2/16 Andreas WESTIN <andreas.westin@stericsson.com>:
>>> + =C2=A0 =C2=A0 =C2=A0 if (!g_isi_modem_set_version(isimodem, modemvers=
ion))
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>>
>> I'm not going to add this API in GIsiModem. If we went this route, and
>> used vendor quirks inside the isimodem driver, then it would make a
>> whole lot more sense to do it in the driver create(), not here.
>>
>> But we're not going that route. Each driver detects the version of the
>> ISI service it is talking to when it is probed.
>>
>
> Yes this should not be there, but maybe I misunderstood you regarding the
> version handling. I was under the impression that we checked the version =
we
> get from doing PN_MTC or PN_MODEM_MCE ?

The modem driver is a bit of a special case again. There is no generic
isimodem modem driver, but each modem plugin implements their own
version. Here, just use PN_MODEM_MCE, since that is what the U8500
uses.

Cheers,
Aki

--===============4260266733377653825==--

