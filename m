Content-Type: multipart/mixed; boundary="===============5638864131370084848=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 1/5] history: expand history API include file
Date: Mon, 22 Nov 2010 18:25:58 +0200
Message-ID: <a8cbb18df1857e4b6ea8a22c01f9c1cb801f9190.1290442823.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1290442823.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5638864131370084848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/history.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/history.h b/include/history.h
index c1c4aa1..a2490f6 100644
--- a/include/history.h
+++ b/include/history.h
@@ -49,6 +49,9 @@ struct ofono_history_driver {
 	const char *name;
 	int (*probe)(struct ofono_history_context *context);
 	void (*remove)(struct ofono_history_context *context);
+	void (*call_started)(struct ofono_history_context *context,
+				const struct ofono_call *call,
+				time_t start);
 	void (*call_ended)(struct ofono_history_context *context,
 				const struct ofono_call *call,
 				time_t start, time_t end);
-- =

1.7.0.4


--===============5638864131370084848==--

