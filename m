Content-Type: multipart/mixed; boundary="===============7019435484852623034=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Internal and Driver API changes for Send USSD
 proactive command
Date: Tue, 07 Sep 2010 17:56:01 -0500
Message-ID: <4C86C301.2000700@gmail.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802A0EB55@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7019435484852623034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/07/2010 12:29 PM, Jeevaka.Badrappan(a)elektrobit.com wrote:
>  =

> Hi Denis,
> =

>>  =

>> -	else if (charset =3D=3D SMS_CHARSET_8BIT) {
>> -		/* TODO: Figure out what to do with 8 bit data */
>> +	if (charset =3D=3D SMS_CHARSET_7BIT) {
>> +		switch (data->charset) {
>> +		case AT_UTIL_CHARSET_GSM:
>> +			msg =3D convert_gsm_to_utf8((const guint8 *)
> content,
>> +		                      strlen(content), NULL, &msg_len,
> 0);
>> +			break;
>> +		case AT_UTIL_CHARSET_PCCP437:
>> +		case AT_UTIL_CHARSET_PCDN:
>> +		case AT_UTIL_CHARSET_8859_1:
>> +		case AT_UTIL_CHARSET_IRA:
>> +		default:
>> +			DBG("charset:%d not supported", data->charset);
>> +			status =3D 4; /* Not supported */
>> +		}
>> +	} else if (charset =3D=3D SMS_CHARSET_8BIT) {
>> +		/* MT/TA converts each 8 bit octet into two IRA
> character
>> +		* long hexadecimal number (e.g. octet with integer value
> 42
>> +		* is presented to TE as two characters 2A (IRA 50 and
> 65))
>> +		*/
>>  		ofono_error("8-bit coded USSD response received");
>>  		status =3D 4; /* Not supported */
> =

>> If we're not handling 8BIT USSDs, what exactly is the point of this
> exercise?
> =

>   Based on the dcs received from network and TE character set chosen,
> modem converts the received ussd response string.
> =

> 	DCS_from_network		TE_char_set
> Conversion done by Modem
> 	GSM 7-bit default		=

> 					PCCP437		GSM 7-bit
> default alphabet to PCCP437
> 					PCDN			GSM
> 7-bit default alphabet to PCDN
> 					ISO8859-1		GSM
> 7-bit default alphabet to 8859-1
> 					IRA			GSM
> 7-bit default alphabet to IRA
> 					GSM 7-bit		None

The basic problem here is that the modem should be configured into UTF8
or GSM mode.  All other character sets are pointless.  This also runs
into trouble when the modem supports UCS2.  Phonebook driver has to
switch to UCS2 when importing the phonebook, so if a USSD arrives during
the import, the results are undefined and most likely vendor specific.

>  =

> 	8-bit - In this case, modem doesn't relay on the chosen TE
> character set. Modem converts each 8-bit octet into
> 		two IRA character long hexadecimal number =

> =

>   I left the 8-bit USSD case unhandled, as I didn't find the conversion
> function for converting the IRA to the 8-bit data.
> Also 3GPP TS Specification, doesn't have any information on what needs
> to be done if the dcs received is UCS2.

For the 8-bit case it is just raw data given in hex.  E.g. 4142 -> 0x41
0x42 -> AB in ASCII.  UCS2 is completely undefined by the specification
and is modem specific.

>> Get rid of this.  The core either passes a raw USSD data or UTF8.
>> There's no mix and match here.
> =

> As you know, USSD string coming via dbus interface will be in UTF8
> format. Whereas, USSD string
> coming from the USAT will be in binary data + len. =

> =

> Do you mean to say that the core will convert the UTF-8 USSD string
> coming from the user(dbus interface) into GSM 8-bit and send it to the
> driver side?
> =


Correct.  The core has to handle this.  If the user enters simple text,
that should be converted into GSM first and packed, before giving it to
the driver.  For ISI the modem accepts raw data + dcs, so the data can
be simply copied and sent as-is.  For AT modems you will have to unpack
from 7bit packed into 7bit unpacked and send it to the modem.  Same
thing in the reverse direction.

>> -	if (written > max_len)
>> -		goto error;
>> +		/* As per 3GPP TS 23.038, When this character set is
> used,
>> +		 * the characters of the message are packed in octets as
> shown in section 6.1.2.1.1,
>> +		 * and the message can consist of up to 160 characters.
>> +		 */
>> +		pack_7bit_own_buf(converted, written, 0, TRUE,
>> +                		      &num_packed, 0, coded_str);
> =

>> CUSD does not take packed GSM data, so I'm lost here
> =

> As you know, when a message is coded in 7-bit default alphabet, the
> message can then consists of upto 182 user charcters.
> I just packed it so that the maximum message length will be 160
> characters for all the cases. Do you mean, CUSD won't take packed GSM
> data? =


CUSD does not take packed data.  More over, sending 8-bit data is not
well defined by the specification.  In the best case the 8-bit data will
have to be hex-encoded.  Handling of UCS2 data is undefined.

> =

>>  =

>>  enum sms_charset {
>> -	SMS_CHARSET_7BIT =3D 0,
>> -	SMS_CHARSET_8BIT =3D 1,
>> -	SMS_CHARSET_UCS2 =3D 2,
>> +	SMS_CHARSET_7BIT =3D 0x00,
>> +	SMS_CHARSET_8BIT =3D 0x04,
>> +	SMS_CHARSET_UCS2 =3D 0x08,
> =

>> Please don't mess with this enum, the USSD DCS has nothing to do with
> SMS.
> =

> I agree the SMS dcs is different from the CBS dcs. But this enumeration
> is just used within ofono for knowing the coding scheme used. =

> Currently, we are using this enumeration in SMS, CBS and USSD as well. I
> have just changed the values so that it matches with the USAT
> values. Since, this enumeration is used to just determine the character
> sets, I didn't find any valid reason why we have to introduce a
> new enumeration just with the USAT specific values.

I know what you're trying to do, and you are abusing the system here.
In fact, messing with this enum is not needed at all.  The only place
where this information is truly required is in the callback that
composes the USSD terminal response.  E.g. maps between the USSD dcs of
7bit/8bit/ucs2 into the Text data object DCS sent to the sim via the
Terminal Response.  So I agree, a new enum is not required, and neither
is messing with this one.

Regards,
-Denis

--===============7019435484852623034==--

