Content-Type: multipart/mixed; boundary="===============2907801721956328664=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v3 0/3] sim: validate IMS private identity
Date: Sat, 16 Jan 2021 22:21:04 +0300
Message-ID: <20210116192107.18568-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2907801721956328664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis and all,

These patches add UTF8 validation for IMS private identity. Without
this check ofono may crash on dbus assert when SIM properties are
reported via org.ofono.SimManager interface.

Regards,
Sergey

v2 -> v3

- support both null-terminated and non-null terminated TLV values
- move validation helper into simutil.c
- add unit tests

Sergey Matyukevich (3):
  simutil: add validate_utf8_tlv
  sim: validate IMS private identity
  unit: add validate_utf8_tlv tests

 src/sim.c           |  3 ++-
 src/simutil.c       | 14 ++++++++++++++
 src/simutil.h       |  1 +
 unit/test-simutil.c | 22 ++++++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

--===============2907801721956328664==--

