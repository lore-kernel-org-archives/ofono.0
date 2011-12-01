Content-Type: multipart/mixed; boundary="===============2228549183891222718=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [RFC_v1 1/2] sierra: Fix memory leak
Date: Thu, 01 Dec 2011 17:48:52 +0100
Message-ID: <1322758133-19701-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1322758133-19701-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2228549183891222718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/sierra.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/plugins/sierra.c b/plugins/sierra.c
index c41e2d1..b33382d 100644
--- a/plugins/sierra.c
+++ b/plugins/sierra.c
@@ -79,6 +79,9 @@ static void sierra_remove(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, NULL);
 =

+	/* Cleanup after hot-unplug */
+	g_at_chat_unref(data->chat);
+
 	g_free(data);
 }
 =

-- =

1.7.1


--===============2228549183891222718==--

