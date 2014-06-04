Content-Type: multipart/mixed; boundary="===============1856395953167604452=="
MIME-Version: 1.0
From: Mark vd. Putten <mark.van.der.putten@intemo.com>
Subject: Multiplexer PH8 Cinterion modem
Date: Wed, 04 Jun 2014 10:26:17 +0200
Message-ID: <3921A44ACDC6C642B0BF6D8E48A862D19C0E86E02E@pdc.office.intemo.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1856395953167604452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I have got a PH8 Cinterion modem.

gatmux.c        ->      g_at_mux_setup_gsm0710
Queries the modem for available multiplex modes
The modem only returns a list with mode 0

ofonod[7120]: Setup: > AT+CMUX=3D?\r
ofonod[7120]: Setup: < \r\n+CMUX: (0)\r\n\r\nOK\r\n

This is not correctly handles by
gatmux.c        ->      mux_query_cb

It expects another subset
798     /* Subset */
799     if (!g_at_result_iter_open_list(&iter))
800             goto error;

Multiplex port is on USB and therefore has no requirements on speed.

What would be the best solution in changing this?
Hack the gatmux.c?


Please consider the environment before printing this email

This e-mail, and any files transmitted with it, is confidential and is inte=
nded solely for the use of the person or entity to whom it is addressed. If=
 you have received this e-mail in error, please notify the sender and delet=
e it from your records.

On all our offers, sales and deliveries our General Terms of Delivery are a=
pplicable, excluding all other Terms and Conditions. Our terms have been de=
posited at the Chamber of commerce Eindhoven (The Netherlands) august 23rd,=
 2001, reference number 17065041, a copy of these terms is enclosed with al=
l quotations, a hardcopy also can be send on your request. You can find our=
 General Terms online at http://www.intemo.com/terms.html

Op al onze aanbiedingen, verkopen en leveringen zijn, met uitsluiting van a=
lle andere voorwaarden, onze algemene voorwaarden van toepassing. Deze zijn=
 gedeponeerd bij de Kamer van Koophandel te Eindhoven onder nummer 17065041=
 per 23 augustus 2001. Bij iedere offerte hoe ook verzonden zijn de algemen=
e voorwaarden bijgevoegd, een kopie kan op aanvraag ook per post worden toe=
gezonden. U kunt onze algemene voorwaarden online inzien op http://www.inte=
mo.com/terms.html

--===============1856395953167604452==--

