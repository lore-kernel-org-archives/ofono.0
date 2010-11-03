Content-Type: multipart/mixed; boundary="===============0206164649818206935=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] isigen: increase offline timeout
Date: Wed, 03 Nov 2010 20:30:53 +0200
Message-ID: <AANLkTikpTANKVM6aBZpXAmjp82hthZAn6xN7fXJbuhFp@mail.gmail.com>
In-Reply-To: <1288808493.9615.56.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0206164649818206935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/11/3 Marcel Holtmann <marcel@holtmann.org>:
>> The modem deregisters from network before response to MTC_STATE_REQ is
>> returned. Deregistering can take at least 8 seconds.
>> ---
>> =C2=A0plugins/isigen.c | =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/plugins/isigen.c b/plugins/isigen.c
>> index 493d926..014456f 100644
>> --- a/plugins/isigen.c
>> +++ b/plugins/isigen.c
>> @@ -373,7 +373,7 @@ static void isigen_online(struct ofono_modem *modem,=
 ofono_bool_t online,
>>
>> =C2=A0 =C2=A0 =C2=A0 isi->online =3D online;
>>
>> - =C2=A0 =C2=A0 if (g_isi_send(isi->client, req, sizeof(req), MTC_TIMEOU=
T,
>> + =C2=A0 =C2=A0 if (g_isi_send(isi->client, req, sizeof(req), 8 + MTC_TI=
MEOUT,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 mtc_state_cb, cbd, NULL))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>
> are you sure you just wanna hardcode it like this and not use a proper
> constant for it?

I'm not sure. It might depend on modem. Aki?

-- =

Pekka.Pessi mail at nokia.com

--===============0206164649818206935==--

