Content-Type: multipart/mixed; boundary="===============5794057936759828372=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] voicecallmanager: Handle last number dialled DBUS call
Date: Wed, 18 Oct 2017 12:03:20 -0500
Message-ID: <6f9197ca-4bd3-f796-1fa0-034047842c04@gmail.com>
In-Reply-To: <20171018140427.16143-3-philippe.deswert@nomovok.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5794057936759828372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 10/18/2017 09:04 AM, Philippe De Swert wrote:
> Handle the new DialLast method on the voicecallmanager interface
> ---
>   src/voicecall.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 89 insertions(+)
> =

> diff --git a/src/voicecall.c b/src/voicecall.c
> index 2ff9aa15..4eeb6621 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -1595,6 +1595,94 @@ static DBusMessage *manager_dial(DBusConnection *c=
onn,
>   	return __ofono_error_failed(msg);
>   }
>   =

> +static void manager_dial_last_callback(const struct ofono_error *error, =
void *data)
> +{
> +	struct ofono_voicecall *vc =3D data;
> +	DBusMessage *reply;
> +	gboolean need_to_emit;
> +	struct voicecall *v;
> +
> +	v =3D dial_handle_result(vc, error, NULL, &need_to_emit);

dial_handle_result is a bit tricky because it handles situations where =

ATD returns immediately and then the call is notified via an unsolicited =

notification, or ATD returns first.

In the case of +BLDN, I believe HFP spec mandates that BLDN always =

returns first, which means that much of the logic in dial_handle_result =

is not applicable.  It may be better to just perform the necessary logic =

directly here.

In the current proposal, we will always generate a new call with an =

empty phone number which will (hopefully) eventually be updated.  I'm =

not so sure that this is a great approach, but I can't think of anything =

better...

> +
> +	if (v) {
> +		const char *path =3D voicecall_build_path(vc, v->call);
> +
> +		reply =3D dbus_message_new_method_return(vc->pending);
> +
> +		dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
> +						DBUS_TYPE_INVALID);
> +	} else {
> +		reply =3D __ofono_error_failed(vc->pending);
> +	}
> +
> +	__ofono_dbus_pending_reply(&vc->pending, reply);
> +
> +	if (need_to_emit)
> +		voicecalls_emit_call_added(vc, v);
> +}
> +
> +static int voicecall_dial_last(struct ofono_voicecall *vc,
> +					ofono_voicecall_cb_t cb, void *data)
> +{
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
> +
> +	if (g_slist_length(vc->call_list) >=3D MAX_VOICE_CALLS)
> +		return -EPERM;
> +
> +	if (ofono_modem_get_online(modem) =3D=3D FALSE)
> +		return -ENETDOWN;
> +
> +	if (vc->driver->dial_last =3D=3D NULL)
> +		return -ENOTSUP;
> +
> +	if (voicecalls_have_incoming(vc))
> +		return -EBUSY;
> +
> +	/* We can't have two dialing/alerting calls, reject outright */
> +	if (voicecalls_num_connecting(vc) > 0)
> +		return -EBUSY;
> +
> +	if (voicecalls_have_active(vc) && voicecalls_have_held(vc))
> +		return -EBUSY;
> +
> +	vc->driver->dial_last(vc, cb, vc);
> +
> +	return 0;
> +}
> +
> +static DBusMessage *manager_dial_last(DBusConnection *conn,
> +					DBusMessage *msg, void *data)
> +{
> +	struct ofono_voicecall *vc =3D data;
> +	int err;
> +
> +	if (vc->pending || vc->dial_req || vc->pending_em)
> +		return __ofono_error_busy(msg);
> +
> +	vc->pending =3D dbus_message_ref(msg);
> +
> +	err =3D voicecall_dial_last(vc, manager_dial_last_callback, vc);
> +
> +	if (err >=3D 0)
> +		return NULL;
> +
> +	vc->pending =3D NULL;
> +	dbus_message_unref(msg);
> +
> +	switch (err) {
> +	case -EINVAL:
> +		return __ofono_error_invalid_format(msg);
> +
> +	case -ENETDOWN:
> +		return __ofono_error_not_available(msg);
> +
> +	case -ENOTSUP:
> +		return __ofono_error_not_implemented(msg);
> +	}
> +
> +	return __ofono_error_failed(msg);
> +}
> +
>   static DBusMessage *manager_transfer(DBusConnection *conn,
>   					DBusMessage *msg, void *data)
>   {
> @@ -2151,6 +2239,7 @@ static const GDBusMethodTable manager_methods[] =3D=
 {
>   		GDBUS_ARGS({ "number", "s" }, { "hide_callerid", "s" }),
>   		GDBUS_ARGS({ "path", "o" }),
>   		manager_dial) },
> +	{ GDBUS_ASYNC_METHOD("DialLast", NULL, NULL, manager_dial_last)},
>   	{ GDBUS_ASYNC_METHOD("Transfer", NULL, NULL, manager_transfer) },
>   	{ GDBUS_ASYNC_METHOD("SwapCalls",  NULL, NULL, manager_swap_calls) },
>   	{ GDBUS_ASYNC_METHOD("ReleaseAndAnswer", NULL, NULL,
> =


Regards,
-Denis

--===============5794057936759828372==--

