Content-Type: multipart/mixed; boundary="===============2063786754123586618=="
MIME-Version: 1.0
From: morphis@gravedo.de
Subject: Palm Pre modem plugin
Date: Fri, 20 Nov 2009 12:45:44 +0100
Message-ID: <3f617f05e6577dad60f6bde6f439783a@localhost>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2063786754123586618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hey,

I saw you added some time ago support for the Palm Pre MSM Modem. I am
working =

on the FSO (http://www.freesmartphone.org/) side to support this kind of
MSM =

modem as well. I am are currently stucked with the binary protocol spoken =

between modem and userland in webOS.

The Problem why we do this is the following: As I and some other people
find out, =

there is no support on the data channel (the one you use in oFono to speak

plain AT with the modem) for unsolicited responses.

So the only option is to support the binary protocol to get minimally the =

response from the modem when for example a call arrives.

So my question is: How do you want to manage this with your plugin for the

Palm Pre modem? Do you even plan to use the serial interface on the =

/dev/modemuart port? =


regards,
morphis


--===============2063786754123586618==--

