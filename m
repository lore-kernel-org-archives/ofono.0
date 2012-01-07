Content-Type: multipart/mixed; boundary="===============8676848656564162308=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 08/10] huaweicdmamodem: Probe the QCDM port with the
 version info request
Date: Sat, 07 Jan 2012 13:12:59 -0600
Message-ID: <4F08993B.1010105@gmail.com>
In-Reply-To: <1323885372-3574-9-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8676848656564162308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 12/14/2011 11:56 AM, Philippe Nunes wrote:
> ---
>  drivers/huaweicdmamodem/network-registration.c |  106 ++++++++++++++++++=
+++---
>  1 files changed, 95 insertions(+), 11 deletions(-)
> =


so the huawecdmamodem tree no longer exists, and I'm not sure that the
QCDM pieces really belong here, perhaps we need a separate helper
library for parsing this information.

> diff --git a/drivers/huaweicdmamodem/network-registration.c b/drivers/hua=
weicdmamodem/network-registration.c
> index 0052044..44d3152 100644
> --- a/drivers/huaweicdmamodem/network-registration.c
> +++ b/drivers/huaweicdmamodem/network-registration.c
> @@ -24,6 +24,8 @@
>  #endif
>  =

>  #define _GNU_SOURCE
> +#include <string.h>
> +#include <stdio.h>
>  #include <glib.h>
>  #include <errno.h>
>  =

> @@ -35,8 +37,32 @@
>  =

>  #include "huaweicdmamodem.h"
>  =

> +#define DIAG_CMD_VERSION_INFO	0	/* Version info */
> +
>  static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
>  =

> +struct netreg_data {
> +	GAtChat *chat;
> +	GAtHDLC *diag;
> +	guint8 cmd;
> +};
> +
> +struct version_info {
> +	guint8 code;
> +	char comp_date[11];
> +	char comp_time[8];
> +	char rel_date[11];
> +	char rel_time[8];
> +	char model[8];
> +	guint8 scm;
> +	guint8 mob_cai_rev;
> +	guint8 mob_model;
> +	guint16 mob_firmware_rev;
> +	guint8 slot_cycle_index;
> +	guint8 msm_ver;
> +	guint8 unknown;
> +} __attribute__ ((packed));
> +
>  static gboolean parse_sysinfo(GAtResult *result, gint *status)
>  {
>  	GAtResultIter iter;
> @@ -107,12 +133,56 @@ static void sysinfo_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>  	ofono_cdma_netreg_status_notify(netreg, status);
>  }
>  =

