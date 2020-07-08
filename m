Content-Type: multipart/mixed; boundary="===============5942709280593270463=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] xmm7xxx-enable-esim-feature-in-xmm
Date: Wed, 08 Jul 2020 14:04:05 -0500
Message-ID: <7888c854-3079-d44e-bddf-5c30f5f476ab@gmail.com>
In-Reply-To: <1594064360-31104-1-git-send-email-shweta2.jain@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5942709280593270463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Shweta,

On 7/6/20 2:39 PM, shweta wrote:
> From: Shweta Jain <shweta2.jain@intel.com>
> =

> ---
>   plugins/xmm7xxx.c | 445 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++-
>   1 file changed, 444 insertions(+), 1 deletion(-)
> =


So when I tried to apply this patch, I got:

Applying: xmm7xxx-enable-esim-feature-in-xmm
.git/rebase-apply/patch:37: trailing whitespace.

.git/rebase-apply/patch:39: space before tab in indent.
  	GAtChat *chat;
.git/rebase-apply/patch:40: space before tab in indent.
  	struct ofono_modem *modem;
.git/rebase-apply/patch:41: trailing whitespace.

.git/rebase-apply/patch:42: space before tab in indent.
  	char *eid;
warning: squelched 347 whitespace errors
error: 352 lines add whitespace errors.
Patch failed at 0001 xmm7xxx-enable-esim-feature-in-xmm
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".


Please make sure your editor uses only tabs for indentation, does not conta=
in =

trailing whitespace.

oFono uses the Linux Kernel coding style, so please make sure that your =

submission follows this whenever possible.  We have several 'house' rules o=
r =

deviations from the Linux coding style that is documented in =

doc/coding-style.txt.  An easy way to test compliance is to run =

scripts/checkpatch.pl from the Linux kernel against your submission prior t=
o =

sending it to the list.

> diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
> index a544798..8744299 100644
> --- a/plugins/xmm7xxx.c
> +++ b/plugins/xmm7xxx.c
> @@ -62,6 +62,7 @@
>   =

>   #define OFONO_COEX_INTERFACE OFONO_SERVICE ".intel.LteCoexistence"
>   #define OFONO_COEX_AGENT_INTERFACE OFONO_SERVICE ".intel.LteCoexistence=
Agent"
> +#define OFONO_EUICC_LPA_INTERFACE OFONO_SERVICE ".intel.EuiccLpa"
>   =

>   #define NET_BAND_LTE_INVALID 0
>   #define NET_BAND_LTE_1 101
> @@ -73,6 +74,8 @@
>   static const char *none_prefix[] =3D { NULL };
>   static const char *xsimstate_prefix[] =3D { "+XSIMSTATE:", NULL };
>   static const char *xnvmplmn_prefix[] =3D { "+XNVMPLMN:", NULL };
> ++static const char *ccho_prefix[] =3D { "+CCHO:", NULL };
> ++static const char *cgla_prefix[] =3D { "+CGLA:", NULL };

This '++' seems wrong.  Have you tried applying your patch and compile test=
ing =

it prior to submission?

>   =

