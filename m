Content-Type: multipart/mixed; boundary="===============4259767489567353258=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH v2] atmodem: fix crash during context deactivation
Date: Wed, 26 May 2010 18:06:59 +0300
Message-ID: <87hbluk8h8.fsf@potku.valot.fi>
In-Reply-To: <1274862952.27220.147.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4259767489567353258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Kalle,

Hi Marcel,

>> Ofono either crashed or busy looped with my Huawei E1552 3G modem when I
>> tried to deactivate GPRS context. The reason was that gcd->chat was
>> unreferenced already in setup_ppp() but the chat was still accessed
>> later in at_gprs_deactivate_primary().
>> =

>> To fix the problem, change the logic instead to suspend chat session
>> for PPP and resume when PPP has disconnected. Now it doesn't crash
>> anymore.
>> =


[...]

>>  	if (gcd->state =3D=3D STATE_ENABLING) {
>>  		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, FALSE, NULL,
>>  					NULL, NULL, NULL, gcd->cb_data);
>> -		return;
>> +	} else if (gcd->state =3D=3D STATE_DISABLING) {
>> +		CALLBACK_WITH_SUCCESS(gcd->down_cb, gcd->cb_data);
>> +	} else {
>> +		ofono_gprs_context_deactivated(gc, gcd->active_context);
>>  	}
>
> the easier to read coding style here is noew clearly a switch statement.

Agree.


[...]

> The rest looks fine to me. However maybe splitting this into one patch
> that removes the CGACT and another that adds suspend/resume calls seems
> a bit cleaner to me.

I'll send v3 soon.

-- =

Kalle Valo

--===============4259767489567353258==--

