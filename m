Content-Type: multipart/mixed; boundary="===============9016330224165112803=="
MIME-Version: 1.0
From: Gabriel LUCAS <gabriel.lucas@smile.fr>
Subject: [PATCH] gemalto: add PIN retries support
Date: Fri, 03 Nov 2017 13:06:53 +0100
Message-ID: <4e565cf20cfc65f00a382e19803627ce@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9016330224165112803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 From 4157f3e7aa0eb16eec0b1ccf87946ecf53539090 Mon Sep 17 00:00:00 2001
 From: Gabriel Lucas <gabriel.lucas@smile.fr>
Date: Tue, 24 Oct 2017 11:15:58 +0200
Subject: [PATCH] gemalto: add PIN retries support
Signed-off-by: Gabriel Lucas <gabriel.lucas@smile.fr>

In SimManager, the Retries property isn't used for gemalto modems.
The at command AT^SPIC is used to get the remaining retries left
for the current required password type.

This commit adds the implementation in the SIM driver of the retries
queries.
---
  drivers/atmodem/sim.c | 45 =

+++++++++++++++++++++++++++++++++++++++++++++
  plugins/gemalto.c     |  3 ++-
  2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 8665274..ce70135 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -70,6 +70,7 @@ static const char *pct_prefix[] =3D { "#PCT:", NULL };
  static const char *pnnm_prefix[] =3D { "+PNNM:", NULL };
  static const char *qpinc_prefix[] =3D { "+QPINC:", NULL };
  static const char *upincnt_prefix[] =3D { "+UPINCNT:", NULL };
+static const char *spic_prefix[] =3D { "^SPIC:", NULL };
  static const char *none_prefix[] =3D { NULL };

  static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer =

user_data)
@@ -1054,6 +1055,45 @@ error:
      CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
  }

+static void spic_cb(gboolean ok, GAtResult *result, gpointer =

user_data)
+{
+    struct cb_data *cbd =3D user_data;
+    struct ofono_sim *sim =3D cbd->user;
+    ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
+    const char *final =3D g_at_result_final_response(result);
+    GAtResultIter iter;
+    struct ofono_error error;
+    int retries[OFONO_SIM_PASSWORD_INVALID];
+    size_t i;
+    int pin_type =3D ofono_sim_get_password_type(sim);
+
+    decode_at_error(&error, final);
+
+    if (!ok) {
+        cb(&error, NULL, cbd->data);
+        return;
+    }
+
+    for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
+        retries[i] =3D -1;
+
+    g_at_result_iter_init(&iter, result);
+
+    if (!g_at_result_iter_next(&iter, "^SPIC:"))
+        goto error;
+
+    if (!g_at_result_iter_next_number(&iter, &retries[pin_type]))
+        goto error;
+
+    DBG("Retry : %d, type : %d", retries[pin_type], pin_type);
+    cb(&error, retries, cbd->data);
+
+    return;
+
+error:
+    CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
  static void at_pin_retries_query(struct ofono_sim *sim,
                      ofono_sim_pin_retries_cb_t cb,
                      void *data)
@@ -1126,6 +1166,11 @@ static void at_pin_retries_query(struct =

ofono_sim *sim,
                      upincnt_cb, cbd, g_free) > 0)
              return;
          break;
+    case OFONO_VENDOR_CINTERION:
+        if (g_at_chat_send(sd->chat, "AT^SPIC", spic_prefix,
+                    spic_cb, cbd, g_free) > 0)
+            return;
+        break;
      default:
          if (g_at_chat_send(sd->chat, "AT+CPINR", cpinr_prefixes,
                      at_cpinr_cb, cbd, g_free) > 0)
diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 45ec0cf..3739d7b 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -420,7 +420,8 @@ static void gemalto_pre_sim(struct ofono_modem =

*modem)

      ofono_devinfo_create(modem, 0, "atmodem", data->app);
      ofono_location_reporting_create(modem, 0, "gemaltomodem", =

data->app);
-    sim =3D ofono_sim_create(modem, 0, "atmodem", data->app);
+    sim =3D ofono_sim_create(modem, OFONO_VENDOR_CINTERION, "atmodem",
+                        data->app);

      if (sim && data->have_sim =3D=3D TRUE)
          ofono_sim_inserted_notify(sim, TRUE);
-- =

1.9.1

--===============9016330224165112803==--

