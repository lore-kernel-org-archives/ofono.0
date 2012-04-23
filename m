Content-Type: multipart/mixed; boundary="===============3429165714853852003=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [RFC v4 10/10] emulator: Update supported features
Date: Mon, 23 Apr 2012 16:01:28 +0200
Message-ID: <4F9560B8.3090708@linux.intel.com>
In-Reply-To: <4F7F2A2B.8070708@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3429165714853852003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

Le 06/04/2012 19:38, Denis Kenzior a =C3=A9crit :
> Hi Fr=C3=A9d=C3=A9ric,
>
> On 04/06/2012 08:17 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
>> Add ECNR (Echo Cancelation/Noise Reduction) and Inband Ringtone
>> capabilities to supported features (+BRSF event)
>> ---
>>   src/emulator.c |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/emulator.c b/src/emulator.c
>> index e7c7d41..371e96c 100644
>> --- a/src/emulator.c
>> +++ b/src/emulator.c
>> @@ -979,6 +979,8 @@ struct ofono_emulator *ofono_emulator_create(struct =
ofono_modem *modem,
>>
>>   	em->type =3D type;
>>   	em->l_features |=3D HFP_AG_FEATURE_3WAY;
>> +	em->l_features |=3D HFP_AG_FEATURE_ECNR;
>> +	em->l_features |=3D HFP_AG_FEATURE_IN_BAND_RING_TONE;
>>   	em->l_features |=3D HFP_AG_FEATURE_REJECT_CALL;
>>   	em->l_features |=3D HFP_AG_FEATURE_ENHANCED_CALL_STATUS;
>>   	em->l_features |=3D HFP_AG_FEATURE_ENHANCED_CALL_CONTROL;
>
> I think it would be better for the features to be modified based on what
> command handlers are registered.  E.g. if NREC handler is registered in
> ofono_emulator_add_handler then add ECNR to local features, etc.

Local features are sent during reply to AT+BRSF command (after emulator =

creation and command handlers registration), but also in the Bluetooth =

SDP record, before client connection (so before emulator creation).

Imho, local features value should only be created in hfp_ag.c file, and =

passed to the emulator through ofono_emulator_create() or a new =

ofono_emulator_set_features() API.

Regards,

Fred

-- =

Frederic Danis                            Open Source Technology Center
frederic.danis(a)intel.com                              Intel Corporation


--===============3429165714853852003==--

