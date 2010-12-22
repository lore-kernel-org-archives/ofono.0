Content-Type: multipart/mixed; boundary="===============0521424147035403992=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: Re: [PATCH v2, 4/7] cdma-sms: Add CDMA SMS Support
Date: Wed, 22 Dec 2010 13:05:54 -0800
Message-ID: <4D126832.7050409@nokia.com>
In-Reply-To: <1292976149-15598-5-git-send-email-lei.2.yu@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0521424147035403992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

On 12/21/2010 04:02 PM, Lei Yu wrote:
> ---
>   Makefile.am    |    2 +-
>   src/cdma-sms.c |  335 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   src/ofono.h    |    3 +
>   3 files changed, 339 insertions(+), 1 deletions(-)
>   create mode 100644 src/cdma-sms.c
>
> diff --git a/Makefile.am b/Makefile.am
> index e85f522..61168ed 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -320,7 +320,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sou=
rces) src/ofono.ver \
>   			src/nettime.c src/stkagent.c src/stkagent.h \
>   			src/simfs.c src/simfs.h src/audio-settings.c \
>   			src/smsagent.c src/smsagent.h src/ctm.c \
> -			src/cdma-smsutil.c
> +			src/cdma-sms.c src/cdma-smsutil.c
>
>   src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_L=
IBS@ -ldl
>
> diff --git a/src/cdma-sms.c b/src/cdma-sms.c
> new file mode 100644
> index 0000000..005262e
> --- /dev/null
> +++ b/src/cdma-sms.c
> @@ -0,0 +1,335 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2010  Nokia Corporation. All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301=
 USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include<config.h>
