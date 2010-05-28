Content-Type: multipart/mixed; boundary="===============1062722970213754742=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 04/11] Changes for SMS statur report.
Date: Fri, 28 May 2010 12:12:51 -0500
Message-ID: <201005281212.51760.denkenz@gmail.com>
In-Reply-To: <1274957690-4893-4-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1062722970213754742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> From: Pasi Miettinen <pasi.miettinen@ixonos.com>
> =

> ---
>  include/sms.h |    2 +-
>  src/sms.c     |  124
>  ++++++++++++++++++++++++++++++++++++++++++++++++++++++--- 2 files =

changed,
>  119 insertions(+), 7 deletions(-)
> =

> diff --git a/include/sms.h b/include/sms.h
> index daaec37..c007675 100644
> --- a/include/sms.h
> +++ b/include/sms.h
> @@ -54,7 +54,7 @@ struct ofono_sms_driver {
> =

>  void ofono_sms_deliver_notify(struct ofono_sms *sms, unsigned char *pdu,
>  				int len, int tpdu_len);
> -void ofono_sms_status_notify(struct ofono_sms *sms, unsigned char *pdu,
> +void ofono_sms_status_report_notify(struct ofono_sms *sms, unsigned char
>  *pdu, int len, int tpdu_len);

Please leave the rename out for now.

> =

>  int ofono_sms_driver_register(const struct ofono_sms_driver *d);
> diff --git a/src/sms.c b/src/sms.c
> index 855bef8..63e0190 100644
> --- a/src/sms.c
> +++ b/src/sms.c
> @@ -459,9 +459,10 @@ static GDBusMethodTable sms_manager_methods[] =3D {
>  };
> =

>  static GDBusSignalTable sms_manager_signals[] =3D {
> -	{ "PropertyChanged",	"sv"		},
> -	{ "IncomingMessage",	"sa{sv}"	},
> -	{ "ImmediateMessage",	"sa{sv}"	},
> +	{ "PropertyChanged",		"sv"		},
> +	{ "IncomingMessage",		"sa{sv}"	},
> +	{ "ImmediateMessage",		"sa{sv}"	},
> +	{ "IncomingStatusReport",	"{sv}"		},

Your patch does too much here.  If you want to reformat this table, send a =

separate patch please.  The current patch should only add the new entry.

>  	{ }
>  };
> =

> @@ -471,6 +472,7 @@ static void dispatch_app_datagram(struct ofono_sms
>  *sms, int dst, int src, DBG("Got app datagram for dst port: %d, src port:
>  %d",
>  			dst, src);
>  	DBG("Contents-Len: %ld", len);
> +	//DBG("buf: %s", buf);

Submissions should never contain commented-out code, you either need it or =
you =

don't.

>  }
> =

>  static void dispatch_text_message(struct ofono_sms *sms,
> @@ -539,6 +541,74 @@ static void dispatch_text_message(struct ofono_sms
>  *sms, }
>  }
> =

> +static void dispatch_sms_delivery_report(struct ofono_sms *sms,
> +					const enum sms_st *st,
> +					const struct sms_address *raddr,
> +					const struct sms_scts *scts)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D __ofono_atom_get_path(sms->atom);
> +	DBusMessage *signal;
> +	DBusMessageIter iter;
> +	DBusMessageIter dict;
> +	char buf[128];
> +	const char *signal_name;
> +	time_t ts;
> +	struct tm remote;
> +	struct tm local;
> +	const char *str =3D buf;
> +
> +	if (!st){
> +		DBG("status unavailable");
> +		return;
> +	}
> +
> +	signal_name =3D "IncomingStatusReport";
> +
> +	signal =3D dbus_message_new_signal(path, OFONO_SMS_MANAGER_INTERFACE,
> +						signal_name);

This variable and assignment is not needed, simply use the string in the =

dbus_message_new_signal call.

> +
> +	if (!signal)
> +		return;
> +
> +

Two consecutive empty lines is a no-no ;)

> +	/*Start assembling dbus-message*/
> +	dbus_message_iter_init_append(signal, &iter);
> +
> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +					OFONO_PROPERTIES_ARRAY_SIGNATURE,
> +						&dict);
> +

Your signature here does not match the IncomingStatusReport signature.

> +	/*This is the time when sender sent the message,
> +	  should be delivery time?*/
> +	ts =3D sms_scts_to_time(scts, &remote);
> +	localtime_r(&ts, &local);
> +
> +	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", &local);
> +	buf[127] =3D '\0';
> +	ofono_dbus_dict_append(&dict, "LocalSentTime", DBUS_TYPE_STRING, &str);
> +
> +	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", &remote);
> +	buf[127] =3D '\0';
> +	ofono_dbus_dict_append(&dict, "SentTime", DBUS_TYPE_STRING, &str);

