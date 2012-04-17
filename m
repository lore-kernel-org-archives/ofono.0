Content-Type: multipart/mixed; boundary="===============3557892046555923412=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 2/2] plugins: Update new at_util_sim_state_query_new()
 prototype use
Date: Tue, 17 Apr 2012 16:48:24 +0200
Message-ID: <1334674104-30039-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1334674104-30039-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3557892046555923412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/alcatel.c |    3 ++-
 plugins/mbm.c     |    2 +-
 plugins/samsung.c |    3 ++-
 plugins/speedup.c |    3 ++-
 plugins/zte.c     |    3 ++-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/plugins/alcatel.c b/plugins/alcatel.c
index fd0e4ec..8005170 100644
--- a/plugins/alcatel.c
+++ b/plugins/alcatel.c
@@ -157,7 +157,8 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	}
 =

 	data->sim_state_query =3D at_util_sim_state_query_new(data->aux,
-						2, 20, sim_state_cb, modem);
+						2, 20, sim_state_cb, modem,
+						NULL);
 }
 =

 static int alcatel_enable(struct ofono_modem *modem)
diff --git a/plugins/mbm.c b/plugins/mbm.c
index 32c7665..035f87e 100644
--- a/plugins/mbm.c
+++ b/plugins/mbm.c
@@ -164,7 +164,7 @@ done:
 	data->sim_state_query =3D at_util_sim_state_query_new(data->modem_port,
 								1, 5,
 								sim_state_cb,
-								modem);
+								modem, NULL);
 }
 =

 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
diff --git a/plugins/samsung.c b/plugins/samsung.c
index 8e0d360..68a9b0a 100644
--- a/plugins/samsung.c
+++ b/plugins/samsung.c
@@ -142,7 +142,8 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	}
 =

 	data->sim_state_query =3D at_util_sim_state_query_new(data->chat,
-						1, 5, sim_state_cb, modem);
+						1, 5, sim_state_cb, modem,
+						NULL);
 }
 =

 static int samsung_enable(struct ofono_modem *modem)
diff --git a/plugins/speedup.c b/plugins/speedup.c
index ca6ed13..ca33f48 100644
--- a/plugins/speedup.c
+++ b/plugins/speedup.c
@@ -174,7 +174,8 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	}
 =

 	data->sim_state_query =3D at_util_sim_state_query_new(data->aux,
-						2, 20, sim_state_cb, modem);
+						2, 20, sim_state_cb, modem,
+						NULL);
 }
 =

 static int speedup_enable(struct ofono_modem *modem)
diff --git a/plugins/zte.c b/plugins/zte.c
index 3a83c8b..53beefe 100644
--- a/plugins/zte.c
+++ b/plugins/zte.c
@@ -218,7 +218,8 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	}
 =

 	data->sim_state_query =3D at_util_sim_state_query_new(data->aux,
-						2, 20, sim_state_cb, modem);
+						2, 20, sim_state_cb, modem,
+						NULL);
 }
 =

 static int zte_enable(struct ofono_modem *modem)
-- =

1.7.4.1


--===============3557892046555923412==--

