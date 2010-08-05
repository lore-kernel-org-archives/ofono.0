Content-Type: multipart/mixed; boundary="===============1613217309781138622=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] STE-driver: Terminating voice call in state
 DIALING/ALERTING.
Date: Thu, 05 Aug 2010 14:19:01 -0500
Message-ID: <4C5B0EA5.80806@gmail.com>
In-Reply-To: <AANLkTinPx07H7LUBiy6SGYRCX7nWCaLUUMwv3wmSjPST@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1613217309781138622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

On 08/05/2010 02:04 PM, Sjur Br=C3=A6ndeland wrote:
> Hi Denis,
> =

> Denis Kenzior wrote:
>>> I'm picking up a really old thread here...
>> Yes a really old thread ;)
> Better late than never, right? :-)
> =

> ...

Definitely :)  I'm very glad you brought this back up.

>>> However, I think we can solve this even simpler if we just
>>> call hangup for any ALERTING/DIALING call..
>> This is a real gray area.  On some devices this will work, on others it
>> might have un-intentional consequences.  At least on the calypso,
>> sending CHUP/ATH will terminate all calls not in the WAITING state.
> =

> Ok, so we should go forward with this proposal then.
> I'll try to send a new RFC within the next couple of days.
> =

> My initial intention here was not to submit patches
> on src/voicecall.c, but to make sure I understood your proposal properly.
> Let me know how you think we should go forward with this, as this
> impacts all drivers/*/voicecall.c
> =


Yes, I think this definitely makes sense.  There might be some other
modems we don't cover properly (some don't allow HELD calls to be
terminated using CHLD=3D1X), but we cross that bridge when we come to it.

>>> -	 if (call->status =3D=3D CALL_STATUS_INCOMING) {
>>> +	 if (vc->driver->hangup_active && call->status =3D=3D CALL_STATUS_INC=
OMING) {
>>
>> You're breaking the logic somewhat here.  If the call is INCOMING, we
>> shouldn't skip the rest of the block if hangup_active is not implemented.
>>
>>> 		 if (vc->driver->hangup =3D=3D NULL)
>>> 			 return __ofono_error_not_implemented(msg);
>>>
>>> 		 vc->pending =3D dbus_message_ref(msg);
>>> -		 vc->driver->hangup(vc, generic_callback, vc);
>>> +		 vc->driver->hangup_active(vc, generic_callback, vc);
>>>
>>> 		 return NULL;
>>> 	 }
>>
>> Here we need to check whether hangup_active or hangup_all are
>> implemented. If both are, then prefer hangup_all.  This would make it
>> easier to keep compatibility with current drivers.
> =

> Did you have something like this in mind then:
> =

> 	if (call->status =3D=3D CALL_STATUS_INCOMING) {
> 		vc->pending =3D dbus_message_ref(msg);
> 		if (vc->driver->hangup_all)
> 			vc->driver->hangup_all(vc, generic_callback, vc);
> 		else if (vc->driver->hangup_active)
> 			vc->driver->hangup_active(vc, generic_callback, vc);
> 		else
> 			return __ofono_error_not_implemented(msg);
> =

> 		return NULL;
> 	}
> =

> Should we do not_implemented here or did you intend the drivers to be all=
owed
> to not implement hangup_active nor hangup_all, and fall through to
> release_specific?

I think doing not_implemented here is a good idea.  However, you should
not take the ref of the message if you're returning not_implemented.
Something like this would be better:

if (call->status =3D=3D CALL_STATUS_INCOMING) {
	if (vc->driver->hangup_all =3D=3D NULL &&
			vc->driver->hangup_active =3D=3D NULL)
		return __ofono_error_not_implemented(msg);

	vc->pending =3D dbus_message_ref(msg);

	if (vc->driver->hangup_all)
		....
	else
		....

	return NULL;
}

> =

>>
>>> @@ -286,12 +286,12 @@ static DBusMessage *voicecall_hangup(DBusConnecti=
on *conn,
>>>
>>> 	 num_calls =3D g_slist_length(vc->call_list);
>>>
>>> -	 if (num_calls =3D=3D 1 && vc->driver->hangup &&
>>> +	 if (vc->driver->hangup_active && num_calls =3D=3D 1 && vc->driver->h=
angup &&
>>
>> This should probably be a condition something like:
>>
>> if (num_calls =3D=3D 1 && (vc->driver->hangup || vc->driver->hangup_acti=
ve)
>> ...
>>
>>> 			 (call->status =3D=3D CALL_STATUS_ACTIVE ||
>>> 				 call->status =3D=3D CALL_STATUS_DIALING ||
>>> 				 call->status =3D=3D CALL_STATUS_ALERTING)) {
>>> 		 vc->pending =3D dbus_message_ref(msg);
>>> -		 vc->driver->hangup(vc, generic_callback, vc);
>>> +		 vc->driver->hangup_active(vc, generic_callback, vc);
>>
>> And again prefer hangup_all over hangup_active to keep compatibility
>> with old drivers.
> =

> =

> Something like this then:
> if (num_calls =3D=3D 1 && (vc->driver->hangup_all || vc->driver->hangup_a=
ctive) &&
> 			(call->status =3D=3D CALL_STATUS_ACTIVE ||
> 				call->status =3D=3D CALL_STATUS_DIALING ||
> 				call->status =3D=3D CALL_STATUS_ALERTING)) {
> 		vc->pending =3D dbus_message_ref(msg);
> 		 if (vc->driver->hangup_all)
> 			vc->driver->hangup_all(vc, generic_callback, vc);
> 		 else if (vc->driver->hangup_active)
> 			vc->driver->hangup_active(vc, generic_callback, vc);
> 		 else
> 			return __ofono_error_not_implemented(msg);
> =


Yep, but see the comment about dbus_message_ref above.

>> This reminds me that we should treat INCOMING calls in HangupAll
>> specially. It should not be handled here.
> =

> What did you have in mind?

I'm thinking of simply checking if there is an INCOMING call.  If so, it
is assumed to be a single call and using hangup_all / hangup_active is
sufficient.  This would also be more consistent with voicecall_hangup
implementation above.

> =

>> HangupAll should also skip waiting calls.
> =

> voicecalls_release_queue and voicecalls_release_next are used for
> multiparty_hangup as well, I assume you want the same behaviour for multi=
-party
> so that we can do these changes in voicecalls_release_queue, right?

Correct, however multiparty calls cannot be in the WAITING state.
Essentially we can just skip these by not queuing them on the release list.

> =

> Regards
> Sjur

Regards,
-Denis

--===============1613217309781138622==--

