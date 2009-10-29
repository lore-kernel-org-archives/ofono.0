Content-Type: multipart/mixed; boundary="===============0986005098991525994=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Inserted the GSM syntax option in modem.conf.
Date: Thu, 29 Oct 2009 22:53:36 +0900
Message-ID: <1256824416.5768.39.camel@localhost.localdomain>
In-Reply-To: <1256814263-15298-1-git-send-email-ryan.raasch@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0986005098991525994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

> Since the modems need to be setup in particular ways, this patch
> allows for the GSM syntax to be specified by the configuration file.
> ---
>  plugins/atgen.c     |    9 ++++++++-
>  plugins/modemconf.c |    6 ++++++
>  2 files changed, 14 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/atgen.c b/plugins/atgen.c
> index db59e36..67a1e8c 100644
> --- a/plugins/atgen.c
> +++ b/plugins/atgen.c
> @@ -117,7 +117,14 @@ static int atgen_enable(struct ofono_modem *modem)
>  		return -EIO;
>  	}
>  =

> -	syntax =3D g_at_syntax_new_gsmv1();
> +	value =3D ofono_modem_get_string(modem, "GsmSyntax");
> +	if (value && g_str_equal(value, "GSM_V1"))
> +		syntax =3D g_at_syntax_new_gsmv1();
> +	else if (value && g_str_equal(value, "GSM_Permissive"))
> +		syntax =3D g_at_syntax_new_gsm_permissive();
> +	else if (value)
> +		return -EINVAL;
> +

first of all, stop checking value all the time. It is fine to have
nested ifs here. And second you duplicate GSM in the parameter name and
also in the value. So just call it V1 and Permissive.

>  	chat =3D g_at_chat_new(channel, syntax);
>  	g_at_syntax_unref(syntax);
>  	g_io_channel_unref(channel);
> diff --git a/plugins/modemconf.c b/plugins/modemconf.c
> index 6b317e6..a5e5824 100644
> --- a/plugins/modemconf.c
> +++ b/plugins/modemconf.c
> @@ -138,6 +138,12 @@ static int set_device(struct ofono_modem *modem,
>  	} else
>  		ofono_modem_set_string(modem, "Rtscts", "on");
>  =

> +	value =3D g_key_file_get_string(keyfile, group, "GsmSyntax", NULL);
> +	if (value) {
> +		ofono_modem_set_string(modem, "GsmSyntax", value);
> +		g_free(value);
> +	} else
> +		ofono_modem_set_string(modem, "GsmSyntax", "GSM_V1");
>  =


Did you check that this applies cleanly against latest GIT tree?

Regards

Marcel



--===============0986005098991525994==--

