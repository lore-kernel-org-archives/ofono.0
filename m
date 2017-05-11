Content-Type: multipart/mixed; boundary="===============6611079164664403566=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 1/2] gemalto: Prepare new interface for hardware monitoring
Date: Thu, 11 May 2017 14:51:35 -0500
Message-ID: <ef7d947d-9e08-00ea-1334-547fe77d26c4@gmail.com>
In-Reply-To: <1494514093-28167-2-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6611079164664403566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On 05/11/2017 09:48 AM, Vincent Cesson wrote:
> Gemalto modems have hardware related commands, allowing to monitor voltage
> and temperature. These parameters will be accessible on DBus interface:
> org.ofono.HardwareMonitor.

It should be clear that this is a vendor specific interface, so =

org.ofono.cinterion.HardwareMonitor.

>
>  - Create the DBus method table with two entries:
> GetTemperature and GetVoltage.

So the applications would need to poll these values.  Does the modem =

enable some sort of unsolicited notifications of these?

>  - Create a dedicated structure to handle the DBus methods.
>  - Create enable/disable functions to handle DBus interface registration.
> ---
>  plugins/gemalto.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 90 insertions(+)
>
> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
> index 2870ce8..985dfd8 100644
> --- a/plugins/gemalto.c
> +++ b/plugins/gemalto.c
> @@ -30,7 +30,11 @@
>  #include <gatchat.h>
>  #include <gattty.h>
>
> +#include "gdbus.h"

By our convention, please use <gdbus.h>

> +#include "ofono.h"
> +
>  #define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/dbus.h>
>  #include <ofono/plugin.h>
>  #include <ofono/log.h>
>  #include <ofono/modem.h>
> @@ -46,14 +50,24 @@
>  #include <drivers/atmodem/atutil.h>
>  #include <drivers/atmodem/vendor.h>
>
> +#define HARDWARE_MONITOR_INTERFACE OFONO_SERVICE ".HardwareMonitor"
> +
>  static const char *none_prefix[] =3D { NULL };
>
> +struct gemalto_hardware_monitor {
> +	DBusMessage *msg;
> +	struct ofono_modem *modem;
> +	int32_t temperature;
> +	int32_t voltage;
> +};
> +
>  struct gemalto_data {
>  	GAtChat *app;
>  	GAtChat *mdm;
>  	struct ofono_sim *sim;
>  	gboolean have_sim;
>  	struct at_util_sim_state_query *sim_state_query;
> +	struct gemalto_hardware_monitor *hm;
>  };
>
>  static int gemalto_probe(struct ofono_modem *modem)
> @@ -142,6 +156,73 @@ static void cfun_enable(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>  						NULL);
>  }
>
> +static DBusMessage *hardware_monitor_get_temperature(DBusConnection *con=
n,
> +							DBusMessage *msg,
> +							void *user_data)
> +{
> +	DBG("");
> +
> +	return __ofono_error_not_implemented(msg);
> +}
> +
> +static DBusMessage *hardware_monitor_get_voltage(DBusConnection *conn,
> +							DBusMessage *msg,
> +							void *user_data)
> +{
> +	DBG("");
> +
> +	return __ofono_error_not_implemented(msg);
> +}
> +
> +static const GDBusMethodTable hardware_monitor_methods[] =3D {
> +	{ GDBUS_ASYNC_METHOD("GetTemperature",
> +			NULL, GDBUS_ARGS({ "temperature", "i" }),
> +			hardware_monitor_get_temperature) },
> +	{ GDBUS_ASYNC_METHOD("GetVoltage",
> +			NULL, GDBUS_ARGS({ "voltage", "i" }),
> +			hardware_monitor_get_voltage) },
> +	{}
> +};
> +

If the modem reports these via unsolicited notifications, then it might =

be better to model Temperature & Voltage as properties instead.

> +static void hardware_monitor_cleanup(void *user_data)
> +{
> +	struct gemalto_data *data =3D user_data;
> +	struct gemalto_hardware_monitor *hm =3D data->hm;
> +
> +	g_free(hm);
> +}
> +
> +static int gemalto_hardware_monitor_enable(struct ofono_modem *modem)
> +{
> +	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D ofono_modem_get_path(modem);
> +
> +	DBG("");
> +
> +	/* Enable temperature output */
> +	g_at_chat_send(data->app, "AT^SCTM=3D0,1", none_prefix, NULL, NULL, NUL=
L);
> +
> +	/* Create Hardware Monitor DBus interface */
> +	data->hm =3D g_try_new0(struct gemalto_hardware_monitor, 1);
> +	if (data->hm =3D=3D NULL)
> +		return -EIO;
> +
> +	data->hm->modem =3D modem;
> +
> +	if (!g_dbus_register_interface(conn, path, HARDWARE_MONITOR_INTERFACE,
> +					hardware_monitor_methods, NULL, NULL,
> +					data, hardware_monitor_cleanup)) {
> +		ofono_error("Could not register %s interface under %s",
> +					HARDWARE_MONITOR_INTERFACE, path);
> +		g_free(data->hm);
> +		return -EIO;
> +	}
> +
> +	ofono_modem_add_interface(modem, HARDWARE_MONITOR_INTERFACE);
> +	return 0;
> +}
> +
>  static int gemalto_enable(struct ofono_modem *modem)
>  {
>  	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> @@ -181,6 +262,8 @@ static int gemalto_enable(struct ofono_modem *modem)
>  	g_at_chat_send(data->app, "AT+CFUN=3D4", none_prefix,
>  			cfun_enable, modem, NULL);
>
> +	gemalto_hardware_monitor_enable(modem);
> +

Might want to do this only after the device is 'enabled'.  E.g. in =

cfun_enable

>  	return -EINPROGRESS;
>  }
>
> @@ -203,12 +286,19 @@ static void gemalto_smso_cb(gboolean ok, GAtResult =
*result, gpointer user_data)
>  static int gemalto_disable(struct ofono_modem *modem)
>  {
>  	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D ofono_modem_get_path(modem);
>
>  	DBG("%p", modem);
>
>  	g_at_chat_cancel_all(data->app);
>  	g_at_chat_unregister_all(data->app);
>
> +	if (g_dbus_unregister_interface(conn, path,
> +				HARDWARE_MONITOR_INTERFACE))
> +		ofono_modem_remove_interface(modem,
> +				HARDWARE_MONITOR_INTERFACE);
> +
>  	/* Shutdown the modem */
>  	g_at_chat_send(data->app, "AT^SMSO", none_prefix, gemalto_smso_cb,
>  			modem, NULL);
>

Regards,
-Denis

--===============6611079164664403566==--

