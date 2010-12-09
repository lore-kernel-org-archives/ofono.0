Content-Type: multipart/mixed; boundary="===============1626034176405191439=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RESEND PATCHv2 2/2] stemodem: Use RTNL to create network
 interfaces.
Date: Fri, 10 Dec 2010 00:01:37 +0100
Message-ID: <1291935697.30085.15.camel@aeonflux.mpl.access-company.com>
In-Reply-To: <1291142345-2389-2-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1626034176405191439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-cont=
ext.c
> index bfc0d65..21ca126 100644
> --- a/drivers/stemodem/gprs-context.c
> +++ b/drivers/stemodem/gprs-context.c
> @@ -47,6 +47,7 @@
>  #include "stemodem.h"
>  #include "caif_socket.h"
>  #include "if_caif.h"
> +#include "caif_rtnl.h"
>  =

>  #define MAX_CAIF_DEVICES 4
>  #define MAX_DNS 2
> @@ -172,12 +173,20 @@ static struct conn_info *conn_info_create(unsigned =
int channel_id)
>  	return connection;
>  }
>  =

> -/*
> - * Creates a new IP interface for CAIF.
> - */
> -static gboolean caif_if_create(struct conn_info *conn)
> +static void rtnl_callback(int ifindex, const char *ifname, void *user_da=
ta)
>  {
> -	return FALSE;
> +	struct conn_info *conn =3D user_data;
> +
> +	if (ifindex < 0) {
> +		conn->created =3D FALSE;
> +		ofono_error("Failed to create caif interface %s",
> +			conn->interface);
> +		return;
> +	}
> +
> +	strncpy(conn->interface, ifname, sizeof(conn->interface));
> +	conn->ifindex =3D ifindex;
> +	conn->created =3D TRUE;
>  }
>  =

>  /*
> @@ -185,6 +194,18 @@ static gboolean caif_if_create(struct conn_info *con=
n)
>   */
>  static void caif_if_remove(struct conn_info *conn)
>  {
> +	if (!conn->created)
> +		return;
> +
> +	if (caif_rtnl_delete_interface(conn->ifindex) < 0) {
> +		ofono_error("Failed to delete caif interface %s",
> +			conn->interface);
> +		return;
> +	}
> +
> +	DBG("removed CAIF interface ch:%d ifname:%s ifindex:%d\n",
> +		conn->channel_id, conn->interface, conn->ifindex);
> +	return;

You don't need return here. Please remove that.
>  }
>  =

>  static void ste_eppsd_down_cb(gboolean ok, GAtResult *result,
> @@ -526,7 +547,7 @@ static int ste_gprs_context_probe(struct ofono_gprs_c=
ontext *gc,
>  	GAtChat *chat =3D data;
>  	struct gprs_context_data *gcd;
>  	struct conn_info *ci;
> -	int i;
> +	int i,err;

Extra whitespace between i and err.

>  =

>  	gcd =3D g_new0(struct gprs_context_data, 1);
>  	gcd->chat =3D g_at_chat_clone(chat);
> @@ -539,7 +560,14 @@ static int ste_gprs_context_probe(struct ofono_gprs_=
context *gc,
>  		ci =3D conn_info_create(i+1);
>  		if (!ci)
>  			return -ENOMEM;
> -		caif_if_create(ci);
> +		err =3D caif_rtnl_create_interface(IFLA_CAIF_IPV4_CONNID,
> +						ci->channel_id, FALSE,
> +						rtnl_callback, ci);
> +		if (err < 0) {
> +			DBG("Failed to create IP interface for CAIF");
> +			return err;
> +		}
> +
>  		g_caif_devices =3D g_slist_append(g_caif_devices, ci);
>  	}
>  =

> @@ -571,10 +599,12 @@ static struct ofono_gprs_context_driver driver =3D {
>  =

>  void ste_gprs_context_init()
>  {
> +	caif_rtnl_init();
>  	ofono_gprs_context_driver_register(&driver);
>  }
>  =

>  void ste_gprs_context_exit()
>  {
> +	caif_rtnl_exit();
>  	ofono_gprs_context_driver_unregister(&driver);
>  }

Are you sure you want rtnl_exit before removing the driver?

Regards

Marcel



--===============1626034176405191439==--

