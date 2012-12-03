Content-Type: multipart/mixed; boundary="===============5331206945925787972=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 14/14] bluetooth: Fix memory leak of UUIDs list
Date: Mon, 03 Dec 2012 10:11:55 -0300
Message-ID: <1354540315-27731-15-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1354540315-27731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5331206945925787972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index ce6dcae..52bf71f 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -434,8 +434,10 @@ static gboolean properties_changed(DBusConnection *con=
n, DBusMessage *msg,
 	 * create the modem properly, including Adapter and
 	 * Alias, so refetch everything again
 	 */
-	if (uuids)
+	if (uuids) {
 		get_device_properties(path);
+		g_slist_free(uuids);
+	}
 =

 	if (alias) {
 		GHashTableIter hash_iter;
-- =

1.7.11.7


--===============5331206945925787972==--

