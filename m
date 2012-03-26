Content-Type: multipart/mixed; boundary="===============4312930721044912769=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v2 07/12] hfp_ag: Add media transport support
Date: Mon, 26 Mar 2012 11:25:24 +0200
Message-ID: <1332753929-9711-8-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1332753929-9711-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4312930721044912769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index ea9c112..c12068a 100644
--- a/plugins/hfp_ag.c
+++ b/plugins/hfp_ag.c
@@ -82,6 +82,7 @@ static DBusMessage *hfp_ag_agent_new_connection(DBusConne=
ction *conn,
 		return __ofono_error_failed(msg);
 =

 	ofono_emulator_register(em, fd);
+	ofono_emulator_set_audio_transport(em, path);
 =

 	return dbus_message_new_method_return(msg);
 }
-- =

1.7.1


--===============4312930721044912769==--

