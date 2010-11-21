Content-Type: multipart/mixed; boundary="===============7800575153845524253=="
MIME-Version: 1.0
From: George Matveev <george@matveev.se>
Subject: Re: [PATCH v2 2/2] stemodem: Use RTNL to create network interfaces.
Date: Sun, 21 Nov 2010 23:20:48 +0100
Message-ID: <d34704fde1df023d47b287f4dad2a528.squirrel@squirrel-webmail.surftown.com>
In-Reply-To: <1290372915-7911-2-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7800575153845524253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

it looks as if two functions:

caif_if_create/remove (struct conn_info *conn)

do nothing but verify the return results of functions:

caif_rtnl_create_interface/caif_rtnl_delete_interface

declared in in  caif_rtnl.h

Which means if you #include caif_rtnl.h in gprs-context.c
create/delete_interface will be available directly without any wrappers
and could make your code run a bit faster and easier to understand?
Unless I missed something.

Regards,
George

> From: Sjur Br=C3=83=C2=A6ndeland <sjur.brandeland@stericsson.com>
>
> ---
>  drivers/stemodem/gprs-context.c |   43
> ++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 42 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/stemodem/gprs-context.c
> b/drivers/stemodem/gprs-context.c
> index 3ccda87..3859107 100644
> --- a/drivers/stemodem/gprs-context.c
> +++ b/drivers/stemodem/gprs-context.c
> @@ -47,6 +47,7 @@
>  #include "stemodem.h"
>  #include "caif_socket.h"
>  #include "if_caif.h"
> +#include "caif_rtnl.h"
>
>  #define MAX_CAIF_DEVICES 4
>  #define MAX_DNS 2
> @@ -172,12 +173,38 @@ static struct conn_info *conn_info_create(unsigned
> int channel_id)
>  	return connection;
>  }
>
> +static void rtnl_callback(int ifindex, const char *ifname, void
> *user_data)
> +{
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
> +}
> +
>  /*
>   * Creates a new IP interface for CAIF.
>   */
>  static gboolean caif_if_create(struct conn_info *conn)
>  {
> -	return FALSE;
> +	int err;
> +
> +	err =3D caif_rtnl_create_interface(IFLA_CAIF_IPV4_CONNID,
> +						conn->channel_id, FALSE,
> +						rtnl_callback, conn);
> +	if (err < 0) {
> +		DBG("Failed to create IP interface for CAIF");
> +		return FALSE;
> +	}
> +
> +	return TRUE;
>  }
>
>  /*
> @@ -185,6 +212,18 @@ static gboolean caif_if_create(struct conn_info
> *conn)
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
>  }
>
>  static void ste_eppsd_down_cb(gboolean ok, GAtResult *result,
> @@ -571,10 +610,12 @@ static struct ofono_gprs_context_driver driver =3D {
>
>  void ste_gprs_context_init()
>  {
> +	caif_rtnl_init();
>  	ofono_gprs_context_driver_register(&driver);
>  }
>
>  void ste_gprs_context_exit()
>  {
> +	caif_rtnl_exit();
>  	ofono_gprs_context_driver_unregister(&driver);
>  }
> --
> 1.7.0.4
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>



--===============7800575153845524253==--

