Content-Type: multipart/mixed; boundary="===============0937104821889138136=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 2/3] ssn: add code and call id to notifications
Date: Wed, 09 Feb 2011 12:34:04 +0200
Message-ID: <a562a3e40e5acbb640fefca65b33e3bdf4d6e61b.1297244230.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1297244229.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0937104821889138136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/ssn.c |    4 ++--
 include/ssn.h         |    7 ++++---
 src/ofono.h           |    6 ++++--
 src/ssn.c             |   11 ++++++-----
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/atmodem/ssn.c b/drivers/atmodem/ssn.c
index b7a9df4..b00871d 100644
--- a/drivers/atmodem/ssn.c
+++ b/drivers/atmodem/ssn.c
@@ -56,7 +56,7 @@ static void cssi_notify(GAtResult *result, gpointer user_=
data)
 	if (!g_at_result_iter_next_number(&iter, &index))
 		index =3D 0;
 =

-	ofono_ssn_cssi_notify(ssn, code1, index);
+	ofono_ssn_cssi_notify(ssn, 0, code1, index);
 }
 =

 static void cssu_notify(GAtResult *result, gpointer user_data)
@@ -93,7 +93,7 @@ static void cssu_notify(GAtResult *result, gpointer user_=
data)
 		return;
 =

 out:
-	ofono_ssn_cssu_notify(ssn, code2, index, &ph);
+	ofono_ssn_cssu_notify(ssn, 0, code2, index, &ph);
 }
 =

 static void at_ssn_initialized(gboolean ok, GAtResult *result,
diff --git a/include/ssn.h b/include/ssn.h
index d640cad..ba3701b 100644
--- a/include/ssn.h
+++ b/include/ssn.h
@@ -37,9 +37,10 @@ struct ofono_ssn_driver {
 };
 =

 /* SSN notifications (CSSI and CSSU).  */
-void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, int code, int index);
-void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, int code, int index,
-				const struct ofono_phone_number *number);
+void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, unsigned int id,
+				int code1, int index);
+void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, unsigned int id, int cod=
e2,
+			int index, const struct ofono_phone_number *number);
 =

 int ofono_ssn_driver_register(const struct ofono_ssn_driver *d);
 void ofono_ssn_driver_unregister(const struct ofono_ssn_driver *d);
diff --git a/src/ofono.h b/src/ofono.h
index 6ba0187..eafab21 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -314,8 +314,10 @@ int __ofono_sms_sim_download(struct ofono_stk *stk, co=
nst struct sms *msg,
 =

 #include <ofono/ssn.h>
 =

-typedef void (*ofono_ssn_mo_notify_cb)(int index, void *user);
-typedef void (*ofono_ssn_mt_notify_cb)(int index,
+typedef void (*ofono_ssn_mo_notify_cb)(unsigned int id, int code1, int ind=
ex,
+					void *user);
+
+typedef void (*ofono_ssn_mt_notify_cb)(unsigned int id, int code2, int ind=
ex,
 					const struct ofono_phone_number *ph,
 					void *user);
 =

diff --git a/src/ssn.c b/src/ssn.c
index 64c94b7..065e4fd 100644
--- a/src/ssn.c
+++ b/src/ssn.c
@@ -112,7 +112,8 @@ gboolean __ofono_ssn_mt_watch_remove(struct ofono_ssn *=
ssn, unsigned int id)
 	return __ofono_watchlist_remove_item(ssn->mt_handler_list, id);
 }
 =

-void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, int code1, int index)
+void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, unsigned int id,
+				int code1, int index)
 {
 	struct ssn_handler *h;
 	GSList *l;
@@ -123,12 +124,12 @@ void ofono_ssn_cssi_notify(struct ofono_ssn *ssn, int=
 code1, int index)
 		notify =3D h->item.notify;
 =

 		if (h->code =3D=3D code1)
-			notify(index, h->item.notify_data);
+			notify(id, code1, index, h->item.notify_data);
 	}
 }
 =

-void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, int code2, int index,
-				const struct ofono_phone_number *ph)
+void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, unsigned int id, int cod=
e2,
+				int index, const struct ofono_phone_number *ph)
 {
 	struct ssn_handler *h;
 	GSList *l;
@@ -139,7 +140,7 @@ void ofono_ssn_cssu_notify(struct ofono_ssn *ssn, int c=
ode2, int index,
 		notify =3D h->item.notify;
 =

 		if (h->code =3D=3D code2)
-			notify(index, ph, h->item.notify_data);
+			notify(id, code2, index, ph, h->item.notify_data);
 	}
 }
 =

-- =

1.7.0.4


--===============0937104821889138136==--

