Content-Type: multipart/mixed; boundary="===============3770763217807644240=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] Fix sending User Cancel response to Set Up Call.
Date: Fri, 10 Sep 2010 03:03:26 +0200
Message-ID: <AANLkTinrUh0=Orm4uR+62DqugQFnKwF0hP9_G2pfOhvR@mail.gmail.com>
In-Reply-To: <4C88F128.4040007@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3770763217807644240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 9 September 2010 16:37, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Andrew,
>
> On 09/08/2010 12:59 PM, Andrzej Zaborowski wrote:
>> One of the clean-up commits changed the semantics of the dial request
>> callback's parameter (NULL if call setup failed, non-NULL if success
>> or user cancelled).
>> ---
>> =C2=A0src/stk.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
>> =C2=A0src/voicecall.c | =C2=A0 14 ++++++++++++++
>> =C2=A02 files changed, 15 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/stk.c b/src/stk.c
>> index b469467..b6ed4c3 100644
>> --- a/src/stk.c
>> +++ b/src/stk.c
>> @@ -1419,7 +1419,7 @@ static void call_setup_connected(struct ofono_call=
 *call, void *data)
>> =C2=A0 =C2=A0 =C2=A0 static struct ofono_error error =3D { .type =3D OFO=
NO_ERROR_TYPE_FAILURE };
>> =C2=A0 =C2=A0 =C2=A0 static unsigned char facility_rejected_result[] =3D=
 { 0x9d };
>>
>> - =C2=A0 =C2=A0 if (!call) {
>> + =C2=A0 =C2=A0 if (!call || call->status =3D=3D CALL_STATUS_DISCONNECTE=
D) {
>
> If the call has been disconnected by the user, shouldn't we be sending
> USER_CANCEL? =C2=A0At least that is what the old behavior implies.

In that case yes, but if it's disconnected because connecting failed,
then we report this to the card.

I noticed that http://git.kernel.org/?p=3Dnetwork/ofono/ofono.git;a=3Dcommi=
tdiff;h=3Ded562ba2b04b56b9a688d40906bb783027c4a1e6
changed the behaviour slightly (but the old behaviour was probably
wrong too).

>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&rsp, 0, sizeof(=
rsp));
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rsp.result.type =3D STK=
_RESULT_TYPE_NETWORK_UNAVAILABLE;
>> diff --git a/src/voicecall.c b/src/voicecall.c
>> index 3bd4dff..e536089 100644
>> --- a/src/voicecall.c
>> +++ b/src/voicecall.c
>> @@ -361,6 +361,16 @@ static DBusMessage *voicecall_deflect(DBusConnectio=
n *conn,
>> =C2=A0 =C2=A0 =C2=A0 return NULL;
>> =C2=A0}
>>
>> +static void dial_request_user_cancel(struct ofono_voicecall *vc,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct voicecall *c=
all)
>> +{
>> + =C2=A0 =C2=A0 if (!vc->dial_req)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> +
>> + =C2=A0 =C2=A0 if (!call || call =3D=3D vc->dial_req->call)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dial_request_finish(vc->dial=
_req->call->vc, TRUE);
>> +}
>> +
>> =C2=A0static DBusMessage *voicecall_hangup(DBusConnection *conn,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBusMessage =
*msg, void *data)
>> =C2=A0{
>> @@ -372,6 +382,8 @@ static DBusMessage *voicecall_hangup(DBusConnection =
*conn,
>> =C2=A0 =C2=A0 =C2=A0 if (vc->pending)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return __ofono_error_bu=
sy(msg);
>>
>> + =C2=A0 =C2=A0 dial_request_user_cancel(vc, v);
>> +
>
> I don't see the need for this part, don't we already take care of this
> in voicecall_set_call_status?

At that point we can't tell where it was a network error / busy signal
/ etc, or the user cancelled the call (which has a different result
value sent to sim).

>
>> =C2=A0 =C2=A0 =C2=A0 switch (call->status) {
>> =C2=A0 =C2=A0 =C2=A0 case CALL_STATUS_DISCONNECTED:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return __ofono_error_fa=
iled(msg);
>> @@ -1278,6 +1290,8 @@ static DBusMessage *manager_hangup_all(DBusConnect=
ion *conn,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return reply;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> + =C2=A0 =C2=A0 dial_request_user_cancel(vc, NULL);
>> +
>
> Same as above...
>
>> =C2=A0 =C2=A0 =C2=A0 vc->flags |=3D VOICECALLS_FLAG_MULTI_RELEASE;
>>
>> =C2=A0 =C2=A0 =C2=A0 vc->pending =3D dbus_message_ref(msg);
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

Regards,
Andrew

--===============3770763217807644240==--

