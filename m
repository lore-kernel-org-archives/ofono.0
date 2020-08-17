Content-Type: multipart/mixed; boundary="===============0574906423759630294=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [RFC PATCH 4/4] plugins: gemalto: fix incomplete at-chat shutdown
Date: Mon, 17 Aug 2020 19:56:46 +0300
Message-ID: <20200817165646.GA4449@curiosity>
In-Reply-To: <20200815214358.69100-5-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0574906423759630294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Function gemalto_modem_ready attempts to restart AT chat data->app
> after  incomplete shutdown. As a result, new AT chat does not work
> as expected loosing AT commands.
> =

> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---
>  plugins/gemalto.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> =

> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
> index 238c7cc4..321c8c1b 100644
> --- a/plugins/gemalto.c
> +++ b/plugins/gemalto.c

...

> @@ -451,6 +455,8 @@ static void gemalto_modem_ready(GAtResult *result, gp=
ointer user_data)
>  	data->modem_ready_id =3D 0;
>  	data->trial_cmd_id =3D 0;
>  =

> +	g_at_chat_cancel_all(data->app);
> +	g_at_chat_unregister_all(data->app);
>  	g_at_chat_unref(data->app);
>  =

>  	data->app =3D open_device(app);

Please disregard this patch in the series. This change does not resolve
the root cause. It looks like when gemalto_modem_ready is called on
^SYSSTART, occasionally modem is not ready to process AT commands.
As a result, the upcoming gemalto_initialize function fails due to
timed out AT commands.

It turns out that the approach implemented in ublox plugin (repeated
probe AT command) provides more reliable results, in particular
in power-off tests. I will do more testing and update this patch
in the next revision of the patch set.

Regards,
Sergey
--===============0574906423759630294==--

