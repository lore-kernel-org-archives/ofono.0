Content-Type: multipart/mixed; boundary="===============9054636509470478522=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH] mbmmodem: don't let chat open after fd is sent
Date: Thu, 03 Mar 2011 14:49:52 -0300
Message-ID: <AANLkTinT54+-0eAyjgfeWrzaBQsgEzVJeC8B8i=qAipW@mail.gmail.com>
In-Reply-To: <1299172911.2519.68.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9054636509470478522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 3, 2011 at 2:21 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Lucas,
>
>> =C2=A0struct gps_data {
>> =C2=A0 =C2=A0 =C2=A0 GAtChat *chat;
>> - =C2=A0 =C2=A0 GAtChat *data_chat;
>> +
>> + =C2=A0 =C2=A0 struct {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIOChannel *channel;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 guint idle_source;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gsize written;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_location_reporting_ena=
ble_cb_t cb;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *cb_data;
>> + =C2=A0 =C2=A0 } stream;
>> =C2=A0};
>
> why do you bother with the struct in struct here?

Just to group these related fields.


regards,
Lucas De Marchi

--===============9054636509470478522==--

