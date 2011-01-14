Content-Type: multipart/mixed; boundary="===============4105680238503635057=="
MIME-Version: 1.0
From: Tomasz Gregorek <tomasz.gregorek@gmail.com>
Subject: [PATCH 1/2] plugins-mbm: Adding timer removal to mbm_remove()
Date: Fri, 14 Jan 2011 14:34:48 +0100
Message-ID: <1295012088-11579-1-git-send-email-tomasz.gregorek@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4105680238503635057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Tomasz Gregorek <tomasz.gregorek@stericsson.com>

In case the modem is disconnected during enabling process, mbm_disconnect()
will set up data->reopen_source timer. This timer needs to be
removed in mbm_remove() to stop execution of reopen_callback() after
hardware disconnection.
---
 plugins/mbm.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/plugins/mbm.c b/plugins/mbm.c
index dca9bd8..38583ac 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -91,6 +91,11 @@ static void mbm_remove(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	if (data->reopen_source > 0) {
+		g_source_remove(data->reopen_source);
+		data->reopen_source =3D 0;
+	}
+
 	ofono_modem_set_data(modem, NULL);
 =

 	g_at_chat_unref(data->data_port);
-- =

1.7.1


--===============4105680238503635057==--

