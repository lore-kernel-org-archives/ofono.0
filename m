Content-Type: multipart/mixed; boundary="===============8533254466465900657=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem/sim: added vendor Gemalto
Date: Mon, 24 Sep 2018 23:16:44 -0500
Message-ID: <a1ed5e09-2be3-1ad3-dfe4-3841afb58366@gmail.com>
In-Reply-To: <CAKSBH7HcXLwdrd73ACcQCVRvfdqJQmNmOheBH3oJuHBMjD7u+g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8533254466465900657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> It is not taken out. It is:
>  =C2=A0=C2=A0 =C2=A0 =C2=A0 case OFONO_VENDOR_CINTERION:
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0case OFONO_VENDOR_GEMALTO:
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (g_at_chat_sen=
d(sd->chat, "AT^SPIC", gemalto_spic_prefix,
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gemalt=
o_spic_cb, cbd, g_free) > 0)
> =

> both are there, and the functions are renamed, but still there.
> Or shall I duplicate the functions for the time being?
> =


Ok, I stand corrected, I assumed you removed OFONO_VENDOR_CINTERION from =

the sms driver.

But still, can we strive for self-contained change sets?  Just take out =

VENDOR_CINTERION use inside the sim driver and change over to =

VENDOR_GEMALTO for any modem drivers that need it.  That makes things =

much easier to follow compared to doing only the sim driver changes now =

and then flipping from one VENDOR to another at some later point.

Regards,
-Denis

--===============8533254466465900657==--

