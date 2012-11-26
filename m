Content-Type: multipart/mixed; boundary="===============0645588150659142899=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v1 15/15] bluetooth: Fix memory leak of UUIDs list
Date: Mon, 26 Nov 2012 10:27:09 -0300
Message-ID: <1353936429-9997-16-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1353936429-9997-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0645588150659142899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 3e63a3d..4dee100 100644
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


--===============0645588150659142899==--

