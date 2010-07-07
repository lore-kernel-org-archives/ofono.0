Content-Type: multipart/mixed; boundary="===============5060944358853818440=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: FYI: Emergency calls with MBM modem
Date: Wed, 07 Jul 2010 19:40:57 +0300
Message-ID: <AANLkTim-EqhbkjoopgLvX2_GhHxq_3j7k6XWOtTuUygG@mail.gmail.com>
In-Reply-To: <4C34A1A1.50006@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5060944358853818440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/7/7 Denis Kenzior <denkenz@gmail.com>:
>> Main results are:
>> - emergency calls are not possible in offline mode (CFUN=3D4), ATD112;
>> returns NO DIALTONE
>
> That was expected, do we have a solution in mind on how to do emergency
> dialing in Offline mode? =C2=A0Is it a UI problem?

I'd do like we do in the N900 equivivalent of voicecall atom:
- request online
- detach packet radio (if applicable)
- hang up existing calls

E.g., we would have something like
ofono_modem_set_emergency_mode(modem, bool) and
ofono_modem_get_emergency_mode().

In emergency mode (while emergency call is on-going) modem would:
- refuse to make other calls
- refuse to power off device

>> - emergency calls can be made without SIM card (but they require AT+CFUN=
=3D1)
>
> That was again expected...
>
>> - most MBM modem functionality (AT+COPS, AT+CLCC does not work without S=
IM card)
>
> The only one that can be triggered without a SIM card is AT+CLCC.

I mean, like, now atmodem voicecall driver is using +CHLD, but in
order to handle emergency calls gracefully it must know if the SIM is
active or not (and change its behavior accordingly.)

The AT+COPS? or AT+CREG? would be useful if you try to make emergency
call with weak reception.

> However, please note that MBM should not be using CLCC, but instead its
> own vendor-specific voicecall extensions.

OK, I hope they work better without SIM or PIN. ;)

>> - emergency calls cannot be handled with usual AT+CHLD commands (e.g.,
>> AT+CHLD=3D11 does not hang up emergency calls)
>
> That is a bit nasty, is there an assumption that every other call is
> hung up when an emergency number is dialed?

That sounds reasonable.

>> =C2=A0 (ofono cannot hangup emergency call and it does not notice when i=
t ends)
>> - emergency call gets number "112" and type 128 (unknown type of
>> number and numbering plan)
>
> Again, most likely because MBM uses its own voicecall extensions.
> Driving it with CLCC is wrong...

I'd guess this is partly because emergency calls do not have phone
numbers, but some kind of bitmask of desired emergency services
(police, hospital, coast guard, etc.), so modem just fills in fake
information in +CLCC.

>> Please find attached log. I first made call to 99999 (an ordinary
>> service number within our lab network) then 118 (non-existing service
>> number) then 112 (emergency call).
>>
>> The emergency call was terminated by callee around 02:58:52 (as you
>> can see, modem indicates it with +CIEV=3D8,0).
>
> These are Bluetooth Handsfree indicators btw, not typically used for
> driving a real modem...

Yes, they just provide useful indications what is going on.

-- =

Pekka.Pessi mail at nokia.com

--===============5060944358853818440==--

