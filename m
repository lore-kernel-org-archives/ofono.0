Content-Type: multipart/mixed; boundary="===============4158907909235817881=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] hfp: Don't call UnregisterAgent if a Release was
 received
Date: Thu, 04 Feb 2010 16:00:10 -0600
Message-ID: <201002041600.10433.denkenz@gmail.com>
In-Reply-To: <1265319021-28299-2-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4158907909235817881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> Prevent to call UnregisterAgent on an already unregistered agent.
> ---
>  plugins/hfp.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/hfp.c b/plugins/hfp.c
> index cd43af7..4202ddf 100644
> --- a/plugins/hfp.c
> +++ b/plugins/hfp.c
> @@ -760,8 +760,11 @@ static int hfp_probe(struct ofono_modem *modem)
>  static void hfp_remove(struct ofono_modem *modem)
>  {
>  	struct hfp_data *data =3D ofono_modem_get_data(modem);
> +	const char *obj_path =3D ofono_modem_get_path(modem);
> =

> -	hfp_unregister_ofono_handsfree(modem);
> +	if (g_dbus_unregister_interface(connection, obj_path,
> +					HFP_AGENT_INTERFACE))
> +		hfp_unregister_ofono_handsfree(modem);
> =

>  	g_hash_table_remove(uuid_hash, data->handsfree_path);
> =

> @@ -804,10 +807,14 @@ static int hfp_disconnect_ofono_handsfree(struct
>  ofono_modem *modem)
> =

>  static int hfp_disable(struct ofono_modem *modem)
>  {
> +	const char *obj_path =3D ofono_modem_get_path(modem);
> +
>  	DBG("%p", modem);
> =

>  	clear_data(modem);
> =

> +	g_dbus_unregister_interface(connection, obj_path, HFP_AGENT_INTERFACE);
> +

Shouldn't this part be in agent_release?

>  	hfp_disconnect_ofono_handsfree(modem);
>  	return 0;
>  }
> =


Regards,
-Denis

--===============4158907909235817881==--

