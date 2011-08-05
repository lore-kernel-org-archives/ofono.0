Content-Type: multipart/mixed; boundary="===============0123200888708361015=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v6 07/14] huaweicdma: create a dedicated netreg atom.
Date: Fri, 05 Aug 2011 11:04:57 -0500
Message-ID: <4E3C14A9.1010008@gmail.com>
In-Reply-To: <1312550475-8537-8-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0123200888708361015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 08/05/2011 08:21 AM, Bertrand Aygon wrote:
> ---
>  Makefile.am                                    |    3 +-
>  drivers/huaweicdmamodem/huaweicdmamodem.c      |    3 +
>  drivers/huaweicdmamodem/huaweicdmamodem.h      |    2 +
>  drivers/huaweicdmamodem/network-registration.c |  175 ++++++++++++++++++=
++++++
>  4 files changed, 182 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/huaweicdmamodem/network-registration.c
> =


<snip>

> +
> +struct huaweicdma_netreg_data {
> +	GAtChat *chat;
> +};
> +

I know other drivers do this, but in general I don't like this form.
I'd rather you set the chat directly into the cdma_netreg data and
simplify things a bit.

Unless you can definitely predict that you will have additional data
members here in the future.

> +static void parse_sysinfo(GAtResult *result, gint *status)
> +{
> +	GAtResultIter iter;
> +	gint srv_status;
> +	gint srv_domain;
> +	gint roaming_status;
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

You can't simply return here, otherwise you end up giving bogus values
to the core.

> +	DBG("%d, %d, %d", srv_status, srv_domain, roaming_status);
> +
> +	switch (srv_status) {
> +	case 1:	/* Restricted service */
> +	case 2:	/* Service valid */
> +	case 3:	/* Restricted region service */
> +		if (roaming_status)
> +			*status =3D CDMA_NETWORK_REGISTRATION_STATUS_ROAMING;
> +		else
> +			*status =3D CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED;
> +		break;
> +	case 0:	/* No service */
> +	case 4:	/* Not registered */
> +	default:
> +		*status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
> +		break;
> +	}
> +
> +	switch (srv_domain) {
> +	case 0: /* No service */
> +	case 255: /* CDMA not supported */
> +		*status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
> +		break;
> +	case 1: /* Only CS */
> +	case 2: /* Only PS */
> +	case 3: /* CS + PS */
> +	case 4: /* CS registered, PS in searching state */
> +		break;
> +	}
> +}
> +
> +static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct ofono_cdma_netreg *netreg =3D user_data;
> +	int status;
> +
> +	if (!ok)
> +		return;
> +
> +	parse_sysinfo(result, &status);

Printing some sort of an error and defaulting to not registered might be
helpful here in case parsing of sysinfo fails.  And remember, "Be more
paranoid"


> +
> +	ofono_cdma_netreg_status_notify(netreg, status);
> +}
> +
> +static void mode_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_cdma_netreg *netreg =3D user_data;
> +	struct huaweicdma_netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg=
);
> +
> +	g_at_chat_send(nd->chat, "AT^SYSINFO", sysinfo_prefix,
> +				sysinfo_cb, netreg, NULL);
> +}
> +
> +static void probe_cb(gboolean ok, GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_cdma_netreg *netreg =3D user_data;
> +
> +	if (!ok)
> +		return;

If the driver fails its probe, you should remove the atom, not simply
leave it in a zombie state consuming resources.

> +
> +	ofono_cdma_netreg_register(netreg);
> +}
> +
> +static int huaweicdma_netreg_probe(struct ofono_cdma_netreg *netreg,
> +				unsigned int vendor, void *data)
> +{
> +	GAtChat *chat =3D data;
> +	struct huaweicdma_netreg_data *nd;
> +
> +	nd =3D g_try_new0(struct huaweicdma_netreg_data, 1);
> +	if (nd =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	nd->chat =3D g_at_chat_clone(chat);
> +
> +	ofono_cdma_netreg_set_data(netreg, nd);
> +
> +	g_at_chat_register(nd->chat, "^MODE:",
> +				mode_notify, FALSE, netreg, NULL);
> +

Shouldn't you do this after you know that SYSINFO is supported?

> +	g_at_chat_send(nd->chat, "AT^SYSINFO", sysinfo_prefix,
> +				probe_cb, netreg, NULL);
> +
> +	return 0;
> +}
> +
> +static void huaweicdma_netreg_remove(struct ofono_cdma_netreg *netreg)
> +{
> +	struct huaweicdma_netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg=
);
> +
> +	ofono_cdma_netreg_set_data(netreg, NULL);
> +
> +	g_at_chat_unref(nd->chat);
> +	g_free(nd);
> +}
> +
> +static struct ofono_cdma_netreg_driver driver =3D {
> +	.name	=3D "huaweicdmamodem",
> +	.probe	=3D huaweicdma_netreg_probe,
> +	.remove	=3D huaweicdma_netreg_remove,
> +};
> +
> +void huaweicdma_netreg_init(void)
> +{
> +	ofono_cdma_netreg_driver_register(&driver);
> +}
> +
> +void huaweicdma_netreg_exit(void)
> +{
> +	ofono_cdma_netreg_driver_unregister(&driver);
> +}


--===============0123200888708361015==--

