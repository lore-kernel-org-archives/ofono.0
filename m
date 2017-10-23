Content-Type: multipart/mixed; boundary="===============3977494709360260331=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCHv2] simauth: fixup adding more dbus return checks
Date: Mon, 23 Oct 2017 20:55:34 +0300
Message-ID: <5d4db6a9-8042-aed6-e83b-e0a2af1c1a30@jolla.com>
In-Reply-To: <1508169980-12627-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3977494709360260331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 16/10/17 19:06, James Prestwood wrote:
> ---
>   src/sim-auth.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/src/sim-auth.c b/src/sim-auth.c
> index b9552b5..9ae5574 100644
> --- a/src/sim-auth.c
> +++ b/src/sim-auth.c
> @@ -427,6 +427,7 @@ static DBusMessage *usim_gsm_authenticate(DBusConnect=
ion *conn,
>   	DBusMessageIter array;
>   	int i;
>   	struct sim_app_record *app;
> +	int rands;
>   =

>   	if (sim->pending)
>   		return __ofono_error_busy(msg);
> @@ -436,11 +437,16 @@ static DBusMessage *usim_gsm_authenticate(DBusConne=
ction *conn,
>   	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_ARRAY)
>   		return __ofono_error_invalid_format(msg);
>   =

> +	rands =3D dbus_message_iter_get_element_count(&iter);


It appears that dbus_message_iter_get_element_count() requires dbus =

1.9.16 or later, would it be possible to avoid it?

Thanks,
-Slava

--===============3977494709360260331==--

