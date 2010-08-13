Content-Type: multipart/mixed; boundary="===============0863198681913945664=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: Terminating emergency calls
Date: Fri, 13 Aug 2010 10:45:34 +0800
Message-ID: <33AB447FBD802F4E932063B962385B3528F0C61C@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <AANLkTin8f-noGsFqYOmjPuEjE6WL=VaAfC_MHAj819RP@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0863198681913945664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

Sjur Br?ndeland wrote:
> Denis Kenzior <denkenz@gmail.com> wrote:
>>> I thought of one more issue with voice calls.
>>> I don't think it is safe to to terminate emergency calls using
>>> release_specific, AT+CHLD=3D1X. At least this don't work for STE
>>> modems. =

>>> =

>>> I suggest calls in state active should be terminated using
>>> hangup_all or hangup_active. What do you think?
>> =

>> So in the case of a single call, the emergency call will be
>> terminated using hangup_all / hangup_active anyway. =C2=A0I have relaxed
>> the single call restriction for active calls when hangup_active is
>> provided by the =

>> driver. =C2=A0Refer to c7b13ec2fe664b122216a312f2442c9ca26f5f43
> =

> Yes, it seems to be ok for voicecall_hangup, but in manager_hangup_all
> the active call is still terminated with release_specific in
> voiceall_release_next.
> This implies that if you have an emergency call and terminate it with
> manager_hangup_all AT+CHLD=3D1X still will be used, right?
> =

> I suggest we change voicecall_release_next like this:
> =

> 	if (vc->driver->hangup_active !=3D NULL &&
> 			(call->call->status =3D=3D CALL_STATUS_ALERTING ||
> 				call->call->status =3D=3D CALL_STATUS_DIALING ||
> +				call->call->status =3D=3D CALL_STATUS_ACTIVE ||
> 				call->call->status =3D=3D CALL_STATUS_INCOMING))
> 		vc->driver->hangup_active(vc, multirelease_callback, vc);
> 	else
> 		vc->driver->release_specific(vc, call->call->id,
> 						multirelease_callback, vc);
> =

>> For mpty calls this gets tricky. =C2=A0I'd like some answers to these
>> questions: =

>> =

>> - Can Emergency calls participate in mpty?
> =

> I have to verify this with some of my colleagues, but I am pretty sure
> emergency calls cannot be applied to the AT+CHLD command. i.e. they
> cannot be part of mpty.

If emergency calls cannot be part of mpty call, we can use either hangup_al=
l or
hangup_active as Denis said. However, your suggested fix will break multipa=
rty call
scenario since multiparty_hangup calls voicecall_release_next as well. Mayb=
e we
should use call->type to indicate whether it's an emergy call. It looks to =
me that the
type flag in struct ofono_call hasn't been used yet. Correct me if I am wro=
ng.

> =

> Regards
> Sjur
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua

--===============0863198681913945664==--

