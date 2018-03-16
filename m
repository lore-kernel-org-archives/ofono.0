Content-Type: multipart/mixed; boundary="===============6726950606593996705=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/6] gemalto: support ALS3 in gemalto's plugin
Date: Fri, 16 Mar 2018 09:23:19 -0500
Message-ID: <dfdb1740-fa49-61ac-627b-2fe6ba0d3659@gmail.com>
In-Reply-To: <8218aab0-70f1-a997-ebd7-3bcea51676ad@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6726950606593996705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

>>> =C2=A0 { >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gemalto_data *data =
=3D ofono_modem_get_data(modem);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *app, *mdm;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>>> +=C2=A0=C2=A0=C2=A0 /* Close devices */
>>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->mdm);
>>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->app);
>>> +
>>
>> Why would you close both devices?=C2=A0 It is unnecessary, especially in =

>> the case that the modem is already up and responding to commands.
> Because it seems that opening the device while it is not ready leads the =

> driver to a weird state.
> When the modem becomes ready, I am not able to send any AT command to =

> the APP device.
> Here is the output:
> =

> ofonod[12826]: src/modem.c:get_modem_property() modem 0x72b750 property =

> Application
> ofonod[12826]: src/modem.c:get_modem_property() modem 0x72b750 property =

> Modem
> ofonod[12826]: plugins/gemalto.c:open_device() Opening device /dev/ttyACM1
> ofonod[12826]: plugins/gemalto.c:open_device() Opening device /dev/ttyACM0
> ofonod[12826]: plugins/gemalto.c:gemalto_modem_ready()
> ofonod[12826]: plugins/gemalto.c:gemalto_initialize()
> ofonod[12826]: src/modem.c:get_modem_property() modem 0x72b750 property =

> Application
> ofonod[12826]: src/modem.c:get_modem_property() modem 0x72b750 property =

> Modem
> ofonod[12826]: plugins/gemalto.c:gemalto_hardware_monitor_enable()
> ofonod[12826]: Mdm> ATE0\r
> ofonod[12826]: Mdm< ATE0\r\r\nOK\r\n
> ofonod[12826]: Mdm> AT&C0\r
> ofonod[12826]: Mdm< \r\n+CME ERROR: operation not supported\r\n
> ofonod[12826]: src/modem.c:set_powered_timeout() modem: 0x72b750
> =

> When it is re-opened, it works fine.

So my question was two fold:

1. Why would you open both devices?  Wouldn't opening just one to figure =

out whether the modem is 'ready' or not be enough?
2. If the modem is ready, why would you close the opened device?  That =

just seems to be a waste of time.

If the device isn't ready then I could see how re-opening the port might =

be required.

>>> +
>>> +=C2=A0=C2=A0=C2=A0 if(!strncmp(model, GEMALTO_MODEL_ALS3, 4)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_lte_create(modem, "at=
modem", data->app);
>>> +=C2=A0=C2=A0=C2=A0 }
>>
>> Why strncmp?=C2=A0 No need for {} and there should be a space between if =

>> and '('
> Because strncmp is more secured than strcmp. But if you prefer strcmp or =

> anything else, I'll change it.

In this case they're the same and its not like you have user input to =

worry about here...

Regards,
-Denis

--===============6726950606593996705==--

