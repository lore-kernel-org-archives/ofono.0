Content-Type: multipart/mixed; boundary="===============3297200961065690674=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [RFC PATCH 4/4] plugins: gemalto: fix incomplete at-chat shutdown
Date: Tue, 18 Aug 2020 11:06:56 +0200
Message-ID: <13183792-de6e-c20d-cfbb-e9d86a136153@geanix.com>
In-Reply-To: <48bb7b40-94b1-55a1-22f4-015a382f35ac@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3297200961065690674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and Sergey,

On 17/08/2020 21.54, Denis Kenzior wrote:
>> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
>> index 238c7cc4..321c8c1b 100644
>> --- a/plugins/gemalto.c
>> +++ b/plugins/gemalto.c
>> @@ -222,6 +222,8 @@ static void sim_state_cb(gboolean present, =

>> gpointer user_data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ofono_modem *modem =3D user_data;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gemalto_data *data =3D ofono_modem=
_get_data(modem);
>> +=C2=A0=C2=A0=C2=A0 DBG("");
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at_util_sim_state_query_free(data->sim_st=
ate_query);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->sim_state_query =3D NULL;
>> @@ -241,6 +243,8 @@ static void cfun_enable(gboolean ok, GAtResult =

>> *result, gpointer user_data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ofono_modem *modem =3D user_data;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gemalto_data *data =3D ofono_modem=
_get_data(modem);
>> +=C2=A0=C2=A0=C2=A0 DBG("");
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ok) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_chat_unref(d=
ata->app);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->app =3D NUL=
L;
>> @@ -451,6 +455,8 @@ static void gemalto_modem_ready(GAtResult *result, =

>> gpointer user_data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->modem_ready_id =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->trial_cmd_id =3D 0;
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_cancel_all(data->app);
>> +=C2=A0=C2=A0=C2=A0 g_at_chat_unregister_all(data->app);
> =

> These get called automatically on unref below, assuming=C2=A0 this is the =

> last (it should be) reference.
> =

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_chat_unref(data->app);
> =

> Instead of this dance of opening / closing the chat in order to =

> force-cancel the 'AT' command queued in gemalto_enable(), maybe there =

> should be something in GAtChat itself to handle this case.=C2=A0 Either a =

> 'force cancel the top of the queue because I know the modem is broken' =

> or maybe some form of 'send this on the port until it responds =

> properly'.=C2=A0 Alternatively, you could simply use GAtIO and a timer to =

> write stuff to the port until it responds and only create the chat at =

> that time.
> =

> There's already something a bit similar in the form of =

> g_at_chat_set_wakeup_command().=C2=A0 It was used on the old Neo Freerunn=
er =

> modem which would go to 'sleep' after several seconds of inactivity.=C2=
=A0 So =

> the subsequent AT command would get eaten.=C2=A0 You basically had to pok=
e it =

> with an empty command, have it timeout / return OK and then you could go =

> on with submitting AT commands again.=C2=A0 But I don't think it is a goo=
d =

> fit for this particular case.

There's also the retry logic used on quectel modems with auto-detection =

of baud rates:
https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/plugins/quectel=
.c#n1082

// Martin
--===============3297200961065690674==--

