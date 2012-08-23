Content-Type: multipart/mixed; boundary="===============8227015839669249839=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH 1/8] ussd: Recover idle state in case of response sending
 failure
Date: Thu, 23 Aug 2012 12:30:33 +0200
Message-ID: <50360649.40403@linux.intel.com>
In-Reply-To: <50356520.9090109@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8227015839669249839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 08/23/2012 01:02 AM, Denis Kenzior wrote:
> Hi Philippe,
>
> On 08/22/2012 11:18 AM, Philippe Nunes wrote:
>> GCF test case 31.8.1.2.3 is rejecting the user response.
>> Any subsequent USSD notification are not handled because USSD is
>> always in
>> state user-action.
>> ---
>> src/ussd.c | 8 +++++++-
>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/ussd.c b/src/ussd.c
>> index 74888b2..0ad4f61 100644
>> --- a/src/ussd.c
>> +++ b/src/ussd.c
>> @@ -414,6 +414,10 @@ void ofono_ussd_notify(struct ofono_ussd *ussd,
>> int status, int dcs,
>> return;
>> }
>>
>> + if (status =3D=3D OFONO_USSD_STATUS_TERMINATED&&
>> + ussd->state =3D=3D USSD_STATE_IDLE)
>> + return;
>> +
>> if (status =3D=3D OFONO_USSD_STATUS_NOT_SUPPORTED) {
>> ussd_change_state(ussd, USSD_STATE_IDLE);
>>
>
> How about you simply handle the TERMINATED notification properly here and
>
>> @@ -595,9 +599,11 @@ static void ussd_response_callback(const struct
>> ofono_error *error, void *data)
>> struct ofono_ussd *ussd =3D data;
>> DBusMessage *reply;
>>
>> - if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
>> + if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>> DBG("ussd response failed with error: %s",
>> telephony_error_to_str(error));
>> + ussd_change_state(ussd, USSD_STATE_IDLE);
>> + }
>>
>> if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR) {
>> ussd_change_state(ussd, USSD_STATE_RESPONSE_SENT);
>
> Take out this chunk.
>

In fact, that's what I did first.
But then, I moved to this version as it looked more logical for me.
In practice, the ussd_response_callback is handled before the TERMINATED =

notification and it is more meaningful to link the error to the 'idle' =

state recovery.
Anyway, I send you a new patch.

Regards,

Philippe.

--===============8227015839669249839==--

