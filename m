Content-Type: multipart/mixed; boundary="===============3530416528719960895=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] emulator: add call, callsetup and callheld indicators
Date: Mon, 21 Mar 2011 14:31:31 -0500
Message-ID: <4D87A793.8020509@gmail.com>
In-Reply-To: <1300464648-11074-3-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3530416528719960895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

> +static void notify_emulator_call_status(struct ofono_voicecall *vc)
> +{
> +	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
> +	int status;
> +
> +	status =3D voicecalls_have_with_status(vc, CALL_STATUS_ACTIVE) ?
> +						OFONO_EMULATOR_CALL_ACTIVE :
> +						OFONO_EMULATOR_CALL_INACTIVE;
> +	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
> +					emulator_call_status_cb,
> +					GINT_TO_POINTER(status));
> +

This looks wrong, the call indicator is not only about active calls.
See Sequence in figure 4.26 in HFP 1.5 for more details.

You really need to sit down and figure out the possible scenarios and
the sequences in which the indicators must be set.  I suggest you also
run PTS tester at a minimum to make sure the sequences sent by oFono is
what the spec expects.

Also, please google MCPC-TR-002 Version 1.5.  That document contains
many more scenarios than are present in the BT HFP 1.5 specification.

> +	if (voicecalls_have_with_status(vc, CALL_STATUS_HELD)) {
> +		if (status)
> +			status =3D OFONO_EMULATOR_CALLHELD_MULTIPLE;
> +		else
> +			status =3D OFONO_EMULATOR_CALLHELD_ON_HOLD;
> +	} else
> +		status =3D OFONO_EMULATOR_CALLHELD_NONE;
> +
> +	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
> +					emulator_callheld_status_cb,
> +					GINT_TO_POINTER(status));
> +
> +	if (voicecalls_have_with_status(vc, CALL_STATUS_DIALING))
> +		status =3D OFONO_EMULATOR_CALLSETUP_OUTGOING;
> +	else if (voicecalls_have_with_status(vc, CALL_STATUS_ALERTING))
> +		status =3D OFONO_EMULATOR_CALLSETUP_ALERTING;
> +	else if (voicecalls_have_with_status(vc, CALL_STATUS_INCOMING)
> +		|| voicecalls_have_with_status(vc, CALL_STATUS_WAITING))

Please re-read doc/coding-style.txt section M4

> +		status =3D OFONO_EMULATOR_CALLSETUP_INCOMING;
> +	else
> +		status =3D OFONO_EMULATOR_CALLSETUP_INACTIVE;
> +
> +	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
> +					emulator_callsetup_status_cb,
> +					GINT_TO_POINTER(status));
> +}
> +
>  static void voicecall_set_call_status(struct voicecall *call, int status)
>  {
>  	DBusConnection *conn =3D ofono_dbus_get_connection();
> @@ -714,6 +779,8 @@ static void voicecall_set_call_status(struct voicecal=
l *call, int status)
>  						"State", DBUS_TYPE_STRING,
>  						&status_str);
>  =

> +	notify_emulator_call_status(call->vc);
> +
>  	if (status =3D=3D CALL_STATUS_ACTIVE &&
>  		(old_status =3D=3D CALL_STATUS_INCOMING ||
>  			old_status =3D=3D CALL_STATUS_DIALING ||
> @@ -1043,6 +1110,8 @@ static void voicecalls_emit_call_added(struct ofono=
_voicecall *vc,
>  	DBusMessageIter dict;
>  	const char *path;
>  =

> +	notify_emulator_call_status(vc);
> +
>  	path =3D __ofono_atom_get_path(vc->atom);
>  =

>  	signal =3D dbus_message_new_signal(path,
> @@ -2188,6 +2257,15 @@ static void voicecall_unregister(struct ofono_atom=
 *atom)
>  	const char *path =3D __ofono_atom_get_path(atom);
>  	GSList *l;
>  =

> +	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
> +					emulator_call_status_cb, 0);
> +	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
> +					emulator_callsetup_status_cb, 0);
> +	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_EMULATOR_HFP,
> +					emulator_callheld_status_cb, 0);
> +
> +	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
> +
>  	if (vc->sim_watch) {
>  		__ofono_modem_remove_atom_watch(modem, vc->sim_watch);
>  		vc->sim_watch =3D 0;
> @@ -2362,6 +2440,16 @@ static void sim_watch(struct ofono_atom *atom,
>  	sim_state_watch(ofono_sim_get_state(sim), vc);
>  }
>  =

> +static void emulator_hfp_watch(struct ofono_atom *atom,
> +				enum ofono_atom_watch_condition cond,
> +				void *data)
> +{
> +	struct ofono_voicecall *vc =3D data;
> +
> +	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED)
> +		notify_emulator_call_status(vc);
> +}
> +
>  void ofono_voicecall_register(struct ofono_voicecall *vc)
>  {
>  	DBusConnection *conn =3D ofono_dbus_get_connection();
> @@ -2398,6 +2486,10 @@ void ofono_voicecall_register(struct ofono_voiceca=
ll *vc)
>  		sim_watch(sim_atom, OFONO_ATOM_WATCH_CONDITION_REGISTERED, vc);
>  =

>  	__ofono_atom_register(vc->atom, voicecall_unregister);
> +
> +	vc->hfp_watch =3D __ofono_modem_add_atom_watch(modem,
> +					OFONO_ATOM_TYPE_EMULATOR_HFP,
> +					emulator_hfp_watch, vc, NULL);
>  }
>  =

>  void ofono_voicecall_remove(struct ofono_voicecall *vc)

Regards,
-Denis

--===============3530416528719960895==--

