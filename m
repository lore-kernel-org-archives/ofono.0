Content-Type: multipart/mixed; boundary="===============1494882256211673007=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [sim-reset-pin PATCH 2/4] atmodem/sim: reset PIN or PIN2
Date: Thu, 26 Aug 2010 19:03:38 +0300
Message-ID: <AANLkTimNdTuk52VSGgB9b1VawN3y8gycCu436f8FAaP5@mail.gmail.com>
In-Reply-To: <4C768489.2030205@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1494882256211673007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/8/26 Denis Kenzior <denkenz@gmail.com>:
>> The PIN or PIN2 reset requires that modem waits for corresponding PUK co=
de.
>> If PIN is unlocked, modem does not wait for PUK code. Modem does not wait
>> for PUK2 by default. The modem is triggered into a state waiting for PUK
>> codes with AT+CPWD command.
>>
>> Password reset may fail if some other command is executed between AT+CPW=
D,
>> AT+CPIN? and AT+CPIN.
>
> Was this patch tested with modems other than mbm?

I'm testing on on the best. None other support PIN2.

-- =

Pekka.Pessi mail at nokia.com

--===============1494882256211673007==--

