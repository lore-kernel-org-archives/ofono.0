Content-Type: multipart/mixed; boundary="===============7775749536247631574=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: Re: [PATCH 2/6] gemalto: support ALS3 in gemalto's plugin
Date: Mon, 19 Mar 2018 10:45:54 +0100
Message-ID: <04d0b76b-3c78-1ec7-9b20-f74c41713f36@smile.fr>
In-Reply-To: <b30564c9-8a92-4fa9-eb3c-a0f01597f12e@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7775749536247631574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


On 16/03/2018 17:08, Denis Kenzior wrote:
>> +
>> +static void gemalto_modem_ready(GAtResult *result, gpointer user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct ofono_modem *modem =3D user_data;
>> +=C2=A0=C2=A0=C2=A0 struct gemalto_data *data =3D ofono_modem_get_data(m=
odem);
>> +=C2=A0=C2=A0=C2=A0 const char *app =3D ofono_modem_get_string(modem, "A=
pplication");
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("");
>> +
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unregister(data->app, data->modem_ready_id=
);
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_cancel(data->app, data->trial_cmd_id);
>
> Since you're unrefing data->app below, this isn't really necessary.=C2=A0 =

> You might want to reset the ids to zero here though.
Done
>
>> +
>> +=C2=A0=C2=A0=C2=A0 /*!
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * As the modem wasn't ready to handle AT comma=
nds when we opened
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * it, we have to close and reopen the device a=
pp.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */ +=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->a=
pp);
>> +
>> +=C2=A0=C2=A0=C2=A0 if(app =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>
> Not our coding style.=C2=A0 Also, the "Application" property should not =

> disappear under you, so I would leave this check out.
Is it like this :
/* foo bar
 =C2=A0* bar
*/
or
/*
 =C2=A0* foo bar
 =C2=A0* bar
*/
?

I've removed the checking.
>
>> +
>> +=C2=A0=C2=A0=C2=A0 data->app =3D open_device(app);
>> +=C2=A0=C2=A0=C2=A0 if (data->app =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>
> You might want to tell the core that the enable operation failed. So =

> ofono_modem_set_powered(modem, FALSE);
Done
>
>> +
>> +=C2=A0=C2=A0=C2=A0 gemalto_initialize(modem);
>> +}
>> +
>> +static void gemalto_at_cb(gboolean ok, GAtResult *result, gpointer =

>> user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct ofono_modem *modem =3D user_data;
>> +=C2=A0=C2=A0=C2=A0 struct gemalto_data *data =3D ofono_modem_get_data(m=
odem);
>> +
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unregister(data->app, data->modem_ready_id=
);
>> +=C2=A0=C2=A0=C2=A0 gemalto_initialize(modem);
>
> Do you also want to reset modem_ready_id to 0 as well?=C2=A0 And trial_cm=
d_id
Done
>
>> +}
>> +
>> +static int gemalto_enable(struct ofono_modem *modem)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct gemalto_data *data =3D ofono_modem_get_data(m=
odem);
>> +=C2=A0=C2=A0=C2=A0 const char *app, *mdm;
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +
>> +=C2=A0=C2=A0=C2=A0 app =3D ofono_modem_get_string(modem, "Application");
>> +=C2=A0=C2=A0=C2=A0 mdm =3D ofono_modem_get_string(modem, "Modem");
Here, I've realized I'm getting the "Modem" property but I'm not
opening it. Should I still get it here such that I could check that it
isn't NULL ? Or do you prefer it to be handled in gemalto_initialize() ?
>> +
>> +=C2=A0=C2=A0=C2=A0 if (app =3D=3D NULL || mdm =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Open devices */
>> +=C2=A0=C2=A0=C2=A0 data->app =3D open_device(app);
>> +=C2=A0=C2=A0=C2=A0 if (data->app =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Try the AT command. If it doesn't work, wait for =
^SYSSTART */
>> +=C2=A0=C2=A0=C2=A0 data->modem_ready_id =3D g_at_chat_register(data->ap=
p, "^SYSSTART",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 gemalto_modem_ready, FALSE, modem, NULL);
>> +=C2=A0=C2=A0=C2=A0 data->trial_cmd_id =3D g_at_chat_send(data->app, "AT=
E0 AT",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 none_prefix, gemalto_at_cb, modem, NULL);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINPROGRESS;
>> =C2=A0 }
>> @@ -432,6 +510,7 @@ static void gemalto_post_sim(struct ofono_modem =

>> *modem)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gemalto_data *data =3D ofono_modem=
_get_data(modem);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ofono_gprs *gprs;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ofono_gprs_context *gc;
>> +=C2=A0=C2=A0=C2=A0 const char *model =3D ofono_modem_get_string(modem, =
"Model");
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> =C2=A0 @@ -444,6 +523,9 @@ static void gemalto_post_sim(struct ofono_mod=
em =

>> *modem)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gprs && gc)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_gprs_add_co=
ntext(gprs, gc);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!g_strcmp0(model, GEMALTO_MODEL_ALS3))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_lte_create(modem, OFON=
O_VENDOR_CINTERION, "atmodem", =

>> data->app);
>
> Over 80 characters here
Done
>
>> =C2=A0 }
>> =C2=A0 =C2=A0 static void gemalto_post_online(struct ofono_modem *modem)
>>
>
> Regards,
> -Denis
Best regards,
Gabriel

--===============7775749536247631574==--

