Content-Type: multipart/mixed; boundary="===============3167683186004348311=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] atmodem: Add use of pin event *EPEV after sending PUK.
Date: Tue, 02 Nov 2010 10:24:16 -0500
Message-ID: <4CD02D20.5090502@gmail.com>
In-Reply-To: <1288710844.3322.175.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3167683186004348311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11/02/2010 10:14 AM, Marcel Holtmann wrote:
> Hi Marit,
> =

>> The MBM/STE modems send the unsolicited result code *EPEV to report when =

>> the PIN code has been inserted and accepted.
> =

> I almost thought so, but I was not sure when adapting this for IFX.
> =

>> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
>> index 94658f2..3abd1d8 100644
>> --- a/drivers/atmodem/sim.c
>> +++ b/drivers/atmodem/sim.c
>> @@ -671,6 +671,16 @@ static void at_pin_send_puk_cb(gboolean ok, GAtResu=
lt *result,
>>  							at_xsim_notify,
>>  							FALSE, cbd, g_free);
>>  		return;
>> +	case OFONO_VENDOR_MBM:
>> +		/*
>> +		 * On the MBM modem, AT+CPIN? keeps returning SIM PIN
>> +		 * for a moment after successful AT+CPIN=3D"..", but then
>> +		 * sends *EPEV when that changes.
>> +		 */
>> +		sd->ready_id =3D g_at_chat_register(sd->chat, "*EPEV",
>> +							at_epev_notify,
>> +							FALSE, cbd, g_free);
>> +		return;
>>  	}
> =

> Denis, I think we can merge the PIN entering and PUK entering code paths
> into one. No need to keep them separate.
> =


Or refactor the EPEV registration into a separate function.  But either
is fine with me.

Regards,
-Denis

--===============3167683186004348311==--

