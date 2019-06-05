Content-Type: multipart/mixed; boundary="===============5192867177821025571=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] netmon: adding get functionality for neighbouring
 cell information
Date: Wed, 05 Jun 2019 14:23:40 -0500
Message-ID: <995b8d02-4c5c-d459-1e1c-3a8031df27de@gmail.com>
In-Reply-To: <1559648318-18737-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5192867177821025571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 06/04/2019 06:38 AM, Antara Borwankar wrote:
> Handled the get neighbouring cell information function which returns
> an array of signal strength of all neighbouring cells.
> ---
>   src/netmon.c | 191 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 191 insertions(+)
> =

> diff --git a/src/netmon.c b/src/netmon.c
> index 6c19df5..daa1875 100644
> --- a/src/netmon.c
> +++ b/src/netmon.c
> @@ -50,6 +50,8 @@ struct ofono_netmon {
>   	const struct ofono_netmon_driver *driver;
>   	DBusMessage *pending;
>   	DBusMessage *reply;
> +	DBusMessageIter iter;
> +	DBusMessageIter arr;
>   	void *driver_data;
>   	struct ofono_atom *atom;
>   	struct netmon_agent *agent;
> @@ -403,6 +405,192 @@ static DBusMessage *netmon_unregister_agent(DBusCon=
nection *conn,
>   	return dbus_message_new_method_return(msg);
>   }
>   =

> +
> +void ofono_netmon_neighbouring_cell_notify(struct ofono_netmon *netmon,
> +					enum ofono_netmon_cell_type type,
> +					int info_type, ...)
> +{
> +	va_list arglist;
> +	DBusMessageIter dict;
> +	DBusMessageIter strct;
> +	enum ofono_netmon_info next_info_type =3D info_type;
> +	const char *tech =3D cell_type_to_tech_name(type);
> +	char *mcc;
> +	char *mnc;
> +	char *cell_id;
> +	int intval;
> +
> +	if (netmon->pending =3D=3D NULL)
> +		return;
> +
> +	if(!netmon->reply) {

Missing space after if

> +		netmon->reply =3D dbus_message_new_method_return(netmon->pending);
> +		dbus_message_iter_init_append(netmon->reply, &netmon->iter);
> +
> +		dbus_message_iter_open_container(&netmon->iter, DBUS_TYPE_ARRAY,
> +					DBUS_STRUCT_BEGIN_CHAR_AS_STRING
> +					DBUS_TYPE_ARRAY_AS_STRING
> +					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
> +					DBUS_TYPE_STRING_AS_STRING
> +					DBUS_TYPE_VARIANT_AS_STRING
> +					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
> +					DBUS_STRUCT_END_CHAR_AS_STRING,
> +					&netmon->arr);
> +	}
> +
> +	tech =3D cell_type_to_tech_name(type);
> +
> +	dbus_message_iter_open_container(&netmon->arr, DBUS_TYPE_STRUCT,
> +						NULL, &strct);
> +	dbus_message_iter_open_container(&strct, DBUS_TYPE_ARRAY,
> +					OFONO_PROPERTIES_ARRAY_SIGNATURE,
> +					&dict);
> +
> +	va_start(arglist, info_type);
> +
> +	if (tech =3D=3D NULL)
> +		goto done;
> +
> +	ofono_dbus_dict_append(&dict, "Technology",
> +					DBUS_TYPE_STRING, &tech);
> +
> +	while (next_info_type !=3D OFONO_NETMON_INFO_INVALID) {
> +		switch (next_info_type) {
> +		case OFONO_NETMON_INFO_MCC:
> +			mcc =3D va_arg(arglist, char *);
> +
> +			if (mcc && strlen(mcc))
> +				ofono_dbus_dict_append(&dict,
> +					"MobileCountryCode",
> +					DBUS_TYPE_STRING, &mcc);
> +			break;

So my only nitpick here is that this entire switch/case seems to be =

copy-paste of the serving cell implementation.  Since the attributes are =

the same, would it not make sense to put this into a helper function =

instead?

> +
> +		case OFONO_NETMON_INFO_MNC:
> +			mnc =3D va_arg(arglist, char *);
> +
> +			if (mnc && strlen(mnc))
> +				ofono_dbus_dict_append(&dict,
> +					"MobileNetworkCode",
> +					DBUS_TYPE_STRING, &mnc);
> +			break;
> +
> +		case OFONO_NETMON_INFO_CI:
> +			cell_id =3D va_arg(arglist, char *);
> +
> +			if (cell_id && strlen(cell_id))
> +				ofono_dbus_dict_append(&dict,
> +					"CellId",
> +					DBUS_TYPE_STRING, &cell_id);
> +			break;
> +
> +		case OFONO_NETMON_INFO_RXLEV:
> +			intval =3D va_arg(arglist, int);
> +
> +			CELL_INFO_DICT_APPEND(&dict, "Strength",
> +					intval, uint8_t, DBUS_TYPE_BYTE);
> +			break;
> +
> +		case OFONO_NETMON_INFO_BER:
> +			intval =3D va_arg(arglist, int);
> +
> +			CELL_INFO_DICT_APPEND(&dict, "BitErrorRate",
> +					intval, uint8_t, DBUS_TYPE_BYTE);
> +			break;
> +
> +		case OFONO_NETMON_INFO_RSCP:
> +			intval =3D va_arg(arglist, int);
> +
> +			CELL_INFO_DICT_APPEND(&dict, "ReceivedSignalCodePower",
> +					intval, uint8_t, DBUS_TYPE_BYTE);
> +			break;
> +
> +		case OFONO_NETMON_INFO_ECN0:
> +			intval =3D va_arg(arglist, int);
> +
> +			CELL_INFO_DICT_APPEND(&dict, "ReceivedEnergyRatio",
> +					intval, uint8_t, DBUS_TYPE_BYTE);
> +			break;
> +
> +		case OFONO_NETMON_INFO_RSRQ:
> +			intval =3D va_arg(arglist, int);
> +
> +			CELL_INFO_DICT_APPEND(&dict,
> +					"ReferenceSignalReceivedQuality",
> +					intval, uint8_t, DBUS_TYPE_BYTE);
> +			break;
> +
> +		case OFONO_NETMON_INFO_RSRP:
> +			intval =3D va_arg(arglist, int);
> +
> +			CELL_INFO_DICT_APPEND(&dict,
> +					"ReferenceSignalReceivedPower",
> +					intval, uint8_t, DBUS_TYPE_BYTE);
> +			break;
> +
> +		case OFONO_NETMON_INFO_INVALID:
> +		default:
> +			break;
> +		}
> +
> +		next_info_type =3D va_arg(arglist, int);
> +	}
> +
> +done:
> +	va_end(arglist);
> +
> +	dbus_message_iter_close_container(&strct, &dict);
> +	dbus_message_iter_close_container(&netmon->arr, &strct);
> +}
> +
> +static void neighbouring_cell_info_callback(const struct ofono_error *er=
ror,
> +		void *data)
> +{
> +	struct ofono_netmon *netmon =3D data;
> +	DBusMessage *reply =3D netmon->reply;
> +
> +	DBG("");

Missing empty line, see doc/coding-style.txt, item M1

> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +		if (reply)
> +			dbus_message_unref(reply);
> +
> +		reply =3D __ofono_error_failed(netmon->pending);
> +        } else if (!reply) {
> +		DBusMessageIter iter;
> +		DBusMessageIter dict;
> +
> +		reply =3D dbus_message_new_method_return(netmon->pending);
> +		dbus_message_iter_init_append(reply, &iter);
> +		dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +					OFONO_PROPERTIES_ARRAY_SIGNATURE,
> +					&dict);
> +		dbus_message_iter_close_container(&iter, &dict);
> +	} else {
> +		dbus_message_iter_close_container(&netmon->iter, &netmon->arr);
> +	}
> +
> +	netmon->reply =3D NULL;
> +	__ofono_dbus_pending_reply(&netmon->pending, reply);
> +}
> +
> +static DBusMessage *netmon_get_neighbouring_cell_info(DBusConnection *co=
nn,
> +			DBusMessage *msg, void *data)
> +{
> +	struct ofono_netmon *netmon =3D data;
> +
> +	if (!netmon->driver->neighbouring_cell_update)
> +		return __ofono_error_not_implemented(msg);
> +
> +	if (netmon->pending)
> +		return __ofono_error_busy(msg);
> +
> +	netmon->pending =3D dbus_message_ref(msg);
> +
> +	netmon->driver->neighbouring_cell_update(netmon,
> +				neighbouring_cell_info_callback, netmon);
> +
> +	return NULL;
> +}
> +
>   static const GDBusMethodTable netmon_methods[] =3D {
>   	{ GDBUS_ASYNC_METHOD("GetServingCellInformation",
>   			NULL, GDBUS_ARGS({ "cellinfo", "a{sv}" }),
> @@ -413,6 +601,9 @@ static const GDBusMethodTable netmon_methods[] =3D {
>   	{ GDBUS_METHOD("UnregisterAgent",
>   			GDBUS_ARGS({ "agent", "o" }), NULL,
>   			netmon_unregister_agent) },
> +	{ GDBUS_ASYNC_METHOD("GetNeighbouringCellInformation",
> +			NULL, GDBUS_ARGS({ "cellinfo", "a(a{sv})" }),
> +			netmon_get_neighbouring_cell_info) },
>   	{ }
>   };
>   =

> =


Regards,
-Denis

--===============5192867177821025571==--

