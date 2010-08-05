Content-Type: multipart/mixed; boundary="===============1550848474620605086=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC] STE-driver: Terminating voice call in state
 DIALING/ALERTING.
Date: Thu, 05 Aug 2010 21:04:32 +0200
Message-ID: <AANLkTinPx07H7LUBiy6SGYRCX7nWCaLUUMwv3wmSjPST@mail.gmail.com>
In-Reply-To: <4C5AE5AC.70806@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1550848474620605086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior wrote:
>> I'm picking up a really old thread here...
>Yes a really old thread ;)
Better late than never, right? :-)

...
>> However, I think we can solve this even simpler if we just
>> call hangup for any ALERTING/DIALING call..
>This is a real gray area.  On some devices this will work, on others it
>might have un-intentional consequences.  At least on the calypso,
>sending CHUP/ATH will terminate all calls not in the WAITING state.

Ok, so we should go forward with this proposal then.
I'll try to send a new RFC within the next couple of days.

My initial intention here was not to submit patches
on src/voicecall.c, but to make sure I understood your proposal properly.
Let me know how you think we should go forward with this, as this
impacts all drivers/*/voicecall.c

>> -	 if (call->status =3D=3D CALL_STATUS_INCOMING) {
>> +	 if (vc->driver->hangup_active && call->status =3D=3D CALL_STATUS_INCO=
MING) {
>
>You're breaking the logic somewhat here.  If the call is INCOMING, we
>shouldn't skip the rest of the block if hangup_active is not implemented.
>
>>		 if (vc->driver->hangup =3D=3D NULL)
>>			 return __ofono_error_not_implemented(msg);
>>
>>		 vc->pending =3D dbus_message_ref(msg);
>> -		 vc->driver->hangup(vc, generic_callback, vc);
>> +		 vc->driver->hangup_active(vc, generic_callback, vc);
>>
>>		 return NULL;
>>	 }
>
>Here we need to check whether hangup_active or hangup_all are
>implemented. If both are, then prefer hangup_all.  This would make it
>easier to keep compatibility with current drivers.

Did you have something like this in mind then:

	if (call->status =3D=3D CALL_STATUS_INCOMING) {
		vc->pending =3D dbus_message_ref(msg);
		if (vc->driver->hangup_all)
			vc->driver->hangup_all(vc, generic_callback, vc);
		else if (vc->driver->hangup_active)
			vc->driver->hangup_active(vc, generic_callback, vc);
		else
			return __ofono_error_not_implemented(msg);

		return NULL;
	}

Should we do not_implemented here or did you intend the drivers to be allow=
ed
to not implement hangup_active nor hangup_all, and fall through to
release_specific?

>
>> @@ -286,12 +286,12 @@ static DBusMessage *voicecall_hangup(DBusConnectio=
n *conn,
>>
>>	 num_calls =3D g_slist_length(vc->call_list);
>>
>> -	 if (num_calls =3D=3D 1 && vc->driver->hangup &&
>> +	 if (vc->driver->hangup_active && num_calls =3D=3D 1 && vc->driver->ha=
ngup &&
>
>This should probably be a condition something like:
>
>if (num_calls =3D=3D 1 && (vc->driver->hangup || vc->driver->hangup_active)
>...
>
>>			 (call->status =3D=3D CALL_STATUS_ACTIVE ||
>>				 call->status =3D=3D CALL_STATUS_DIALING ||
>>				 call->status =3D=3D CALL_STATUS_ALERTING)) {
>>		 vc->pending =3D dbus_message_ref(msg);
>> -		 vc->driver->hangup(vc, generic_callback, vc);
>> +		 vc->driver->hangup_active(vc, generic_callback, vc);
>
>And again prefer hangup_all over hangup_active to keep compatibility
>with old drivers.


Something like this then:
if (num_calls =3D=3D 1 && (vc->driver->hangup_all || vc->driver->hangup_act=
ive) &&
			(call->status =3D=3D CALL_STATUS_ACTIVE ||
				call->status =3D=3D CALL_STATUS_DIALING ||
				call->status =3D=3D CALL_STATUS_ALERTING)) {
		vc->pending =3D dbus_message_ref(msg);
		 if (vc->driver->hangup_all)
			vc->driver->hangup_all(vc, generic_callback, vc);
		 else if (vc->driver->hangup_active)
			vc->driver->hangup_active(vc, generic_callback, vc);
		 else
			return __ofono_error_not_implemented(msg);

>This reminds me that we should treat INCOMING calls in HangupAll
>specially. It should not be handled here.

What did you have in mind?

>HangupAll should also skip waiting calls.

voicecalls_release_queue and voicecalls_release_next are used for
multiparty_hangup as well, I assume you want the same behaviour for multi-p=
arty
so that we can do these changes in voicecalls_release_queue, right?

Regards
Sjur

--===============1550848474620605086==--