>   struct bt_coex_info {
>   	int safe_tx_min;
> @@ -108,8 +111,429 @@ struct xmm7xxx_data {
>   	ofono_bool_t have_sim;
>   	ofono_bool_t sms_phonebook_added;
>   	unsigned int netreg_watch;
> +	ofono_bool_t stk_enable;
> +	ofono_bool_t enable_euicc;
>   };
>   =

> + /* eUICC Implementation */
> + #define EUICC_EID_CMD "80e2910006BF3E035C015A00"
> + #define EUICC_ISDR_AID "A0000005591010FFFFFFFF8900000100"
> +
> + struct xmm7xxx_euicc {
> + 	GAtChat *chat;
> + 	struct ofono_modem *modem;
> +
> + 	char *eid;
> + 	int channel;
> + 	char *command;
> + 	int length;
> + 	DBusMessage *pending;
> + 	ofono_bool_t is_registered;
> + };
> +
> + static char *euiccCmdBytesToHexString(const unsigned char *DataBytes,
> + 					int dataSize, int *bufferStringSize)
> + {
> + 	int offset =3D 0;
> + 	char *BufferString =3D NULL;
> + 	*bufferStringSize =3D dataSize * 2;
> +
> + 	if (DataBytes) {
> + 		BufferString =3D g_new0(char, *bufferStringSize  + 1);
> + 		while (offset < dataSize) {
> + 			sprintf(&BufferString[offset * 2], "%02x",
> + 						DataBytes[offset]);
> +			offset++;
> + 		}
> + 	}
> +
> + 	return BufferString;
> + }

We already have something similar in src/util.[ch]: encode_hex_own_buf().  =
So =

I'd just use that instead.

> +
> + static unsigned char *euiccRspStringToBytes(const char *DataString,
> + 					int dataSize, int *bufferBytesSize)
> + {
> + 	int offset =3D 0, tmp;
> + 	unsigned char *BufferBytes =3D NULL;
> + 	*bufferBytesSize =3D dataSize / 2;
> +
> + 	if (DataString) {
> + 		BufferBytes =3D g_new0(unsigned char, *bufferBytesSize);
> +
> + 		while (offset < *bufferBytesSize) {
> + 			sscanf(&DataString[offset * 2], "%02x", &tmp);
> + 			BufferBytes[offset] =3D tmp;
> + 			offset ++;
> + 		}
> + 	}
> +
> + 	return BufferBytes;
> + }

Similarly here, looks like this can use decode_hex_own_buf.

Or better yet, just use ell's utilities for this:
l_util_hexstring
l_util_from_hexstring

> +
> + static void euicc_cleanup(void *data)
> + {
> + 	struct xmm7xxx_euicc *euicc =3D data;
> +
> + 	g_free(euicc->command);
> + 	g_free(euicc->eid);
> + 	g_free(euicc->pending);

This looks wrong.  The pending was allocated using dbus_* APIs and should b=
e =

deallocated accordingly.

> + 	g_free(euicc);
> + }
> +
> + static void euicc_release_isdr(struct xmm7xxx_euicc *euicc)
> + {
> + 	DBusMessage *reply;
> + 	DBusConnection *conn =3D ofono_dbus_get_connection();
> + 	char buff[20];
> +
> + 	snprintf(buff, sizeof(buff), "AT+CCHC=3D%u", euicc->channel);
> +
> + 	g_at_chat_send(euicc->chat, buff, none_prefix, NULL, NULL, NULL);
> +
> + 	euicc->channel =3D -1;
> + 	g_free(euicc->command);
> + 	euicc->command =3D NULL;
> + 	euicc->length =3D 0;
> + }
> +
> + static void euicc_pending_reply(struct xmm7xxx_euicc *euicc,
> + 							const char *resp)
> + {
> + 	DBusMessage *reply;
> + 	DBusConnection *conn =3D ofono_dbus_get_connection();
> + 	DBusMessageIter iter, array;
> + 	unsigned char *response;
> + 	int length;
> +
> + 	DBG("");
> + 	response =3D euiccRspStringToBytes(resp, strlen(resp), &length);
> +
> + 	reply =3D dbus_message_new_method_return(euicc->pending);
> + 	if (reply =3D=3D NULL)
> + 		return;
> +
> + 	dbus_message_iter_init_append(reply, &iter);
> +
> + 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> + 				DBUS_TYPE_BYTE_AS_STRING, &array);
> +
> + 	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
> + 					&response, length);
> +
> + 	dbus_message_iter_close_container(&iter, &array);
> +
> + 	if (dbus_connection_send(conn, reply, NULL) =3D=3D FALSE)
> + 		return;
> +
> + 	dbus_message_unref(reply);
> + 	dbus_message_unref(euicc->pending);
> + 	euicc->pending =3D NULL;
> +
> + 	g_free(response);
> + }
> +
> + static DBusMessage *euicc_get_properties(DBusConnection *conn,
> + 					DBusMessage *msg, void *data)
> + {
> + 	struct xmm7xxx_euicc *euicc =3D data;
> + 	DBusMessage *reply;
> + 	DBusMessageIter iter;
> + 	DBusMessageIter dict;
> + 	const char *eid =3D NULL;
> +
> + 	reply =3D dbus_message_new_method_return(msg);
> + 	if (reply =3D=3D NULL)
> + 		return NULL;
> +
> + 	dbus_message_iter_init_append(reply, &iter);
> +
> + 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> + 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
> + 					&dict);
> +
> + 	eid =3D euicc->eid;
> + 	ofono_dbus_dict_append(&dict, "EID", DBUS_TYPE_STRING, &eid);
> +
> + 	dbus_message_iter_close_container(&iter, &dict);
> +
> + 	return reply;
> + }
> +
> + static DBusMessage *euicc_transmit_pdu(DBusConnection *conn,
> + 					DBusMessage *msg, void *data);
> +
> + static DBusMessage *euicc_select_isdr_req(DBusConnection *conn,
> + 					DBusMessage *msg, void *data);
> +
> + static DBusMessage *euicc_release_isdr_req(DBusConnection *conn,
> + 					DBusMessage *msg, void *data);

