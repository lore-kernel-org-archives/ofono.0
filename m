Content-Type: multipart/mixed; boundary="===============2602510619288404073=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH 2/4] voicecall: add ATD support for HFP emulator
Date: Wed, 18 May 2011 17:33:13 +0200
Message-ID: <4DD3E6B9.7000908@linux.intel.com>
In-Reply-To: <4DD350AE.6020809@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2602510619288404073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

Le 18/05/2011 06:53, Denis Kenzior a =C3=A9crit :
> Hi Fr=C3=A9d=C3=A9ric,
>
> On 05/12/2011 09:40 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
>> ---
>>   src/voicecall.c |   92 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>   1 files changed, 92 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/voicecall.c b/src/voicecall.c
>> index 037caac..b98c858 100644
>> --- a/src/voicecall.c
>> +++ b/src/voicecall.c
>> @@ -2473,6 +2473,10 @@ static void emulator_hfp_unregister(struct ofono_=
atom *atom)
>>   						OFONO_ATOM_TYPE_EMULATOR_HFP,
>>   						emulator_remove_handler,
>>   						"+CHLD");
>> +	__ofono_modem_foreach_registered_atom(modem,
>> +						OFONO_ATOM_TYPE_EMULATOR_HFP,
>> +						emulator_remove_handler,
>> +						"D");
>>
>>   	__ofono_modem_remove_atom_watch(modem, vc->hfp_watch);
>>   }
>> @@ -2918,6 +2922,93 @@ fail:
>>   	ofono_emulator_send_final(em,&result);
>>   }
>>
>> +static void emulator_dial_callback(const struct ofono_error *error, voi=
d *data)
>> +{
>> +	struct ofono_voicecall *vc =3D data;
>> +	const char *number =3D NULL;
>> +	gboolean need_to_emit;
>> +	struct voicecall *v;
>> +
>> +	v =3D dial_handle_result(vc, error, number,&need_to_emit);
>> +
>> +	if (v =3D=3D NULL) {
>> +		struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
>> +
>> +		if (is_emergency_number(vc, number) =3D=3D TRUE)
>> +			__ofono_modem_dec_emergency_mode(modem);
>> +	}
>> +
>> +	if (need_to_emit)
>> +		voicecalls_emit_call_added(vc, v);
>> +}
>> +
>> +static void emulator_dial(struct ofono_emulator *em, struct ofono_voice=
call *vc,
>> +				const char *number)
>> +{
>> +	enum ofono_clir_option clir;
>> +	struct ofono_error result;
>> +	enum dial_error err;
>> +
>> +	result.error =3D 0;
>> +
>> +	if (number =3D=3D NULL || number[0] =3D=3D '\0') {
>> +		result.type =3D OFONO_ERROR_TYPE_FAILURE;
>> +		goto send;
>> +	}
>> +
>> +	if (!strncmp(number, "*31#", 4)) {
>> +		number +=3D 4;
>> +		clir =3D OFONO_CLIR_OPTION_INVOCATION;
>> +	} else if (!strncmp(number, "#31#", 4)) {
>> +		number +=3D 4;
>> +		clir =3D  OFONO_CLIR_OPTION_SUPPRESSION;
>> +	} else
>> +		clir =3D OFONO_CLIR_OPTION_DEFAULT;
>> +
>
> Actually this is not quite right.  The clir option is determined by the
> presence of 'I'/'i' characters at the end of the dial string.  Refer to
> 27.007 for more details.
>
> oFono does not actually recognize temporary forms of *31/#31 invocation y=
et.
>
I added *31/#31 as I found them in telephony-ofono implementation of =

BlueZ HFP AG,
but 27.007 uses I/i,
and HFP 1.5 does not seem to support clir option (ATDdd...dd;)

Should I remove this part of code and only be compatible with HFP specs ?

>> +	err =3D voicecall_dial(vc, number, clir, emulator_dial_callback, vc);
>> +	switch (err) {
>> +	case DIAL_NO_ERROR:
>> +		result.type =3D OFONO_ERROR_TYPE_NO_ERROR;
>> +		break;
>> +
>> +	case DIAL_NO_NETWORK:
>> +		result.error =3D 30;
>> +		result.type =3D OFONO_ERROR_TYPE_CME;
>> +		break;
>
> This might need to be NO CARRIER
>
As far as I understand, when there is no network, ATD should reply NO =

CARRIER if CMEE error mode is set to 0, or +CME ERROR: 30 if it is set to 1.
So, I think that voicecall should return an OFONO_ERROR_TYPE_CME 30, and =

ofono_emulator_send_final should take care of replying the right string.

Something like :

void ofono_emulator_send_final(struct ofono_emulator *em,
				const struct ofono_error *final)
{
	char buf[256];

	/*
	 * TODO: Handle various CMEE modes and report error strings from
	 * common.c
	 */
	switch (final->type) {
	case OFONO_ERROR_TYPE_CMS:
		sprintf(buf, "+CMS ERROR: %d", final->error);
		g_at_server_send_ext_final(em->server, buf);
		break;

	case OFONO_ERROR_TYPE_CME:
		switch (em->cmee_mode) {
		case 1:
			sprintf(buf, "+CME ERROR: %d", final->error);
			break;

		case 2:
			sprintf(buf, "+CME ERROR: %s",
					telephony_error_to_str(final));
			break;

		default:
			if (final->error =3D=3D 30) {
				g_at_server_send_final(em->server,
					G_AT_SERVER_RESULT_NO_CARRIER);
				break;
			}

			goto failure;
		}

		g_at_server_send_ext_final(em->server, buf);
		break;

	case OFONO_ERROR_TYPE_NO_ERROR:
		g_at_server_send_final(em->server,
					G_AT_SERVER_RESULT_OK);
		break;

	case OFONO_ERROR_TYPE_CEER:
	case OFONO_ERROR_TYPE_SIM:
	case OFONO_ERROR_TYPE_FAILURE:
failure:
		g_at_server_send_final(em->server,
					G_AT_SERVER_RESULT_ERROR);
		break;
	};
}

Is it Ok ?

Regards

Fred

-- =

Frederic Danis                            Open Source Technology Centre
frederic.danis(a)intel.com                              Intel Corporation


--===============2602510619288404073==--