SentTime and LocalSentTime?

> +
> +	/*Status*/
> +	if(*st=3D=3D0x00){
> +		str =3D sms_address_to_string(raddr);
> +		ofono_dbus_dict_append(&dict, "Message was delivered to",
>  DBUS_TYPE_STRING, &str); +	}
> +	else{
> +		str =3D sms_address_to_string(raddr);
> +		ofono_dbus_dict_append(&dict, "Message was not delivered to",
>  DBUS_TYPE_STRING, &str); +	}

I suggest using simple string types, like 'delivered', 'undeliverable', etc=
.  =

Also, the status report enum has nice definitions on whether this is a fina=
l / =

non-final result, etc.  These should be handled appropriately.

> +
> +	/*dbus-message assembled*/
> +	dbus_message_iter_close_container(&iter, &dict);
> +
> +	g_dbus_send_message(conn, signal);
> +
> +}
> +
>  static void sms_dispatch(struct ofono_sms *sms, GSList *sms_list)
>  {
>  	GSList *l;
> @@ -646,6 +716,18 @@ static void sms_dispatch(struct ofono_sms *sms, GSLi=
st
>  *sms_list) }
>  }
> =

> +static void sms_status_report_dispatch(struct ofono_sms *sms, GSList
>  *sms_list) +{
> +	const struct sms *s;
> +	enum sms_charset uninitialized_var(old_charset);

What is the purpose of this variable?

> +
> +	s =3D sms_list->data;
> +	dispatch_sms_delivery_report(sms, &s->status_report.st,
> +					&s->status_report.raddr,
> +					&s->status_report.scts);
> +
> +}
> +

Not quite sure why all of this is in a separate function...

>  static void handle_deliver(struct ofono_sms *sms, const struct sms
>  *incoming) {
>  	GSList *l;
> @@ -679,6 +761,19 @@ static void handle_deliver(struct ofono_sms *sms,
>  const struct sms *incoming) g_slist_free(l);
>  }
> =

> +static void handle_sms_status_report(struct ofono_sms *sms, const struct
>  sms *incoming) +{
> +	GSList *l;
> +
> +	/*TODO:
> +	fragmented SMS delivery report? check handle_deliver()
> +	*/

I suggest that we figure this part out first actually :)

> +
> +	l =3D g_slist_append(NULL, (void *)incoming);

Casting is not required.

> +	sms_status_report_dispatch(sms, l);
> +	g_slist_free(l);
> +}
> +
>  static inline gboolean handle_mwi(struct ofono_sms *sms, struct sms *s)
>  {
>  	gboolean discard;
> @@ -696,7 +791,7 @@ void ofono_sms_deliver_notify(struct ofono_sms *sms,
>  unsigned char *pdu, {
>  	struct sms s;
>  	enum sms_class cls;
> -
> +	DBG("ofono_sms_deliver_notify");

You should use a newline to separate the variable definitions and code.  If =

statement blocks should generally be preceded and followed by an empty line.

>  	if (!sms_decode(pdu, len, FALSE, tpdu_len, &s)) {
>  		ofono_error("Unable to decode PDU");
>  		return;
> @@ -807,10 +902,27 @@ out:
>  	handle_deliver(sms, &s);
>  }
> =

> -void ofono_sms_status_notify(struct ofono_sms *sms, unsigned char *pdu,
> +void ofono_sms_status_report_notify(struct ofono_sms *sms, unsigned char
>  *pdu, int len, int tpdu_len)
>  {
> -	ofono_error("SMS Status-Report not yet handled");
> +	struct sms s;
> +	enum sms_class cls;
> +
> +	if (!sms_decode(pdu, len, FALSE, tpdu_len, &s)) {
> +		ofono_error("Unable to decode PDU");
> +		return;
> +	}
> +
> +	if (s.type !=3D SMS_TYPE_STATUS_REPORT) {
> +		ofono_error("Expecting a STATUS REPORT pdu");
> +	}
> +
> +	if (!sms_dcs_decode(s.deliver.dcs, &cls, NULL, NULL, NULL)) {
> +		ofono_error("Unknown / Reserved DCS.  Ignoring");
> +		return;
> +	}
> +
> +	handle_sms_status_report(sms, &s);
>  }
> =

>  int ofono_sms_driver_register(const struct ofono_sms_driver *d)
> =


Regards,
-Denis

--===============1062722970213754742==--