> +#endif
> +
> +#include<string.h>
> +#include<stdio.h>
> +#include<errno.h>
> +
> +#include<glib.h>
> +#include<gdbus.h>
> +#include<sys/time.h>
> +
> +#include "ofono.h"
> +
> +#include "cdma-smsutil.h"
> +
> +static GSList *g_drivers;
> +
> +struct ofono_cdma_sms {
> +	const struct ofono_cdma_sms_driver *driver;
> +	void *driver_data;
> +	struct ofono_atom *atom;
> +};
> +
> +static GDBusMethodTable cdma_sms_manager_methods[] =3D {
> +	/* TODO */
> +	{ }
> +};
> +
> +static GDBusSignalTable cdma_sms_manager_signals[] =3D {
> +	{ "IncomingMessage",	"sa{sv}"	},
> +	/* TODO */
> +	{ }
> +};
> +
> +static void cdma_dispatch_text_message(struct ofono_cdma_sms *cdma_sms,
> +					const char *message,
> +					const char *oaddr)
> +{
> +	const char *path =3D __ofono_atom_get_path(cdma_sms->atom);
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	DBusMessage *signal;
> +	DBusMessageIter iter;
> +	DBusMessageIter dict;
> +	const char *signal_name;
> +
> +	/* TODO: Support ImmediateMessage */
> +	signal_name =3D "IncomingMessage";
> +
> +	signal =3D dbus_message_new_signal(path,
> +					OFONO_CDMA_MESSAGE_MANAGER_INTERFACE,
> +					signal_name);
> +	if (signal =3D=3D NULL)
> +		return;
> +
> +	dbus_message_iter_init_append(signal,&iter);
> +
> +	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,&(message));
> +
> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +					OFONO_PROPERTIES_ARRAY_SIGNATURE,
> +					&dict);
> +
> +	ofono_dbus_dict_append(&dict, "Sender", DBUS_TYPE_STRING,&oaddr);
> +
> +	/* TODO: Other properties not supported yet */
> +
> +	dbus_message_iter_close_container(&iter,&dict);
> +
> +	g_dbus_send_message(conn, signal);
> +
> +	/*TODO: Add the message to history*/
> +}
> +
> +static void ofono_cdma_sms_process_wmt_deliver(struct ofono_cdma_sms *cd=
ma_sms,
> +						struct cdma_sms *incoming)
> +{
> +	char *message;
> +	char *oaddr;
> +
> +	message =3D cdma_sms_decode_text(&incoming->p2p_msg.bearer_data.ud);
> +	if (message =3D=3D NULL)
> +		return;
> +
> +	oaddr =3D cdma_sms_address_to_string(&incoming->p2p_msg.oaddr);
> +	if (oaddr =3D=3D NULL) {
> +		g_free(message);
> +		return;
> +	}
> +
> +	cdma_dispatch_text_message(cdma_sms, message, oaddr);
> +
> +	g_free(message);
> +	g_free(oaddr);
> +}
> +
> +static void ofono_cdma_sms_process_wmt(struct ofono_cdma_sms *cdma_sms,
> +					struct cdma_sms *incoming)
> +{
> +	if (!check_bitmap(incoming->p2p_msg.bearer_data.subparam_bitmap,
> +				CDMA_SMS_SUBPARAM_ID_MESSAGE_ID))
> +		return;
> +
> +	/* TODO: Add duplicate detection support */
> +
> +	switch (incoming->p2p_msg.bearer_data.id.msg_type) {
> +	case CDMA_SMS_RESERVED:
> +		break;
> +	case CDMA_SMS_DELIVER:
> +		ofono_cdma_sms_process_wmt_deliver(cdma_sms, incoming);
> +		break;
> +	case CDMA_SMS_SUBMIT:
> +	case CDMA_SMS_CANCEL:
> +	case CDMA_SMS_DELIVER_ACK:
> +	case CDMA_SMS_USER_ACK:
> +	case CDMA_SMS_READ_ACK:
> +		/* TODO */
> +		break;
> +	}
> +}
> +
> +static void ofono_cdma_sms_process_p2p(struct ofono_cdma_sms *cdma_sms,
> +					struct cdma_sms *incoming)
> +{
> +	gboolean ts_exist, oaddr_exist;
> +
> +	ts_exist =3D check_bitmap(incoming->p2p_msg.bearer_data.subparam_bitmap,
> +				CDMA_SMS_PARAM_ID_TELESERVICE_IDENTIFIER);
> +	oaddr_exist =3D check_bitmap(incoming->p2p_msg.param_bitmap,
> +				CDMA_SMS_PARAM_ID_ORIGINATING_ADDRESS);
> +
> +	/*
> +	 * Check validity of incoming message, per Table 3.4.2.1-1 of
> +	 * 3GPP2 C.S0015-B v2.0.
> +	 */
> +	if (!ts_exist || !oaddr_exist)
> +		return;
> +
> +	switch (incoming->p2p_msg.teleservice_id) {
> +	case TELESERVICE_CMT91:
> +	case TELESERVICE_WPT:
> +		break; /* TODO: Not supported yet */
> +	case TELESERVICE_WMT:
> +		ofono_cdma_sms_process_wmt(cdma_sms, incoming);
> +		break;
> +	case TELESERVICE_VMN:
> +	case TELESERVICE_WAP:
> +	case TELESERVICE_WEMT:
> +	case TELESERVICE_SCPT:
> +	case TELESERVICE_CATPT:
> +		break; /* TODO: Not supported yet */
> +	}
> +}
> +
> +void ofono_cdma_sms_deliver_notify(struct ofono_cdma_sms *cdma_sms,
> +					unsigned char *pdu, int pdu_len)
> +{
> +	static struct cdma_sms s;
> +
> +	DBG("pdu len %d", pdu_len);
> +
> +	memset(&s, 0, sizeof(struct cdma_sms));
> +
> +	if (!cdma_sms_decode(pdu, pdu_len,&s))
> +		return;
> +
> +	switch (s.type) {
> +	case CDMA_SMS_P2P:
> +		ofono_cdma_sms_process_p2p(cdma_sms,&s);
> +		break;
> +	case CDMA_SMS_BCAST:
> +	case CDMA_SMS_ACK:
> +		/*
> +		 * TODO: Support SMS Broadcast Message and SMS
> +		 * Acknowledge Message.
> +		 */
> +		break;
> +	}
> +}
> +
> +int ofono_cdma_sms_driver_register(const struct ofono_cdma_sms_driver *d)
> +{
> +	DBG("driver: %p, name: %s", d, d->name);
> +
> +	if (d->probe =3D=3D NULL)
> +		return -EINVAL;
> +
> +	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
> +
> +	return 0;
> +}
> +
> +void ofono_cdma_sms_driver_unregister(const struct ofono_cdma_sms_driver=
 *d)