> +static void send_command(GAtHDLC *hdlc, guint8 cmd)
> +{
> +	unsigned char cmdbuf[1];
> +
> +	cmdbuf[0] =3D cmd;
> +
> +	g_at_hdlc_send(hdlc, cmdbuf, sizeof(cmdbuf));
> +}
> +
> +static void hdlc_receive(const unsigned char *buf, gsize len, void *user=
_data)
> +{
> +	struct ofono_cdma_netreg *netreg =3D user_data;
> +	struct netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
> +
> +	if (nd->cmd =3D=3D DIAG_CMD_VERSION_INFO) {
> +		struct version_info *verinfo;
> +		char str[12];
> +
> +		if (len < 1 || len > sizeof(struct version_info) ||
> +				nd->cmd !=3D buf[0]) {
> +			/* This is probably not a QCDM port */
> +			g_at_hdlc_unref(nd->diag);
> +			nd->diag =3D NULL;
> +			return;
> +		}
> +
> +		DBG("Version information\n");
> +		verinfo =3D (struct version_info *)buf;

You really can't do this since the endian-ness of QCDM is likely always
little-endian, while oFono might be running on big-endian machine.

> +		snprintf(str, 12, "%s", verinfo->comp_date);
> +		DBG("Compiled Date: %s\n", str);
> +		snprintf(str, 9, "%s", verinfo->comp_time);
> +		DBG("Compiled Time: %s\n", str);
> +		snprintf(str, 12, "%s", verinfo->rel_date);
> +		DBG("Release Date: %s\n", str);
> +		snprintf(str, 9, "%s", verinfo->rel_time);
> +		DBG("Release Time: %s\n", str);
> +		snprintf(str, 9, "%s", verinfo->model);
> +		DBG("Model: %s\n", str);
> +		DBG("MSM version: %d\n", verinfo->msm_ver);
> +	}
> +
> +	return;
> +}
> +
>  static void mode_notify(GAtResult *result, gpointer user_data)
>  {
>  	struct ofono_cdma_netreg *netreg =3D user_data;
> -	GAtChat *chat =3D ofono_cdma_netreg_get_data(netreg);
> +	struct netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
>  =

> -	g_at_chat_send(chat, "AT^SYSINFO", sysinfo_prefix,
> +	g_at_chat_send(nd->chat, "AT^SYSINFO", sysinfo_prefix,
>  				sysinfo_cb, netreg, NULL);
>  }
>  =

> @@ -169,20 +239,20 @@ error:
>  static void probe_cb(gboolean ok, GAtResult *result, gpointer user_data)
>  {
>  	struct ofono_cdma_netreg *netreg =3D user_data;
> -	GAtChat *chat =3D ofono_cdma_netreg_get_data(netreg);
> +	struct netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
>  =

>  	if (!ok) {
>  		ofono_cdma_netreg_remove(netreg);
>  		return;
>  	}
>  =

> -	g_at_chat_register(chat, "^MODE:",
> +	g_at_chat_register(nd->chat, "^MODE:",
>  				mode_notify, FALSE, netreg, NULL);
>  =

> -	g_at_chat_register(chat, "^RSSILVL:",
> +	g_at_chat_register(nd->chat, "^RSSILVL:",
>  				rssilvl_notify, FALSE, netreg, NULL);
>  =

> -	g_at_chat_register(chat, "^HRSSILVL:",
> +	g_at_chat_register(nd->chat, "^HRSSILVL:",
>  				hrssilvl_notify, FALSE, netreg, NULL);
>  =

>  	ofono_cdma_netreg_register(netreg);
> @@ -191,23 +261,37 @@ static void probe_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
>  static int huaweicdma_netreg_probe(struct ofono_cdma_netreg *netreg,
>  				unsigned int vendor, void *data)
>  {
> -	GAtChat *chat =3D g_at_chat_clone(data);
> +	struct netreg_data *nd;
> +
> +	nd =3D g_new0(struct netreg_data, 1);
> +
> +	nd->chat =3D g_at_chat_clone(data);
> +	nd->diag =3D g_at_chat_get_slave_qcdm(data);
>  =

> -	ofono_cdma_netreg_set_data(netreg, chat);
> +	ofono_cdma_netreg_set_data(netreg, nd);
>  =

> -	g_at_chat_send(chat, "AT^SYSINFO", sysinfo_prefix,
> +	g_at_chat_send(nd->chat, "AT^SYSINFO", sysinfo_prefix,
>  				probe_cb, netreg, NULL);
>  =

> +	if (nd->diag) {
> +		g_at_hdlc_set_receive(nd->diag, hdlc_receive, netreg);
> +		/* Request version info to probe the QCDM port */
> +		nd->cmd =3D DIAG_CMD_VERSION_INFO;
> +		send_command(nd->diag, nd->cmd);
> +	}
> +
>  	return 0;
>  }
>  =

>  static void huaweicdma_netreg_remove(struct ofono_cdma_netreg *netreg)
>  {
> -	GAtChat *chat =3D ofono_cdma_netreg_get_data(netreg);
> +	struct netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
>  =

>  	ofono_cdma_netreg_set_data(netreg, NULL);
>  =

> -	g_at_chat_unref(chat);
> +	g_at_chat_unref(nd->chat);
> +	g_at_hdlc_unref(nd->diag);
> +	g_free(nd);
>  }
>  =

>  static struct ofono_cdma_netreg_driver driver =3D {

Regards,
-Denis

--===============8676848656564162308==--

