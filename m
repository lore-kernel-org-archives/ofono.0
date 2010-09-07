Content-Type: multipart/mixed; boundary="===============2069509008448150754=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH 1/2] Internal and Driver API changes for Send USSD
 proactive command
Date: Tue, 07 Sep 2010 20:29:26 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802A0EB55@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <4C86523B.7060804@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2069509008448150754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 =

Hi Denis,

>  =

> -	else if (charset =3D=3D SMS_CHARSET_8BIT) {
> -		/* TODO: Figure out what to do with 8 bit data */
> +	if (charset =3D=3D SMS_CHARSET_7BIT) {
> +		switch (data->charset) {
> +		case AT_UTIL_CHARSET_GSM:
> +			msg =3D convert_gsm_to_utf8((const guint8 *)
content,
> +		                      strlen(content), NULL, &msg_len,
0);
> +			break;
> +		case AT_UTIL_CHARSET_PCCP437:
> +		case AT_UTIL_CHARSET_PCDN:
> +		case AT_UTIL_CHARSET_8859_1:
> +		case AT_UTIL_CHARSET_IRA:
> +		default:
> +			DBG("charset:%d not supported", data->charset);
> +			status =3D 4; /* Not supported */
> +		}
> +	} else if (charset =3D=3D SMS_CHARSET_8BIT) {
> +		/* MT/TA converts each 8 bit octet into two IRA
character
> +		* long hexadecimal number (e.g. octet with integer value
42
> +		* is presented to TE as two characters 2A (IRA 50 and
65))
> +		*/
>  		ofono_error("8-bit coded USSD response received");
>  		status =3D 4; /* Not supported */

> If we're not handling 8BIT USSDs, what exactly is the point of this
exercise?

  Based on the dcs received from network and TE character set chosen,
modem converts the received ussd response string.

	DCS_from_network		TE_char_set
Conversion done by Modem
	GSM 7-bit default		=

					PCCP437		GSM 7-bit
default alphabet to PCCP437
					PCDN			GSM
7-bit default alphabet to PCDN
					ISO8859-1		GSM
7-bit default alphabet to 8859-1
					IRA			GSM
7-bit default alphabet to IRA
					GSM 7-bit		None
 =

	8-bit - In this case, modem doesn't relay on the chosen TE
character set. Modem converts each 8-bit octet into
		two IRA character long hexadecimal number =


  I left the 8-bit USSD case unhandled, as I didn't find the conversion
function for converting the IRA to the 8-bit data.
Also 3GPP TS Specification, doesn't have any information on what needs
to be done if the dcs received is UCS2.

> -	g_free(converted);
> +	ofono_ussd_notify(ussd, status, -1, (const guint8 *) msg, (int) =

> +msg_len);

> Err, why are we passing UTF8 text as binary data + len?  I'm lost.
You either do UTF8 always, or full binary always.

>  =

> -	converted =3D convert_utf8_to_gsm(str, strlen(str), NULL,
&written, 0);
> +	if (dcs =3D=3D -1) {
> +		converted =3D convert_utf8_to_gsm((const char *) str,
str_len, NULL, =

> +&written, 0);

> Get rid of this.  The core either passes a raw USSD data or UTF8.
> There's no mix and match here.

As you know, USSD string coming via dbus interface will be in UTF8
format. Whereas, USSD string
coming from the USAT will be in binary data + len. =


Do you mean to say that the core will convert the UTF-8 USSD string
coming from the user(dbus interface) into GSM 8-bit and send it to the
driver side?

> -	if (written > max_len)
> -		goto error;
> +		/* As per 3GPP TS 23.038, When this character set is
used,
> +		 * the characters of the message are packed in octets as
shown in section 6.1.2.1.1,
> +		 * and the message can consist of up to 160 characters.
> +		 */
> +		pack_7bit_own_buf(converted, written, 0, TRUE,
> +                		      &num_packed, 0, coded_str);

> CUSD does not take packed GSM data, so I'm lost here

As you know, when a message is coded in 7-bit default alphabet, the
message can then consists of upto 182 user charcters.
I just packed it so that the maximum message length will be 160
characters for all the cases. Do you mean, CUSD won't take packed GSM
data? =


>  =

>  enum sms_charset {
> -	SMS_CHARSET_7BIT =3D 0,
> -	SMS_CHARSET_8BIT =3D 1,
> -	SMS_CHARSET_UCS2 =3D 2,
> +	SMS_CHARSET_7BIT =3D 0x00,
> +	SMS_CHARSET_8BIT =3D 0x04,
> +	SMS_CHARSET_UCS2 =3D 0x08,

> Please don't mess with this enum, the USSD DCS has nothing to do with
SMS.

I agree the SMS dcs is different from the CBS dcs. But this enumeration
is just used within ofono for knowing the coding scheme used. =

Currently, we are using this enumeration in SMS, CBS and USSD as well. I
have just changed the values so that it matches with the USAT
values. Since, this enumeration is used to just determine the character
sets, I didn't find any valid reason why we have to introduce a
new enumeration just with the USAT specific values.

Thanks and Regards,
Jeevaka

--===============2069509008448150754==--

