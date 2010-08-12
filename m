Content-Type: multipart/mixed; boundary="===============6314497735819460846=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: Terminating emergency calls
Date: Fri, 13 Aug 2010 01:10:40 +0200
Message-ID: <AANLkTin8f-noGsFqYOmjPuEjE6WL=VaAfC_MHAj819RP@mail.gmail.com>
In-Reply-To: <4C643C3E.9080803@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6314497735819460846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> wrote:
>> I thought of one more issue with voice calls.
>> I don't think it is safe to to terminate emergency calls using
>> release_specific, AT+CHLD=3D1X.
>> At least this don't work for STE modems.
>>
>> I suggest calls in state active should be terminated using hangup_all
>> or hangup_active.
>> What do you think?
>
> So in the case of a single call, the emergency call will be terminated
> using hangup_all / hangup_active anyway. =C2=A0I have relaxed the single =
call
> restriction for active calls when hangup_active is provided by the
> driver. =C2=A0Refer to c7b13ec2fe664b122216a312f2442c9ca26f5f43

Yes, it seems to be ok for voicecall_hangup, but in manager_hangup_all
the active call is still terminated with release_specific in
voiceall_release_next.
This implies that if you have an emergency call and terminate it with
manager_hangup_all AT+CHLD=3D1X still will be used, right?

I suggest we change voicecall_release_next like this:

	if (vc->driver->hangup_active !=3D NULL &&
			(call->call->status =3D=3D CALL_STATUS_ALERTING ||
				call->call->status =3D=3D CALL_STATUS_DIALING ||
+				call->call->status =3D=3D CALL_STATUS_ACTIVE ||
				call->call->status =3D=3D CALL_STATUS_INCOMING))
		vc->driver->hangup_active(vc, multirelease_callback, vc);
	else
		vc->driver->release_specific(vc, call->call->id,
						multirelease_callback, vc);

> For mpty calls this gets tricky. =C2=A0I'd like some answers to these que=
stions:
>
> - Can Emergency calls participate in mpty?

I have to verify this with some of my colleagues, but I am pretty sure
emergency calls cannot be applied to the AT+CHLD command. i.e. they cannot
be part of mpty.


Regards
Sjur

--===============6314497735819460846==--

