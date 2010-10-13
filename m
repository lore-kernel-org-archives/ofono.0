Content-Type: multipart/mixed; boundary="===============5214463161833002474=="
MIME-Version: 1.0
From: Alexander A Khryukin <alexander@mezon.ru>
Subject: Re: huawei e1550
Date: Wed, 13 Oct 2010 17:57:04 +0400
Message-ID: <1286978224.10204.39.camel@mezon.ru>
In-Reply-To: <87tykqcl1w.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5214463161833002474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

=D0=92 =D0=A1=D1=80=D0=B4, 13/10/2010 =D0=B2 15:51 +0300, Kalle Valo =D0=BF=
=D0=B8=D1=88=D0=B5=D1=82:
> Alexander A Khryukin <alexander@mezon.ru> writes:
> =

> > # patch -p1 < ofono.patch =

> >
> > patching file plugins/huawei.c
> > Hunk #1 FAILED at 624.
> > 1 out of 1 hunk FAILED -- saving rejects to file plugins/huawei.c.rej
> >
> > im using
> > http://www.kernel.org/pub/linux/network/ofono/ofono-0.31.tar.bz2
> =

> My patch was against latest git. But I copy pasted the patch, maybe that
> was the reason it failed. Here's a new one, this time against 0.31.
> =

> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index 12abdc6..3372454 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -617,8 +617,6 @@ static void huawei_post_online(struct ofono_modem *mo=
dem)
>  								data->pcui);
>  =

>  	ofono_sms_create(modem, OFONO_VENDOR_HUAWEI, "atmodem", data->pcui);
> -	ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
> -						"atmodem", data->pcui);
>  	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
>  						"atmodem", data->pcui);
>  =

> =



Ok.It was compiled.
Let's go.

Start ofono.Nice.
http://pastie.org/1218096

Then i plug my huawei e1550 =


Bus 002 Device 007: ID 12d1:1001 Huawei Technologies Co., Ltd. E620 USB
Modem

And log it:


http://pastie.org/1218122


# /usr/lib/ofono/test/list-modems =

[ /huawei0 ]
    Interfaces =3D =

    Powered =3D 0
    Features =3D =

    Online =3D 0

#/usr/lib/ofono/test/enable-modem
Connecting modem /huawei0..

http://pastie.org/1218123


#/usr/lib/ofono/test/list-modems  =


[ /huawei0 ]
    Features =3D sim =

    Powered =3D 1
    Interfaces =3D org.ofono.Phonebook org.ofono.AudioSettings
org.ofono.VoiceCallManager org.ofono.SimManager =

    Online =3D 0
    Model =3D E1550
    Manufacturer =3D huawei
    Serial =3D 353142033084081
    Revision =3D 11.608.12.00.143
    [ org.ofono.Phonebook ]
    [ org.ofono.AudioSettings ]
        Active =3D 0
    [ org.ofono.VoiceCallManager ]
        EmergencyNumbers =3D 112 911 000 08 110 999 118 119 =

    [ org.ofono.SimManager ]
        SubscriberNumbers =3D =

        PreferredLanguages =3D en =


Looks normally.


#/usr/lib/ofono/test/enable-modem =


Connecting modem /huawei0...


# /usr/lib/ofono/test/online-modem =


http://pastie.org/1218129



/usr/lib/ofono/test/enable-gprs =

Connecting modem /huawei0..

http://pastie.org/1218136


And then it in loopback :(
add_modem
remove_modem
and again






--===============5214463161833002474==--

