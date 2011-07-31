Content-Type: multipart/mixed; boundary="===============1525413967495678596=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v4 6/6] cdmamodem: register for network status
 notification.
Date: Sun, 31 Jul 2011 05:34:53 -0500
Message-ID: <4E352FCD.70105@gmail.com>
In-Reply-To: <1312289122-22845-7-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1525413967495678596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 08/02/2011 07:45 AM, Bertrand Aygon wrote:
> ---
>  drivers/cdmamodem/network-registration.c |   75 ++++++++++++++++++++++++=
++++++
>  1 files changed, 75 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/cdmamodem/network-registration.c b/drivers/cdmamodem=
/network-registration.c
> index 92dad56..665f940 100644
> --- a/drivers/cdmamodem/network-registration.c
> +++ b/drivers/cdmamodem/network-registration.c
> @@ -34,10 +34,79 @@
>  =

>  #include "cdmamodem.h"
>  =

> +static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
> +
>  struct netreg_data {
>  	GAtChat *chat;
>  };
>  =

> +static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct ofono_cdma_netreg *netreg =3D user_data;
> +	gint srv_status;
> +	gint srv_domain;
> +	gint roaming_status;
> +	int status;
> +	GAtResultIter iter;
> +
> +	if (!ok)
> +		return;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "^SYSINFO:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &srv_status))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &srv_domain))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &roaming_status))
> +		return;
> +
> +	DBG("%d, %d, %d", srv_status, srv_domain, roaming_status);
> +
> +	switch (srv_status) {
> +	case 0:	/* No service */
> +	case 4:	/* Not registered */
> +		status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
> +		break;
> +	case 1:	/* Restricted service */
> +	case 2:	/* Service valid */
> +	case 3:	/* Restricted region service */
> +		status =3D CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED;
> +		break;
> +	default:
> +		status =3D CDMA_NETWORK_REGISTRATION_STATUS_UNKNOWN;
> +		break;
> +	}
> +
> +	switch (srv_domain) {
> +	case 0: /* No service */
> +		status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
> +		break;
> +	case 1: /* Only CS */
> +	case 2: /* Only PS */
> +	case 3: /* CS + PS */
> +	case 4: /* CS registered, PS in searching state */
> +		break;
> +	}
> +
> +	ofono_cdma_netreg_status_notify(netreg, status);
> +}
> +
> +

Why the double empty line?

> +static void mode_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_cdma_netreg *netreg =3D user_data;
> +	struct netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
> +
> +	g_at_chat_send(nd->chat, "AT^SYSINFO", sysinfo_prefix, sysinfo_cb,
> +				netreg, NULL);
> +}
> +
>  static int cdma_netreg_probe(struct ofono_cdma_netreg *netreg,
>  				unsigned int vendor, void *data)
>  {
> @@ -49,8 +118,14 @@ static int cdma_netreg_probe(struct ofono_cdma_netreg=
 *netreg,
>  	nd->chat =3D g_at_chat_clone(chat);
>  	ofono_cdma_netreg_set_data(netreg, nd);
>  =

> +	g_at_chat_register(nd->chat, "^MODE:",
> +				mode_notify, FALSE, netreg, NULL);
> +

I don't see how Huawei specific commands belong inside the cdmamodem
driver without at least a vendor quirk.  Personally I would put these
inside huaweicdmamodem driver.

>  	ofono_cdma_netreg_register(netreg);
>  =

> +	g_at_chat_send(nd->chat, "AT^SYSINFO", sysinfo_prefix, sysinfo_cb,
> +				netreg, NULL);
> +
>  	return 0;
>  }
>  =


Regards,
-Denis

--===============1525413967495678596==--

