Content-Type: multipart/mixed; boundary="===============8474239365327852870=="
MIME-Version: 1.0
From: Mylene JOSSERAND <mylene.josserand@openwide.fr>
Subject: [help] automatic data reconnection in case of signal loss
Date: Wed, 24 Dec 2014 15:39:05 +0100
Message-ID: <549AD009.6@openwide.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8474239365327852870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone,


I am doing some tests with Ofono.
Currently, I am trying to see if Ofono can handle an automatic data =

reconnection in case of signal loss.

I am doing the following test :
- Connect the modem to data connection via atmodem driver (so PPP link)
- Disconnect the antenna to lose signal
- Reconnect the antenna to get signal back
- Try to get data connection back

The atmodem driver is notified that the signal is lost so it disconnects =

ppp with "gprs-context.c:ppp_disconnect() Reason: 6".
After re-connecting the antenna and that the network is back, in the =

Ofono interfaces, it did not changed, I always have the =

ConnectionManager interface. The difference is that the context is not =

activated. So, I try to re-activate it but it failed with error :

gprs.c:pri_activate_callback() Activating context failed with error: =

Unknown error type

I guess that someone should have test it before me. If it is the case, =

is there something I am doing wrong ? I do not know how Ofono should =

react in this case. Maybe it should remove some interfaces ? Go in =

"offline" mode ?
If nobody tested it before, what should I look for ?


Thank you in advance for any help and Merry Christmas :)


Myl=C3=A8ne

--===============8474239365327852870==--

