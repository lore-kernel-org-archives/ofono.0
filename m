Content-Type: multipart/mixed; boundary="===============8881610238882350550=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/3] network-registration.c: implement CIND forTelit
 UC864-G
Date: Tue, 24 May 2011 02:18:45 -0500
Message-ID: <4DDB5BD5.7010303@gmail.com>
In-Reply-To: <1306350484.2681.38.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8881610238882350550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 05/25/2011 02:08 PM, Marcel Holtmann wrote:
> Hi Bernhard,
> =

>> *UC864 has an incompatible CIND
>> *add a Telit specific check for "not measurable" strength
>>
>> Co-authored-by: Christopher Vogl <Christopher.Vogl@hale.at>
>> ---
>>  drivers/atmodem/network-registration.c |   40 +++++++++++++++++++++++++=
++++--
>>  1 files changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/ne=
twork-registration.c
>> index b3aa511..984e85e 100644
>> --- a/drivers/atmodem/network-registration.c
>> +++ b/drivers/atmodem/network-registration.c
>> @@ -666,7 +666,20 @@ static void ciev_notify(GAtResult *result, gpointer=
 user_data)
>>  	if (!g_at_result_iter_next_number(&iter, &strength))
>>  		return;
>>  =

>> -	strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
>> +	switch (nd->vendor) {
>> +	case OFONO_VENDOR_TELIT:
>> +		/* Check for "signal not measurable" */
>> +		if (strength =3D=3D 99)
>> +			strength =3D 0;
>> +		else
>> +			strength =3D (strength * 100) / (nd->signal_max -
>> +						nd->signal_min);
>> +		break;
>> +	default:
>> +		strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
>> +		break;
>> +	}
>> +
> =

> this is something that does not look like vendor quirk. The 99 is always
> a special value and we should just do this for all modems.
> =

> Denis, any thoughts?
> =


99 is used by +CSQ and certain vendor extensions to CSQ to denote an
unmeasurable / unknown RSSI value.  This is already handled by
at_util_convert_signal_strength.

Some modems / protocols (e.g. mbm, hfp) use CIND style indicators for
signal strength instead, however the indicator values are contiguous
(e.g. 0-5) and oFono's logic assumes this behavior.

It seems that the Telit modem uses a contiguous range (0-5) and the
special value 99 to denote unmeasurable value.  The Telit modem is the
first one I have seen that uses this behavior.  From that standpoint I
really have no preference here, but it seems that generalizing the logic
to handle 99 should be easy enough.

However, I really don't like this patch hardcoding the signal
index/min/max inside at_creg_set_cb.  Telit is a nicely compliant modem,
we should be able to trust what it reports.

Bernhard, a question for you: what does the UC864-G return when issuing:
'AT+CIND=3D?'

Regards,
-Denis

--===============8881610238882350550==--

