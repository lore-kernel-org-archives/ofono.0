Content-Type: multipart/mixed; boundary="===============0456403506739171005=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 4/4] plugins: gemalto: fix incomplete at-chat shutdown
Date: Mon, 17 Aug 2020 14:54:34 -0500
Message-ID: <48bb7b40-94b1-55a1-22f4-015a382f35ac@gmail.com>
In-Reply-To: <20200815214358.69100-5-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0456403506739171005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On 8/15/20 4:43 PM, Sergey Matyukevich wrote:
> Function gemalto_modem_ready attempts to restart AT chat data->app
> after  incomplete shutdown. As a result, new AT chat does not work
> as expected loosing AT commands.
> =

> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---
>   plugins/gemalto.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Patch 2, 3 look good to me.

For this one, what is it trying to do actually?

> =

> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
> index 238c7cc4..321c8c1b 100644
> --- a/plugins/gemalto.c
> +++ b/plugins/gemalto.c
> @@ -222,6 +222,8 @@ static void sim_state_cb(gboolean present, gpointer u=
ser_data)
>   	struct ofono_modem *modem =3D user_data;
>   	struct gemalto_data *data =3D ofono_modem_get_data(modem);
>   =

> +	DBG("");
> +
>   	at_util_sim_state_query_free(data->sim_state_query);
>   	data->sim_state_query =3D NULL;
>   =

> @@ -241,6 +243,8 @@ static void cfun_enable(gboolean ok, GAtResult *resul=
t, gpointer user_data)
>   	struct ofono_modem *modem =3D user_data;
>   	struct gemalto_data *data =3D ofono_modem_get_data(modem);
>   =

> +	DBG("");
> +
>   	if (!ok) {
>   		g_at_chat_unref(data->app);
>   		data->app =3D NULL;
> @@ -451,6 +455,8 @@ static void gemalto_modem_ready(GAtResult *result, gp=
ointer user_data)
>   	data->modem_ready_id =3D 0;
>   	data->trial_cmd_id =3D 0;
>   =

> +	g_at_chat_cancel_all(data->app);
> +	g_at_chat_unregister_all(data->app);

These get called automatically on unref below, assuming  this is the last (=
it =

should be) reference.

>   	g_at_chat_unref(data->app);

Instead of this dance of opening / closing the chat in order to force-cance=
l the =

'AT' command queued in gemalto_enable(), maybe there should be something in =

GAtChat itself to handle this case.  Either a 'force cancel the top of the =
queue =

because I know the modem is broken' or maybe some form of 'send this on the=
 port =

until it responds properly'.  Alternatively, you could simply use GAtIO and=
 a =

timer to write stuff to the port until it responds and only create the chat=
 at =

that time.

There's already something a bit similar in the form of =

g_at_chat_set_wakeup_command().  It was used on the old Neo Freerunner mode=
m =

which would go to 'sleep' after several seconds of inactivity.  So the =

subsequent AT command would get eaten.  You basically had to poke it with a=
n =

empty command, have it timeout / return OK and then you could go on with =

submitting AT commands again.  But I don't think it is a good fit for this =

particular case.

>   =

>   	data->app =3D open_device(app);
> @@ -466,6 +472,8 @@ static void gemalto_at_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>   	struct ofono_modem *modem =3D user_data;
>   	struct gemalto_data *data =3D ofono_modem_get_data(modem);
>   =

> +	DBG("");
> +
>   	g_at_chat_unregister(data->app, data->modem_ready_id);
>   	data->modem_ready_id =3D 0;
>   =

> =


Regards,
-Denis
--===============0456403506739171005==--

