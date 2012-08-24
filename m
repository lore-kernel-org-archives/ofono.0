Content-Type: multipart/mixed; boundary="===============5766351328735234512=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH v2] ussd: Recover idle state in case of response sending
 failure
Date: Fri, 24 Aug 2012 11:15:03 +0200
Message-ID: <50374617.7050401@linux.intel.com>
In-Reply-To: <50367059.9050406@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5766351328735234512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 08/23/2012 08:03 PM, Denis Kenzior wrote:
> Hi Philippe,
>
> On 08/23/2012 11:27 AM, Philippe Nunes wrote:
>> GCF test case 31.8.1.2.3 is rejecting the user response.
>> Any subsequent USSD notification are not handled because USSD is
>> always in
>> state user-action.
>> ---
>> src/ussd.c | 12 ++++++++++++
>> 1 file changed, 12 insertions(+)
>>
>> diff --git a/src/ussd.c b/src/ussd.c
>> index 74888b2..21e0164 100644
>> --- a/src/ussd.c
>> +++ b/src/ussd.c
>> @@ -414,6 +414,18 @@ void ofono_ussd_notify(struct ofono_ussd *ussd,
>> int status, int dcs,
>> return;
>> }
>>
>> + if (status =3D=3D OFONO_USSD_STATUS_TERMINATED&&
>> + (ussd->state =3D=3D USSD_STATE_IDLE ||
>> + ussd->state =3D=3D USSD_STATE_USER_ACTION)) {
>
> This check makes no sense, why bother checking for ussd->state =3D=3D
> USSD_STATE_IDLE?

The issue has been unveiled after a network initiated USSD request:

\r\n+CUSD: 1,"Type *70*635*562# and send",15\r\n
src/ussd.c:ofono_ussd_notify() status: 1 ACTION_REQUIRED, state: 0 IDLE

then we try to  give an answer:

AT+CUSD=3D1,"*70*635*562#",15\r
\r\n+CUSD: 2\r\n
\r\n+CME ERROR: 100\r\n


I presume that the same error could occur after a user USSD request. In =

this case, the state is still 'idle' and the "Terminated" notification =

results in a "NotificationReceived" signal with a NULL string. To avoid =

this, I need to check also for ussd->state =3D=3D USSD_STATE_IDLE. That's =

why the first version was for me more appropriate.


>
>> + ussd_change_state(ussd, USSD_STATE_IDLE);
>> +
>> + if (ussd->pending =3D=3D NULL)
>> + return;
>> +
>> + reply =3D __ofono_error_not_supported(ussd->pending);
>> + goto out;
>> + }
>> +
>
> I would handle it just like the 'Not Supported' case but with a new
> __ofono_error_network_terminated error reply. Or perhaps re-use
> __ofono_error_canceled.

In practice, I don't ever expect to send a reply since the =

ussd_response_callback/ ussd_callback is invoked before the TERMINATED =

notification. The error returned in the callback is __ofono_error_failed.
So, what about changing the state to 'idle' if not already set and =

simply return?

Regards,

Philippe.


--===============5766351328735234512==--

