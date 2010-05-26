Content-Type: multipart/mixed; boundary="===============8500264650209375503=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH v4 1/2] atmodem: remove CGACT command
Date: Wed, 26 May 2010 20:35:25 +0300
Message-ID: <878w76k1lu.fsf@potku.valot.fi>
In-Reply-To: <1274890351.27220.168.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8500264650209375503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Kalle,

Hi Marcel,

>> It's enough that we shutdown PPP, no need to send CGACT after that.
>> Recommended by Denis.
>> ---

[...]

>> @@ -104,13 +88,21 @@ static void ppp_disconnect(GAtPPPDisconnectReason r=
eason, gpointer user_data)
>>  	struct ofono_gprs_context *gc =3D user_data;
>>  	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
>>  =

>> -	if (gcd->state =3D=3D STATE_ENABLING) {
>> +	DBG("");
>> +
>> +	switch (gcd->state) {
>> +	case STATE_ENABLING:
>>  		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, FALSE, NULL,
>>  					NULL, NULL, NULL, gcd->cb_data);
>> -		return;
>> +		break;
>
> just double-checking that you really wanna have break; and not return;
> here. So that gcd->state gets reset to STATE_IDLE.

Yes, my intention was really to use break here.

-- =

Kalle Valo

--===============8500264650209375503==--

