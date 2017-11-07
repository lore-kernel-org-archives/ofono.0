Content-Type: multipart/mixed; boundary="===============2405948580691714413=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 2/3] sim: logical access API implementation
Date: Tue, 07 Nov 2017 08:42:49 -0800
Message-ID: <1510072970-19030-2-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1510072970-19030-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2405948580691714413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implemented wrapper for the sim drivers logical
access API
---
 src/sim.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/sim.c b/src/sim.c
index f623db5..729c881 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -3644,3 +3644,18 @@ GSList *__ofono_sim_get_aid_list(struct ofono_sim *s=
im)
 {
 	return sim->aid_list;
 }
+
+int ofono_sim_logical_access(struct ofono_sim *sim, int session_id,
+		unsigned char *pdu, unsigned int len,
+		ofono_sim_logical_access_cb_t cb, void *data)
+{
+	if (!sim->driver->logical_access)
+		return -ENOTSUP;
+
+	if (session_id <=3D 0)
+		return -EINVAL;
+
+	sim->driver->logical_access(sim, session_id, pdu, len, cb, data);
+
+	return 0;
+}
-- =

2.7.4


--===============2405948580691714413==--