In general, forward declarations of static functions should be avoided.  Se=
e =

item M17 in doc/coding-style.txt The only exception is if a circular depend=
ency =

exists.  Can these forward-delcarations be gotten rid of by reorganizing th=
e code?

> +
> + static const GDBusMethodTable euicc_methods[] =3D {
> + 	{ GDBUS_ASYNC_METHOD("TransmitLpaApdu",
> + 			GDBUS_ARGS({ "pdu", "ay" }),
> + 			GDBUS_ARGS({ "pdu", "ay" }),
> + 			euicc_transmit_pdu) },
> + 	{ GDBUS_ASYNC_METHOD("SelectISDR",
> + 			NULL, NULL, euicc_select_isdr_req) },
> + 	{ GDBUS_ASYNC_METHOD("ReleaseISDR",
> + 			NULL, NULL, euicc_release_isdr_req) },
> + 	{ GDBUS_ASYNC_METHOD("GetProperties",
> + 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
> + 			euicc_get_properties) },
> + 	{ }
> + };
> +
> + static const GDBusSignalTable euicc_signals[] =3D {
> + 	{ GDBUS_SIGNAL("PropertyChanged",
> + 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
> + 	{ }
> + };
> +
> + static void euicc_register(struct xmm7xxx_euicc *euicc)
> + {
> + 	DBusConnection *conn =3D ofono_dbus_get_connection();
> + 	const char *path =3D ofono_modem_get_path(euicc->modem);
> +
> + 	DBG("");
> + 	if (!g_dbus_register_interface(conn, path, OFONO_EUICC_LPA_INTERFACE,
> + 					euicc_methods,
> + 					euicc_signals,
> + 					NULL, euicc, euicc_cleanup)) {
> + 		ofono_error("Could not register %s interface under %s",
> + 					OFONO_EUICC_LPA_INTERFACE, path);
> + 		return;
> + 	}
> +
> + 	ofono_modem_add_interface(euicc->modem, OFONO_EUICC_LPA_INTERFACE);
> +
> + 	euicc->is_registered =3D TRUE;
> +
> + 	ofono_dbus_signal_property_changed(conn, path,
> + 			OFONO_EUICC_LPA_INTERFACE, "EID",
> + 			DBUS_TYPE_STRING, &euicc->eid);
> + }
> +
> + static void euicc_send_cmd_cb(gboolean ok, GAtResult *result,
> + 					gpointer user_data)
> + {
> + 	struct xmm7xxx_euicc *euicc =3D user_data;
> + 	GAtResultIter iter;
> + 	int length;
> + 	const char *resp;
> +
> + 	DBG("ok %d", ok);
> +
> + 	if (!ok) {
> + 		g_free(euicc->command);
> +
> + 		if (!euicc->is_registered) {
> + 			g_free(euicc->eid);
> + 			g_free(euicc);
> + 		}
> +
> + 		return;
> + 	}
> +
> + 	DBG("Success");
> + 	g_at_result_iter_init(&iter, result);
> + 	DBG("Iter init");
> +	if (!g_at_result_iter_next(&iter, "+CGLA:"))
> + 		return;
> + 	DBG("CGLA");
> + 	if (!g_at_result_iter_next_number(&iter, &length))
> + 		return;
> +
> + 	DBG("length =3D %d", length);
> +
> + 	if (!g_at_result_iter_next_string(&iter, &resp))
> + 		return;
> +
> + 	DBG("resp =3D %s", resp);
> +
> + 	if (!euicc->is_registered) {
> + 		g_free(euicc->eid);
> + 		euicc->eid =3D g_strdup(resp+10);
> +
> + 		euicc_release_isdr(euicc);
> +
> + 		/* eid is present register interface*/
> + 		euicc_register(euicc);
> + 	}
> +
> + 	DBG("pending =3D %p", euicc->pending);
> +
> + 	if (euicc->pending)
> + 		euicc_pending_reply(euicc, resp);
> + }
> +
> + static void euicc_send_cmd(struct xmm7xxx_euicc *euicc)
> + {
> + 	char *buff =3D g_new0(char, euicc->length + 20);
> +
> + 	sprintf(buff, "AT+CGLA=3D%u,%u,\"%s\"",
> + 		euicc->channel, euicc->length, euicc->command);
> +
> + 	g_at_chat_send(euicc->chat, buff, cgla_prefix,
> + 			euicc_send_cmd_cb, euicc, NULL);
> +
> + 	g_free(buff);
> + }
> +
> + static void euicc_select_isdr_cb(gboolean ok, GAtResult *result,
> + 					gpointer user_data)
> + {
> + 	struct xmm7xxx_euicc *euicc =3D user_data;
> + 	DBusConnection *conn =3D ofono_dbus_get_connection();
> + 	GAtResultIter iter;
> + 	DBusMessage *reply =3D NULL;
> +
> + 	DBG("ok %d", ok);
> +
> + 	if (!ok) {
> + 		g_free (euicc->command);
> +
> + 		if (!euicc->is_registered) {
> + 			g_free(euicc->eid);
> + 			g_free(euicc);
> + 		}
> +
> + 		return;
> + 	}
> +
> + 	g_at_result_iter_init(&iter, result);
> +
> + 	if (!g_at_result_iter_next(&iter, "+CCHO:"))
> +		return;
> +
> + 	g_at_result_iter_next_number(&iter, &euicc->channel);
> +
> + 	if(!euicc->is_registered)
> + 		euicc_send_cmd(euicc);
> +
> + 	if (euicc->pending) {
> + 		reply =3D dbus_message_new_method_return(euicc->pending);
> + 		if (reply =3D=3D NULL)
> + 			return;
> +
> + 		if (dbus_connection_send(conn, reply, NULL) =3D=3D FALSE)
> + 			return;
> +
> + 		dbus_message_unref(reply);
> + 		dbus_message_unref(euicc->pending);
> + 		euicc->pending =3D NULL;
> + 	}
> + }
> +
> + static void euicc_select_isdr(struct xmm7xxx_euicc *euicc)
> + {
> + 	char buff[50];
> +
> + 	snprintf(buff, sizeof(buff), "AT+CCHO=3D\"%s\"", EUICC_ISDR_AID);
> +
> + 	g_at_chat_send(euicc->chat, buff, ccho_prefix,
> + 			euicc_select_isdr_cb, euicc, NULL);
> + }
> +
> + static DBusMessage *euicc_transmit_pdu(DBusConnection *conn,
> + 					DBusMessage *msg, void *data)
> + {
> + 	struct xmm7xxx_euicc *euicc =3D data;
> + 	DBusMessageIter iter, array;
> + 	const unsigned char *command;
> + 	int length;
> +
> + 	DBG("");
> + 	if (euicc->pending)
> + 		return __ofono_error_busy(msg);
> +
> + 	if (!dbus_message_iter_init(msg, &iter))
> + 		return __ofono_error_invalid_args(msg);
> +
> + 	dbus_message_iter_recurse(&iter, &array);
> + 	dbus_message_iter_get_fixed_array(&array, &command, &length);

You should be checking the return values of these functions, as they can fa=
il. =

Remember, you're running as root on the system and any invalid input can le=
ad to =

the system being compromised.

Also, should you checking the maximum size of the PDU being sent?

> +
> + 	g_free(euicc->command);
> + 	euicc->command =3D euiccCmdBytesToHexString(command, length,
> + 							&euicc->length);

Why do you store the PDU in euicc->command?  It would seem you can generate=
 the =

resulting CGLA command here and avoid storing the pdu completely.  i.e. =

something like:

cgla_buf =3D l_new(char, length + 20);
pdu_str =3D l_util_hexstring(command, length);
sprintf(cgla_buf, "AT+CGLA=3D%u,%u,\"%s\"",
		euicc->channel, length, pdu_str);

l_free(pdu_str);
l_free(cgla_buf);

This might make management of euicc->command much easier.

> +
> + 	euicc->pending =3D dbus_message_ref(msg);
> +
> + 	if(euicc->channel < 0)
> + 		return __ofono_error_not_available(msg);
> +
> + 	euicc_send_cmd(euicc);
> +
> + 	return NULL;
> + }
> +
> + static DBusMessage *euicc_select_isdr_req(DBusConnection *conn,
> + 					DBusMessage *msg, void *data)
> + {
> + 	struct xmm7xxx_euicc *euicc =3D data;
> +
> + 	DBG("");
> + 	if (euicc->pending)
> + 		return __ofono_error_busy(msg);
> +
> + 	euicc_select_isdr(euicc);
> +
> + 	euicc->pending =3D dbus_message_ref(msg);
> +
> + 	return NULL;
> + }
> +
> + static DBusMessage *euicc_release_isdr_req(DBusConnection *conn,
> + 					DBusMessage *msg, void *data)
> + {
> + 	struct xmm7xxx_euicc *euicc =3D data;
> +
> + 	DBG("");
> + 	if (euicc->pending)
> + 		return __ofono_error_busy(msg);
> +
> + 	euicc_release_isdr(euicc);
> +
> +         return dbus_message_new_method_return(msg);
> + }
> +
> + static void euicc_update_eid(struct xmm7xxx_euicc *euicc)
> + {
> + 	g_free(euicc->command);
> + 	euicc->command =3D g_strdup(EUICC_EID_CMD);
> + 	euicc->length =3D sizeof(EUICC_EID_CMD) - 1;

What is actually the purpose of euicc->command in this context?

> +
> + 	euicc_select_isdr(euicc);
> + }

This function is called only once, so I'd just put this in-line in the call=
er below.

> +
> + static void xmm_euicc_enable(struct ofono_modem *modem, void *data)
> + {
> + 	struct xmm7xxx_euicc *euicc =3D g_new0(struct xmm7xxx_euicc, 1);
> +
> + 	DBG("euicc enable");
> +
> + 	euicc->chat =3D data;
> + 	euicc->modem =3D modem;
> + 	euicc->eid =3D g_strdup("INVALID");
> + 	euicc->channel =3D -1;
> + 	euicc->command =3D NULL;
> + 	euicc->pending =3D NULL;
> + 	euicc->is_registered =3D FALSE;
> +
> + 	euicc_update_eid(euicc);
> + }
> +
> + static void xmm_euicc_disable(struct ofono_modem *modem)
> + {
> + 	DBusConnection *conn =3D ofono_dbus_get_connection();
> + 	const char *path =3D ofono_modem_get_path(modem);
> +
> + 	if (g_dbus_unregister_interface(conn, path,
> + 					OFONO_EUICC_LPA_INTERFACE))
> + 		ofono_modem_remove_interface(modem,
> + 						OFONO_EUICC_LPA_INTERFACE);
> + }
> + /* eUICC Implementation Ends */
> +
>   /* Coex Implementation */
>   enum wlan_bw {
>   	WLAN_BW_UNSUPPORTED =3D -1,
> @@ -1008,6 +1432,9 @@ static void switch_sim_state_status(struct ofono_mo=
dem *modem, int status)
>   		}
>   =

>   		break;
> +	case 18:
> +		data->enable_euicc=3DTRUE;
> +        break;
>   	default:
>   		ofono_warn("Unknown SIM state %d received", status);
>   		break;
> @@ -1181,6 +1608,7 @@ static int xmm7xxx_disable(struct ofono_modem *mode=
m)
>   		data->netreg_watch =3D 0;
>   	}
>   =

> +    xmm_euicc_disable(modem);
>   	return -EINPROGRESS;
>   }
>   =

