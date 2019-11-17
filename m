Content-Type: multipart/mixed; boundary="===============0590855669889339828=="
MIME-Version: 1.0
From: David Lechner <david@lechnology.com>
Subject: [PATCH] test: make all files executable
Date: Sun, 17 Nov 2019 22:03:24 +0000
Message-ID: <20191117220324.2401-1-david@lechnology.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0590855669889339828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This sets the executable bit on the only two files in the test directory
that do not already have it set.
---
 test/set-sms-alphabet       | 0
 test/test-serving-cell-info | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 =3D> 100755 test/set-sms-alphabet
 mode change 100644 =3D> 100755 test/test-serving-cell-info

diff --git a/test/set-sms-alphabet b/test/set-sms-alphabet
old mode 100644
new mode 100755
diff --git a/test/test-serving-cell-info b/test/test-serving-cell-info
old mode 100644
new mode 100755
-- =

2.20.1

--===============0590855669889339828==--

