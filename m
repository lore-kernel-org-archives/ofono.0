Content-Type: multipart/mixed; boundary="===============7503890708159705665=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: [PATCH 1/2] Telit HE910 general fixes for gprs, sms and voicecall
Date: Fri, 06 Mar 2015 17:07:00 +0100
Message-ID: <CAH4ZQwsN37v8_62vBf1vMNH3u+AdreTuONz38=_rC9ZREYTbew@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7503890708159705665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

diff --git a/plugins/he910.c b/plugins/he910.c
index 69362b8..304fd35 100644
--- a/plugins/he910.c
+++ b/plugins/he910.c
@@ -59,6 +59,8 @@
 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>

+#define TELIT_CFUN_DELAY 3*1000*1000 /* uS */
+
 static const char *none_prefix[] =3D { NULL };
 static const char *qss_prefix[] =3D { "#QSS:", NULL };

@@ -141,7 +143,7 @@ static void switch_sim_state_status(struct ofono_modem
*modem, int status)
        case 3: /* SIM inserted, SMS and phonebook ready */
                if (data->sms_phonebook_added =3D=3D FALSE) {
                        ofono_phonebook_create(modem, 0, "atmodem",
data->chat);
-                       ofono_sms_create(modem, 0, "atmodem", data->chat);
+                       ofono_sms_create(modem, OFONO_VENDOR_TELIT,
"atmodem", data->chat);
                        data->sms_phonebook_added =3D TRUE;
                }
                break;
@@ -217,6 +219,8 @@ static void cfun_enable_cb(gboolean ok, GAtResult
*result, gpointer user_data)
         * When the DCD is disabled the modem does not hangup anymore
         * after the data connection.
         */
+       g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);
+
        g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);

        data->have_sim =3D FALSE;
@@ -224,24 +228,40 @@ static void cfun_enable_cb(gboolean ok, GAtResult
*result, gpointer user_data)
        ofono_modem_set_powered(modem, TRUE);

-       /*
-        * Tell the modem not to automatically initiate auto-attach
-        * proceedures on its own.
-        */
-       g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix,
-                               NULL, NULL, NULL);
-
        /* Follow sim state */
        g_at_chat_register(data->chat, "#QSS:", he910_qss_notify,
                                FALSE, modem, NULL);

-       /* Enable sim state notification */
-       g_at_chat_send(data->chat, "AT#QSS=3D2", none_prefix, NULL, NULL,
NULL);
-
        g_at_chat_send(data->chat, "AT#QSS?", qss_prefix,
                        qss_query_cb, modem, NULL);
 }

+static void cfun_delay_cb(gboolean ok, GAtResult *result, gpointer
user_data)
+{
+       struct ofono_modem *modem =3D user_data;
+       struct he910_data *data =3D ofono_modem_get_data(modem);
+
+       DBG("%p", modem);
+
+       if (!ok) {
+               g_at_chat_unref(data->chat);
+               data->chat =3D NULL;
+
+               g_at_chat_unref(data->modem);
+               data->modem =3D NULL;
+
+               ofono_modem_set_powered(modem, FALSE);
+               return;
+       }
+
+       DBG("Wait for AT+CFUN=3D4 command completion");
+       usleep(TELIT_CFUN_DELAY);
+
+       /* Set phone functionality */
+       g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
+                               cfun_enable_cb, modem, NULL);
+}
+
 static int he910_enable(struct ofono_modem *modem)
 {
        struct he910_data *data =3D ofono_modem_get_data(modem);
@@ -268,9 +288,11 @@ static int he910_enable(struct ofono_modem *modem)
        g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
                                NULL, NULL, NULL);

-       /* Set phone functionality */
-       g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
-                               cfun_enable_cb, modem, NULL);
+       /* Set QSS notifications before restarting the SIM */
+       g_at_chat_send(data->chat, "AT#QSS=3D2", none_prefix,     NULL,
modem, NULL);
+
+       /* Power off module to get alla notifications on startup */
+       g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix, cfun_delay_c=
b,
modem, NULL);

        return -EINPROGRESS;
 }
@@ -333,7 +355,7 @@ static void he910_post_online(struct ofono_modem *modem)

        ofono_voicecall_create(modem, 0, "atmodem", data->chat);
        ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem",
data->chat);
-       ofono_ussd_create(modem, 0, "atmodem", data->chat);
+       ofono_ussd_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->chat);
        ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
        ofono_call_settings_create(modem, 0, "atmodem", data->chat);
        ofono_call_meter_create(modem, 0, "atmodem", data->chat);
@@ -349,6 +371,8 @@ static void he910_post_online(struct ofono_modem *modem)

        if (gprs && gc)
                ofono_gprs_add_context(gprs, gc);
+       g_at_chat_send(data->chat, "AT#AUTOATT=3D1", none_prefix,
+                               NULL, NULL, NULL);
 }

 static int he910_probe(struct ofono_modem *modem)
