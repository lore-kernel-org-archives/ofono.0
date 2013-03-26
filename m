Content-Type: multipart/mixed; boundary="===============1467453938444235949=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add GPRS, mux,
 volume control support in SIMCOM sim900 modem module
Date: Tue, 26 Mar 2013 10:54:19 -0500
Message-ID: <5151C4AB.2060009@gmail.com>
In-Reply-To: <1363099078-13416-1-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1467453938444235949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Renat,

On 03/12/2013 09:37 AM, r.r.zaripov(a)gmail.com wrote:
> From: Renat Zaripov<r.r.zaripov@gmail.com>
>
> ---
>   plugins/sim900.c |  201 ++++++++++++++++++++++++++++++++++++++++++++++-=
-------
>   1 file changed, 171 insertions(+), 30 deletions(-)
>

I applied this patch, however here are a few comments:

> @@ -119,10 +132,32 @@ static GAtChat *open_device(struct ofono_modem *mod=
em,
>   	if (channel =3D=3D NULL)
>   		return NULL;
>
> +	data->device =3D channel;
>   	syntax =3D g_at_syntax_new_gsm_permissive();
>   	chat =3D g_at_chat_new(channel, syntax);
>   	g_at_syntax_unref(syntax);
>
> +	if (chat =3D=3D NULL)
> +		return NULL;

In this case you are not destroying the data->device object.  This is a =

potential memory leak.  I fixed this for you in commit =

b4518caa50f03b40e9f9434dc17558665bb8ee3f

> +
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(chat, sim900_debug, debug);
> +
> +	return chat;
> +}
> +

<snip>

> @@ -134,6 +169,96 @@ static GAtChat *open_device(struct ofono_modem *mode=
m,
>   	return chat;
>   }
>
> +static void shutdown_device(struct sim900_data *data)
> +{
> +	int i, fd;

make --no-print-directory all-am
   CC     plugins/sim900.o
cc1: warnings being treated as errors
plugins/sim900.c: In function =E2=80=98shutdown_device=E2=80=99:
plugins/sim900.c:180:9: error: unused variable =E2=80=98fd=E2=80=99
make[1]: *** [plugins/sim900.o] Error 1
make: *** [all] Error 2

Please 'make distcheck' before submitting patches.

> +
> +	DBG("");
> +
> +	for (i =3D 0; i<  NUM_DLC; i++) {
> +		if (data->dlcs[i] =3D=3D NULL)
> +			continue;
> +
> +		g_at_chat_unref(data->dlcs[i]);
> +		data->dlcs[i] =3D NULL;
> +	}
> +
> +	if (data->mux) {
> +		g_at_mux_shutdown(data->mux);
> +		g_at_mux_unref(data->mux);
> +		data->mux =3D NULL;
> +		goto done;

This goto seems redundant.  I got rid of this for you in commit =

548611e93948902ccffaf5568dcd31bef1d4f764.

> +	}
> +
> +done:
> +	g_io_channel_unref(data->device);
> +	data->device =3D NULL;
> +}
> +

<snip>

>   static void cfun_disable(gboolean ok, GAtResult *result, gpointer user_=
data)
>   {
>   	struct ofono_modem *modem =3D user_data;
> @@ -181,8 +307,11 @@ static void cfun_disable(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>
>   	DBG("");
>
> -	g_at_chat_unref(data->modem);
> -	data->modem =3D NULL;
> +	g_at_mux_shutdown(data->mux);
> +	g_at_mux_unref(data->mux);
> +
> +	g_at_chat_unref(data->dlcs[SETUP_DLC]);
> +	data->dlcs[SETUP_DLC] =3D NULL;
>
>   	if (ok)
>   		ofono_modem_set_powered(modem, FALSE);


> @@ -194,12 +323,11 @@ static int sim900_disable(struct ofono_modem *modem)
>
>   	DBG("%p", modem);
>
> -	g_at_chat_cancel_all(data->modem);
> -	g_at_chat_unregister_all(data->modem);
> -
> -	g_at_chat_send(data->modem, "AT+CFUN=3D4", none_prefix,
> +	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CFUN=3D4", none_prefix,
>   					cfun_disable, modem, NULL);
>
> +	shutdown_device(data);
> +

Calling shutdown_device here is premature.  I bet that you're never =

actually sending the CFUN=3D4 with this setup because you close the tty =

before that happens.  I fixed this in commit =

93ac1669a069a1bcce1ed121ca60977db53abf4e.  If you disagree, please let =

me know.

>   	return -EINPROGRESS;
>   }
>

Regards,
-Denis

--===============1467453938444235949==--

