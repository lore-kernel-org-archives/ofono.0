Content-Type: multipart/mixed; boundary="===============7084763747300201804=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 0/2] phonesim: Add timer to set the variable with the delay
Date: Wed, 29 Feb 2012 11:37:45 +0200
Message-ID: <1330508267-8656-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7084763747300201804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the changes in order to permit to set variables
with the delay (specify the delay in milliseconds):

<chat>
	<set name=3D"AAA" value=3D"BBB" delay=3D"30000"/>
</chat>

This might be useful to simulate SIM PIN unlocking cases, etc.

Regards,
Oleg

Oleg Zhurakivskyy (2):
  phonesim: Minor reflow in SimChat::command()
  phonesim: Add timer to set the variable with the delay

 src/phonesim.cpp |   49 ++++++++++++++++++++++++++++++++++++++-----------
 src/phonesim.h   |   14 ++++++++++++++
 2 files changed, 52 insertions(+), 11 deletions(-)

-- =

1.7.5.4


--===============7084763747300201804==--

