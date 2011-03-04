Content-Type: multipart/mixed; boundary="===============6659879635927389737=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Fix huawei_disconnect function issue
Date: Fri, 04 Mar 2011 03:04:16 -0800
Message-ID: <1299236656.32127.2.camel@aeonflux>
In-Reply-To: <1299224643-19026-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6659879635927389737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

> huawei_disconnect is used to recovery the io and gprs context when
> io error happends, see commit 39382730d7758b093ca6271f4e9dea875fa04b3a
> However, io error not only happends at PPP disconnect, in theory it
> can happends at any situation. I also observed that it happens when modem
> go into offline mode at my Huawei EM770W modem. in this case, gprs should
> not be reopened.

<snip>

>  static void huawei_set_online(struct ofono_modem *modem, ofono_bool_t on=
line,
> @@ -595,21 +611,26 @@ static void huawei_set_online(struct ofono_modem *m=
odem, ofono_bool_t online,
>  {
>  	struct huawei_data *data =3D ofono_modem_get_data(modem);
>  	GAtChat *chat =3D data->pcui;
> -	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +	struct huawei_cb_data *online_cbd;
>  	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D5";
>  =

>  	DBG("modem %p %s", modem, online ? "online" : "offline");
>  =

> -	if (cbd =3D=3D NULL)
> +	online_cbd =3D g_try_new0(struct huawei_cb_data, 1);
> +	online_cbd->cbd =3D cb_data_new(cb, user_data);
> +	if (online_cbd->cbd =3D=3D NULL)
>  		goto error;

you know that you are doing exactly the wrong NULL pointer checks
here ;)

Anyhow, we need to get rid of the if (cbd =3D=3D NULL) check first. A while
back we changed cb_data_new() to use g_new0() instead of g_try_new0() to
simplify the code. So first that should be all cleaned up.

A quick grep showed these locations for the AT modems:

drivers/mbmmodem/location-reporting.c:  if (cbd =3D=3D NULL)
plugins/bluetooth.c:    if (cbd =3D=3D NULL) {
plugins/huawei.c:       if (cbd =3D=3D NULL)

The ISI modem stuff is a different story and needs to be tackled
separately anyway.

Regards

Marcel



--===============6659879635927389737==--

