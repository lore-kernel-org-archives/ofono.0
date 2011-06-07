Content-Type: multipart/mixed; boundary="===============1449366835972228057=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH V3 2/4] voicecall: add ATD support for HFP emulator
Date: Tue, 07 Jun 2011 14:58:00 +0200
Message-ID: <4DEE2058.3000601@linux.intel.com>
In-Reply-To: <4DE6F0B4.10208@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1449366835972228057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

Le 02/06/2011 04:08, Denis Kenzior a =C3=A9crit :
>> +static void emulator_dial(struct ofono_emulator *em, struct ofono_voice=
call *vc,
>> +				const char *number)
>> +{
>> +	struct ofono_error result;
>> +	int err;
>> +
>> +	result.error =3D 0;
>> +
>> +	if (vc->pending_em) {
>> +		result.type =3D OFONO_ERROR_TYPE_FAILURE;
>> +		goto send;
>> +	}
>
> You might also want to check that the Dial is not happening via D-Bus or
> STK, and vice-versa.

Voicecall_dial will check if there is already a pending outgoing call.
I think this is sufficient to manage concurrent ATD between D-Bus, STK =

and emulator.

>
>> +
>> +	vc->pending_em =3D em;
>> +
>> +	err =3D voicecall_dial(vc, number, OFONO_CLIR_OPTION_DEFAULT,
>> +					emulator_dial_callback, vc);
>> +
>> +	if (err>=3D 0)
>> +		return;
>> +
>> +	vc->pending_em =3D NULL;
>> +
>> +	switch (err) {
>> +	case -ENETDOWN:
>> +		result.error =3D 30;
>> +		result.type =3D OFONO_ERROR_TYPE_CME;
>> +		break;
>> +
>> +	default:
>> +		result.type =3D OFONO_ERROR_TYPE_FAILURE;
>> +	}
>> +
>> +send:
>> +	ofono_emulator_send_final(em,&result);
>> +}
>> +

Regards

Fred


-- =

Frederic Danis                            Open Source Technology Centre
frederic.danis(a)intel.com                              Intel Corporation


--===============1449366835972228057==--

