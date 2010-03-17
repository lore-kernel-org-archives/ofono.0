Content-Type: multipart/mixed; boundary="===============0797263481284536147=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/8][RFC] STATUS,
 FETCH and TERMINAL RESPONSE for AT driver.
Date: Wed, 17 Mar 2010 14:56:27 -0600
Message-ID: <201003171556.27681.denkenz@gmail.com>
In-Reply-To: <1268688112-4026-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0797263481284536147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Fix ENVELOPE implementation.
> @@ -753,7 +794,7 @@ static void at_sim_envelope(struct ofono_sim *sim, int
>  length, ofono_sim_read_cb_t cb, void *data)
>  {
>  	struct sim_data *sd =3D ofono_sim_get_data(sim);
> -	struct cb_data *cbd =3D cb_data_new(cb, data);
> +	struct sim_cb_data *cbd =3D sim_cb_data_new(sd, cb, data);
>  	char *buf =3D g_try_new(char, 64 + length * 2);
>  	int len, ret;
> =

> @@ -761,12 +802,14 @@ static void at_sim_envelope(struct ofono_sim *sim,
>  int length, goto error;
> =

>  	len =3D sprintf(buf, "AT+CSIM=3D%i,A0C20000%02hhX",
> -			10 + length * 2, length);
> +			12 + length * 2, length);
> =

>  	for (; length; length--)
>  		len +=3D sprintf(buf + len, "%02hhX", *command++);
> =

> -	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
> +	len +=3D sprintf(buf + len, "FF");
> +
> +	ret =3D g_at_chat_send(sd->chat, buf, csim_prefix,
>  				at_csim_envelope_cb, cbd, g_free);

I really need more detailed explanation why appending FF here is necessary.=
  =

And this really belongs in a separate patch.

> =

>  	g_free(buf);
> @@ -785,6 +828,219 @@ error:
>  	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
>  }
> =

> =


Regards,
-Denis

--===============0797263481284536147==--

