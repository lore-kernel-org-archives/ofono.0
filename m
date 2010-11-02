Content-Type: multipart/mixed; boundary="===============8326925059560346208=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/2] coding_style: Fix enum name
Date: Tue, 02 Nov 2010 22:21:36 +0800
Message-ID: <1288707697-26374-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8326925059560346208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/coding-style.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index 95ed50b..9e5a811 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -167,7 +167,7 @@ enum animal_type {
 If the enum contents have values (e.g. from specification) the preferred
 formatting is as follows:
 =

-enum animal type {
+enum animal_type {
 	ANIMAL_TYPE_FOUR_LEGS =3D		4,
 	ANIMAL_TYPE_EIGHT_LEGS =3D	8,
 	ANIMAL_TYPE_TWO_LEGS =3D		2,
-- =

1.7.2.3


--===============8326925059560346208==--