> +{
> +	DBG("driver: %p, name: %s", d, d->name);
> +
> +	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
> +}
> +
> +static void cdma_sms_unregister(struct ofono_atom *atom)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
> +	const char *path =3D __ofono_atom_get_path(atom);
> +
> +	g_dbus_unregister_interface(conn, path,
> +					OFONO_CDMA_MESSAGE_MANAGER_INTERFACE);
> +
> +	ofono_modem_remove_interface(modem,
> +					OFONO_CDMA_MESSAGE_MANAGER_INTERFACE);
> +}
> +
> +static void cdma_sms_remove(struct ofono_atom *atom)
> +{
> +	struct ofono_cdma_sms *cdma_sms =3D __ofono_atom_get_data(atom);
> +
> +	DBG("atom: %p", atom);
> +
> +	if (cdma_sms =3D=3D NULL)
> +		return;
> +
> +	if (cdma_sms->driver&&  cdma_sms->driver->remove)
> +		cdma_sms->driver->remove(cdma_sms);
> +
> +	g_free(cdma_sms);
> +}
> +
> +/*
> + * Create a CDMA SMS driver
> + *
> + * This creates a CDMA SMS driver that is hung off a @modem
> + * object. However, for the driver to be used by the system, it has to
> + * be registered with the oFono core using ofono_sms_register().
> + *
> + * This is done once the modem driver determines that SMS is properly
> + * supported by the hardware.
> + */
> +struct ofono_cdma_sms *ofono_cdma_sms_create(struct ofono_modem *modem,
> +						unsigned int vendor,
> +						const char *driver,
> +						void *data)
> +{
> +	struct ofono_cdma_sms *cdma_sms;
> +	GSList *l;
> +
> +	if (driver =3D=3D NULL)
> +		return NULL;
> +
> +	cdma_sms =3D g_try_new0(struct ofono_cdma_sms, 1);
> +	if (cdma_sms =3D=3D NULL)
> +		return NULL;
> +
> +	cdma_sms->atom =3D __ofono_modem_add_atom(modem,
> +						OFONO_ATOM_TYPE_CDMA_SMS,
> +						cdma_sms_remove, cdma_sms);
> +
> +	for (l =3D g_drivers; l; l =3D l->next) {
> +		const struct ofono_cdma_sms_driver *drv =3D l->data;
> +
> +		if (g_strcmp0(drv->name, driver))
> +			continue;
> +
> +		if (drv->probe(cdma_sms, vendor, data)<  0)
> +			continue;
> +
> +		cdma_sms->driver =3D drv;
> +		break;
> +	}
> +
> +	return cdma_sms;
> +}
> +
> +/*
> + * Indicate oFono that a CDMA SMS driver is ready for operation
> + *
> + * This is called after ofono_cdma_sms_create() was done and the modem
> + * driver determined that a modem supports SMS correctly. Once this
> + * call succeeds, the D-BUS interface for SMS goes live.
> + */
> +void ofono_cdma_sms_register(struct ofono_cdma_sms *cdma_sms)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(cdma_sms->atom);
> +	const char *path =3D __ofono_atom_get_path(cdma_sms->atom);
> +
> +	if (!g_dbus_register_interface(conn, path,
> +					OFONO_CDMA_MESSAGE_MANAGER_INTERFACE,
> +					cdma_sms_manager_methods,
> +					cdma_sms_manager_signals,
> +					NULL, cdma_sms, NULL)) {
> +		ofono_error("Could not create %s interface",
> +				OFONO_CDMA_MESSAGE_MANAGER_INTERFACE);
> +		return;
> +	}
> +
> +	ofono_modem_add_interface(modem, OFONO_CDMA_MESSAGE_MANAGER_INTERFACE);
> +
> +	__ofono_atom_register(cdma_sms->atom, cdma_sms_unregister);
> +}
> +
> +void ofono_cdma_sms_remove(struct ofono_cdma_sms *cdma_sms)
> +{
> +	__ofono_atom_free(cdma_sms->atom);
> +}
> +
> +void ofono_cdma_sms_set_data(struct ofono_cdma_sms *cdma_sms, void *data)
> +{
> +	cdma_sms->driver_data =3D data;
> +}
> +
> +void *ofono_cdma_sms_get_data(struct ofono_cdma_sms *cdma_sms)
> +{
> +	return cdma_sms->driver_data;
> +}
> diff --git a/src/ofono.h b/src/ofono.h
> index 792134b..422fa8a 100644
> --- a/src/ofono.h
> +++ b/src/ofono.h
> @@ -126,6 +126,7 @@ enum ofono_atom_type {
>   	OFONO_ATOM_TYPE_STK =3D 20,
>   	OFONO_ATOM_TYPE_NETTIME =3D 21,
>   	OFONO_ATOM_TYPE_CTM =3D 22,
> +	OFONO_ATOM_TYPE_CDMA_SMS =3D 23,
>   };
>
>   enum ofono_atom_watch_condition {
> @@ -415,3 +416,5 @@ void __ofono_nettime_probe_drivers(struct ofono_modem=
 *modem);
>
>   void __ofono_nettime_info_received(struct ofono_modem *modem,
>   					struct ofono_network_time *info);
> +
> +#include<ofono/cdma-sms.h>

I just submitted v3 of this patch which fixes two bugs I just found. =

Please review v3 instead.

Regards
Lei


--===============0521424147035403992==--

