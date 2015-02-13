Content-Type: multipart/mixed; boundary="===============0889931742839240919=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: [PATCH 0/2] SMS-DELIVER TP-OA Alphanum decoding and encoding fix
Date: Fri, 13 Feb 2015 14:23:44 +0200
Message-ID: <1423830226-32024-1-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0889931742839240919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are problems with some real-life scenarios where SMS-DELIVER originat=
or
address is an alphanumeric string with 11 chars (some extended ASCII like =
=C3=A4=C3=B6=C3=BC).
Currently oFono rejects such messages. Here's a patch to improve that.

Tommi Kenakkala (2):
  sms: SMS-DELIVER TP-OA Alphanum decoding and encoding fix
  unit: SMS-DELIVER decoding/encoding test for long alphanum address

 src/smsutil.c   |   12 +++++++++---
 src/smsutil.h   |    6 +++++-
 unit/test-sms.c |   38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 4 deletions(-)

-- =

1.7.9.5


--===============0889931742839240919==--

