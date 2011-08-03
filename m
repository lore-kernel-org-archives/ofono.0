Content-Type: multipart/mixed; boundary="===============1889546840471668716=="
MIME-Version: 1.0
From: iiro.kaihlaniemi@nokia.com
Subject: [PATCH 0/3] isimodem: Allow network registration automatically
Date: Wed, 03 Aug 2011 11:12:09 +0000
Message-ID: <6B9DA0A3415B234191A1ADFA6275C51CB241E5@008-AM1MPN1-041.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1889546840471668716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Network registration is disabled by default. Enable network registration an=
d roaming  when network is started.

 drivers/isimodem/debug.c                |    5 ++
 drivers/isimodem/network-registration.c |   85 +++++++++++++++++++++++++++=
++++
 drivers/isimodem/network.h              |   12 ++++-
 3 files changed, 101 insertions(+), 1 deletions(-)

--===============1889546840471668716==--

