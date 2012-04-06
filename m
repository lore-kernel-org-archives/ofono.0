Content-Type: multipart/mixed; boundary="===============9148262995044287234=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC v4 05/10] bluetooth: Add AT+NREC support
Date: Fri, 06 Apr 2012 12:32:17 -0500
Message-ID: <4F7F28A1.2080909@gmail.com>
In-Reply-To: <1333718232-8447-6-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9148262995044287234==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 04/06/2012 08:17 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> ---
>  plugins/bluetooth.c |  142 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 142 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
> index 971e2c6..b6328bc 100644
> --- a/plugins/bluetooth.c
> +++ b/plugins/bluetooth.c
> @@ -38,6 +38,7 @@
>  =

>  #include <btio.h>
>  #include "bluetooth.h"
> +#include "ofono.h"

Why do you need ofono.h?

>  =

>  static DBusConnection *connection;
>  static GHashTable *uuid_hash =3D NULL;
> @@ -73,6 +74,12 @@ struct agent {
>  	guint16 features;
>  };
>  =

> +struct hfp_data {
> +	struct ofono_emulator *em;
> +	char *path;
> +	guint16 r_features;
> +};
> +
>  void bluetooth_create_path(const char *dev_addr, const char *adapter_add=
r,
>  				char *buf, int size)
>  {
> @@ -154,6 +161,141 @@ fail:
>  	return err;
>  }
>  =

> +static void audio_transport_set_property_cb(DBusPendingCall *call,
> +						gpointer user_data)
> +{
> +	struct ofono_emulator *em =3D user_data;
> +	DBusMessage *reply;
> +	struct DBusError derr;
> +	struct ofono_error result;
> +
> +	reply =3D dbus_pending_call_steal_reply(call);
> +
> +	dbus_error_init(&derr);
> +
> +	if (dbus_set_error_from_message(&derr, reply)) {
> +		ofono_error("MediaTransport.SetProperties replied an error: " \
> +				"%s, %s", derr.name, derr.message);
> +		dbus_error_free(&derr);
> +		result.type =3D OFONO_ERROR_TYPE_FAILURE;
> +	} else
> +		result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
> +
> +	result.error =3D 0;
> +	ofono_emulator_send_final(em, &result);
> +
> +	dbus_message_unref(reply);
> +}
> +
> +static void audio_transport_set_property(struct hfp_data *hfp, const cha=
r *name,
> +						int type, const void *value)
> +{
> +	DBusMessage *msg;
> +	DBusMessageIter iter, var;
> +	const char *str_type;
> +	DBusConnection *connection;
> +	DBusPendingCall *c;
> +
> +	if (hfp->path =3D=3D NULL)
> +		return;
> +
> +	switch (type) {
> +	case DBUS_TYPE_BOOLEAN:
> +		str_type =3D DBUS_TYPE_BOOLEAN_AS_STRING;
> +		break;
> +
> +	case DBUS_TYPE_UINT16:
> +		str_type =3D DBUS_TYPE_UINT16_AS_STRING;
> +		break;
> +
> +	default:
> +		return;
> +	}
> +
> +	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, hfp->path,
> +				BLUEZ_TRANSPORT_INTERFACE, "SetProperty");
> +	if (msg =3D=3D NULL)
> +		return;
> +
> +	dbus_message_iter_init_append(msg, &iter);
> +	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
> +
> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT, str_type,
> +						&var);
> +	dbus_message_iter_append_basic(&var, type, value);
> +	dbus_message_iter_close_container(&iter, &var);
> +
> +	connection =3D ofono_dbus_get_connection();
> +
> +	if (!dbus_connection_send_with_reply(connection, msg, &c, -1)) {
> +		ofono_error("Sending SetProperty failed");
> +		goto fail;
> +	}
> +
> +	dbus_pending_call_set_notify(c, audio_transport_set_property_cb,
> +								hfp->em, NULL);

So what happens if the emulator is removed during a pending call? E.g.
by the modem being powered down.

> +	dbus_pending_call_unref(c);
> +
> +fail:
> +	dbus_message_unref(msg);
> +}
> +
> +static void emulator_nrec_cb(struct ofono_emulator *em,
> +			struct ofono_emulator_request *req, void *userdata)
> +{
> +	struct hfp_data *hfp =3D userdata;
> +	struct ofono_error result;
> +	int val;
> +
> +	switch (ofono_emulator_request_get_type(req)) {
> +	case OFONO_EMULATOR_REQUEST_TYPE_SET:
> +		if (!ofono_emulator_request_next_number(req, &val))
> +			goto fail;
> +
> +		if (val !=3D 0 && val !=3D 1)
> +			goto fail;
> +
> +		audio_transport_set_property(hfp, "NREC", DBUS_TYPE_BOOLEAN,
> +									&val);
> +		break;
> +
> +	default:
> +fail:
> +		result.error =3D 0;
> +		result.type =3D OFONO_ERROR_TYPE_FAILURE;
> +		ofono_emulator_send_final(em, &result);
> +	};
> +}
> +
> +void bluetooth_free_audio_management(void *data)
> +{
> +	struct hfp_data *hfp =3D data;
> +
> +	DBG("");
> +
> +	ofono_emulator_remove_handler(hfp->em, "+NREC");

Do you really need to do this?

> +
> +	g_free(hfp->path);
> +	g_free(hfp);
> +}
> +
> +void *bluetooth_set_audio_management(void *em, const char *path,
> +							guint16 features)
> +{
> +	struct hfp_data *hfp;
> +
> +	DBG("");
> +
> +	hfp =3D g_new0(struct hfp_data, 1);
> +	hfp->em =3D em;
> +	hfp->path =3D g_strdup(path);
> +	hfp->r_features =3D features;
> +
> +	ofono_emulator_add_handler(em, "+NREC", emulator_nrec_cb, hfp, NULL);
> +
> +	return hfp;
> +}
> +
>  static void register_telephony_agent(const char *path, const char *handl=
e,
>  						struct agent *agent)
>  {

Regards,
-Denis

--===============9148262995044287234==--

