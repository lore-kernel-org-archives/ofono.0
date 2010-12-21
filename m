Content-Type: multipart/mixed; boundary="===============0699853553890819945=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCHv2] plugin: Add ste modem initd integration
Date: Tue, 21 Dec 2010 16:06:20 +0100
Message-ID: <AANLkTikMvR2pYbyg_d=S0+Ba8usaJyEyveU--MXViv_C@mail.gmail.com>
In-Reply-To: <1292942189.2658.44.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0699853553890819945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.

>> +
>> +/* ResetState requests resending of StateChange. */
>> +#define MID_RESEND_STATE =C2=A0 =C2=A0 "ResendState"
>
> This is a bad D-Bus API btw. Using a D-Bus method to trigger signal
> sending. You will wake up any listener for that signal. What is wrong
> with just having a GetState?

My problem is that I need to get the path, or modem serial-number if
you like, to the
modem(s). As I don't know the start order I have to query the state at star=
tup.
So this will happens only once. The simples way for me to get the path is
to send "ResendState" to path "/". This will then send the state info
for all modem
paths.

I don't think I have the path them available at connect...
If you have any other ideas of how to query the modem instances I'm all ear=
s?


The other is feedback makes sens to me ;-)
Thanks for review and feedback.


Regards,
Sjur

--===============0699853553890819945==--

