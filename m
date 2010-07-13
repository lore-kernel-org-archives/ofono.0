Content-Type: multipart/mixed; boundary="===============1152061283953267747=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] Support phonesim proactive command notification
Date: Tue, 13 Jul 2010 09:56:42 -0500
Message-ID: <4C3C7EAA.5030002@gmail.com>
In-Reply-To: <1279017001-23915-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1152061283953267747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> +static void phonesim_tcmd_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_stk *stk =3D user_data;
> +	struct stk_data *data =3D ofono_stk_get_data(stk);
> +	GAtResultIter iter;
> +	int length;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "*TCMD:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &length))
> +		return;
> +
> +	at_sim_fetch_command(data->chat, stk, length);
> +}
> +

drivers/atmodem/stk.c: In function =E2=80=98phonesim_tcmd_notify=E2=80=99:
drivers/atmodem/stk.c:282: error: passing argument 1 of
=E2=80=98at_sim_fetch_command=E2=80=99 from incompatible pointer type
drivers/atmodem/stk.c:92: note: expected =E2=80=98struct ofono_stk *=E2=80=
=99 but
argument is of type =E2=80=98struct GAtChat *=E2=80=99
drivers/atmodem/stk.c:282: error: passing argument 2 of
=E2=80=98at_sim_fetch_command=E2=80=99 makes integer from pointer without a=
 cast
drivers/atmodem/stk.c:92: note: expected =E2=80=98int=E2=80=99 but argument=
 is of type
=E2=80=98struct ofono_stk *=E2=80=99
drivers/atmodem/stk.c:282: error: too many arguments to function
=E2=80=98at_sim_fetch_command=E2=80=99

I fixed this up for you since it was trivial, however please at least
compile-check your patches ;)

Regards,
-Denis

--===============1152061283953267747==--