diff --git a/src/sim.c b/src/sim.c
index b5badf1..65e5c32 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -801,6 +801,29 @@ static DBusMessage *sim_change_pin(DBusConnection
*conn, DBusMessage *msg,
        return NULL;
 }

+static void sim_iccid_read_cb(int ok, int length, int record,
+                               const unsigned char *data,
+                               int record_length, void *userdata)
+{
+       struct ofono_sim *sim =3D userdata;
+       const char *path =3D __ofono_atom_get_path(sim->atom);
+       DBusConnection *conn =3D ofono_dbus_get_connection();
+       char iccid[21]; /* ICCID max length is 20 + 1 for NULL */
+
+       if (!ok || length < 10)
+               return;
+
+       extract_bcd_number(data, length, iccid);
+       iccid[20] =3D '\0';
+       sim->iccid =3D g_strdup(iccid);
+
+       ofono_dbus_signal_property_changed(conn, path,
+                                               OFONO_SIM_MANAGER_INTERFACE,
+                                               "CardIdentifier",
+                                               DBUS_TYPE_STRING,
+                                               &sim->iccid);
+}
+
 static void sim_enter_pin_cb(const struct ofono_error *error, void *data)
 {
        struct ofono_sim *sim =3D data;
@@ -813,6 +836,11 @@ static void sim_enter_pin_cb(const struct ofono_error
*error, void *data)

        __ofono_dbus_pending_reply(&sim->pending, reply);

+       if (!sim->iccid)
+               ofono_sim_read(sim->early_context, SIM_EF_ICCID_FILEID,
+
 OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
+                                          sim_iccid_read_cb, sim);
+
        __ofono_sim_recheck_pin(sim);
 }

@@ -2045,29 +2073,6 @@ skip_efpl:
        sim->language_prefs_update =3D FALSE;
 }

