Content-Type: multipart/mixed; boundary="===============8541274575736402962=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Added implementation for "ReportVoiceCall",
 "ReportTextMessage",
 "Release" methods and related code.Please take a look and give me feedback on
 the code quality ,
 thinks that need to be changed. Signed-off-by: Rajyalakshmi Bommaraju
 <Rajyalakshmi.Bommaraju@intel.com>
Date: Tue, 09 Nov 2010 11:19:56 -0600
Message-ID: <4CD982BC.9000102@gmail.com>
In-Reply-To: <1288826447-19225-2-git-send-email-Rajyalakshmi.Bommaraju@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8541274575736402962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11/03/2010 06:20 PM, Rajyalakshmi Bommaraju wrote:
> ---
>  Makefile.am             |    6 +
>  plugins/history.c       |  438 +++++++++++++++++++++++++++++++++++++++++=
++++
>  plugins/history_agent.c |  453 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  plugins/history_agent.h |  103 +++++++++++

You might want to separate this patch into a series of patches.  Start
with the API definition in the oFono API documentation format.  Then the
history_agent implementation.  Then the actual history plugin
implementation.

>  4 files changed, 1000 insertions(+), 0 deletions(-)
>  create mode 100755 plugins/history.c
>  create mode 100644 plugins/history_agent.c
>  create mode 100644 plugins/history_agent.h
> =

> diff --git a/Makefile.am b/Makefile.am
> index cd17fa2..530c2de 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -286,6 +286,12 @@ builtin_sources +=3D plugins/ste.c
>  =

>  builtin_modules +=3D caif
>  builtin_sources +=3D plugins/caif.c
> +
> +
> +builtin_modules +=3D history
> +builtin_sources +=3D plugins/history_agent.h
> +builtin_sources +=3D plugins/history_agent.c
> +builtin_sources +=3D plugins/history.c
>  endif
>  =

>  if MAINTAINER_MODE
> diff --git a/plugins/history.c b/plugins/history.c
> new file mode 100755
> index 0000000..f5d4ba0
> --- /dev/null
> +++ b/plugins/history.c
> @@ -0,0 +1,438 @@
> +/*
> + *
> + * oFono - Open Source Telephony
> + *
> + * Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <errno.h>
> +
> +#include "gdbus/gdbus.h"
> +#include <ofono/history.h>
> +#include "plugins/history_agent.h"
> +#include "src/common.h"
> +
> +#define HISTORY_FILE_PATH "/var/cache/ofonohistory/"
> +#define HISTORY_FILE HISTORY_FILE_PATH"ofonohistorydata"
> +#define OFONO_MANAGER_PATH "/"

Please note that this is already defined in include/dbus.h

> +#define OFONO_HISTORY_INTERFACE "com.meego.TelephonyHistory"

Please don't hijack OFONO_ prefix for private enums / defines.

> +
> +struct ofono_history {
> +	struct history_agent *current_agent;
> +	int timeout;
> +} *history;
> +
> +

Please avoid double empty lines

> +static int history_plugin_probe(struct ofono_history_context *context)
> +{
> +	DBG("History Probe for modem: %p", context->modem);
> +	return 0;
> +}
> +
> +static void history_plugin_remove(struct ofono_history_context *context)
> +{
> +	DBG("History Remove for modem: %p", context->modem);
> +}
> +
> +/**
> + * history_call_ended:
> + * ofono calls this method with the call information
> + */
> +

Remove this empty line here

> +static void history_plugin_call_ended(struct ofono_history_context *cont=
ext,
> +					const struct ofono_call *call,
> +					time_t start,
> +					time_t end)
> +{
> +	struct ofono_modem *modem;
> +	const char *path;
> +	struct history *v =3D g_try_new0(struct history, 1);

There should be an empty line after a variable declaration block.

> +	if (!v)
> +		return;
> +
> +	v->data.voice.type =3D VOICE;
> +
> +	strcpy(v->data.voice.lineid, "Unknown");
> +
> +	if (call->type !=3D 0)
> +		return;
> +
> +	DBG("Voice Call, %s", call->direction ? "Incoming" : "Outgoing");
> +	v->data.voice.type =3D call->direction;
> +
> +	if (call->clip_validity =3D=3D 0)
> +		strcpy(v->data.voice.lineid,
> +				phone_number_to_string(&call->phone_number));
> +
> +	v->data.voice.start_time =3D start;
> +	v->data.voice.end_time =3D end;
> +
> +	DBG("Call Ended on modem: %p", context->modem);
> +	modem =3D context->modem;
> +	path =3D ofono_modem_get_path(modem);
> +
> +	v->data.voice.modem_path =3D g_try_malloc0(strlen(path) + 1);
> +	if (v->data.voice.modem_path)
> +		strcpy(v->data.voice.modem_path, path);
> +
> +	if (!history) {
> +		g_free(v);
> +		return;
> +	}
> +
> +	history_agent_report_voicecall(v, history->current_agent,
> +					history->timeout);
> +}
> +
> +/**
> + * history_call_missed:
> + * ofono calls this method with the call information
> + */
> +

