Content-Type: multipart/mixed; boundary="===============7685062239115633951=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/6] stk-api.txt: Describe new d-bus APIs related to BIP
 commands.
Date: Thu, 24 Mar 2011 10:26:32 -0500
Message-ID: <4D8B62A8.6040607@gmail.com>
In-Reply-To: <4D8B5676.7080201@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7685062239115633951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>>>           boolean ConfirmCallSetup(string information, byte icon_id)
>>>
>>> @@ -245,6 +252,7 @@ Methods        byte RequestSelection(string
>>> title, byte icon_id,
>>>               Possible Errors: [service].Error.SimToolkit.EndSession
>>>
>>>           void DisplayActionInformation(string text, byte icon_id)
>>> +                        [noreply]
>>>
>>
>> Why are you marking this noreply when we do actually expect one?
> =

> In practice, this API is called once an alpha Id is provided by the
> proactive commands SEND SS, SEND SMS, SEND USSD.
> =

> For such proactive commands, no "user" answer is expected. That's why
> the error code [service].Error.SimToolkit.EndSession is even not
> allowed. And that's the reason why I added the criteria [No reply]

Ok fair enough.

> =

> Now, I just realized that I missed the proactive command SEND DTMF for
> which this API is also relevant and for which the user can indeed
> request to end the session. So, the criteria [noreply] is indeed not fair.
> =


Send DTMF is a little bit more subtle.  The problem is that it is
usually handled by the modem side and we have no control over the
terminal response.  So the current Send DTMF implementation will likely
work magically everywhere anyway.  We probably should split up this
implementation into two paths:

- If the command is notified via
ofono_stk_proactive_command_handled_notify, then do as we do now, e.g.
using DisplayActionInformation
- If the command is notified via ofono_stk_proactive_command_notify,
then we should probably call a different function.

> But, the reason for which I introduced the new API
> DisplayChannelActivity was to distinguish precisely when the STK agent
> could allow the user to end the session (typically when the button
> Cancel could be displayed).
> =


And that makes sense to me now

> Now, to handle correctly the case SEND DTMF, I presume that it would be
> better to refactor this API 'DisplayActionInformation' in order to
> address all the proactive commands which require simply to display an
> alpha ID. But this requires I guess to introduce a new argument like a
> boolean "end_session_allowed".
> =


I think a separate function makes sense.  Perhaps
DisplayAbortableActionInfo or feel free to come up with a better name.

Regards,
-Denis

--===============7685062239115633951==--

