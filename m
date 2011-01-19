Content-Type: multipart/mixed; boundary="===============2084871608309791993=="
MIME-Version: 1.0
From: Jussi Kangas <jussi.kangas@tieto.com>
Subject: Ofono has too tight limits for SIM lock code lengths
Date: Wed, 19 Jan 2011 11:04:44 +0200
Message-ID: <1295427884.3171.0.camel@jussi-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2084871608309791993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I've been testing SIM locks with Ofono and it looks to me that method
is_valid_pin in src/common.c has somewhat too tight rules for PIN
lenghts. SIM or subsidy lock codes can be longer than 8 digits (as
dictated in 22.022 chapter 14)

There are several ways to fix this. My current favourite is changing the
is_valid_pin so that it takes the actual return value of
sim_string_to_passwd instead of pin_type enumaration as parameter and
checks with 16-digit limit the SIM locks.

Other option that comes to my mind would be separate a valid check
method for SIM locks. =


As third option I suggest adding fifth value to pin_type enumeration and
give that as a parameter for is_valid_pin to make it use different
limits. It would require more specific code type recognition in calling
function though. =


Opinions? Other ideas?

Br, =

-Jussi =



--===============2084871608309791993==--

