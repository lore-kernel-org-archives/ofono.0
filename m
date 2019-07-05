Content-Type: multipart/mixed; boundary="===============4343154639250358242=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 07/10] quectel: replace glib uses with ell
Date: Fri, 05 Jul 2019 17:27:22 -0500
Message-ID: <13967c73-d755-da9f-4175-388637bde53c@gmail.com>
In-Reply-To: <20190703180955.18246-8-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4343154639250358242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 07/03/2019 01:09 PM, Martin Hundeb=C3=B8ll wrote:
> ---
>   plugins/quectel.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> =

> diff --git a/plugins/quectel.c b/plugins/quectel.c
> index 83197991..3c6b9d9f 100644
> --- a/plugins/quectel.c
> +++ b/plugins/quectel.c
> @@ -27,7 +27,7 @@
>   #include <stdlib.h>
>   #include <stdbool.h>
>   =

> -#include <glib.h>
> +#include <ell/ell.h>
>   #include <gatchat.h>
>   #include <gattty.h>
>   =

> @@ -68,9 +68,7 @@ static int quectel_probe(struct ofono_modem *modem)
>   =

>   	DBG("%p", modem);
>   =

> -	data =3D g_try_new0(struct quectel_data, 1);
> -	if (data =3D=3D NULL)
> -		return -ENOMEM;
> +	data =3D l_new(struct quectel_data, 1);
>   =

>   	ofono_modem_set_data(modem, data);
>   =

> @@ -89,7 +87,7 @@ static void quectel_remove(struct ofono_modem *modem)
>   	ofono_modem_set_data(modem, NULL);
>   	g_at_chat_unref(data->aux);
>   	g_at_chat_unref(data->modem);
> -	g_free(data);
> +	l_free(data);
>   }
>   =

>   static void cpin_notify(GAtResult *result, void *user_data)
> @@ -281,7 +279,7 @@ static void quectel_set_online(struct ofono_modem *mo=
dem, int online,
>   =

>   	CALLBACK_WITH_FAILURE(cb, cbd->data);
>   =

> -	g_free(cbd);
> +	l_free(cbd);

While this is pretty much fine in the end since everything just maps to =

free, cb_data_new uses g_new0, so we should keep g_free until that is =

converted.

>   }
>   =

>   static void quectel_pre_sim(struct ofono_modem *modem)
> =


Regards,
-Denis

--===============4343154639250358242==--