> @@ -1193,15 +1621,25 @@ static void xmm7xxx_pre_sim(struct ofono_modem *m=
odem)
>   	ofono_devinfo_create(modem, OFONO_VENDOR_IFX, "atmodem", data->chat);
>   	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_XMM, "atmodem",
>   					data->chat);
> +	xmm_euicc_enable(modem, data->chat);
> +    ofono_stk_create(modem, 0, "atmodem", data->chat);
> +	=

>   }
>   =

>   static void set_online_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
>   {
>   	struct cb_data *cbd =3D user_data;
>   	ofono_modem_online_cb_t cb =3D cbd->cb;
> +    char * strng =3D cbd->cb;
>   	struct ofono_error error;
> -
> +    struct ofono_modem *modem =3D cbd->data;
> +    struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
>   	decode_at_error(&error, g_at_result_final_response(result));
> +    if(data->enable_euicc=3D=3DTRUE && data->stk_enable=3D=3DTRUE ){
> +	  g_at_chat_send(data->chat, "AT+CFUN=3D16", none_prefix,
> +						NULL, NULL, NULL);
> +	}
> +	=


Looks like you're resetting the SIM here.  Are you sure you want to do this =

every time the user goes out of Airplane mode?

>   	cb(&error, cbd->data);
>   }
>   =

> @@ -1211,8 +1649,13 @@ static void xmm7xxx_set_online(struct ofono_modem =
*modem, ofono_bool_t online,
>   	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
>   	struct cb_data *cbd =3D cb_data_new(cb, user_data);
>   	char const *command =3D online ? "AT+CFUN=3D1" : "AT+CFUN=3D4";
> +    data->stk_enable=3DFALSE;
>   =

>   	DBG("modem %p %s", modem, online ? "online" : "offline");
> +    if(online){
> +        data->stk_enable=3DTRUE;
> +		=

> +	 }
>   =


indentation and coding style is all wrong here

>   	if (g_at_chat_send(data->chat, command, none_prefix,
>   					set_online_cb, cbd, g_free) > 0)
> =


Regards,
-Denis
--===============5942709280593270463==--

