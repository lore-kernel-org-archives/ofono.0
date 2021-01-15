Content-Type: multipart/mixed; boundary="===============5811424095510828080=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] sim: validate IMS private identity
Date: Fri, 15 Jan 2021 14:10:23 -0600
Message-ID: <091b23a6-70aa-64c0-d968-8c0de2ab7846@gmail.com>
In-Reply-To: <20210115195635.26791-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5811424095510828080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On 1/15/21 1:56 PM, Sergey Matyukevich wrote:
> Make sure that IMS private identity is a valid UTF8 string before
> setting sim->impi field. Otherwise ofono may crash on dbus assert
> when SIM properties are reported via org.ofono.SimManager interface.
> ---
>   src/sim.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index 33e1245f..2a663e2d 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -1664,7 +1664,8 @@ static void impi_read_cb(int ok, int total_length, =
int record,
>   		return;
>   	}
>   =

> -	sim->impi =3D g_strndup((const char *)data + 2, data[1]);
> +	if (g_utf8_validate((const char *)data + 2, data[1], NULL))
> +		sim->impi =3D g_strndup((const char *)data + 2, data[1]);

I assume this code path was tested with a file containing embedded NULs as =
that =

is the only way it would have worked.

glib docs [1] say:
"Note that g_utf8_validate() returns FALSE if max_len is positive and any o=
f the =

max_len bytes are nul."

So I think the above logic would flag such a file as invalid, no?

>   }
>   =

>   static void discover_apps_cb(const struct ofono_error *error,
> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org
> =


Regards,
-Denis

[1] =

https://developer.gnome.org/glib/stable/glib-Unicode-Manipulation.html#g-ut=
f8-validate
--===============5811424095510828080==--

