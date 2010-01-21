Content-Type: multipart/mixed; boundary="===============3425475928696450857=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH 2/2] Implement HandsfreeGateway Interface
Date: Thu, 21 Jan 2010 19:25:19 -0200
Message-ID: <fbf08281001211325g33b2828cve6dcd9201d83f558@mail.gmail.com>
In-Reply-To: <2a9506371001211320r6dc7958h5b0040cec6f79e4b@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3425475928696450857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2010 at 7:20 PM, Vinicius Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Gustavo,
>
> On Thu, Jan 21, 2010 at 5:31 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
>> + =C2=A0 =C2=A0 =C2=A0 gw->sco =3D chan;
>> + =C2=A0 =C2=A0 =C2=A0 g_io_channel_ref(chan);
>> +
>
> You must have forgotten to change this.
>
>> @@ -307,17 +565,15 @@ struct gateway *gateway_init(struct audio_device *=
dev)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct gateway *gw;
>>
>> + =C2=A0 =C2=A0 =C2=A0 gw =3D g_new0(struct gateway, 1);
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!g_dbus_register_interface(dev->conn, dev=
->path,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AUDIO_=
GATEWAY_INTERFACE,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gatewa=
y_methods, gateway_signals,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, =
dev, NULL))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
>>
>
> Seems like gw is leaking if registration fails. Move it down a little, pe=
rhaps?

Sounds good.  Thanks. :)

>
>> - =C2=A0 =C2=A0 =C2=A0 debug("in gateway_init, dev is %p", dev);
>> - =C2=A0 =C2=A0 =C2=A0 gw =3D g_new0(struct gateway, 1);
>> - =C2=A0 =C2=A0 =C2=A0 gw->state =3D GATEWAY_STATE_DISCONNECTED;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return gw;
>> -
>> =C2=A0}
>>
>
>
> Cheers,
> --
> Vinicius Gomes
> INdT - Instituto Nokia de Tecnologia
>



-- =

Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi

--===============3425475928696450857==--

