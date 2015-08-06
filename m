Content-Type: multipart/mixed; boundary="===============1149927270281806457=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH 2/3] voicecall.c: call driver's dial string validation
Date: Thu, 06 Aug 2015 18:57:00 +0200
Message-ID: <1438880221-23834-4-git-send-email-kubax.t.pawlak@intel.com>
In-Reply-To: <1438880221-23834-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1149927270281806457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 550b79b404f605b9570e771c7754b51c52cfbabb..e030027c6d5b94ebbc7e92ff96c=
193d5a000e471 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1513,7 +1513,12 @@ static int voicecall_dial(struct ofono_voicecall *vc=
, const char *number,
 	if (g_slist_length(vc->call_list) >=3D MAX_VOICE_CALLS)
 		return -EPERM;
 =

-	if (!valid_long_phone_number_format(number))
+	if (vc->driver->validate_dial) {
+		if (!vc->driver->validate_dial(number)) {
+			return -EINVAL;
+		}
+	}
+	else if (!valid_long_phone_number_format(number))
 		return -EINVAL;
 =

 	if (ofono_modem_get_online(modem) =3D=3D FALSE)
-- =

1.7.11.7

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Prof. Dr. Hermann Eul
Chairperson of the Supervisory Board: Tiffany Doon Silva
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


--===============1149927270281806457==--

