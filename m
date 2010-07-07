Content-Type: multipart/mixed; boundary="===============3573744364088350366=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: FYI: Emergency calls with MBM modem
Date: Wed, 07 Jul 2010 18:26:46 +0300
Message-ID: <AANLkTimjzak-lL4wbASpV4bAfuPzk2C4mltcSJ7kXw8G@mail.gmail.com>
In-Reply-To: <1278509608.2789.123.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3573744364088350366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/7/7 Marcel Holtmann <marcel@holtmann.org>:
> Hi Pekka,
>
>> I just did some emergency calls in our lab with the Ericsson MBM modem
>> (3507g). The modem firmware has the voice calls enabled, even while
>> there is no audio input/output from the modem (as far as I know).
>>
>> Main results are:
>> - emergency calls are not possible in offline mode (CFUN=3D4), ATD112;
>> returns NO DIALTONE
>> - emergency calls can be made without SIM card (but they require AT+CFUN=
=3D1)
>> - most MBM modem functionality (AT+COPS, AT+CLCC does not work without S=
IM card)
>> - emergency calls cannot be handled with usual AT+CHLD commands (e.g.,
>> AT+CHLD=3D11 does not hang up emergency calls)
>> =C2=A0 (ofono cannot hangup emergency call and it does not notice when i=
t ends)
>> - emergency call gets number "112" and type 128 (unknown type of
>> number and numbering plan)
>
> thanks for testing this. However I am not sure how representative these
> tests are since we are basically dealing with data-only modem. I know
> that the MBM in theory can support some sort of voice calls, but for the
> currently on the market MBM devices, that support might not be tested at
> all or being proper certified.

The MBM in question is a crippled OEM piece, modems really intended
for voice use would probably behave better.

However, 27.007 implies (see, for instance, commentary on +CPIN) that
things the atmodem voicecall driver takes as granted (+CLCC, +CHLD) do
not necessary work when there is no SIM or SIM is missing PIN code.
+CIND polling is only thing promised by spec (however, it did not work
on my MBM).

Another thing is the radio handling: making an emergency calls
requires that radio is explicitly turned on (with AT+CFUN=3D1). If there
is no SIM or SIM is missing PIN and radio is on, modem registers with
its IMEI code (it gets so called limited service). Keeping radio on in
limited service state just wastes battery (unless you want to make an
emergency call).

-- =

Pekka.Pessi mail at nokia.com

--===============3573744364088350366==--

