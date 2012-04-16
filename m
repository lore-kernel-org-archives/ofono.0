Content-Type: multipart/mixed; boundary="===============6120185867158298825=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH] atmodem: Do some polling on at_pin_query
Date: Mon, 16 Apr 2012 10:06:15 +0200
Message-ID: <4F8BD2F7.10906@linux.intel.com>
In-Reply-To: <4F872EB4.60207@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6120185867158298825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 12/04/2012 21:36, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 04/12/2012 09:28 AM, Guillaume Zajac wrote:
>> For some modem like ZTE MF180/190, we need to do some
>> polling to check SIM state when it returns +CME ERROR: 14 busy.
>> ---
>>   drivers/atmodem/sim.c |   59 +++++++++++++++++++++++++++++++++++++++--=
-------
>>   1 files changed, 48 insertions(+), 11 deletions(-)
>>
> <snip>
>
>> @@ -874,9 +878,22 @@ static void at_cpin_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>>   	else
>>   		decode_at_error(&error, final);
>>
>> -	if (!ok) {
>> +	switch (error.type) {
>> +	case OFONO_ERROR_TYPE_NO_ERROR:
>> +		break;
>> +	case OFONO_ERROR_TYPE_CME:
>> +		/* Check for SIM busy - try again later */
>> +		if (error.error =3D=3D 14) {
>> +			if (sd->poll_count++<  12) {
>> +				sd->poll_source =3D g_timeout_add_seconds(2,
>> +						sim_state_check, cbd);
>> +				return;
>> +			}
>> +		}
>> +		/* fall through */
>> +	default:
>>   		cb(&error, -1, cbd->data);
>> -		return;
>> +		goto done;
>>   	}
>>
>>   	if (sd->vendor =3D=3D OFONO_VENDOR_WAVECOM) {
> Is there a reason we are not using at_util_sim_state_query_new?

This function is only giving sim present information through its =

callback, however I also need to parse the answer from AT+CPIN?
So it means we would send once the AT+CPIN? using atutil helper and once =

to parse the answer.
I thought about implementing a new atutil helper function or a new =

g_at_chat_send_recursive() function but I saw in =

drivers/atmodem/phonebook.c on AT+CPBS=3D? command that polling mechanism =

is integrated into the driver itself.
That's why I have chosen this solution.

> <snip>
>
> Regards,
> -Denis

Kind regards,
Guillaume


--===============6120185867158298825==--

