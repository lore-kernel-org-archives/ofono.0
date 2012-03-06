Content-Type: multipart/mixed; boundary="===============2813575159444022144=="
MIME-Version: 1.0
From: Radek Polak <psonek2@seznam.cz>
Subject: Re: [Gta04-owner] Polling CLCC error handling on Option modem (GTA04)
Date: Tue, 06 Mar 2012 21:30:41 +0000
Message-ID: <201203062130.41546.psonek2@seznam.cz>
In-Reply-To: <2B3E493D-2A99-47FD-9AB7-C8669C14643A@goldelico.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2813575159444022144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday 06 March 2012 20:17:32 Dr. H. Nikolaus Schaller wrote:

> @Radek: is it possible to manually contact the AT interface in this state
> and try if it is still operational and another AT+CLCC would succeed?

It seems after few errors it starts working again - if i understand it righ=
t =

(see log below). Btw the probability of +CME ERROR increases with smaller C=
LCC =

interval.

So ingoring the error and trying again is the way to go for us?

Regards

Radek

AtChat :  F : "+CLCC: 1,1,4,0,0,"+420608828973",145" =

AtChat :  F : "OK" =

AtChat :  T : "AT+CLCC" =

AtChat :  F : "+CLCC: 1,1,4,0,0,"+420608828973",145" =

AtChat :  F : "OK" =

AtChat :  T : "AT+CLCC" =

AtChat :  F : "+CLCC: 1,1,4,0,0,"+420608828973",145" =

AtChat :  F : "OK" =

AtChat :  T : "AT+CLCC" =

AtChat :  F : "+CLCC: 1,1,4,0,0,"+420608828973",145" =

AtChat :  F : "OK" =

AtChat :  T : "AT+CLCC" =

AtChat :  F : "+CME ERROR: 100" =

AtChat :  T : "AT+CLCC" =

AtChat :  F : "+CME ERROR: 100" =

AtChat :  T : "AT+CLCC" =

AtChat :  F : "+CME ERROR: 100" =

AtChat :  T : "AT+CLCC" =

AtChat :  F : "+CME ERROR: 100" =

AtChat :  T : "AT+CLCC" =

AtChat :  F : "OK" =

AtChat :  T : "AT+CLCC" =

AtChat :  F : "OK" =

AtChat :  T : "AT+CLCC" =

AtChat :  F : "OK" =

AtChat :  T : "AT+CLCC" =

AtChat :  F : "OK" =

AtChat :  T : "AT+CLCC" =

AtChat :  F : "OK" =

AtChat :  T : "AT+CLCC" =

AtChat :  F : "OK" =

AtChat :  T : "AT+CLCC" =

AtChat :  F : "OK" =

AtChat :  T : "AT+CLCC" =

AtChat :  F : "OK" =

AtChat :  T : "AT+CLCC" =

AtChat :  F : "OK"

--===============2813575159444022144==--

