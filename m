Content-Type: multipart/mixed; boundary="===============1951469807240450763=="
MIME-Version: 1.0
From: Florian Mayer <chef@ultra-gonzos.de>
Subject: Huawei EM700 SIM card recognition
Date: Wed, 04 Aug 2010 21:15:27 +0000
Message-ID: <4C59D862.90200@ultra-gonzos.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1951469807240450763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

we currently test a Huawei EM770W modem in a customer application =

together with ofono and connman. Dialup works fine so far with the =

2.6.35~rc5 kernel from Meego 1.1 developement trunk. With kernel =

2.6.33.3 from Meego 1.0 we had the problem that the communication got =

stuck from time to time. We had to reload the option.ko kernel module =

then. We use the recent release versions (0.26 and 0.55). The problem is =

that a SIM card is only recognised, when inserted before the device is =

powered on. A restart of ofonod is not a solution either.
Is there a way to reset the modem through ofono that it will recognize a =

recently inserted SIM card?

Regards
Florian Mayer
Mayer Electronics

--===============1951469807240450763==--

