Content-Type: multipart/mixed; boundary="===============2362509277467714238=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: Re: [PATCH 2/6] gemalto: support ALS3 in gemalto's plugin
Date: Fri, 16 Mar 2018 11:30:25 +0100
Message-ID: <8218aab0-70f1-a997-ebd7-3bcea51676ad@smile.fr>
In-Reply-To: <ede1a470-9930-352a-be94-3501f298974b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2362509277467714238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 15/03/2018 18:11, Denis Kenzior wrote:
> No // please, use /* */.=C2=A0 This is C code ;)
Fixed. I've just learned it was not ANSI C :).
>
> You leak options here in case channel =3D=3D NULL.=C2=A0 The typical patt=
ern is =

> to call g_hash_table_destroy(options) right after g_at_tty_open.=C2=A0 Se=
e =

> other plugins for details.
Fixed
>
>> =C2=A0 @@ -118,6 +138,7 @@ static GAtChat *open_device(const char *devic=
e)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chat =3D g_at_chat_new(channel, syntax);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_syntax_unref(syntax);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_io_channel_unref(channel);
>> +=C2=A0=C2=A0=C2=A0 g_hash_table_destroy(options);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (chat =3D=3D NULL)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> @@ -300,29 +321,33 @@ static int =

>> gemalto_hardware_monitor_enable(struct ofono_modem *modem)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 -static int gemalto_enable(struct ofono_modem *modem)
>> +static void gemalto_initialize(struct ofono_modem *modem)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gemalto_data *data =3D ofono_modem=
_get_data(modem);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *app, *mdm;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 DBG("%p", modem);
>> +=C2=A0=C2=A0=C2=A0 /* Close devices */
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->mdm);
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->app);
>> +
>
> Why would you close both devices?=C2=A0 It is unnecessary, especially in =

> the case that the modem is already up and responding to commands.
Because it seems that opening the device while it is not ready leads the =

driver to a weird state.
When the modem becomes ready, I am not able to send any AT command to =

the APP device.
Here is the output:

ofonod[12826]: src/modem.c:get_modem_property() modem 0x72b750 property =

Application
ofonod[12826]: src/modem.c:get_modem_property() modem 0x72b750 property =

Modem
ofonod[12826]: plugins/gemalto.c:open_device() Opening device /dev/ttyACM1
ofonod[12826]: plugins/gemalto.c:open_device() Opening device /dev/ttyACM0
ofonod[12826]: plugins/gemalto.c:gemalto_modem_ready()
ofonod[12826]: plugins/gemalto.c:gemalto_initialize()
ofonod[12826]: src/modem.c:get_modem_property() modem 0x72b750 property =

Application
ofonod[12826]: src/modem.c:get_modem_property() modem 0x72b750 property =

Modem
ofonod[12826]: plugins/gemalto.c:gemalto_hardware_monitor_enable()
ofonod[12826]: Mdm> ATE0\r
ofonod[12826]: Mdm< ATE0\r\r\nOK\r\n
ofonod[12826]: Mdm> AT&C0\r
ofonod[12826]: Mdm< \r\n+CME ERROR: operation not supported\r\n
ofonod[12826]: src/modem.c:set_powered_timeout() modem: 0x72b750

When it is re-opened, it works fine.
>
>> +=C2=A0=C2=A0=C2=A0 DBG("");
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 app =3D ofono_modem_get_string(mod=
em, "Application");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mdm =3D ofono_modem_get_string(modem, "Mo=
dem");
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (app =3D=3D NULL || mdm =3D=3D =
NULL)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Open devices */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->app =3D open_device(app);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->app =3D=3D NULL)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->mdm =3D open_device(mdm);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->mdm =3D=3D NULL) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_chat_unref(d=
ata->app);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->app =3D NUL=
L;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (getenv("OFONO_AT_DEBUG")) {
>> @@ -340,6 +365,67 @@ static int gemalto_enable(struct ofono_modem =

>> *modem)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 cfun_enable, modem, NULL);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gemalto_hardware_monitor_enable(mo=
dem);
>> +}
>> +
>> +static void gemalto_modem_ready(GAtResult *result, gpointer user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct ofono_modem *modem =3D user_data;
>> +=C2=A0=C2=A0=C2=A0 struct gemalto_data *data =3D ofono_modem_get_data(m=
odem);
>> +
>> +=C2=A0=C2=A0=C2=A0 DBG("");
>> +
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unregister(data->app, data->modem_ready_id=
);
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_cancel(data->app, data->trial_cmd_id);
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
>> +}
>> +
>> +static gboolean gemalto_at_timeout(gpointer user_data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct ofono_modem *modem =3D user_data;
>> +=C2=A0=C2=A0=C2=A0 struct gemalto_data *data =3D ofono_modem_get_data(m=
odem);
>> +
>> +=C2=A0=C2=A0=C2=A0 data->trial_cmd_id =3D g_at_chat_send(data->app, "AT=
+CFUN?", =

>> none_prefix, gemalto_at_cb, modem, NULL);
>
> What does this do?
Some gemalto's modems have their USB devices mounted before they are =

ready to handle AT command.
At modem's or oFono's startup, the modem is either ready or not. In =

gemalto_enable, we register to the "^SYSSTART" URC and send the "AT" =

command.
- If the AT command returns, then the modem is ready so we unregister =

the "^SYSSTART" URC and start initializing the modem.
- If the modem isn't ready, the AT command will never return so we have =

to wait for the "^SYSSTART" URC. When it is received, we cancel the AT
command because it will never get any answer and start initializing the =

modem.

I've no cleaner way to do that.
>
>> +
>> +=C2=A0=C2=A0=C2=A0 return FALSE;
>> +}
>
> Where is the timeout started?
Seems like I forgot to clean some parts of the code ;). There is no timeout.
>
> We use the Linux Kernel coding style with house rules documented in =

> doc/coding-style.txt.=C2=A0 No lines over 80 characters please.
Fixed
>
> Why do you open both ports only to close them in gemalto_initialize? =

> One port here would be sufficient.
You are right, I've changed the code such that it opens only app, then =

try the modem on it and reopen it
only if the modem wasn't ready.
>
> You might as well perform this assignment at variable declaration.
Fixed
>> +
>> +=C2=A0=C2=A0=C2=A0 if(!strncmp(model, GEMALTO_MODEL_ALS3, 4)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_lte_create(modem, "atm=
odem", data->app);
>> +=C2=A0=C2=A0=C2=A0 }
>
> Why strncmp?=C2=A0 No need for {} and there should be a space between if =

> and '('
Because strncmp is more secured than strcmp. But if you prefer strcmp or =

anything else, I'll change it.
>
> Also, you most likely need the LTE atom in post_sim.
>
> You also now have to little arguments to ofono_lte_create.=C2=A0 Please g=
it =

> pull --rebase first.
Fixed

I'm waiting for your answers before reposting the reviewed patch.
Thanks for the patch review.

Best Regards,
Gabriel

--===============2362509277467714238==--

