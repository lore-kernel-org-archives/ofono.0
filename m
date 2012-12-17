Content-Type: multipart/mixed; boundary="===============5724938601876664903=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] telit: set baud rate to 115200
Date: Mon, 17 Dec 2012 09:32:01 -0600
Message-ID: <50CF3AF1.2060003@gmail.com>
In-Reply-To: <1355739357-24794-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5724938601876664903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 12/17/2012 04:15 AM, Christopher Vogl wrote:
> Telit HE910 needs the baud rate to be set.
> ---
>   plugins/telit.c |    9 ++++++++-
>   1 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/plugins/telit.c b/plugins/telit.c
> index fe2ccd6..64f763a 100644
> --- a/plugins/telit.c
> +++ b/plugins/telit.c
> @@ -186,6 +186,7 @@ static GAtChat *open_device(struct ofono_modem *modem,
>   	GAtSyntax *syntax;
>   	GIOChannel *channel;
>   	GAtChat *chat;
> +	GHashTable *options;
>
>   	device =3D ofono_modem_get_string(modem, key);
>   	if (device =3D=3D NULL)
> @@ -193,7 +194,13 @@ static GAtChat *open_device(struct ofono_modem *mode=
m,
>
>   	DBG("%s %s", key, device);
>
> -	channel =3D g_at_tty_open(device, NULL);
> +	options =3D g_hash_table_new(g_str_hash, g_str_equal);
> +	if (options =3D=3D NULL)
> +		return NULL;
> +
> +	g_hash_table_insert(options, "Baud", "115200");
> +
> +	channel =3D g_at_tty_open(device, options);

Are you leaking the hash table object here?

>   	if (channel =3D=3D NULL)
>   		return NULL;
>

Regards,
-Denis

--===============5724938601876664903==--