-static void sim_iccid_read_cb(int ok, int length, int record,
-                               const unsigned char *data,
-                               int record_length, void *userdata)
-{
-       struct ofono_sim *sim =3D userdata;
-       const char *path =3D __ofono_atom_get_path(sim->atom);
-       DBusConnection *conn =3D ofono_dbus_get_connection();
-       char iccid[21]; /* ICCID max length is 20 + 1 for NULL */
-
-       if (!ok || length < 10)
-               return;
-
-       extract_bcd_number(data, length, iccid);
-       iccid[20] =3D '\0';
-       sim->iccid =3D g_strdup(iccid);
-
-       ofono_dbus_signal_property_changed(conn, path,
-                                               OFONO_SIM_MANAGER_INTERFACE,
-                                               "CardIdentifier",
-                                               DBUS_TYPE_STRING,
-                                               &sim->iccid);
-}
-
 static void sim_iccid_changed(int id, void *userdata)
 {
        struct ofono_sim *sim =3D userdata;

--===============7503890708159705665==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGRpdiBjbGFz
cz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+
ZGlmZiAtLWdpdCBhL3BsdWdpbnMvaGU5MTAuYyBiL3BsdWdpbnMvaGU5MTAuYzwvZm9udD48L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBz
YW5zLXNlcmlmIj5pbmRleCA2OTM2MmI4Li4zMDRmZDM1IDEwMDY0NDwvZm9udD48L2Rpdj48ZGl2
IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNl
cmlmIj4tLS0gYS9wbHVnaW5zL2hlOTEwLmM8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+KysrIGIvcGx1
Z2lucy9oZTkxMC5jPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxl
Pjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPkBAIC01OSw2ICs1OSw4IEBAPC9mb250
PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRh
bmEsIHNhbnMtc2VyaWYiPsKgI2luY2x1ZGUgJmx0O2RyaXZlcnMvYXRtb2RlbS9hdHV0aWwuaCZn
dDs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFj
ZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+wqAjaW5jbHVkZSAmbHQ7ZHJpdmVycy9hdG1vZGVtL3Zl
bmRvci5oJmd0OzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48
Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj48YnI+PC9mb250PjwvZGl2PjxkaXYgY2xh
c3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYi
PisjZGVmaW5lIFRFTElUX0NGVU5fREVMQVkgMyoxMDAwKjEwMDAgLyogdVMgKi88L2ZvbnQ+PC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwg
c2Fucy1zZXJpZiI+KzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHls
ZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj7CoHN0YXRpYyBjb25zdCBjaGFyICpu
b25lX3ByZWZpeFtdID0geyBOVUxMIH07PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2Rl
ZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPsKgc3RhdGljIGNv
bnN0IGNoYXIgKnFzc19wcmVmaXhbXSA9IHsgJnF1b3Q7I1FTUzomcXVvdDssIE5VTEwgfTs8L2Zv
bnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVy
ZGFuYSwgc2Fucy1zZXJpZiI+PGJyPjwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZh
dWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj5AQCAtMTQxLDcgKzE0
Myw3IEBAIHN0YXRpYyB2b2lkIHN3aXRjaF9zaW1fc3RhdGVfc3RhdHVzKHN0cnVjdCBvZm9ub19t
b2RlbSAqbW9kZW0sIGludCBzdGF0dXMpPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2Rl
ZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPsKgIMKgIMKgIMKg
IGNhc2UgMzogLyogU0lNIGluc2VydGVkLCBTTVMgYW5kIHBob25lYm9vayByZWFkeSAqLzwvZm9u
dD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJk
YW5hLCBzYW5zLXNlcmlmIj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoZGF0YS0mZ3Q7c21z
X3Bob25lYm9va19hZGRlZCA9PSBGQUxTRSkgezwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj7CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBvZm9ub19waG9uZWJvb2tfY3JlYXRlKG1vZGVt
LCAwLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBkYXRhLSZndDtjaGF0KTs8L2ZvbnQ+PC9kaXY+PGRp
diBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1z
ZXJpZiI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBvZm9ub19zbXNfY3JlYXRl
KG1vZGVtLCAwLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBkYXRhLSZndDtjaGF0KTs8L2ZvbnQ+PC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwg
c2Fucy1zZXJpZiI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBvZm9ub19zbXNf
Y3JlYXRlKG1vZGVtLCBPRk9OT19WRU5ET1JfVEVMSVQsICZxdW90O2F0bW9kZW0mcXVvdDssIGRh
dGEtJmd0O2NoYXQpOzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHls
ZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBkYXRhLSZndDtzbXNfcGhvbmVib29rX2FkZGVkID0gVFJVRTs8L2ZvbnQ+
PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFu
YSwgc2Fucy1zZXJpZiI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTwvZm9udD48L2Rpdj48ZGl2
IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNl
cmlmIj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBicmVhazs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFz
cz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+
QEAgLTIxNyw2ICsyMTksOCBAQCBzdGF0aWMgdm9pZCBjZnVuX2VuYWJsZV9jYihnYm9vbGVhbiBv
aywgR0F0UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0YSk8L2ZvbnQ+PC9kaXY+PGRp
diBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1z
ZXJpZiI+wqAgwqAgwqAgwqAgwqAqIFdoZW4gdGhlIERDRCBpcyBkaXNhYmxlZCB0aGUgbW9kZW0g
ZG9lcyBub3QgaGFuZ3VwIGFueW1vcmU8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVm
YXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+wqAgwqAgwqAgwqAg
wqAqIGFmdGVyIHRoZSBkYXRhIGNvbm5lY3Rpb24uPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9Imdt
YWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPsKgIMKg
IMKgIMKgIMKgKi88L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+
PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+KyDCoCDCoCDCoCBnX2F0X2NoYXRfc2Vu
ZChkYXRhLSZndDttb2RlbSwgJnF1b3Q7QVQmYW1wO0MwJnF1b3Q7LCBOVUxMLCBOVUxMLCBOVUxM
LCBOVUxMKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZv
bnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+KzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJn
bWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj7CoCDC
oCDCoCDCoCBnX2F0X2NoYXRfc2VuZChkYXRhLSZndDtjaGF0LCAmcXVvdDtBVCZhbXA7QzAmcXVv
dDssIE5VTEwsIE5VTEwsIE5VTEwsIE5VTEwpOzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj48YnI+PC9m
b250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZl
cmRhbmEsIHNhbnMtc2VyaWYiPsKgIMKgIMKgIMKgIGRhdGEtJmd0O2hhdmVfc2ltID0gRkFMU0U7
PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9
InZlcmRhbmEsIHNhbnMtc2VyaWYiPkBAIC0yMjQsMjQgKzIyOCw0MCBAQCBzdGF0aWMgdm9pZCBj
ZnVuX2VuYWJsZV9jYihnYm9vbGVhbiBvaywgR0F0UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVyIHVz
ZXJfZGF0YSk8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZv
bnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+wqAgwqAgwqAgwqAgb2Zvbm9fbW9kZW1fc2V0
X3Bvd2VyZWQobW9kZW0sIFRSVUUpOzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZh
dWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj48YnI+PC9mb250Pjwv
ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEs
IHNhbnMtc2VyaWYiPi0gwqAgwqAgwqAgLyo8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+LSDCoCDCoCDC
oCDCoCogVGVsbCB0aGUgbW9kZW0gbm90IHRvIGF1dG9tYXRpY2FsbHkgaW5pdGlhdGUgYXV0by1h
dHRhY2g8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQg
ZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+LSDCoCDCoCDCoCDCoCogcHJvY2VlZHVyZXMgb24g
aXRzIG93bi48L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZv
bnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+LSDCoCDCoCDCoCDCoCovPC9mb250PjwvZGl2
PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNh
bnMtc2VyaWYiPi0gwqAgwqAgwqAgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7Y2hhdCwgJnF1b3Q7
QVQjQVVUT0FUVD0wJnF1b3Q7LCBub25lX3ByZWZpeCw8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0i
Z21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+LSDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOVUxMLCBOVUxMLCBO
VUxMKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQg
ZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+LTwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj7CoCDCoCDC
oCDCoCAvKiBGb2xsb3cgc2ltIHN0YXRlICovPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWls
X2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPsKgIMKgIMKg
IMKgIGdfYXRfY2hhdF9yZWdpc3RlcihkYXRhLSZndDtjaGF0LCAmcXVvdDsjUVNTOiZxdW90Oywg
aGU5MTBfcXNzX25vdGlmeSw8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIg
c3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgRkFMU0UsIG1vZGVtLCBOVUxMKTs8L2ZvbnQ+
PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFu
YSwgc2Fucy1zZXJpZiI+PGJyPjwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0
IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4tIMKgIMKgIMKgIC8qIEVu
YWJsZSBzaW0gc3RhdGUgbm90aWZpY2F0aW9uICovPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9Imdt
YWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPi0gwqAg
wqAgwqAgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7Y2hhdCwgJnF1b3Q7QVQjUVNTPTImcXVvdDss
IG5vbmVfcHJlZml4LCBOVUxMLCBOVUxMLCBOVUxMKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0i
Z21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+LTwv
Zm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2
ZXJkYW5hLCBzYW5zLXNlcmlmIj7CoCDCoCDCoCDCoCBnX2F0X2NoYXRfc2VuZChkYXRhLSZndDtj
aGF0LCAmcXVvdDtBVCNRU1M/JnF1b3Q7LCBxc3NfcHJlZml4LDwvZm9udD48L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlm
Ij7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBxc3NfcXVlcnlfY2IsIG1vZGVt
LCBOVUxMKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZv
bnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+wqB9PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9
ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPjxi
cj48L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFj
ZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+K3N0YXRpYyB2b2lkIGNmdW5fZGVsYXlfY2IoZ2Jvb2xl
YW4gb2ssIEdBdFJlc3VsdCAqcmVzdWx0LCBncG9pbnRlciB1c2VyX2RhdGEpPC9mb250PjwvZGl2
PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNh
bnMtc2VyaWYiPit7PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxl
Pjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPisgwqAgwqAgwqAgc3RydWN0IG9mb25v
X21vZGVtICptb2RlbSA9IHVzZXJfZGF0YTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+KyDCoCDCoCDC
oCBzdHJ1Y3QgaGU5MTBfZGF0YSAqZGF0YSA9IG9mb25vX21vZGVtX2dldF9kYXRhKG1vZGVtKTs8
L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0i
dmVyZGFuYSwgc2Fucy1zZXJpZiI+KzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZh
dWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rIMKgIMKgIMKgIERC
RygmcXVvdDslcCZxdW90OywgbW9kZW0pOzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9k
ZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rPC9mb250Pjwv
ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEs
IHNhbnMtc2VyaWYiPisgwqAgwqAgwqAgaWYgKCFvaykgezwvZm9udD48L2Rpdj48ZGl2IGNsYXNz
PSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4r
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdfYXRfY2hhdF91bnJlZihkYXRhLSZndDtjaGF0KTs8L2Zv
bnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVy
ZGFuYSwgc2Fucy1zZXJpZiI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkYXRhLSZndDtjaGF0ID0g
TlVMTDs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQg
ZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+KzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGdfYXRfY2hhdF91bnJlZihkYXRhLSZndDttb2RlbSk7PC9mb250Pjwv
ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEs
IHNhbnMtc2VyaWYiPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGF0YS0mZ3Q7bW9kZW0gPSBOVUxM
OzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNl
PSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2Rl
ZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPisgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgb2Zvbm9fbW9kZW1fc2V0X3Bvd2VyZWQobW9kZW0sIEZBTFNFKTs8L2ZvbnQ+
PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFu
YSwgc2Fucy1zZXJpZiI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm47PC9mb250PjwvZGl2
PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNh
bnMtc2VyaWYiPisgwqAgwqAgwqAgfTwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZh
dWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rPC9mb250PjwvZGl2
PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNh
bnMtc2VyaWYiPisgwqAgwqAgwqAgREJHKCZxdW90O1dhaXQgZm9yIEFUK0NGVU49NCBjb21tYW5k
IGNvbXBsZXRpb24mcXVvdDspOzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0
IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rIMKgIMKgIMKgIHVzbGVl
cChURUxJVF9DRlVOX0RFTEFZKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVs
dCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+KzwvZm9udD48L2Rpdj48
ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5z
LXNlcmlmIj4rIMKgIMKgIMKgIC8qIFNldCBwaG9uZSBmdW5jdGlvbmFsaXR5ICovPC9mb250Pjwv
ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEs
IHNhbnMtc2VyaWYiPisgwqAgwqAgwqAgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7Y2hhdCwgJnF1
b3Q7QVQrQ0ZVTj0xJnF1b3Q7LCBub25lX3ByZWZpeCw8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0i
Z21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+KyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjZnVuX2VuYWJsZV9j
YiwgbW9kZW0sIE5VTEwpOzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBz
dHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rfTwvZm9udD48L2Rpdj48ZGl2
IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNl
cmlmIj4rPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250
IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPsKgc3RhdGljIGludCBoZTkxMF9lbmFibGUoc3Ry
dWN0IG9mb25vX21vZGVtICptb2RlbSk8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVm
YXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+wqB7PC9mb250Pjwv
ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEs
IHNhbnMtc2VyaWYiPsKgIMKgIMKgIMKgIHN0cnVjdCBoZTkxMF9kYXRhICpkYXRhID0gb2Zvbm9f
bW9kZW1fZ2V0X2RhdGEobW9kZW0pOzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZh
dWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj5AQCAtMjY4LDkgKzI4
OCwxMSBAQCBzdGF0aWMgaW50IGhlOTEwX2VuYWJsZShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVt
KTwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNl
PSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj7CoCDCoCDCoCDCoCBnX2F0X2NoYXRfc2VuZChkYXRhLSZn
dDtjaGF0LCAmcXVvdDtBVEUwICtDTUVFPTEmcXVvdDssIG5vbmVfcHJlZml4LDwvZm9udD48L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBz
YW5zLXNlcmlmIj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBOVUxMLCBOVUxMLCBOVUxMKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVs
dCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+PGJyPjwvZm9udD48L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBz
YW5zLXNlcmlmIj4tIMKgIMKgIMKgIC8qIFNldCBwaG9uZSBmdW5jdGlvbmFsaXR5ICovPC9mb250
PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRh
bmEsIHNhbnMtc2VyaWYiPi0gwqAgwqAgwqAgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7Y2hhdCwg
JnF1b3Q7QVQrQ0ZVTj0xJnF1b3Q7LCBub25lX3ByZWZpeCw8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFz
cz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+
LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjZnVuX2VuYWJs
ZV9jYiwgbW9kZW0sIE5VTEwpOzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0
IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rIMKgIMKgIMKgIC8qIFNl
dCBRU1Mgbm90aWZpY2F0aW9ucyBiZWZvcmUgcmVzdGFydGluZyB0aGUgU0lNICovPC9mb250Pjwv
ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEs
IHNhbnMtc2VyaWYiPisgwqAgwqAgwqAgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7Y2hhdCwgJnF1
b3Q7QVQjUVNTPTImcXVvdDssIG5vbmVfcHJlZml4LCDCoCDCoCBOVUxMLCBtb2RlbSwgTlVMTCk7
PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9
InZlcmRhbmEsIHNhbnMtc2VyaWYiPis8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVm
YXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+KyDCoCDCoCDCoCAv
KiBQb3dlciBvZmYgbW9kdWxlIHRvIGdldCBhbGxhIG5vdGlmaWNhdGlvbnMgb24gc3RhcnR1cCAq
LzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNl
PSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rIMKgIMKgIMKgIGdfYXRfY2hhdF9zZW5kKGRhdGEtJmd0
O2NoYXQsICZxdW90O0FUK0NGVU49NCZxdW90Oywgbm9uZV9wcmVmaXgsIGNmdW5fZGVsYXlfY2Is
IG1vZGVtLCBOVUxMKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5
bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+PGJyPjwvZm9udD48L2Rpdj48ZGl2
IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNl
cmlmIj7CoCDCoCDCoCDCoCByZXR1cm4gLUVJTlBST0dSRVNTOzwvZm9udD48L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlm
Ij7CoH08L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQg
ZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+QEAgLTMzMyw3ICszNTUsNyBAQCBzdGF0aWMgdm9p
ZCBoZTkxMF9wb3N0X29ubGluZShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKTwvZm9udD48L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBz
YW5zLXNlcmlmIj48YnI+PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0
eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPsKgIMKgIMKgIMKgIG9mb25vX3Zv
aWNlY2FsbF9jcmVhdGUobW9kZW0sIDAsICZxdW90O2F0bW9kZW0mcXVvdDssIGRhdGEtJmd0O2No
YXQpOzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBm
YWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj7CoCDCoCDCoCDCoCBvZm9ub19uZXRyZWdfY3JlYXRl
KG1vZGVtLCBPRk9OT19WRU5ET1JfVEVMSVQsICZxdW90O2F0bW9kZW0mcXVvdDssIGRhdGEtJmd0
O2NoYXQpOzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9u
dCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4tIMKgIMKgIMKgIG9mb25vX3Vzc2RfY3JlYXRl
KG1vZGVtLCAwLCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBkYXRhLSZndDtjaGF0KTs8L2ZvbnQ+PC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwg
c2Fucy1zZXJpZiI+KyDCoCDCoCDCoCBvZm9ub191c3NkX2NyZWF0ZShtb2RlbSwgT0ZPTk9fVkVO
RE9SX1RFTElULCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBkYXRhLSZndDtjaGF0KTs8L2ZvbnQ+PC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwg
c2Fucy1zZXJpZiI+wqAgwqAgwqAgwqAgb2Zvbm9fY2FsbF9mb3J3YXJkaW5nX2NyZWF0ZShtb2Rl
bSwgMCwgJnF1b3Q7YXRtb2RlbSZxdW90OywgZGF0YS0mZ3Q7Y2hhdCk7PC9mb250PjwvZGl2Pjxk
aXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMt
c2VyaWYiPsKgIMKgIMKgIMKgIG9mb25vX2NhbGxfc2V0dGluZ3NfY3JlYXRlKG1vZGVtLCAwLCAm
cXVvdDthdG1vZGVtJnF1b3Q7LCBkYXRhLSZndDtjaGF0KTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFz
cz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+
wqAgwqAgwqAgwqAgb2Zvbm9fY2FsbF9tZXRlcl9jcmVhdGUobW9kZW0sIDAsICZxdW90O2F0bW9k
ZW0mcXVvdDssIGRhdGEtJmd0O2NoYXQpOzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9k
ZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj5AQCAtMzQ5LDYg
KzM3MSw4IEBAIHN0YXRpYyB2b2lkIGhlOTEwX3Bvc3Rfb25saW5lKHN0cnVjdCBvZm9ub19tb2Rl
bSAqbW9kZW0pPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxm
b250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPjxicj48L2ZvbnQ+PC9kaXY+PGRpdiBjbGFz
cz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+
wqAgwqAgwqAgwqAgaWYgKGdwcnMgJmFtcDsmYW1wOyBnYyk8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFz
cz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgb2Zvbm9fZ3Byc19hZGRfY29udGV4dChncHJzLCBnYyk7
PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9
InZlcmRhbmEsIHNhbnMtc2VyaWYiPisgwqAgwqAgwqAgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7
Y2hhdCwgJnF1b3Q7QVQjQVVUT0FUVD0xJnF1b3Q7LCBub25lX3ByZWZpeCw8L2ZvbnQ+PC9kaXY+
PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fu
cy1zZXJpZiI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBO
VUxMLCBOVUxMLCBOVUxMKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIg
c3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+wqB9PC9mb250PjwvZGl2Pjxk
aXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMt
c2VyaWYiPjxicj48L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+
PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+wqBzdGF0aWMgaW50IGhlOTEwX3Byb2Jl
KHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0pPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWls
X2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPmRpZmYgLS1n
aXQgYS9zcmMvc2ltLmMgYi9zcmMvc2ltLmM8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+aW5kZXggYjVi
YWRmMS4uNjVlNWMzMiAxMDA2NDQ8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVs
dCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+LS0tIGEvc3JjL3NpbS5j
PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9
InZlcmRhbmEsIHNhbnMtc2VyaWYiPisrKyBiL3NyYy9zaW0uYzwvZm9udD48L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlm
Ij5AQCAtODAxLDYgKzgwMSwyOSBAQCBzdGF0aWMgREJ1c01lc3NhZ2UgKnNpbV9jaGFuZ2VfcGlu
KERCdXNDb25uZWN0aW9uICpjb25uLCBEQnVzTWVzc2FnZSAqbXNnLDwvZm9udD48L2Rpdj48ZGl2
IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNl
cmlmIj7CoCDCoCDCoCDCoCByZXR1cm4gTlVMTDs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+wqB9PC9m
b250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZl
cmRhbmEsIHNhbnMtc2VyaWYiPjxicj48L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVm
YXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+K3N0YXRpYyB2b2lk
IHNpbV9pY2NpZF9yZWFkX2NiKGludCBvaywgaW50IGxlbmd0aCwgaW50IHJlY29yZCw8L2ZvbnQ+
PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFu
YSwgc2Fucy1zZXJpZiI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBjb25zdCB1bnNpZ25lZCBjaGFyICpkYXRhLDwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJn
bWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGludCByZWNvcmRfbGVu
Z3RoLCB2b2lkICp1c2VyZGF0YSk8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVs
dCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+K3s8L2ZvbnQ+PC9kaXY+
PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fu
cy1zZXJpZiI+KyDCoCDCoCDCoCBzdHJ1Y3Qgb2Zvbm9fc2ltICpzaW0gPSB1c2VyZGF0YTs8L2Zv
bnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVy
ZGFuYSwgc2Fucy1zZXJpZiI+KyDCoCDCoCDCoCBjb25zdCBjaGFyICpwYXRoID0gX19vZm9ub19h
dG9tX2dldF9wYXRoKHNpbS0mZ3Q7YXRvbSk7PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWls
X2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPisgwqAgwqAg
wqAgREJ1c0Nvbm5lY3Rpb24gKmNvbm4gPSBvZm9ub19kYnVzX2dldF9jb25uZWN0aW9uKCk7PC9m
b250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZl
cmRhbmEsIHNhbnMtc2VyaWYiPisgwqAgwqAgwqAgY2hhciBpY2NpZFsyMV07IC8qIElDQ0lEIG1h
eCBsZW5ndGggaXMgMjAgKyAxIGZvciBOVUxMICovPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9Imdt
YWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPis8L2Zv
bnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVy
ZGFuYSwgc2Fucy1zZXJpZiI+KyDCoCDCoCDCoCBpZiAoIW9rIHx8IGxlbmd0aCAmbHQ7IDEwKTwv
Zm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2
ZXJkYW5hLCBzYW5zLXNlcmlmIj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybjs8L2ZvbnQ+
PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFu
YSwgc2Fucy1zZXJpZiI+KzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBz
dHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rIMKgIMKgIMKgIGV4dHJhY3Rf
YmNkX251bWJlcihkYXRhLCBsZW5ndGgsIGljY2lkKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0i
Z21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+KyDC
oCDCoCDCoCBpY2NpZFsyMF0gPSAmIzM5O1wwJiMzOTs7PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9
ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPisg
wqAgwqAgwqAgc2ltLSZndDtpY2NpZCA9IGdfc3RyZHVwKGljY2lkKTs8L2ZvbnQ+PC9kaXY+PGRp
diBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1z
ZXJpZiI+KzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9u
dCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rIMKgIMKgIMKgIG9mb25vX2RidXNfc2lnbmFs
X3Byb3BlcnR5X2NoYW5nZWQoY29ubiwgcGF0aCw8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+KyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBPRk9OT19TSU1fTUFOQUdFUl9JTlRFUkZBQ0UsPC9mb250PjwvZGl2PjxkaXYgY2xh
c3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYi
PisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgJnF1b3Q7Q2FyZElkZW50aWZpZXImcXVvdDssPC9mb250PjwvZGl2Pjxk
aXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMt
c2VyaWYiPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgREJVU19UWVBFX1NUUklORyw8L2ZvbnQ+PC9kaXY+PGRpdiBj
bGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJp
ZiI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAmYW1wO3NpbS0mZ3Q7aWNjaWQpOzwvZm9udD48L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlm
Ij4rfTwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBm
YWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWls
X2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPsKgc3RhdGlj
IHZvaWQgc2ltX2VudGVyX3Bpbl9jYihjb25zdCBzdHJ1Y3Qgb2Zvbm9fZXJyb3IgKmVycm9yLCB2
b2lkICpkYXRhKTwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48
Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj7CoHs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFz
cz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+
wqAgwqAgwqAgwqAgc3RydWN0IG9mb25vX3NpbSAqc2ltID0gZGF0YTs8L2ZvbnQ+PC9kaXY+PGRp
diBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1z
ZXJpZiI+QEAgLTgxMyw2ICs4MzYsMTEgQEAgc3RhdGljIHZvaWQgc2ltX2VudGVyX3Bpbl9jYihj
b25zdCBzdHJ1Y3Qgb2Zvbm9fZXJyb3IgKmVycm9yLCB2b2lkICpkYXRhKTwvZm9udD48L2Rpdj48
ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5z
LXNlcmlmIj48YnI+PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxl
Pjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPsKgIMKgIMKgIMKgIF9fb2Zvbm9fZGJ1
c19wZW5kaW5nX3JlcGx5KCZhbXA7c2ltLSZndDtwZW5kaW5nLCByZXBseSk7PC9mb250PjwvZGl2
PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNh
bnMtc2VyaWYiPjxicj48L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5
bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+KyDCoCDCoCDCoCBpZiAoIXNpbS0m
Z3Q7aWNjaWQpPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxm
b250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgb2Zv
bm9fc2ltX3JlYWQoc2ltLSZndDtlYXJseV9jb250ZXh0LCBTSU1fRUZfSUNDSURfRklMRUlELDwv
Zm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2
ZXJkYW5hLCBzYW5zLXNlcmlmIj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgT0ZPTk9fU0lNX0ZJTEVfU1RSVUNUVVJFX1RSQU5T
UEFSRU5ULDwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9u
dCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2ltX2ljY2lkX3JlYWRfY2IsIHNp
bSk7PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZh
Y2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPis8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+wqAgwqAgwqAg
wqAgX19vZm9ub19zaW1fcmVjaGVja19waW4oc2ltKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0i
Z21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+wqB9
PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9
InZlcmRhbmEsIHNhbnMtc2VyaWYiPjxicj48L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+QEAgLTIwNDUs
MjkgKzIwNzMsNiBAQCBza2lwX2VmcGw6PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2Rl
ZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPsKgIMKgIMKgIMKg
IHNpbS0mZ3Q7bGFuZ3VhZ2VfcHJlZnNfdXBkYXRlID0gRkFMU0U7PC9mb250PjwvZGl2PjxkaXYg
Y2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2Vy
aWYiPsKgfTwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9u
dCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj48YnI+PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9
ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPi1z
dGF0aWMgdm9pZCBzaW1faWNjaWRfcmVhZF9jYihpbnQgb2ssIGludCBsZW5ndGgsIGludCByZWNv
cmQsPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZh
Y2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgY29uc3QgdW5zaWduZWQgY2hhciAqZGF0YSw8L2ZvbnQ+PC9kaXY+PGRp
diBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1z
ZXJpZiI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpbnQg
cmVjb3JkX2xlbmd0aCwgdm9pZCAqdXNlcmRhdGEpPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9Imdt
YWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPi17PC9m
b250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZl
cmRhbmEsIHNhbnMtc2VyaWYiPi0gwqAgwqAgwqAgc3RydWN0IG9mb25vX3NpbSAqc2ltID0gdXNl
cmRhdGE7PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250
IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPi0gwqAgwqAgwqAgY29uc3QgY2hhciAqcGF0aCA9
IF9fb2Zvbm9fYXRvbV9nZXRfcGF0aChzaW0tJmd0O2F0b20pOzwvZm9udD48L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlm
Ij4tIMKgIMKgIMKgIERCdXNDb25uZWN0aW9uICpjb25uID0gb2Zvbm9fZGJ1c19nZXRfY29ubmVj
dGlvbigpOzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9u
dCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4tIMKgIMKgIMKgIGNoYXIgaWNjaWRbMjFdOyAv
KiBJQ0NJRCBtYXggbGVuZ3RoIGlzIDIwICsgMSBmb3IgTlVMTCAqLzwvZm9udD48L2Rpdj48ZGl2
IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNl
cmlmIj4tPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250
IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPi0gwqAgwqAgwqAgaWYgKCFvayB8fCBsZW5ndGgg
Jmx0OyAxMCk8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZv
bnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1
cm47PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZh
Y2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPi08L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+LSDCoCDCoCDC
oCBleHRyYWN0X2JjZF9udW1iZXIoZGF0YSwgbGVuZ3RoLCBpY2NpZCk7PC9mb250PjwvZGl2Pjxk
aXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMt
c2VyaWYiPi0gwqAgwqAgwqAgaWNjaWRbMjBdID0gJiMzOTtcMCYjMzk7OzwvZm9udD48L2Rpdj48
ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5z
LXNlcmlmIj4tIMKgIMKgIMKgIHNpbS0mZ3Q7aWNjaWQgPSBnX3N0cmR1cChpY2NpZCk7PC9mb250
PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRh
bmEsIHNhbnMtc2VyaWYiPi08L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIg
c3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+LSDCoCDCoCDCoCBvZm9ub19k
YnVzX3NpZ25hbF9wcm9wZXJ0eV9jaGFuZ2VkKGNvbm4sIHBhdGgsPC9mb250PjwvZGl2PjxkaXYg
Y2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2Vy
aWYiPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgT0ZPTk9fU0lNX01BTkFHRVJfSU5URVJGQUNFLDwvZm9udD48L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBz
YW5zLXNlcmlmIj4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O0NhcmRJZGVudGlmaWVyJnF1b3Q7LDwvZm9u
dD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJk
YW5hLCBzYW5zLXNlcmlmIj4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIERCVVNfVFlQRV9TVFJJTkcsPC9mb250Pjwv
ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEs
IHNhbnMtc2VyaWYiPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmFtcDtzaW0tJmd0O2ljY2lkKTs8L2ZvbnQ+PC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwg
c2Fucy1zZXJpZiI+LX08L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5
bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+LTwvZm9udD48L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlm
Ij7CoHN0YXRpYyB2b2lkIHNpbV9pY2NpZF9jaGFuZ2VkKGludCBpZCwgdm9pZCAqdXNlcmRhdGEp
PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9
InZlcmRhbmEsIHNhbnMtc2VyaWYiPsKgezwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9k
ZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj7CoCDCoCDCoCDC
oCBzdHJ1Y3Qgb2Zvbm9fc2ltICpzaW0gPSB1c2VyZGF0YTs8L2ZvbnQ+PC9kaXY+PC9kaXY+PGRp
dj48ZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2Pgo8L2Rpdj4K

--===============7503890708159705665==--

