Content-Type: multipart/mixed; boundary="===============0558100205465281594=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: support of "emergency call when SIM not inserted" ?
Date: Thu, 23 Sep 2010 17:13:26 +0300
Message-ID: <AANLkTimP-Tvv49XQUeJ1Jef2F9bgxH-eG23mYyMDJ1Rd@mail.gmail.com>
In-Reply-To: <1285250042.20811.76.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0558100205465281594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone,

2010/9/23 Marcel Holtmann <marcel@holtmann.org>:
>> I need a clarification about SIM:
>> Most GSM mobile phones can dial emergency calls even when the phone is
>> without a SIM card.
>> But it seems that oFono does not support an emergency call if the sim
>> driver is present but no SIM is inserted:
>
> I have never tested it by myself, but this should actually work just
> fine. The voice call driver is registered in the pre-SIM state and has
> some special handling when no SIM is present.
>
> If it does not work, then this is a bug.

It definitely is a bug (or missing feature). Andras from our team is
working on it, he can probably post patches on emergency call
handling. Shortly, the modem will register to network if a emergency
call is to be dialed.

-- =

Pekka.Pessi mail at nokia.com

--===============0558100205465281594==--

