Content-Type: multipart/mixed; boundary="===============0852297629564478353=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] hfp_hf: retrieve AG version
Date: Fri, 05 Aug 2011 17:13:10 -0500
Message-ID: <4E3C6AF6.3060906@gmail.com>
In-Reply-To: <1312462544-21581-3-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0852297629564478353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 08/04/2011 07:55 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> ---
>  plugins/hfp_hf.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> =

> diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
> index 5625141..cf2bb42 100644
> --- a/plugins/hfp_hf.c
> +++ b/plugins/hfp_hf.c
> @@ -163,9 +163,12 @@ static DBusMessage *hfp_agent_new_connection(DBusCon=
nection *conn,
>  	struct hfp_data *hfp_data =3D ofono_modem_get_data(modem);
>  =

>  	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UNIX_FD, &fd,
> +				DBUS_TYPE_UINT16, &hfp_data->info.ag_version,

I don't like doing it this way, hfp_slc_info_init implies that it
initializes the entire structure.  Perhaps passing the version into
hfp_slc_info_init would be better.

Also, I don't know if we want to be a little 'nice' and allow the second
argument to be omitted.  For those that might still be running against
an older version of BlueZ (and then retire this in a version or two of
oFono)  However, since there are not many users of hfp client right now
I'm not particularly picky here.

>  				DBUS_TYPE_INVALID))
>  		return __ofono_error_invalid_args(msg);
>  =

> +	hfp_slc_info_init(&hfp_data->info);
> +
>  	err =3D service_level_connection(modem, fd);
>  	if (err < 0 && err !=3D -EINPROGRESS)
>  		return __ofono_error_failed(msg);
> @@ -192,7 +195,7 @@ static DBusMessage *hfp_agent_release(DBusConnection =
*conn,
>  }
>  =

>  static GDBusMethodTable agent_methods[] =3D {
> -	{ "NewConnection", "h", "", hfp_agent_new_connection,
> +	{ "NewConnection", "hq", "", hfp_agent_new_connection,
>  		G_DBUS_METHOD_FLAG_ASYNC },
>  	{ "Release", "", "", hfp_agent_release },
>  	{ NULL, NULL, NULL, NULL }
> @@ -223,8 +226,6 @@ static int hfp_hf_probe(const char *device, const cha=
r *dev_addr,
>  	if (data =3D=3D NULL)
>  		goto free;
>  =

> -	hfp_slc_info_init(&data->info);
> -
>  	data->handsfree_path =3D g_strdup(device);
>  	if (data->handsfree_path =3D=3D NULL)
>  		goto free;

The rest looks good to me.

Regards,
-Denis

--===============0852297629564478353==--

