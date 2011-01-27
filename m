Content-Type: multipart/mixed; boundary="===============2539424782788750336=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 0/3] Persist TX SMS messages
Date: Thu, 27 Jan 2011 16:43:00 -0200
Message-ID: <1296153783-2633-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2539424782788750336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Differences from previous version:

- Now we don't re-encode the SMS to a PDU when storing it to disk
- Sms' ref is not incremented
- When restoring sms pdus, directories and files that do not match the expe=
cted
  names are filtered out

I've tested this patch series using phonesim by calling exit(1) in some pla=
ces
to simulate crashes. The pending sms messages were correctly sent once oFono
was up again.


Lucas De Marchi (3):
  sms: store pending tx pdus on disk
  sms: delete sent sms messages from backup
  sms: restore pending tx messages from backup

 src/ofono.h   |    1 +
 src/sms.c     |   96 +++++++++++++++++++++
 src/smsutil.c |  260 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/smsutil.h |   19 ++++
 4 files changed, 376 insertions(+), 0 deletions(-)

-- =

1.7.3.5


--===============2539424782788750336==--

