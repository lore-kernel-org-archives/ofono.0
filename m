Content-Type: multipart/mixed; boundary="===============4123280171208117514=="
MIME-Version: 1.0
From: Alexander A Khryukin <alexander@mezon.ru>
Subject: Re: huawei e1550
Date: Wed, 13 Oct 2010 16:42:28 +0400
Message-ID: <1286973748.10204.5.camel@mezon.ru>
In-Reply-To: <8739sae1c4.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4123280171208117514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

=D0=92 =D0=A1=D1=80=D0=B4, 13/10/2010 =D0=B2 15:14 +0300, Kalle Valo =D0=BF=
=D0=B8=D1=88=D0=B5=D1=82:
> Alexander A Khryukin <alexander@mezon.ru> writes:
> =

> >> Sorry, I wasn't able to immeadiately say from the logs what went wrong.
> >> Can you get a log which includes AT commands? It would help a lot.
> >> =

> >> Just run this command to get the logs:
> >> =

> >> OFONO_AT_DEBUG=3D1 /usr/sbin/ofonod -n
> >> =

> >> What's the exact version of ofono you are using? Huawei has had some
> >> changes lately. =

> >> =

> >> Also is the SIM configured to ask for PIN or not? I'm guessing no from
> >> the log, but can't be sure.
> >
> > Ok.I connect modem to usb-port, and log it
> >
> > OFONO_AT_DEBUG=3D1 /usr/sbin/ofonod -n
> =

> Sorry, I forgot -d switch from the command which enables the debug
> messages. So it should be like this:
> =

> OFONO_AT_DEBUG=3D1 /usr/sbin/ofonod -n -d
> =

> > http://pastie.org/1212535
> =

> I didn't immeadiately find anything wrong in the AT logs. So basically
> your modem disappers from the bus and then comes back. Can a firmware
> crash cause that?
> =

> The last commands were:
> =

> ofonod[838]: PCUI: > AT+CSCB=3D1\r
> ofonod[838]: PCUI: < \r\nOK\r\n
> ofonod[838]: PCUI: > AT+CSCB=3D0,"4096,4097,4098,4099,4100,4101,4102,4103=
,4104,4105,4106,4107,4108,4109,4110,4111,4352-4356"\r
> =

> Can you try the patch below? Maybe it gives us some hint what's
> happening.
> =

> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index b20d83c..13ef192 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -624,8 +624,6 @@ static void huawei_post_online(struct ofono_modem *mo=
dem)
>                                                                 data->pcu=
i);
>  =

>         ofono_sms_create(modem, OFONO_VENDOR_HUAWEI, "atmodem", data->pcu=
i);
> -       ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
> -                                               "atmodem", data->pcui);
>         ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
>                                                 "atmodem", data->pcui);
> =


# patch -p1 < ofono.patch =


patching file plugins/huawei.c
Hunk #1 FAILED@624.
1 out of 1 hunk FAILED -- saving rejects to file plugins/huawei.c.rej

im using
http://www.kernel.org/pub/linux/network/ofono/ofono-0.31.tar.bz2



--===============4123280171208117514==--

