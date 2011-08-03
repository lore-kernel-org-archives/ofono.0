Content-Type: multipart/mixed; boundary="===============4235532320988251619=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v5 2/8] cdmamodem: define CDMA netreg atom.
Date: Wed, 03 Aug 2011 15:50:46 +0200
Message-ID: <1312379452-821-3-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312379452-821-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4235532320988251619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 808a8f1..ef5e77d 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -135,6 +135,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_LOCATION_REPORTING,
 	OFONO_ATOM_TYPE_GNSS,
 	OFONO_ATOM_TYPE_CDMA_SMS,
+	OFONO_ATOM_TYPE_CDMA_NETREG,
 };
 =

 enum ofono_atom_watch_condition {
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============4235532320988251619==--

