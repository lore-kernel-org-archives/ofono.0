Content-Type: multipart/mixed; boundary="===============0435132754088881899=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 1/5 v3] nettime: Header file for nettime plugins
Date: Thu, 13 Jan 2011 11:49:31 +0200
Message-ID: <1294912175-12026-2-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1294912175-12026-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0435132754088881899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/nettime.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/nettime.h b/include/nettime.h
index 0f23cc7..2f73e1a 100644
--- a/include/nettime.h
+++ b/include/nettime.h
@@ -31,6 +31,10 @@ struct ofono_network_time;
 struct ofono_nettime_context {
 	struct ofono_nettime_driver *driver;
 	struct ofono_modem *modem;
+	unsigned int timed_watch;
+	gboolean timed_present;
+	struct ofono_netreg *netreg;
+	unsigned int netreg_st_watch;
 	void *data;
 };
 =

-- =

1.7.1


--===============0435132754088881899==--

