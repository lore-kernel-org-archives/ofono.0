Content-Type: multipart/mixed; boundary="===============1412900417690909510=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [gisi-notify-fix PATCH 2/4] gisi: simplify handling of pending
Date: Tue, 18 Jan 2011 22:54:44 +0200
Message-ID: <AANLkTinbdMDzXFO_vUh-ycE+ttabHRGwEhyVNcsmbCEE@mail.gmail.com>
In-Reply-To: <AANLkTim9SW4=yLM3v_hzo9oMLZ1Yh6fvFq6b9-u7r4xq@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1412900417690909510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2011/1/18 Aki Niemi <aki@protocolpolice.com>:
>> -void g_isi_pending_remove(GIsiPending *operation);
>> +void g_isi_pending_own(GIsiPending *op, gpointer owner);
>> +void g_isi_remove_all_my_pending(GIsiModem *modem, uint8_t resource,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpointer own=
er);
>
> Overall, I like the idea.
>
> But how about naming these a bit better? Something like
> g_isi_pending_set_owner() and g_isi_pending_remove_by_owner()?

Sounds better. I'll do that, and I think I also leave the
g_isi_pending_remove() as an added bonus. Just in case.

-- =

Pekka.Pessi mail at nokia.com

--===============1412900417690909510==--

