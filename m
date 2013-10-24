Content-Type: multipart/mixed; boundary="===============8775606090315403683=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 1/4] plugin: Plugin that finds correspondence between MCC and
 MNC length
Date: Thu, 24 Oct 2013 13:01:09 +0200
Message-ID: <1382612469-29522-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8775606090315403683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The implementation searchs in two tables, one of them with some special cas=
es
for some operators and the other with the MNC length for a given MCC, as
recommended by the ITU (http://www.itu.int/pub/T-SP-E.212B).
---
 plugins/mnclength.c | 392 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 392 insertions(+)
 create mode 100644 plugins/mnclength.c

diff --git a/plugins/mnclength.c b/plugins/mnclength.c
new file mode 100644
index 0000000..ee40857
--- /dev/null
+++ b/plugins/mnclength.c
@@ -0,0 +1,392 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2013  Canonical Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <string.h>
+#include <stdlib.h>
+
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/types.h>
+#include <ofono/log.h>
+#include <ofono/plugin.h>
+#include <ofono/sim-mnclength.h>
+
+
+struct mcc_mnclength {
+	int mcc;
+	int mnclength;
+};
+
+/*
+ * Database of MCC to MNC length correspondences based on "Mobile Network =
Codes
+ * (MNC) for the international identification plan for public networks and
+ * subscriptions (According to Recommendation ITU-T E.212 (05/2008))"
+ * Latest version of that document can be found in
+ * http://www.itu.int/pub/T-SP-E.212B.
+ */
+static struct mcc_mnclength mnclen_db[] =3D {
+	{202, 2},
+	{204, 2},
+	{206, 2},
+	{208, 2},
+	{212, 2},
+	{213, 2},
+	{214, 2},
+	{216, 2},
+	{218, 2},
+	{219, 2},
+	{220, 2},
+	{222, 2},
+	{225, 2},
+	{226, 2},
+	{228, 2},
+	{230, 2},
+	{231, 2},
+	{232, 2},
+	{234, 2},
+	{235, 2},
+	{238, 2},
+	{240, 2},
+	{242, 2},
+	{244, 2},
+	{246, 2},
+	{247, 2},
+	{248, 2},
+	{250, 2},
+	{255, 2},
+	{257, 2},
+	{259, 2},
+	{260, 2},
+	{262, 2},
+	{266, 2},
+	{268, 2},
+	{270, 2},
+	{272, 2},
+	{274, 2},
+	{276, 2},
+	{278, 2},
+	{280, 2},
+	{282, 2},
+	{283, 2},
+	{284, 2},
+	{286, 2},
+	{288, 2},
+	{289, 2},
+	{290, 2},
+	{292, 2},
+	{293, 2},
+	{294, 2},
+	{295, 2},
+	{297, 2},
+	{302, 3},
+	{308, 2},
+	{310, 3},
+	{311, 3},
+	{312, 3},
+	{313, 3},
+	{314, 3},
+	{315, 3},
+	{316, 3},
+	{330, 2},
+	{332, 2},
+	{334, 3},
+	{338, 3},
+	{340, 2},
+	{342, 3},
+	{344, 3},
+	{346, 3},
+	{348, 3},
+	{350, 2},
+	{352, 2},
+	{354, 2},
+	{356, 2},
+	{358, 2},
+	{360, 2},
+	{362, 2},
+	{363, 2},
+	{364, 2},
+	{365, 3},
+	{366, 2},
+	{368, 2},
+	{370, 2},
+	{372, 2},
+	{374, 2},
+	{376, 2},
+	{400, 2},
+	{401, 2},
+	{402, 2},
+	{404, 2},
+	{405, 2},
+	{410, 2},
+	{412, 2},
+	{413, 2},
+	{414, 2},
+	{415, 2},
+	{416, 2},
+	{417, 2},
+	{418, 2},
+	{419, 2},
+	{420, 2},
+	{421, 2},
+	{422, 2},
+	{423, 2},
+	{424, 2},
+	{425, 2},
+	{426, 2},
+	{427, 2},
+	{428, 2},
+	{429, 2},
+	{430, 2},
+	{431, 2},
+	{432, 2},
+	{434, 2},
+	{436, 2},
+	{437, 2},
+	{438, 2},
+	{440, 2},
+	{441, 2},
+	{450, 2},
+	{452, 2},
+	{454, 2},
+	{455, 2},
+	{456, 2},
+	{457, 2},
+	{460, 2},
+	{461, 2},
+	{466, 2},
+	{467, 2},
+	{470, 2},
+	{472, 2},
+	{502, 2},
+	{505, 2},
+	{510, 2},
+	{514, 2},
+	{515, 2},
+	{520, 2},
+	{525, 2},
+	{528, 2},
+	{530, 2},
+	{534, 2},
+	{535, 2},
+	{536, 2},
+	{537, 2},
+	{539, 2},
+	{540, 2},
+	{541, 2},
+	{542, 2},
+	{543, 2},
+	{544, 2},
+	{545, 2},
+	{546, 2},
+	{547, 2},
+	{548, 2},
+	{549, 2},
+	{550, 2},
+	{551, 2},
+	{552, 2},
+	{602, 2},
+	{603, 2},
+	{604, 2},
+	{605, 2},
+	{606, 2},
+	{607, 2},
+	{608, 2},
+	{609, 2},
+	{610, 2},
+	{611, 2},
+	{612, 2},
+	{613, 2},
+	{614, 2},
+	{615, 2},
+	{616, 2},
+	{617, 2},
+	{618, 2},
+	{619, 2},
+	{620, 2},
+	{621, 2},
+	{622, 2},
+	{623, 2},
+	{624, 2},
+	{625, 2},
+	{626, 2},
+	{627, 2},
+	{628, 2},
+	{629, 2},
+	{630, 2},
+	{631, 2},
+	{632, 2},
+	{633, 2},
+	{634, 2},
+	{635, 2},
+	{636, 2},
+	{637, 2},
+	{638, 2},
+	{639, 2},
+	{640, 2},
+	{641, 2},
+	{642, 2},
+	{643, 2},
+	{645, 2},
+	{646, 2},
+	{647, 2},
+	{648, 2},
+	{649, 2},
+	{650, 2},
+	{651, 2},
+	{652, 2},
+	{653, 2},
+	{654, 2},
+	{655, 2},
+	{657, 2},
+	{702, 2},
+	{704, 2},
+	{706, 2},
+	{708, 3},
+	{710, 2},
+	{712, 2},
+	{714, 2},
+	{716, 2},
+	{722, 3},
+	{724, 2},
+	{730, 2},
+	{732, 3},
+	{734, 2},
+	{736, 2},
+	{738, 2},
+	{740, 2},
+	{742, 2},
+	{744, 2},
+	{746, 2},
+	{748, 2},
+	{750, 2},
+};
+
+/*
+ * These MCC+MNC combinations have 3 digit MNC even though the default for
+ * the corresponing MCC in mnclen_db is length 2.
+ */
+static int codes_mnclen3_db[] =3D {
+	405025, 405026, 405027, 405028, 405029, 405030, 405031, 405032,
+	405033, 405034, 405035, 405036, 405037, 405038, 405039, 405040,
+	405041, 405042, 405043, 405044, 405045, 405046, 405047, 405750,
+	405751, 405752, 405753, 405754, 405755, 405756, 405799, 405800,
+	405801, 405802, 405803, 405804, 405805, 405806, 405807, 405808,
+	405809, 405810, 405811, 405812, 405813, 405814, 405815, 405816,
+	405817, 405818, 405819, 405820, 405821, 405822, 405823, 405824,
+	405825, 405826, 405827, 405828, 405829, 405830, 405831, 405832,
+	405833, 405834, 405835, 405836, 405837, 405838, 405839, 405840,
+	405841, 405842, 405843, 405844, 405845, 405846, 405847, 405848,
+	405849, 405850, 405851, 405852, 405853, 405875, 405876, 405877,
+	405878, 405879, 405880, 405881, 405882, 405883, 405884, 405885,
+	405886, 405908, 405909, 405910, 405911, 405912, 405913, 405914,
+	405915, 405916, 405917, 405918, 405919, 405920, 405921, 405922,
+	405923, 405924, 405925, 405926, 405927, 405928, 405929, 405930,
+	405931, 405932
+};
+
+static int comp_int(const void *key, const void *value)
+{
+	int mccmnckey =3D *(int *) key;
+	int mccmnccurr =3D *(int *) value;
+
+	return mccmnckey - mccmnccurr;
+}
+
+static int comp_mcc(const void *key, const void *value)
+{
+	int mcc =3D *(int *) key;
+	struct mcc_mnclength *mccmnc =3D (struct mcc_mnclength *) value;
+
+	return mcc - mccmnc->mcc;
+}
+
+static int mnclength_get_mnclength(const char *imsi)
+{
+	char mccmnc[OFONO_MAX_MCC_LENGTH + OFONO_MAX_MNC_LENGTH + 1];
+	size_t nelem_mnclen3 =3D sizeof(codes_mnclen3_db)
+				/ sizeof(codes_mnclen3_db[0]);
+	size_t nelem_mccmnc =3D sizeof(mnclen_db)
+				/ sizeof(mnclen_db[0]);
+	int mccmnc_num;
+	int *mccmnc3_res;
+	int mcc_num;
+	struct mcc_mnclength *mccmnc_res;
+
+	if (strlen(imsi) < 6)
+		return 0;
+
+	/* Special case for some operators */
+	strncpy(mccmnc, imsi, sizeof(mccmnc) - 1);
+	mccmnc[sizeof(mccmnc) - 1] =3D '\0';
+	errno =3D 0;
+	mccmnc_num =3D (int) strtol(mccmnc, NULL, 10);
+
+	if (errno =3D=3D 0) {
+		mccmnc3_res =3D
+			bsearch(&mccmnc_num, codes_mnclen3_db, nelem_mnclen3,
+				sizeof(codes_mnclen3_db[0]), comp_int);
+
+		if (mccmnc3_res)
+			return 3;
+	}
+
+	/* General case */
+	mccmnc[OFONO_MAX_MCC_LENGTH] =3D '\0';
+	errno =3D 0;
+	mcc_num =3D (int) strtol(mccmnc, NULL, 10);
+
+	if (errno =3D=3D 0) {
+		mccmnc_res =3D
+			bsearch(&mcc_num, mnclen_db, nelem_mccmnc,
+				sizeof(mnclen_db[0]), comp_mcc);
+
+		if (mccmnc_res)
+			return mccmnc_res->mnclength;
+	}
+
+	return 0;
+}
+
+static struct ofono_sim_mnclength_driver mnclength_driver =3D {
+	.name		=3D "MNC length",
+	.get_mnclength	=3D mnclength_get_mnclength
+};
+
+static int mnclength_init(void)
+{
+	return ofono_sim_mnclength_driver_register(&mnclength_driver);
+}
+
+static void mnclength_exit(void)
+{
+	ofono_sim_mnclength_driver_unregister(&mnclength_driver);
+}
+
+OFONO_PLUGIN_DEFINE(mnclength, "MNC length Plugin", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			mnclength_init, mnclength_exit)
-- =

1.8.3.2


--===============8775606090315403683==--

