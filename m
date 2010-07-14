Content-Type: multipart/mixed; boundary="===============1723898447969227645=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] mbm: poll SIM status when initializing
Date: Wed, 14 Jul 2010 19:15:05 +0300
Message-ID: <AANLkTimlw9Lj66MC4jR0WQ65bto5qcmkygKaz6IEWfIA@mail.gmail.com>
In-Reply-To: <4C3DDF11.4070505@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1723898447969227645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/7/14 Denis Kenzior <denkenz@gmail.com>:
>> @@ -99,17 +102,35 @@ static void simpin_check(gboolean ok, GAtResult *re=
sult, gpointer user_data)
>>
>> =C2=A0 =C2=A0 =C2=A0 DBG("");
>>
>> - =C2=A0 =C2=A0 /* Modem returns error if there is no SIM in slot */
>> + =C2=A0 =C2=A0 /* Modem returns +CME ERROR: 10 if SIM is not ready. */
>> + =C2=A0 =C2=A0 if (!ok && result->final_or_pdu &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !strcmp(result->final_or_pdu=
, "+CME ERROR: 10")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_timeout_add_seconds(1, ini=
t_simpin_check, modem);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 /* Modem returns ERROR if there is no SIM in slot. */
>
> What if the modem has no SIM present at all? =C2=A0You might want to set a
> retry threshold so that we don't poll the modem into oblivion.

If there is no SIM, +CPIN? returns plain ERROR (as I try to explain in
the comment above).

+CME ERROR: 10 is returned while modem is busy trying to connect with
the SIM card.

I'll add a check to stop polling after 5 seconds.

-- =

Pekka.Pessi mail at nokia.com

--===============1723898447969227645==--

