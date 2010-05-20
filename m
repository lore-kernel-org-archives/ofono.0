Content-Type: multipart/mixed; boundary="===============3524803230364477224=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH v3 2/2] huawei: add gprs context
Date: Thu, 20 May 2010 10:35:13 +0300
Message-ID: <87mxvvnhzi.fsf@potku.valot.fi>
In-Reply-To: <201005190844.38234.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3524803230364477224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> writes:

> Hi Kalle,

Hi again Denis,

>> +	ret =3D at_util_parse_reg_unsolicited(result, "+CGREG:", &status,
>> +					    NULL, NULL, NULL,
>> +					    OFONO_VENDOR_HUAWEI);
>
> No mixing of tabs & spaces for indentation

Fixed.

Oh man, I have to fix my emacs settings :/

>> +
>> +	if (ret =3D=3D FALSE)
>> +		return;
>> +
>> +	ofono_gprs_status_notify(gprs, status);
>> +}
>> +
>> +static inline void report_signal_strength(struct ofono_netreg *netreg,
>> +					  int strength)
>
> And here

This function is gone now.

>> +	DBG("%d", strength);
>> +
>> +	if (strength =3D=3D 99)
>> +		strength =3D -1;
>> +	else
>> +		strength =3D (strength * 100) / 31;
>> +
>> +	ofono_netreg_strength_notify(netreg, strength);
>> +}
>
> You might really want to make this into an atutil function instead of cop=
y-
> pasting it around.

I created this:

static inline int at_util_convert_signal_strength(int strength)
{
	int result;

	if (strength =3D=3D 99)
		result =3D -1;
	else
		result =3D (strength * 100) / 31;

	return result;
}

>> -	ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem", data->chat);
>> +	netreg =3D ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
>> +				     data->chat);
>
> Again with mixed indentation

Fixed.

>>  	ofono_sms_create(modem, OFONO_VENDOR_QUALCOMM_MSM, "atmodem",
>>  data->chat); +
>> +	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
>> +				 data->chat);
>
> And here

Fixed.

>> +	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);
>> +
>> +	if (gprs && gc) {
>> +		ofono_gprs_add_context(gprs, gc);
>> +
>> +		/* huawei has a separate channel for CGREG notifications */
>> +		g_at_chat_register(data->event, "+CGREG:",
>> +				   huawei_cgreg_notify, FALSE, gprs, NULL);
>
> And here

Fixed.

>> +
>> +		/* huawei uses non-standard "^RSSI:18" strings */
>> +		g_at_chat_register(data->event, "^RSSI:",
>> +				   huawei_rssi_notify, FALSE, netreg, NULL);
>
> And here

Fixed.

Thank you for the comments. I'll run some tests first and send v4 soon.

-- =

Kalle Valo

--===============3524803230364477224==--