Remove the empty line here

> +static void history_plugin_call_missed(struct ofono_history_context *con=
text,
> +					const struct ofono_call *call,
> +					time_t when)
> +{
> +	struct ofono_modem *modem;
> +	const char *modem_path;
> +

Preferred way would be to remove the empty line here

> +	struct history *v =3D g_try_new0(struct history, 1);

and add an empty line here

> +	if (!v)
> +		return;

Empty line here, refer to rule M1 of doc/coding-style.txt

> +	v->type =3D VOICE;
> +
> +	strcpy(v->data.voice.lineid, "Unknown");
> +
> +	if (call->type !=3D 0)
> +		return;
> +
> +	v->type =3D MISSED;
> +
> +	if (call->clip_validity =3D=3D 0)
> +		strcpy(v->data.voice.lineid,
> +				phone_number_to_string(&call->phone_number));
> +
> +	v->data.voice.start_time =3D when;
> +
> +	v->data.voice.end_time =3D when;
> +
> +	DBG("Call Missed on modem: %p", context->modem);
> +	modem =3D context->modem;
> +	modem_path =3D ofono_modem_get_path(modem);
> +
> +	v->data.voice.modem_path =3D g_try_malloc0(strlen(modem_path) + 1);
> +	if (v->data.voice.modem_path)
> +		strcpy(v->data.voice.modem_path, modem_path);

Again, rule M1

> +	if (!history) {
> +		g_free(v);
> +		return;
> +	}
> +
> +	history_agent_report_voicecall(v, history->current_agent,
> +					history->timeout);
> +}
> +
> +static void history_plugin_sms_received(struct ofono_history_context *co=
ntext,
> +					const struct ofono_uuid *uuid,
> +					const char *from,
> +					const struct tm *remote,
> +					const struct tm *local,
> +					const char *text)
> +{
> +	char buf[128];
> +	struct ofono_modem *modem;
> +	const char *modem_path;
> +
> +	struct history *thistory =3D g_try_new0(struct history, 1);

And empty line here

> +	if (!thistory)
> +		return;
> +
> +	thistory->data.text.type =3D TEXT;
> +
> +	strcpy(thistory->data.text.uid, ofono_uuid_to_str(uuid));
> +
> +	strftime(buf, 127, "%a %d %b %Y %H:%M:%S %z", local);
> +	buf[127] =3D '\0';
> +	DBG("Local Sent Time: %s", buf);
> +
> +	thistory->data.text.localsenttime =3D *local;
> +
> +	strftime(buf, 127, "%a %d %b %Y %H:%M:%S %z", remote);
> +	buf[127] =3D '\0';
> +	DBG("Remote Sent Time: %s", buf);
> +	thistory->data.text.remotesenttime =3D *remote;
> +
> +	DBG("Text: %s", text);
> +
> +	thistory->data.text.message =3D (char *) g_try_malloc0(strlen(text) + 1=
);
> +	strcpy(thistory->data.text.message, text);
> +
> +	DBG("From: %s:", from);
> +	strcpy(thistory->data.text.lineid, from);
> +
> +	thistory->data.text.type =3D INCOMING;
> +
> +	thistory->data.text.status =3D OFONO_HISTORY_SMS_STATUS_SUBMITTED;
> +
> +	DBG("Incoming SMS on modem: %p", context->modem);
> +	modem =3D context->modem;
> +	modem_path =3D ofono_modem_get_path(modem);
> +
> +	thistory->data.text.modem_path =3D g_try_malloc0(strlen(modem_path) + 1=
);

Rule M1...

> +	if (thistory->data.text.modem_path)
> +		strcpy(thistory->data.text.modem_path, modem_path);
> +
> +	history_agent_report_textmessage(thistory, history->current_agent,
> +					history->timeout);
> +}
> +
> +static void history_plugin_sms_send_status(
> +					struct ofono_history_context *context,
> +					const struct ofono_uuid *uuid,
> +					time_t when,
> +					enum ofono_history_sms_status s)
> +{
> +	char buf[128];
> +	struct ofono_modem *modem;
> +	const char *modem_path;
> +
> +	struct history *thistory =3D g_try_new0(struct history, 1);

An empty line here

> +	if (!thistory)
> +		return;
> +
> +	thistory->type =3D TEXT;
> +
> +	strcpy(thistory->data.text.uid, ofono_uuid_to_str(uuid));
> +
> +	thistory->data.text.localsenttime =3D *(localtime(&when));
> +	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z",
> +			&(thistory->data.text.localsenttime));
> +	buf[127] =3D '\0';
> +	thistory->data.text.type =3D OUTGOING;
> +
> +	switch (s) {
> +	case OFONO_HISTORY_SMS_STATUS_PENDING:
> +		break;
> +	case OFONO_HISTORY_SMS_STATUS_SUBMITTED:
> +
> +		DBG("SMS %s submitted successfully", ofono_uuid_to_str(uuid));
> +		DBG("Submission Time: %s", buf);
> +
> +		thistory->data.text.status =3D
> +					OFONO_HISTORY_SMS_STATUS_SUBMITTED;
> +		break;
> +	case OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED:
> +
> +		DBG("SMS %s submitted successfully", ofono_uuid_to_str(uuid));
> +		DBG("Failure Time: %s", buf);
> +
> +		thistory->data.text.status =3D
> +					OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED;
> +		break;
> +	default:
> +		break;
> +	};
> +
> +	modem =3D context->modem;
> +	modem_path =3D ofono_modem_get_path(modem);
> +
> +	thistory->data.text.modem_path =3D g_try_malloc0(strlen(modem_path)
> +									+ 1);
> +	if (thistory->data.text.modem_path)
> +		strcpy(thistory->data.text.modem_path, modem_path);
> +
> +	history_agent_report_textmessage(thistory, history->current_agent,
> +					history->timeout);
> +}
> +
> +static void history_plugin_sms_send_pending(
> +					struct ofono_history_context *context,
> +					const struct ofono_uuid *uuid,
> +					const char *to, time_t when,
> +					const char *text)
> +{
> +	char buf[128];
> +	struct ofono_modem *modem;
> +	const char *modem_path;
> +
> +	struct history *thistory =3D g_try_new0(struct history, 1);
> +	if (!thistory)
> +		return;
> +
> +	thistory->type =3D TEXT;
> +
> +	DBG("To: %s:", to);
> +	strcpy(thistory->data.text.lineid, to);
> +
> +	DBG("SMS %s submitted successfully", ofono_uuid_to_str(uuid));
> +	strcpy(thistory->data.text.uid, ofono_uuid_to_str(uuid));
> +
> +	thistory->data.text.localsenttime =3D *(localtime(&when));
> +	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z",
> +			&(thistory->data.text.localsenttime));
> +	buf[127] =3D '\0';
> +	DBG("Local Time: %s", buf);
> +
> +	thistory->data.text.type =3D OUTGOING;
> +
> +	DBG("Text: %s", text);
> +	thistory->data.text.message =3D (char *) g_try_malloc0(strlen(text)
> +									+ 1);
> +	if (thistory->data.text.message)
> +		strcpy(thistory->data.text.message, text);
> +
> +	thistory->data.text.status =3D OFONO_HISTORY_SMS_STATUS_PENDING;
> +
> +	DBG("Sending SMS on modem: %p", context->modem);
> +	modem =3D context->modem;
> +	modem_path =3D ofono_modem_get_path(modem);
> +
> +	thistory->data.text.modem_path =3D g_try_malloc0(strlen(modem_path)
> +									+ 1);
> +	if (thistory->data.text.modem_path)
> +		strcpy(thistory->data.text.modem_path, modem_path);
> +
> +	history_agent_report_textmessage(thistory, history->current_agent,
> +					history->timeout);
> +}
> +
> +static void history_notify(gpointer user_data)
> +{
> +	struct ofono_history *ohistory =3D user_data;
> +
> +	DBG("History Agent Removed");
> +
> +	ohistory->current_agent =3D NULL;
> +}
> +
> +static DBusMessage *history_register_agent(DBusConnection *conn,
> +					DBusMessage *msg, void *data)
> +{
> +	const char *agent_path;
> +	if (dbus_message_get_args(msg, NULL,
> +					DBUS_TYPE_OBJECT_PATH, &agent_path,
> +					DBUS_TYPE_INVALID) =3D=3D FALSE)
> +		return __ofono_error_invalid_args(msg);
> +
> +	if (!__ofono_dbus_valid_object_path(agent_path))
> +		return __ofono_error_invalid_format(msg);
> +
> +	if (!history)
> +		return __ofono_error_failed(msg);
> +
> +	history->current_agent =3D history_agent_new(agent_path,
> +					dbus_message_get_sender(msg),
> +					FALSE);
> +
> +	if (!history->current_agent)
> +		return __ofono_error_failed(msg);
> +
> +	DBG("History agent created");
> +
> +	history_agent_set_removed_notify(history->current_agent,
> +					history_notify, history);
> +
> +	return dbus_message_new_method_return(msg);
> +}
> +
> +static DBusMessage *history_unregister_agent(DBusConnection *conn,
> +					DBusMessage *msg, void *data)
> +{
> +	const char *agent_path;
> +
> +	const char *agent_bus =3D dbus_message_get_sender(msg);
> +
> +	if (dbus_message_get_args(msg, NULL,
> +					DBUS_TYPE_OBJECT_PATH, &agent_path,
> +					DBUS_TYPE_INVALID) =3D=3D FALSE)
> +		return __ofono_error_invalid_args(msg);
> +
> +	if (!history->current_agent)
> +		return __ofono_error_failed(msg);
> +
> +	if (!history_agent_matches(history->current_agent, agent_path,
> +						agent_bus))
> +		return __ofono_error_failed(msg);
> +
> +	history_agent_free(history->current_agent);
> +
> +	return dbus_message_new_method_return(msg);
> +}
> +
> +static GDBusMethodTable history_methods[] =3D {
> +	{ "RegisterAgent",	"o",	"",	history_register_agent },
> +	{ "UnregisterAgent",	"o",	"",	history_unregister_agent },
> +	{ }
> +};
> +
> +static struct ofono_history_driver history_driver =3D {
> +	.name =3D "history plugin",
> +	.probe =3D history_plugin_probe,
> +	.remove =3D history_plugin_remove,
> +	.call_ended =3D history_plugin_call_ended,
> +	.call_missed =3D history_plugin_call_missed,
> +	.sms_received =3D history_plugin_sms_received,
> +	.sms_send_pending =3D history_plugin_sms_send_pending,
> +	.sms_send_status =3D history_plugin_sms_send_status
> +};
> +
> +static int history_plugin_init(void)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +
> +	if (!g_dbus_register_interface(conn,
> +					OFONO_MANAGER_PATH,
> +					OFONO_HISTORY_INTERFACE,
> +					history_methods,
> +					NULL,
> +					NULL,	/* Properties */
> +					NULL,	/* Userdata   */
> +					NULL)) {	/* Destroy func */
> +		ofono_error("Could not create %s interface",
> +					OFONO_HISTORY_INTERFACE);
> +
> +		return -EIO;
> +	}
> +
> +	history =3D g_try_new0(struct ofono_history, 1);
> +
> +	if (!history)
> +		return -EIO;
> +
> +	history->timeout =3D 600;		/* 10 minutes */
> +	return ofono_history_driver_register(&history_driver);
> +}
> +
> +static void history_plugin_exit(void)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +
> +	g_dbus_unregister_interface(conn, OFONO_MANAGER_PATH,
> +				OFONO_HISTORY_INTERFACE);
> +	if (history)
> +		g_free(history);
> +	ofono_history_driver_unregister(&history_driver);
> +}
> +
> +OFONO_PLUGIN_DEFINE(history, "History Plugin",
> +		OFONO_VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
> +		history_plugin_init, history_plugin_exit)
> diff --git a/plugins/history_agent.c b/plugins/history_agent.c
> new file mode 100644
> index 0000000..d4d55ec
> --- /dev/null
> +++ b/plugins/history_agent.c
> @@ -0,0 +1,453 @@
> +/*
> + *
> + * oFono - Open Source Telephony
> + *
> + * Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#define MODEM_STRUCT_LEN 2
> +
> +#include "plugins/history_agent.h"
> +
> +#define OFONO_HISTORY_AGENT "com.meego.TelephonyHistoryAgent"

Again, please do not hijack OFONO_ prefix for your private defines.

> +#define ERROR_PREFIX OFONO_SERVICE ".Error"
> +#define FAILED_ERROR ERROR_PREFIX ".Failed"
> +
> +enum allowed_errors {
> +	ALLOWED_ERROR_FAILED =3D 0x1
> +};
> +
> +struct history_agent {
> +	char *path;
> +	char *bus;
> +	guint disconnect_watch;
> +	ofono_bool_t remove_on_terminate;
> +	ofono_destroy_func removed_cb;
> +	void *removed_data;
> +	DBusPendingCall *call;
> +	void *user_data;

So in general this data structure is fine, however do keep in mind that
it is possible to perform only a single request at a time.  If several
history events happen simultaneously, they need to be queued / buffered
by the caller.

I don't believe your current code is handling this possibility at all.
The other obvious thing that is missing is the lack of serialization /
deserialization of this queue, or the immediate submission of the events
to the agent when it is first registered.

> +};
> +
> +void history_agent_free(struct history_agent *agent)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +
> +	if (agent->disconnect_watch) {
> +		history_agent_send_release(agent);
> +		g_dbus_remove_watch(conn, agent->disconnect_watch);
> +		agent->disconnect_watch =3D 0;
> +	}
> +
> +	if (agent->removed_cb)
> +		agent->removed_cb(agent->removed_data);
> +
> +	g_free(agent->path);
> +	g_free(agent->bus);
> +	g_free(agent);
> +}
> +
> +static void history_agent_disconnect_cb(DBusConnection *conn, void *user=
_data)
> +{
> +	DBG("Agent exited without unregister");
> +
> +	struct history_agent *agent =3D user_data;
> +
> +	agent->disconnect_watch =3D 0;
> +
> +	history_agent_free(agent);
> +}
> +
> +ofono_bool_t history_agent_matches(struct history_agent *agent,
> +					const char *path, const char *sender)
> +{
> +	return !strcmp(agent->path, path) && !strcmp(agent->bus, sender);
> +}
> +
> +struct history_agent *history_agent_new(const char *path, const char *se=
nder,
> +					ofono_bool_t remove_on_terminate)

Please note that remove_on_terminate is not really needed and should be
TRUE by default.  This was specific to stkagent and should not be
propagated elsewhere.

> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	struct history_agent *agent =3D g_try_new0(struct history_agent, 1);

En empty line here

> +	if (!agent)
> +		return NULL;
> +
> +	agent->path =3D g_strdup(path);
> +	agent->bus =3D g_strdup(sender);
> +	agent->remove_on_terminate =3D remove_on_terminate;
> +
> +	agent->disconnect_watch =3D g_dbus_add_disconnect_watch(conn, sender,
> +						history_agent_disconnect_cb,
> +						agent, NULL);
> +	return agent;
> +}
> +
> +static int check_error(struct history_agent *agent, DBusMessage *reply,
> +				int allowed_errors,
> +				enum HISTORY_AGENT_RESULT *out_result)
> +{
> +	DBusError err;
> +	int result =3D 0;
> +
> +	dbus_error_init(&err);
> +
> +	if (dbus_set_error_from_message(&err, reply) =3D=3D FALSE) {
> +		*out_result =3D HISTORY_AGENT_RESULT_OK;
> +		return 0;
> +	}
> +
> +	ofono_debug("HistoryAgent %s replied with error %s, %s",
> +			agent->path, err.name, err.message);
> +
> +	/* Timeout is always valid */
> +	if (g_str_equal(err.name, DBUS_ERROR_NO_REPLY)) {
> +		/* Send a Cancel() to the agent since its taking too long */
> +		*out_result =3D HISTORY_AGENT_RESULT_TIMEOUT;
> +		goto out;
> +	}
> +
> +	if ((allowed_errors & ALLOWED_ERROR_FAILED) &&
> +		g_str_equal(err.name, FAILED_ERROR)) {
> +		*out_result =3D HISTORY_AGENT_RESULT_FAILED;
> +		goto out;
> +	}
> +
> +	result =3D -EINVAL;
> +out:
> +	dbus_error_free(&err);
> +	return result;
> +}
> +
> +static void history_agent_send_no_reply(struct history_agent *agent,
> +					const char *method)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	DBusMessage *message;
> +
> +	message =3D dbus_message_new_method_call(agent->bus, agent->path,
> +						OFONO_HISTORY_AGENT,
> +						method);
> +
> +	if (message =3D=3D NULL)
> +		return;
> +
> +	dbus_message_set_no_reply(message, TRUE);
> +
> +	g_dbus_send_message(conn, message);
> +}
> +
> +static void history_agent_data_free(void *data)
> +{
> +	struct history *history =3D (struct history *)data;

An empty line here.

> +	if (history->type =3D=3D TEXT) {
> +		g_free(history->data.text.message);
> +		g_free(history->data.text.modem_path);
> +	} else {
> +		g_free(history->data.voice.modem_path);
> +	}

And again please see rule M1 in doc/coding-style.txt

> +	g_free(history);
> +}
> +
> +static const char *call_type_to_string(enum type tp)
> +{
> +	switch (tp) {
> +	case INCOMING:
> +		return "incoming";
> +	case OUTGOING:
> +		return "outgoing";
> +	case MISSED:
> +		return "missed";
> +	default:
> +		return "unknown";
> +	}
> +}
> +
> +static const char *status_to_string(enum ofono_history_sms_status status)
> +{
> +	switch (status) {
> +	case OFONO_HISTORY_SMS_STATUS_PENDING:
> +		return "Pending";
> +	case OFONO_HISTORY_SMS_STATUS_SUBMITTED:
> +		return "Submitted";
> +	case OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED:
> +		return "Submit Failed";
> +	case OFONO_HISTORY_SMS_STATUS_DELIVERED:
> +		return "Delivered";
> +	case OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED:
> +		return "Deliver Failed";
> +	default:
> +		return "unknown";
> +	}

In general oFono APIs use lower caps and hyphens for values.  Remember,
these are not translated.  So this should be 'pending', 'submitted',
'submit-failed', 'delivered', 'delivery-failed', or something like that.

The 'unknown' state is pretty much useless.

> +}
> +
> +static void data_delivery_cb(DBusPendingCall *call, void *data)
> +{
> +	struct history_agent *agent =3D data;
> +	enum HISTORY_AGENT_RESULT result =3D -EINVAL;
> +
> +	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
> +
> +	if (check_error(agent, reply,
> +				 ALLOWED_ERROR_FAILED,
> +				&result) =3D=3D -EINVAL) {
> +		g_print("Agent disappeared\n");
> +		/* TODO - persist  agent->user_data  */
> +		history_agent_data_free(agent->user_data);
> +	}
> +
> +	if (result =3D=3D HISTORY_AGENT_RESULT_OK) {
> +		g_print("Agent reply ok\n");
> +		history_agent_data_free(agent->user_data);
> +	}
> +
> +	if (result =3D=3D HISTORY_AGENT_RESULT_TIMEOUT) {
> +		g_print("Reply timedout\n");
> +		/* TODO - persist  agent->user_data*/
> +		history_agent_data_free(agent->user_data);
> +	}
> +}
> +
> +static char **get_modem_struct(const char *path)
> +{
> +	int i =3D 0;
> +	char **ret;
> +
> +	/* TODO - Figureout how to release this*/
> +	ret =3D g_try_new0(char *, 3);
> +	if (!ret)
> +		return NULL;
> +
> +	ret[i++] =3D g_strdup("Modem");
> +	ret[i++] =3D g_strdup(path);
> +
> +	return ret;
> +}
> +
> +static void append_texthistory_properties(struct text_history *h,
> +						DBusMessageIter *array)
> +{
> +	const char *localtm, *senttm;
> +	static char localsenttm[128], rsenttime[128];
> +	const char *phone;
> +	const char *mesg;
> +	const char *msgid;
> +	DBusMessageIter dict;
> +	char **modem_dict;
> +
> +	dbus_message_iter_open_container(array, DBUS_TYPE_ARRAY,
> +					OFONO_PROPERTIES_ARRAY_SIGNATURE,
> +					&dict);
> +
> +	strftime(localsenttm, 127, "%Y-%m-%dT%H:%M:%S%z",
> +				(&h->localsenttime));
> +	localsenttm[127] =3D '\0';
> +	localtm =3D localsenttm;
> +
> +	strftime(rsenttime, 127, "%Y-%m-%dT%H:%M:%S%z",
> +				(&h->remotesenttime));
> +	rsenttime[127] =3D '\0';
> +	senttm =3D rsenttime;
> +
> +	msgid =3D h->uid;
> +
> +	ofono_dbus_dict_append(&dict, "Uid", DBUS_TYPE_STRING, &msgid);
> +
> +	const char *type_str =3D call_type_to_string(h->type);
> +
> +	ofono_dbus_dict_append(&dict, "Type",
> +				DBUS_TYPE_STRING, &type_str);
> +
> +	const char *status_str =3D status_to_string(h->status);
> +
> +	ofono_dbus_dict_append(&dict, "Status",
> +				DBUS_TYPE_STRING, &status_str);
> +
> +	phone =3D h->lineid;
> +	ofono_dbus_dict_append(&dict, "LineIdentification", DBUS_TYPE_STRING,
> +				&phone);
> +
> +	ofono_dbus_dict_append(&dict, "LocalSentTime", DBUS_TYPE_STRING,
> +				&localtm);
> +
> +	ofono_dbus_dict_append(&dict, "SentTime", DBUS_TYPE_STRING,
> +				&senttm);
> +	mesg =3D h->message;
> +	ofono_dbus_dict_append(&dict, "Message", DBUS_TYPE_STRING,
> +				&mesg);
> +
> +	modem_dict =3D get_modem_struct(h->modem_path);
> +
> +	ofono_dbus_dict_append_dict(&dict, "Information", DBUS_TYPE_STRING,
> +					&modem_dict);
> +
> +	dbus_message_iter_close_container(array, &dict);
> +}
> +
> +static void append_voicehistory_properties(struct voice_history *h,
> +						DBusMessageIter *array)
> +{
> +	const char *sttime, *entime;
> +	static char starttime[128], endtime[128];
> +	struct tm starttm, endtm;
> +	const char *phone;
> +	char **modem_dict;
> +	DBusMessageIter dict;
> +
> +	dbus_message_iter_open_container(array, DBUS_TYPE_ARRAY,
> +					OFONO_PROPERTIES_ARRAY_SIGNATURE,
> +					&dict);
> +
> +	strftime(starttime, 127, "%Y-%m-%dT%H:%M:%S%z",
> +				localtime_r(&h->start_time, &starttm));
> +	starttime[127] =3D '\0';
> +	sttime =3D starttime;
> +
> +	strftime(endtime, 127, "%Y-%m-%dT%H:%M:%S%z",
> +				localtime_r(&h->end_time, &endtm));
> +	endtime[127] =3D '\0';
> +	entime =3D endtime;
> +
> +	ofono_dbus_dict_append(&dict, "Uid", DBUS_TYPE_UINT32, &h->uid);
> +
> +	const char *type_str =3D call_type_to_string(h->type);
> +
> +	ofono_dbus_dict_append(&dict, "Type",
> +				DBUS_TYPE_STRING, &type_str);
> +
> +	phone =3D h->lineid;
> +	ofono_dbus_dict_append(&dict, "LineIdentification", DBUS_TYPE_STRING,
> +				&phone);
> +
> +	ofono_dbus_dict_append(&dict, "StartTime", DBUS_TYPE_STRING,
> +				&sttime);
> +
> +	ofono_dbus_dict_append(&dict, "EndTime", DBUS_TYPE_STRING,
> +				&entime);
> +
> +	modem_dict =3D get_modem_struct(h->modem_path);
> +
> +	ofono_dbus_dict_append_dict(&dict, "Information", DBUS_TYPE_STRING,
> +					&modem_dict);
> +
> +	dbus_message_iter_close_container(array, &dict);
> +}
> +
> +int history_agent_report_voicecall(struct history *history,
> +				struct history_agent *agent, int timeout)
> +{
> +	if (!agent)
> +		/* TODO persist history */
> +		return -1;
> +
> +	DBusMessage *msg ;
> +	DBusMessageIter iter, array;
> +	struct voice_history *vhistory =3D &(history->data.voice);
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +
> +	msg =3D dbus_message_new_method_call(agent->bus,
> +					   agent->path,
> +						OFONO_HISTORY_AGENT,
> +						"ReportVoiceCall");
> +	if (msg =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	dbus_message_iter_init_append(msg, &iter);
> +
> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +					DBUS_TYPE_ARRAY_AS_STRING
> +					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
> +					DBUS_TYPE_STRING_AS_STRING
> +					DBUS_TYPE_VARIANT_AS_STRING
> +					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
> +					&array);
> +	append_voicehistory_properties(vhistory, &array);
> +
> +	dbus_message_iter_close_container(&iter, &array);
> +
> +	agent->user_data =3D (void *)history;
> +
> +	if (dbus_connection_send_with_reply(conn, msg, &agent->call,
> +						timeout) =3D=3D FALSE ||
> +			agent->call =3D=3D NULL)
> +		return -EIO;
> +
> +	dbus_pending_call_set_notify(agent->call, data_delivery_cb,
> +							agent, NULL);
> +	return 0;
> +}
> +
> +
> +int history_agent_report_textmessage(struct history *history,
> +				struct history_agent *agent, int timeout)
> +{
> +	if (!agent)
> +		/* TODO Persist history */
> +		return -1;
> +
> +	DBusMessage *msg ;
> +	DBusMessageIter iter, array;
> +	struct text_history *text_history =3D &(history->data.text);
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +
> +	msg =3D dbus_message_new_method_call(agent->bus,
> +					   agent->path,
> +						OFONO_HISTORY_AGENT,
> +						"ReportTextMessage");
> +	if (msg =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	dbus_message_iter_init_append(msg, &iter);
> +
> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +					DBUS_TYPE_ARRAY_AS_STRING
> +					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
> +					DBUS_TYPE_STRING_AS_STRING
> +					DBUS_TYPE_VARIANT_AS_STRING
> +					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
> +					&array);
> +	append_texthistory_properties(text_history, &array);
> +
> +	dbus_message_iter_close_container(&iter, &array);
> +
> +	agent->user_data =3D (void *)history;
> +
> +	if (dbus_connection_send_with_reply(conn, msg, &agent->call,
> +						timeout) =3D=3D FALSE ||
> +			agent->call =3D=3D NULL)
> +		return -EIO;
> +
> +	dbus_pending_call_set_notify(agent->call, data_delivery_cb,
> +							agent, NULL);
> +	return 0;
> +}
> +
> +void history_agent_send_release(struct history_agent *agent)
> +{
> +	history_agent_send_no_reply(agent, "Release");
> +}
> +
> +void history_agent_set_removed_notify(struct history_agent *agent,
> +				ofono_destroy_func destroy,
> +				void *user_data)
> +{
> +	agent->removed_cb =3D destroy;
> +	agent->removed_data =3D user_data;
> +}
> diff --git a/plugins/history_agent.h b/plugins/history_agent.h
> new file mode 100644
> index 0000000..fe7049e
> --- /dev/null
> +++ b/plugins/history_agent.h
> @@ -0,0 +1,103 @@
> +/*
> + *
> + * oFono - Open Source Telephony
> + *
> + * Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <errno.h>
> +#include <string.h>
> +
> +#include "gdbus/gdbus.h"
> +#include <ofono/dbus.h>
> +#include <ofono/history.h>
> +#include <ofono/log.h>
> +#include <ofono/types.h>
> +#include "src/ofono.h"
> +
> +#define PHONE_NUMBER_LENGTH 64
> +struct history_agent;
> +
> +enum history_type {
> +	VOICE =3D 0,
> +	TEXT
> +};
> +
> +struct voice_history {
> +	guint32 uid;
> +	guint8 type;
> +	char lineid[PHONE_NUMBER_LENGTH];
> +	time_t start_time;
> +	time_t end_time;
> +	char *modem_path;
> +};
> +
> +struct text_history {
> +	char uid[OFONO_SHA1_UUID_LEN * 2 + 1];
> +	guint8 type;
> +	guint8 status;
> +	char lineid[PHONE_NUMBER_LENGTH];
> +	struct tm localsenttime;
> +	struct tm remotesenttime;
> +	char *message;
> +	char *modem_path;
> +};
> +
> +struct history {
> +	union {
> +		struct voice_history voice;
> +		struct text_history text;
> +	} data;
> +	enum history_type type;
> +};
> +
> +enum HISTORY_AGENT_RESULT {
> +	HISTORY_AGENT_RESULT_OK,
> +	HISTORY_AGENT_RESULT_FAILED,
> +	HISTORY_AGENT_RESULT_TIMEOUT
> +};
> +
> +enum type {
> +	OUTGOING =3D 0,
> +	INCOMING,
> +	MISSED
> +};
> +
> +struct history_agent *history_agent_new(const char *path, const char *se=
nder,
> +					ofono_bool_t remove_on_terminate);
> +
> +void history_agent_free(struct history_agent *agent);
> +
> +ofono_bool_t history_agent_matches(struct history_agent *agent,
> +					const char *path, const char *sender);
> +
> +int history_agent_report_voicecall(struct history *vhistory,
> +				struct history_agent *agent, int timeout);
> +
> +int history_agent_report_textmessage(struct history *history,
> +				struct history_agent *agent, int timeout);
> +
> +void history_agent_send_release(struct history_agent *agent);
> +
> +void history_agent_set_removed_notify(struct history_agent *agent,
> +					ofono_destroy_func destroy,
> +					void *user_data);

Regards,
-Denis

--===============8541274575736402962==--

