Content-Type: multipart/mixed; boundary="===============9016403027885142207=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Access to SIM card when Modem is not "Powered"
Date: Fri, 19 Mar 2010 19:24:41 +0200
Message-ID: <80fd4e751003191024w5aa343f1ke2c92fad680df80d@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9016403027885142207==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I think the Modem "Powered" property is meant to control the radios
(something like at+cfun=3D0 vs. at+cfun=3D1..). Now core automatically
removes all the atoms in case modem has "Powered" false. However, the
SIM card should be accessible while the radios are off (cfun=3D0) so
that PIN code could be entered. If the +CFUN=3D1 is given before PIN
code is entered, the modem registers to network in limited service
(emergency call only) mode. Perhaps it would be better to let the
modem driver itself decide which atoms are active when it is not fully
powered?

-- =

Pekka.Pessi mail at nokia.com

--===============9016403027885142207==--

