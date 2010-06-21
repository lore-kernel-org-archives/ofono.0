Content-Type: multipart/mixed; boundary="===============0607849144238604503=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 2/5] history: print SMS status
Date: Mon, 21 Jun 2010 18:35:30 -0500
Message-ID: <201006211835.31214.denkenz@gmail.com>
In-Reply-To: <1276780498-7573-3-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0607849144238604503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> ---
>  src/history.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> =

> diff --git a/src/history.c b/src/history.c
> index f868ca2..0eef130 100644
> --- a/src/history.c
> +++ b/src/history.c
> @@ -238,6 +238,8 @@ void __ofono_history_sms_send_status(struct ofono_mod=
em
>  *modem, enum ofono_history_sms_status status)
>  {
>  	struct history_sms_foreach_data hfd;
> +	struct tm  *ts;
> +	char buf[80];
> =

>  	hfd.msg_id =3D msg_id;
>  	hfd.address =3D NULL;
> @@ -245,6 +247,15 @@ void __ofono_history_sms_send_status(struct
>  ofono_modem *modem, hfd.when =3D when;
>  	hfd.status =3D status;
> =

> +	/* Format time, "ddd yyyy-mm-dd hh:mm:ss zzz" */
> +	ts =3D localtime(&when);
> +	strftime(buf, sizeof(buf), "%a %Y-%m-%d %H:%M:%S %Z", ts);
> +
> +	if (status =3D=3D OFONO_HISTORY_SMS_STATUS_DELIVERED)
> +		DBG("SMS delivered, msg_id: %i, time: %s", msg_id, buf);
> +	else if (status =3D=3D OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED)
> +		DBG("SMS undeliverable, msg_id: %i, time: %s", msg_id, buf);
> +

I didn't take this patch because these debugs really don't belong here.  =

Instead I put them in plugins/example_history.c.

Regards,
-Denis

--===============0607849144238604503==--

