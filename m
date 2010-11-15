Content-Type: multipart/mixed; boundary="===============4733208035412022026=="
MIME-Version: 1.0
From: Andras Domokos <Andras.Domokos@nokia.com>
Subject: [RFC PATCH 2/5] history: expand history API
Date: Mon, 15 Nov 2010 13:50:15 +0200
Message-ID: <a66b016f1ffe986688b513d2703c35f05575ee7c.1289819191.git.Andras.Domokos@nokia.com>
In-Reply-To: <cover.1289819191.git.Andras.Domokos@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4733208035412022026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/history.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/src/history.c b/src/history.c
index 0229cf5..31efadb 100644
--- a/src/history.c
+++ b/src/history.c
@@ -114,6 +114,30 @@ void __ofono_history_probe_drivers(struct ofono_modem =
*modem)
 	}
 }
 =

+static void history_call_started(struct ofono_atom *atom, void *data)
+{
+	struct ofono_history_context *context =3D __ofono_atom_get_data(atom);
+	struct history_call_foreach_data *hfd =3D data;
+
+	if (context->driver->call_started =3D=3D NULL)
+		return;
+
+	context->driver->call_started(context, hfd->call, hfd->start);
+}
+
+void __ofono_history_call_started(struct ofono_modem *modem,
+				const struct ofono_call *call,
+				time_t start)
+{
+	struct history_call_foreach_data hfd;
+
+	hfd.call =3D call;
+	hfd.start =3D start;
+
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_HISTORY,
+					history_call_started, &hfd);
+}
+
 static void history_call_ended(struct ofono_atom *atom, void *data)
 {
 	struct ofono_history_context *context =3D __ofono_atom_get_data(atom);
-- =

1.7.0.4


--===============4733208035412022026==--

