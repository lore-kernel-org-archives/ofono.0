Content-Type: multipart/mixed; boundary="===============1550882258768055277=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 0/3] Persist TX SMS messages
Date: Tue, 25 Jan 2011 10:47:12 -0200
Message-ID: <1295959635-4987-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1550882258768055277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series is a re-sending of a previous series sent by Kristen Carl=
son
Accardi. What I did was some cleanups, style changes, ported it to the new =
sms
API and fixed some leaks (hopefully I didn't introduce more).

Marcel/Denis, I don't know if letting "Based on patch from" is the right
approach. Feel free to change the author of the commits if you think this m=
ore
appropriate.

Lucas De Marchi (3):
  sms: store pending tx pdus on disk
  sms: delete sent sms messages from backup
  sms: restore pending tx messages from backup

 src/ofono.h   |    1 +
 src/sms.c     |  107 +++++++++++++++++++++++++++
 src/smsutil.c |  223 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/smsutil.h |   16 ++++
 4 files changed, 347 insertions(+), 0 deletions(-)

-- =

1.7.3.5


--===============1550882258768055277==--

