Content-Type: multipart/mixed; boundary="===============8146738067670339416=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/9] Add SimToolkit and SimApplicationAgent interfaces.
Date: Fri, 02 Jul 2010 12:21:57 -0500
Message-ID: <4C2E2035.6050305@gmail.com>
In-Reply-To: <1277806448-5322-6-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8146738067670339416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 06/29/2010 05:14 AM, Andrzej Zaborowski wrote:
> The interface is as outlined in
> http://lists.ofono.org/pipermail/ofono/2010-June/003040.html
> This patch adds a skeleton that command implementations will use.
> ---
>  include/dbus.h |    2 +
>  src/stk.c      |  468 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-

You might still want to include the dbus api document for easier
cross-reference and I'd still prefer the dbus.h change in a separate patch.

> @@ -34,17 +34,37 @@
>  =

>  #include "ofono.h"
>  =

> +#include "common.h"
>  #include "smsutil.h"
>  #include "stkutil.h"
>  =

>  static GSList *g_drivers =3D NULL;
>  =

> +struct stk_app_agent {
> +	char *path;
> +	char *bus;
> +	guint watch;
> +	DBusMessage *msg;
> +	DBusPendingCall *call;
> +};
> +
> +enum stk_agent_state {
> +	STK_AGENT_IDLE =3D 0,
> +};
> +
>  struct ofono_stk {
>  	const struct ofono_stk_driver *driver;
>  	void *driver_data;
>  	struct ofono_atom *atom;
>  	struct stk_command *pending_cmd;
> -	void (*cancel_cmd)(struct ofono_stk *stk);
> +	struct stk_app_agent *app_agent;
> +	enum stk_agent_state app_agent_state;
> +	int timeout; /* Manufacturer defined timeout */
> +	int custom_timeout; /* Command defined, overrides default */
> +	guint cmd_timeout;
> +
> +	void (*cmd_send)(struct ofono_stk *stk, DBusMessage *call);
> +	void (*cmd_cb)(struct ofono_stk *stk, DBusMessage *reply);
>  =

>  	gboolean envelope_q_busy;
>  	GQueue *envelope_q;
> @@ -59,6 +79,10 @@ struct envelope_op {
>  =

>  #define ENVELOPE_RETRIES_DEFAULT 5
>  =

> +#define OFONO_NAVIGATION_PREFIX OFONO_SERVICE ".Navigation."
> +#define OFONO_NAVIGATION_GOBACK OFONO_NAVIGATION_PREFIX "Back"
> +#define OFONO_NAVIGATION_TERMINATED OFONO_NAVIGATION_PREFIX "Terminated"
> +
>  static void envelope_queue_run(struct ofono_stk *stk);
>  =

>  static int stk_respond(struct ofono_stk *stk, struct stk_response *rsp,
> @@ -201,7 +225,8 @@ static void stk_command_cb(const struct ofono_error *=
error,
>  	stk->pending_cmd =3D NULL;
>  =

>  	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		ofono_error("TERMINAL RESPONSE to a UICC command failed");
> +		ofono_error("TERMINAL RESPONSE to a UICC command failed: %s",
> +				telephony_error_to_str(error));

This really belongs in a separate patch.

>  		/* "The ME may retry to deliver the same Cell Broadcast
>  		 * page." */
>  		return;
> @@ -210,14 +235,392 @@ static void stk_command_cb(const struct ofono_erro=
r *error,
>  	DBG("TERMINAL RESPONSE to a command reported no errors");
>  }
>  =

> -void ofono_stk_proactive_command_cancel(struct ofono_stk *stk)
> +static void app_agent_request_end(struct ofono_stk *stk)
>  {
> -	if (!stk->pending_cmd)
> +	stk->cmd_send =3D NULL;
> +	stk->cmd_cb =3D NULL;
> +
> +	if (stk->cmd_timeout) {
> +		g_source_remove(stk->cmd_timeout);
> +		stk->cmd_timeout =3D 0;
> +	}
> +}
> +
> +static void app_agent_request_send_cancel(struct stk_app_agent *agent)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	DBusMessage *message;
> +
> +	if (!agent->call)
> +		return;
> +
> +	dbus_message_unref(agent->msg);
> +	agent->msg =3D NULL;
> +
> +	dbus_pending_call_cancel(agent->call);
> +	dbus_pending_call_unref(agent->call);
> +	agent->call =3D NULL;
> +
> +	message =3D dbus_message_new_method_call(agent->bus, agent->path,
> +						OFONO_SIM_APP_INTERFACE,
> +						"Cancel");
> +	if (message =3D=3D NULL)
> +		return;
> +
> +	dbus_message_set_no_reply(message, TRUE);
> +
> +	g_dbus_send_message(conn, message);
> +}
> +
> +static void app_agent_request_cancel(struct ofono_stk *stk)
> +{
> +	struct stk_app_agent *agent =3D stk->app_agent;
> +	void (*cb)(struct ofono_stk *stk, DBusMessage *reply) =3D stk->cmd_cb;
> +
> +	app_agent_request_end(stk);
> +	if (cb)
> +		cb(stk, NULL);
> +
> +	stk->app_agent_state =3D STK_AGENT_IDLE;
> +
> +	if (!agent)
> +		return;
> +
> +	app_agent_request_send_cancel(agent);
> +}
> +
> +static gboolean app_agent_request_timeout(gpointer user_data)
> +{
> +	struct ofono_stk *stk =3D user_data;
> +
> +	stk->cmd_timeout =3D 0;
> +	app_agent_request_cancel(stk);
> +
> +	return FALSE;
> +}
> +
> +static void app_agent_request_reply_handle(DBusPendingCall *call, void *=
data)
> +{
> +	struct ofono_stk *stk =3D data;
> +	void (*cb)(struct ofono_stk *stk, DBusMessage *reply) =3D stk->cmd_cb;
> +	DBusError err;
> +	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
> +
> +	dbus_error_init(&err);
> +	if (dbus_set_error_from_message(&err, reply)) {
> +		ofono_error("SimAppAgent %s replied with error %s, %s",
> +				stk->app_agent ? stk->app_agent->path :
> +				"(destroyed)", err.name, err.message);
> +
> +		if (g_str_equal(DBUS_ERROR_UNKNOWN_METHOD, err.name) ||
> +				g_str_equal(DBUS_ERROR_NO_REPLY, err.name))
> +			goto err_out;
> +
> +		if (g_str_has_prefix(err.name, OFONO_NAVIGATION_PREFIX)) {
> +			app_agent_request_end(stk);
> +
> +			cb(stk, reply);
> +			stk->app_agent_state =3D STK_AGENT_IDLE;
> +
> +			goto err_out;
> +		}
> +
> +		app_agent_request_end(stk);
> +
> +		cb(stk, NULL);
> +		stk->app_agent_state =3D STK_AGENT_IDLE;
> +
> +err_out:
> +		dbus_error_free(&err);
> +		goto out;
> +	}
> +
> +	app_agent_request_end(stk);
> +
> +	cb(stk, reply);
> +	stk->app_agent_state =3D STK_AGENT_IDLE;
> +
> +out:
> +	dbus_message_unref(reply);
> +
> +	if (!stk->app_agent)
>  		return;
>  =

> -	stk->cancel_cmd(stk);
> +	dbus_message_unref(stk->app_agent->msg);
> +	stk->app_agent->msg =3D NULL;
> +
> +	dbus_pending_call_cancel(stk->app_agent->call);
> +	dbus_pending_call_unref(stk->app_agent->call);
> +	stk->app_agent->call =3D NULL;
>  }
>  =

> +static gboolean app_agent_request_send(struct ofono_stk *stk,
> +					struct stk_app_agent *agent)
> +{
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +
> +	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
> +							OFONO_SIM_APP_INTERFACE,
> +							"Cancel");
> +	if (agent->msg =3D=3D NULL) {
> +		ofono_error("Couldn't make a DBusMessage");
> +		return FALSE;
> +	}
> +
> +	stk->cmd_send(stk, agent->msg);
> +
> +	if (dbus_connection_send_with_reply(conn,
> +				agent->msg, &agent->call, INT_MAX) =3D=3D FALSE ||
> +			agent->call =3D=3D NULL) {
> +		dbus_message_unref(agent->msg);
> +		agent->msg =3D NULL;
> +
> +		ofono_error("Couldn't send a method call");
> +		return FALSE;
> +	}
> +
> +	dbus_pending_call_set_notify(agent->call,
> +					app_agent_request_reply_handle,
> +					stk, NULL);
> +
> +	return TRUE;
> +}
> +
> +static void app_agent_request_start(struct ofono_stk *stk,
> +					void (*send)(struct ofono_stk *stk,
> +							DBusMessage *call),
> +					void (*cb)(struct ofono_stk *stk,
> +							DBusMessage *reply),
> +					enum stk_agent_state state)
> +{
> +	int timeout =3D 0;
> +
> +	if (stk->app_agent_state !=3D STK_AGENT_IDLE)
> +		app_agent_request_cancel(stk);
> +
> +	stk->cmd_send =3D send;
> +	stk->cmd_cb =3D cb;
> +
> +	if (stk->app_agent)
> +		app_agent_request_send(stk, stk->app_agent);
> +
> +	stk->app_agent_state =3D state;
> +
> +	/* Use the timeout value specified in the command, if any.  */
> +	if (stk->custom_timeout > 0)
> +		timeout =3D stk->custom_timeout;
> +	else if (stk->custom_timeout =3D=3D 0)
> +		timeout =3D stk->timeout * 1000;
> +
> +	if (!timeout)
> +		return;
> +
> +	stk->cmd_timeout =3D g_timeout_add(timeout, app_agent_request_timeout,
> +						stk);
> +}
> +

So to summarize here:
	1. If there's no agent, we start the command anyway
	2. When the agent arrives, we send it the command to handle
	3. If the agent goes away, we don't cancel the command
	4. If the agent is unregistered, we send a cancel but don't cancel the
command

So it seems to me with the exception of Setup Menu and Idle Mode Text we
should simply reject the Proactive Command outright if there is no Agent
registered.

This will prevent weird situations where a proactive command is pending
for Timeout - 1 seconds, an agent is registered, we send the agent the
command and 1 second later the User gets booted out.  It also seems to
make the implementation easier...

I'm also in favor of moving
> +	enum stk_agent_state app_agent_state;
> +	int timeout; /* Manufacturer defined timeout */
> +	int custom_timeout; /* Command defined, overrides default */
> +	guint cmd_timeout;
> +
> +	void (*cmd_send)(struct ofono_stk *stk, DBusMessage *call);
> +	void (*cmd_cb)(struct ofono_stk *stk, DBusMessage *reply);

to the stk_app_agent structure instead of the main structure.  If the
agent isn't registered and we reject everything except idle mode text /
setup menu, then these attributes are not really necessary until the
agent exists.

<snip>

> +
> +static struct stk_app_agent *app_agent_create(struct ofono_stk *stk,
> +						const char *path,
> +						const char *sender)
> +{
> +	struct stk_app_agent *agent =3D g_try_new0(struct stk_app_agent, 1);
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +
> +	if (!agent)
> +		return NULL;
> +
> +	agent->path =3D g_strdup(path);
> +	agent->bus =3D g_strdup(sender);
> +
> +	agent->watch =3D g_dbus_add_disconnect_watch(conn, sender,
> +							app_agent_disconnect_cb,
> +							stk, NULL);
> +
> +	if (stk->app_agent_state !=3D STK_AGENT_IDLE)
> +		app_agent_request_send(stk, agent);
> +

This looks a bit dangerous, you're sending a request to the agent before
it is registered.  Please be nice and perform the RegisterAgent method
return first, and then send the request.

> +	return agent;
> +}

<snip>

> +
> +static DBusMessage *stk_set_property(DBusConnection *conn,
> +					DBusMessage *msg, void *data)
> +{
> +	struct ofono_stk *stk =3D data;
> +	const char *path =3D __ofono_atom_get_path(stk->atom);
> +	DBusMessageIter iter;
> +	DBusMessageIter var;
> +	const char *property;
> +	dbus_uint16_t timeout;
> +
> +	if (!dbus_message_iter_init(msg, &iter))
> +		return __ofono_error_invalid_args(msg);
> +
> +	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
> +		return __ofono_error_invalid_args(msg);
> +
> +	dbus_message_iter_get_basic(&iter, &property);
> +	if (!dbus_message_iter_next(&iter))
> +		return __ofono_error_invalid_args(msg);
> +
> +	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
> +		return __ofono_error_invalid_args(msg);
> +
> +	dbus_message_iter_recurse(&iter, &var);
> +
> +	if (!strcmp(property, "Timeout")) {
> +		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_UINT16)
> +			return __ofono_error_invalid_args(msg);
> +
> +		dbus_message_iter_get_basic(&var, &timeout);
> +		if (dbus_message_iter_next(&iter))
> +			return __ofono_error_invalid_args(msg);
> +
> +		stk->timeout =3D timeout;
> +
> +		if (stk->cmd_timeout && stk->custom_timeout =3D=3D 0) {
> +			g_source_remove(stk->cmd_timeout);
> +			stk->cmd_timeout =3D g_timeout_add_seconds(stk->timeout,
> +						app_agent_request_timeout, stk);
> +		}

This doesn't seem right to me, what if we have just 1 second left on our
timeout and the Timeout property is set?  We end up resetting the
timeout completely.  What do you think of simply using the new value for
all subsequent requests?

I actually question the need for this attribute, who's going to actually
set it?  Let us default to some reasonable value and add a SetProperty
for this later if required...

> +
> +		ofono_dbus_signal_property_changed(conn, path,
> +						OFONO_SIM_APP_INTERFACE,
> +						"Timeout",
> +						DBUS_TYPE_UINT16, &timeout);
> +
> +		return dbus_message_new_method_return(msg);
> +	}
> +
> +	return __ofono_error_invalid_args(msg);
> +}
> +

<snip>

> +static DBusMessage *stk_unregister_agent(DBusConnection *conn,
> +						DBusMessage *msg, void *data)
> +{
> +	struct ofono_stk *stk =3D data;
> +	const char *agent_path;
> +
> +	if (dbus_message_get_args(msg, NULL,
> +					DBUS_TYPE_OBJECT_PATH, &agent_path,
> +					DBUS_TYPE_INVALID) =3D=3D FALSE)
> +		return __ofono_error_invalid_args(msg);
> +
> +	if (!stk->app_agent || strcmp(stk->app_agent->path, agent_path))
> +		return __ofono_error_failed(msg);
> +

One other thing to keep in mind here is that only the sender who
registered the agent should be able to unregister it.  This prevents
some random app from messing with the system.  However, this can be
added later if leaving this check out helps in testing in the short term.

> +	app_agent_remove(stk->app_agent);
> +	stk->app_agent =3D NULL;
> +
> +	return dbus_message_new_method_return(msg);
> +}
> +

<snip>

>  static gboolean handle_command_more_time(const struct stk_command *cmd,
>  						struct stk_response *rsp,
>  						struct ofono_stk *stk)
> @@ -227,6 +630,14 @@ static gboolean handle_command_more_time(const struc=
t stk_command *cmd,
>  	return TRUE;
>  }
>  =

> +void ofono_stk_proactive_command_cancel(struct ofono_stk *stk)
> +{
> +	if (!stk->pending_cmd)
> +		return;
> +
> +	stk->cmd_cb(stk, NULL);
> +}
> +
>  void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
>  					int length, const unsigned char *pdu)
>  {
> @@ -236,6 +647,16 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
>  	int i, err;
>  	gboolean respond =3D TRUE;
>  =

> +	/*
> +	 * Depending on the hardware we may have received a new
> +	 * command before we managed to send a TERMINAL RESPONSE to
> +	 * the previous one.  3GPP says in the current revision only
> +	 * one command can be executing at any time, so assume that
> +	 * the previous one is being cancelled and the card just
> +	 * expects a response to the new one.
> +	 */
> +	ofono_stk_proactive_command_cancel(stk);
> +

This really belongs in a separate patch

>  	buf =3D g_try_malloc(length * 2 + 1);
>  	if (!buf)
>  		return;
> @@ -254,6 +675,8 @@ void ofono_stk_proactive_command_notify(struct ofono_=
stk *stk,
>  		goto done;
>  	}
>  =

> +	stk->custom_timeout =3D 0; /* Use the default timeout value */
> +

The custom timeout handling is not used by this patch, I'd really prefer
it to be bundled with the first occurence where it is used or in a
separate patch right before where it is used with a commit description
stating the intent.

>  	ofono_debug("Proactive command PDU: %s", buf);
>  =

>  	memset(&rsp, 0, sizeof(rsp));

<snip>

Regards,
-Denis

--===============8146738067670339416==--

