Content-Type: multipart/mixed; boundary="===============1754043575068650552=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH] Avoid error when URL is null
Date: Tue, 05 Apr 2011 14:07:05 +0200
Message-ID: <1302005225-30385-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1754043575068650552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Avoid error with STK command "LAUNCH BROWSER" and default URL

---
 src/stkagent.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/stkagent.c b/src/stkagent.c
index 54ca575..220812e 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -1061,6 +1061,9 @@ int stk_agent_confirm_launch_browser(struct stk_agent=
 *agent, const char *text,
 	if (agent->msg =3D=3D NULL)
 		return -ENOMEM;
 =

+	if (url =3D=3D NULL)
+		url =3D "";
+
 	dbus_message_append_args(agent->msg,
 					DBUS_TYPE_STRING, &text,
 					DBUS_TYPE_BYTE, &icon_id,
-- =

1.7.1


--===============1754043575068650552==--

