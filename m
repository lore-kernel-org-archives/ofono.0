Content-Type: multipart/mixed; boundary="===============0609115070829194950=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: qmi on huawei
Date: Mon, 26 Nov 2012 16:32:37 +0100
Message-ID: <CABvLYuAOC9uTod+r_bQZaDUrMibA64y2ApCZ_AWbLa6Lk+YWXg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0609115070829194950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I have a Huawei E398 dongle with a qmi interface, and i'm trying to make
ofono use the qmi interface for the gprs-context atom. I have this working,
but depending on how i unref the qmi_device in huawei_disable, ofono
crashes or there's have a memory leak.

The first approach i've tried is the same as in the gobi plugin.
I call qmi_device_shutdown() from huawei_disable(), and unref the
qmi_device from the callback.
The problem with this is: when i unplug the device ofono crashes.
When the device is unplugged, first  huawei_disable() is called, then
huawei_remove(), and
afterwards shutdown_cb() is called. At that time the ofono_modem struct is
already freed, shutdown_cb() tries to access it and crashes.

The second approach i've tried is to unref the qmi_device directly from
huawei_disable.
With this approach, i see a memory leak of the qmi_service.
qmi_gprs_context_remove() is being called from flush_atoms(). And i can see
release_client() is being called. But the service_release_callback(), which
should free the service, is never being called.
I think the request get's canceled because qmi_device_unref() is being
called from huawei_disable(). The request is destroyed and the callback
which should free the qmi_service is never called.

Does anyone have thoughts/ideas on how i can fix this?

Below are the changes to the huawei plugin to add qmi support (other
patches are needed to make it work, but they're not relevant to this issue).

Thanks,
Cedric

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 5d8875a..7003760 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -26,6 +26,8 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+#include <fcntl.h>
+#include <unistd.h>

 #include <glib.h>
 #include <gatchat.h>
@@ -57,6 +59,10 @@
 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>

+#include <drivers/qmimodem/qmi.h>
+#include <drivers/qmimodem/dms.h>
+#include <drivers/qmimodem/util.h>
+
 static const char *none_prefix[] =3D { NULL };
 static const char *gcap_prefix[] =3D { "+GCAP:", NULL };
 static const char *rfswitch_prefix[] =3D { "^RFSWITCH:", NULL };
@@ -78,6 +84,7 @@ enum {
 struct huawei_data {
        GAtChat *modem;
        GAtChat *pcui;
+       struct qmi_device *device;
        gboolean have_sim;
        int sim_state;
        guint sysinfo_poll_source;
@@ -120,6 +127,7 @@ static void huawei_remove(struct ofono_modem *modem)

        /* Cleanup after hot-unplug */
        g_at_chat_unref(data->pcui);
+       qmi_device_unref(data->device);

        g_free(data);
 }
@@ -577,6 +585,36 @@ static GAtChat *open_device(struct ofono_modem *modem,
        return chat;
 }

+static struct qmi_device *open_qmi_device(struct ofono_modem *modem,
+                                       const char *key, char *debug)
+
+{
+       const char *device;
+       struct qmi_device *qmi_device;
+       int fd;
+
+       device =3D ofono_modem_get_string(modem, key);
+       if (device =3D=3D NULL)
+               return NULL;
+       DBG("%s %s", key, device);
+
+       fd =3D open(device, O_RDWR | O_NONBLOCK | O_CLOEXEC);
+       if (fd < 0)
+               return NULL;
+
+       qmi_device =3D qmi_device_new(fd);
+       if (!qmi_device) {
+               close(fd);
+               return NULL;
+       }
+       if (getenv("OFONO_QMI_DEBUG"))
+               qmi_device_set_debug(qmi_device, huawei_debug, debug);
+
+       qmi_device_set_close_on_unref(qmi_device, true);
+       return qmi_device;
+
+}
+
 static int huawei_enable(struct ofono_modem *modem)
 {
        struct huawei_data *data =3D ofono_modem_get_data(modem);
@@ -594,6 +632,8 @@ static int huawei_enable(struct ofono_modem *modem)
                return -EIO;
        }

+       data->device =3D open_qmi_device(modem, "Device", "QMI: ");
+
        g_at_chat_set_slave(data->modem, data->pcui);

        g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NUL=
L);
@@ -622,6 +662,17 @@ static void cfun_disable(gboolean ok, GAtResult
*result, gpointer user_data)
                ofono_modem_set_powered(modem, FALSE);
 }

+static void qmi_shutdown_cb(void *user_data)
+{
+       struct ofono_modem *modem =3D user_data;
+       struct huawei_data *data =3D ofono_modem_get_data(modem);
+
+       DBG("");
+
+       qmi_device_unref(data->device);
+       data->device =3D NULL;
+}
+
 static int huawei_disable(struct ofono_modem *modem)
 {
        struct huawei_data *data =3D ofono_modem_get_data(modem);
@@ -646,9 +697,14 @@ static int huawei_disable(struct ofono_modem *modem)
                data->online_cbd =3D NULL;
        }

+       if (data->device) {
+               qmi_device_unref(data->device);
+               data->device =3D NULL;
+       //      qmi_device_shutdown(data->device, qmi_shutdown_cb, modem,
NULL);
+       }
+
        g_at_chat_send(data->pcui, "AT+CFUN=3D0", none_prefix,
                                        cfun_disable, modem, NULL);
-
        return -EINPROGRESS;
 }

@@ -804,6 +860,7 @@ static void huawei_post_sim(struct ofono_modem *modem)
 {
        struct huawei_data *data =3D ofono_modem_get_data(modem);

+
        DBG("%p", modem);

        if (data->have_voice =3D=3D TRUE) {
@@ -822,11 +879,15 @@ static void huawei_post_sim(struct ofono_modem *modem)

                ofono_sms_create(modem, OFONO_VENDOR_HUAWEI,
                                                "atmodem", data->pcui);
-
                gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI,
                                                "atmodem", data->pcui);
-               gc =3D ofono_gprs_context_create(modem, 0,
+               if (data->device =3D=3D NULL) {
+                       gc =3D ofono_gprs_context_create(modem,
OFONO_VENDOR_HUAWEI,
                                                "atmodem", data->modem);
+               } else {
+                       gc =3D ofono_gprs_context_create(modem, 0,
+                                               "qmimodem", data->device);
+               }

                if (gprs && gc)
                        ofono_gprs_add_context(gprs, gc);

--===============0609115070829194950==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGksPGRpdj48YnI+PC9kaXY+PGRpdj5JIGhhdmUgYSBIdWF3ZWkgRTM5OCBkb25nbGUgd2l0aCBh
IHFtaSBpbnRlcmZhY2UsIGFuZCBpJiMzOTttIHRyeWluZyB0byBtYWtlIG9mb25vIHVzZSB0aGUg
cW1pIGludGVyZmFjZSBmb3IgdGhlIGdwcnMtY29udGV4dCBhdG9tLiBJIGhhdmUgdGhpcyB3b3Jr
aW5nLCBidXQgZGVwZW5kaW5nIG9uIGhvdyBpIHVucmVmIHRoZSBxbWlfZGV2aWNlIGluIGh1YXdl
aV9kaXNhYmxlLCBvZm9ubyBjcmFzaGVzIG9yIHRoZXJlJiMzOTtzIGhhdmUgYSBtZW1vcnkgbGVh
ay48L2Rpdj4KPGRpdj48YnI+PC9kaXY+PGRpdj5UaGUgZmlyc3QgYXBwcm9hY2ggaSYjMzk7dmUg
dHJpZWQgaXMgdGhlIHNhbWUgYXMgaW4gdGhlIGdvYmkgcGx1Z2luLjwvZGl2PjxkaXY+SSBjYWxs
IHFtaV9kZXZpY2Vfc2h1dGRvd24oKSBmcm9tIGh1YXdlaV9kaXNhYmxlKCksIGFuZCB1bnJlZiB0
aGUgcW1pX2RldmljZSBmcm9tIHRoZSBjYWxsYmFjay48L2Rpdj48ZGl2PlRoZSBwcm9ibGVtIHdp
dGggdGhpcyBpczogd2hlbiBpIHVucGx1ZyB0aGUgZGV2aWNlIG9mb25vIGNyYXNoZXMuoDwvZGl2
Pgo8ZGl2PldoZW4gdGhlIGRldmljZSBpcyB1bnBsdWdnZWQsIGZpcnN0IKBodWF3ZWlfZGlzYWJs
ZSgpIGlzIGNhbGxlZCwgdGhlbiBodWF3ZWlfcmVtb3ZlKCksIGFuZDwvZGl2PjxkaXY+YWZ0ZXJ3
YXJkcyBzaHV0ZG93bl9jYigpIGlzIGNhbGxlZC4gQXQgdGhhdCB0aW1lIHRoZSBvZm9ub19tb2Rl
bSBzdHJ1Y3QgaXMgYWxyZWFkeSBmcmVlZCwgc2h1dGRvd25fY2IoKSB0cmllcyB0byBhY2Nlc3Mg
aXQgYW5kIGNyYXNoZXMuoDwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSBzZWNvbmQgYXBw
cm9hY2ggaSYjMzk7dmUgdHJpZWQgaXMgdG8gdW5yZWYgdGhlIHFtaV9kZXZpY2UgZGlyZWN0bHkg
ZnJvbSBodWF3ZWlfZGlzYWJsZS48L2Rpdj48ZGl2PldpdGggdGhpcyBhcHByb2FjaCwgaSBzZWUg
YSBtZW1vcnkgbGVhayBvZiB0aGUgcW1pX3NlcnZpY2UuoDwvZGl2PjxkaXY+cW1pX2dwcnNfY29u
dGV4dF9yZW1vdmUoKSBpcyBiZWluZyBjYWxsZWQgZnJvbSBmbHVzaF9hdG9tcygpLiBBbmQgaSBj
YW4gc2VlIHJlbGVhc2VfY2xpZW50KCkgaXMgYmVpbmcgY2FsbGVkLiBCdXQgdGhlIHNlcnZpY2Vf
cmVsZWFzZV9jYWxsYmFjaygpLCB3aGljaCBzaG91bGQgZnJlZSB0aGUgc2VydmljZSwgaXMgbmV2
ZXIgYmVpbmcgY2FsbGVkLjwvZGl2Pgo8ZGl2PkkgdGhpbmsgdGhlIHJlcXVlc3QgZ2V0JiMzOTtz
IGNhbmNlbGVkIGJlY2F1c2UgcW1pX2RldmljZV91bnJlZigpIGlzIGJlaW5nIGNhbGxlZCBmcm9t
IGh1YXdlaV9kaXNhYmxlKCkuIFRoZSByZXF1ZXN0IGlzIGRlc3Ryb3llZCBhbmQgdGhlIGNhbGxi
YWNrIHdoaWNoIHNob3VsZCBmcmVlIHRoZSBxbWlfc2VydmljZSBpcyBuZXZlciBjYWxsZWQuPC9k
aXY+PGRpdj48YnI+PC9kaXY+CjxkaXY+RG9lcyBhbnlvbmUgaGF2ZSB0aG91Z2h0cy9pZGVhcyBv
biBob3cgaSBjYW4gZml4IHRoaXM/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5CZWxvdyBhcmUg
dGhlIGNoYW5nZXMgdG8gdGhlIGh1YXdlaSBwbHVnaW4gdG8gYWRkIHFtaSBzdXBwb3J0IChvdGhl
ciBwYXRjaGVzIGFyZSBuZWVkZWQgdG8gbWFrZSBpdCB3b3JrLCBidXQgdGhleSYjMzk7cmUgbm90
IHJlbGV2YW50IHRvIHRoaXMgaXNzdWUpLjwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5r
cyw8L2Rpdj48ZGl2PkNlZHJpYzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj5kaWZmIC0t
Z2l0IGEvcGx1Z2lucy9odWF3ZWkuYyBiL3BsdWdpbnMvaHVhd2VpLmM8L2Rpdj48ZGl2PmluZGV4
IDVkODg3NWEuLjcwMDM3NjAgMTAwNjQ0PC9kaXY+PGRpdj4tLS0gYS9wbHVnaW5zL2h1YXdlaS5j
PC9kaXY+PGRpdj4rKysgYi9wbHVnaW5zL2h1YXdlaS5jPC9kaXY+CjxkaXY+QEAgLTI2LDYgKzI2
LDggQEA8L2Rpdj48ZGl2PqAjaW5jbHVkZSAmbHQ7ZXJybm8uaCZndDs8L2Rpdj48ZGl2PqAjaW5j
bHVkZSAmbHQ7c3RkbGliLmgmZ3Q7PC9kaXY+PGRpdj6gI2luY2x1ZGUgJmx0O3N0cmluZy5oJmd0
OzwvZGl2PjxkaXY+KyNpbmNsdWRlICZsdDtmY250bC5oJmd0OzwvZGl2PjxkaXY+KyNpbmNsdWRl
ICZsdDt1bmlzdGQuaCZndDs8L2Rpdj48ZGl2PqA8L2Rpdj4KPGRpdj6gI2luY2x1ZGUgJmx0O2ds
aWIuaCZndDs8L2Rpdj48ZGl2PqAjaW5jbHVkZSAmbHQ7Z2F0Y2hhdC5oJmd0OzwvZGl2PjxkaXY+
QEAgLTU3LDYgKzU5LDEwIEBAPC9kaXY+PGRpdj6gI2luY2x1ZGUgJmx0O2RyaXZlcnMvYXRtb2Rl
bS9hdHV0aWwuaCZndDs8L2Rpdj48ZGl2PqAjaW5jbHVkZSAmbHQ7ZHJpdmVycy9hdG1vZGVtL3Zl
bmRvci5oJmd0OzwvZGl2PjxkaXY+oDwvZGl2PjxkaXY+CisjaW5jbHVkZSAmbHQ7ZHJpdmVycy9x
bWltb2RlbS9xbWkuaCZndDs8L2Rpdj48ZGl2PisjaW5jbHVkZSAmbHQ7ZHJpdmVycy9xbWltb2Rl
bS9kbXMuaCZndDs8L2Rpdj48ZGl2PisjaW5jbHVkZSAmbHQ7ZHJpdmVycy9xbWltb2RlbS91dGls
LmgmZ3Q7PC9kaXY+PGRpdj4rPC9kaXY+PGRpdj6gc3RhdGljIGNvbnN0IGNoYXIgKm5vbmVfcHJl
Zml4W10gPSB7IE5VTEwgfTs8L2Rpdj48ZGl2Pgqgc3RhdGljIGNvbnN0IGNoYXIgKmdjYXBfcHJl
Zml4W10gPSB7ICZxdW90OytHQ0FQOiZxdW90OywgTlVMTCB9OzwvZGl2PjxkaXY+oHN0YXRpYyBj
b25zdCBjaGFyICpyZnN3aXRjaF9wcmVmaXhbXSA9IHsgJnF1b3Q7XlJGU1dJVENIOiZxdW90Oywg
TlVMTCB9OzwvZGl2PjxkaXY+QEAgLTc4LDYgKzg0LDcgQEAgZW51bSB7PC9kaXY+PGRpdj6gc3Ry
dWN0IGh1YXdlaV9kYXRhIHs8L2Rpdj4KPGRpdj6gIKAgoCCgIEdBdENoYXQgKm1vZGVtOzwvZGl2
PjxkaXY+oCCgIKAgoCBHQXRDaGF0ICpwY3VpOzwvZGl2PjxkaXY+KyCgIKAgoCBzdHJ1Y3QgcW1p
X2RldmljZSAqZGV2aWNlOzwvZGl2PjxkaXY+oCCgIKAgoCBnYm9vbGVhbiBoYXZlX3NpbTs8L2Rp
dj48ZGl2PqAgoCCgIKAgaW50IHNpbV9zdGF0ZTs8L2Rpdj48ZGl2PqAgoCCgIKAgZ3VpbnQgc3lz
aW5mb19wb2xsX3NvdXJjZTs8L2Rpdj4KPGRpdj5AQCAtMTIwLDYgKzEyNyw3IEBAIHN0YXRpYyB2
b2lkIGh1YXdlaV9yZW1vdmUoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSk8L2Rpdj48ZGl2PqA8
L2Rpdj48ZGl2PqAgoCCgIKAgLyogQ2xlYW51cCBhZnRlciBob3QtdW5wbHVnICovPC9kaXY+PGRp
dj6gIKAgoCCgIGdfYXRfY2hhdF91bnJlZihkYXRhLSZndDtwY3VpKTs8L2Rpdj48ZGl2PisgoCCg
IKAgcW1pX2RldmljZV91bnJlZihkYXRhLSZndDtkZXZpY2UpOzwvZGl2Pgo8ZGl2PqA8L2Rpdj48
ZGl2PqAgoCCgIKAgZ19mcmVlKGRhdGEpOzwvZGl2PjxkaXY+oH08L2Rpdj48ZGl2PkBAIC01Nzcs
NiArNTg1LDM2IEBAIHN0YXRpYyBHQXRDaGF0ICpvcGVuX2RldmljZShzdHJ1Y3Qgb2Zvbm9fbW9k
ZW0gKm1vZGVtLDwvZGl2PjxkaXY+oCCgIKAgoCByZXR1cm4gY2hhdDs8L2Rpdj48ZGl2PqB9PC9k
aXY+PGRpdj6gPC9kaXY+PGRpdj4rc3RhdGljIHN0cnVjdCBxbWlfZGV2aWNlICpvcGVuX3FtaV9k
ZXZpY2Uoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSw8L2Rpdj4KPGRpdj4rIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgY29uc3QgY2hhciAqa2V5LCBjaGFyICpkZWJ1Zyk8
L2Rpdj48ZGl2Pis8L2Rpdj48ZGl2Pit7PC9kaXY+PGRpdj4rIKAgoCCgIGNvbnN0IGNoYXIgKmRl
dmljZTs8L2Rpdj48ZGl2PisgoCCgIKAgc3RydWN0IHFtaV9kZXZpY2UgKnFtaV9kZXZpY2U7PC9k
aXY+PGRpdj4rIKAgoCCgIGludCBmZDs8L2Rpdj48ZGl2PgorPC9kaXY+PGRpdj4rIKAgoCCgIGRl
dmljZSA9IG9mb25vX21vZGVtX2dldF9zdHJpbmcobW9kZW0sIGtleSk7PC9kaXY+PGRpdj4rIKAg
oCCgIGlmIChkZXZpY2UgPT0gTlVMTCk8L2Rpdj48ZGl2PisgoCCgIKAgoCCgIKAgoCByZXR1cm4g
TlVMTDs8L2Rpdj48ZGl2PisgoCCgIKAgREJHKCZxdW90OyVzICVzJnF1b3Q7LCBrZXksIGRldmlj
ZSk7PC9kaXY+PGRpdj4rPC9kaXY+PGRpdj4rIKAgoCCgIGZkID0gb3BlbihkZXZpY2UsIE9fUkRX
UiB8IE9fTk9OQkxPQ0sgfCBPX0NMT0VYRUMpOzwvZGl2Pgo8ZGl2PisgoCCgIKAgaWYgKGZkICZs
dDsgMCk8L2Rpdj48ZGl2PisgoCCgIKAgoCCgIKAgoCByZXR1cm4gTlVMTDs8L2Rpdj48ZGl2Pis8
L2Rpdj48ZGl2PisgoCCgIKAgcW1pX2RldmljZSA9IHFtaV9kZXZpY2VfbmV3KGZkKTs8L2Rpdj48
ZGl2PisgoCCgIKAgaWYgKCFxbWlfZGV2aWNlKSB7PC9kaXY+PGRpdj4rIKAgoCCgIKAgoCCgIKAg
Y2xvc2UoZmQpOzwvZGl2PjxkaXY+KyCgIKAgoCCgIKAgoCCgIHJldHVybiBOVUxMOzwvZGl2Pgo8
ZGl2PisgoCCgIKAgfTwvZGl2PjxkaXY+KyCgIKAgoCBpZiAoZ2V0ZW52KCZxdW90O09GT05PX1FN
SV9ERUJVRyZxdW90OykpPC9kaXY+PGRpdj4rIKAgoCCgIKAgoCCgIKAgcW1pX2RldmljZV9zZXRf
ZGVidWcocW1pX2RldmljZSwgaHVhd2VpX2RlYnVnLCBkZWJ1Zyk7PC9kaXY+PGRpdj4rPC9kaXY+
PGRpdj4rIKAgoCCgIHFtaV9kZXZpY2Vfc2V0X2Nsb3NlX29uX3VucmVmKHFtaV9kZXZpY2UsIHRy
dWUpOzwvZGl2Pgo8ZGl2PisgoCCgIKAgcmV0dXJuIHFtaV9kZXZpY2U7PC9kaXY+PGRpdj4rPC9k
aXY+PGRpdj4rfTwvZGl2PjxkaXY+KzwvZGl2PjxkaXY+oHN0YXRpYyBpbnQgaHVhd2VpX2VuYWJs
ZShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKTwvZGl2PjxkaXY+oHs8L2Rpdj48ZGl2PqAgoCCg
IKAgc3RydWN0IGh1YXdlaV9kYXRhICpkYXRhID0gb2Zvbm9fbW9kZW1fZ2V0X2RhdGEobW9kZW0p
OzwvZGl2Pgo8ZGl2PkBAIC01OTQsNiArNjMyLDggQEAgc3RhdGljIGludCBodWF3ZWlfZW5hYmxl
KHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0pPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKAgcmV0
dXJuIC1FSU87PC9kaXY+PGRpdj6gIKAgoCCgIH08L2Rpdj48ZGl2PqA8L2Rpdj48ZGl2PisgoCCg
IKAgZGF0YS0mZ3Q7ZGV2aWNlID0gb3Blbl9xbWlfZGV2aWNlKG1vZGVtLCAmcXVvdDtEZXZpY2Um
cXVvdDssICZxdW90O1FNSTogJnF1b3Q7KTs8L2Rpdj4KPGRpdj4rPC9kaXY+PGRpdj6gIKAgoCCg
IGdfYXRfY2hhdF9zZXRfc2xhdmUoZGF0YS0mZ3Q7bW9kZW0sIGRhdGEtJmd0O3BjdWkpOzwvZGl2
PjxkaXY+oDwvZGl2PjxkaXY+oCCgIKAgoCBnX2F0X2NoYXRfc2VuZChkYXRhLSZndDttb2RlbSwg
JnF1b3Q7QVRFMCArQ01FRT0xJnF1b3Q7LCBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMKTs8L2Rpdj48
ZGl2PkBAIC02MjIsNiArNjYyLDE3IEBAIHN0YXRpYyB2b2lkIGNmdW5fZGlzYWJsZShnYm9vbGVh
biBvaywgR0F0UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0YSk8L2Rpdj4KPGRpdj6g
IKAgoCCgIKAgoCCgIKAgb2Zvbm9fbW9kZW1fc2V0X3Bvd2VyZWQobW9kZW0sIEZBTFNFKTs8L2Rp
dj48ZGl2PqB9PC9kaXY+PGRpdj6gPC9kaXY+PGRpdj4rc3RhdGljIHZvaWQgcW1pX3NodXRkb3du
X2NiKHZvaWQgKnVzZXJfZGF0YSk8L2Rpdj48ZGl2Pit7PC9kaXY+PGRpdj4rIKAgoCCgIHN0cnVj
dCBvZm9ub19tb2RlbSAqbW9kZW0gPSB1c2VyX2RhdGE7PC9kaXY+PGRpdj4KKyCgIKAgoCBzdHJ1
Y3QgaHVhd2VpX2RhdGEgKmRhdGEgPSBvZm9ub19tb2RlbV9nZXRfZGF0YShtb2RlbSk7PC9kaXY+
PGRpdj4rPC9kaXY+PGRpdj4rIKAgoCCgIERCRygmcXVvdDsmcXVvdDspOzwvZGl2PjxkaXY+Kzwv
ZGl2PjxkaXY+KyCgIKAgoCBxbWlfZGV2aWNlX3VucmVmKGRhdGEtJmd0O2RldmljZSk7PC9kaXY+
PGRpdj4rIKAgoCCgIGRhdGEtJmd0O2RldmljZSA9IE5VTEw7PC9kaXY+CjxkaXY+K308L2Rpdj48
ZGl2Pis8L2Rpdj48ZGl2PqBzdGF0aWMgaW50IGh1YXdlaV9kaXNhYmxlKHN0cnVjdCBvZm9ub19t
b2RlbSAqbW9kZW0pPC9kaXY+PGRpdj6gezwvZGl2PjxkaXY+oCCgIKAgoCBzdHJ1Y3QgaHVhd2Vp
X2RhdGEgKmRhdGEgPSBvZm9ub19tb2RlbV9nZXRfZGF0YShtb2RlbSk7PC9kaXY+PGRpdj5AQCAt
NjQ2LDkgKzY5NywxNCBAQCBzdGF0aWMgaW50IGh1YXdlaV9kaXNhYmxlKHN0cnVjdCBvZm9ub19t
b2RlbSAqbW9kZW0pPC9kaXY+CjxkaXY+oCCgIKAgoCCgIKAgoCCgIGRhdGEtJmd0O29ubGluZV9j
YmQgPSBOVUxMOzwvZGl2PjxkaXY+oCCgIKAgoCB9PC9kaXY+PGRpdj6gPC9kaXY+PGRpdj4rIKAg
oCCgIGlmIChkYXRhLSZndDtkZXZpY2UpIHs8L2Rpdj48ZGl2PisgoCCgIKAgoCCgIKAgoCBxbWlf
ZGV2aWNlX3VucmVmKGRhdGEtJmd0O2RldmljZSk7PC9kaXY+PGRpdj4rIKAgoCCgIKAgoCCgIKAg
ZGF0YS0mZ3Q7ZGV2aWNlID0gTlVMTDs8L2Rpdj4KPGRpdj4rIKAgoCCgIC8vIKAgoCCgcW1pX2Rl
dmljZV9zaHV0ZG93bihkYXRhLSZndDtkZXZpY2UsIHFtaV9zaHV0ZG93bl9jYiwgbW9kZW0sIE5V
TEwpOzwvZGl2PjxkaXY+KyCgIKAgoCB9PC9kaXY+PGRpdj4rPC9kaXY+PGRpdj6gIKAgoCCgIGdf
YXRfY2hhdF9zZW5kKGRhdGEtJmd0O3BjdWksICZxdW90O0FUK0NGVU49MCZxdW90Oywgbm9uZV9w
cmVmaXgsPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
Y2Z1bl9kaXNhYmxlLCBtb2RlbSwgTlVMTCk7PC9kaXY+CjxkaXY+LTwvZGl2PjxkaXY+oCCgIKAg
oCByZXR1cm4gLUVJTlBST0dSRVNTOzwvZGl2PjxkaXY+oH08L2Rpdj48ZGl2PqA8L2Rpdj48ZGl2
PkBAIC04MDQsNiArODYwLDcgQEAgc3RhdGljIHZvaWQgaHVhd2VpX3Bvc3Rfc2ltKHN0cnVjdCBv
Zm9ub19tb2RlbSAqbW9kZW0pPC9kaXY+PGRpdj6gezwvZGl2PjxkaXY+oCCgIKAgoCBzdHJ1Y3Qg
aHVhd2VpX2RhdGEgKmRhdGEgPSBvZm9ub19tb2RlbV9nZXRfZGF0YShtb2RlbSk7PC9kaXY+Cjxk
aXY+oDwvZGl2PjxkaXY+KzwvZGl2PjxkaXY+oCCgIKAgoCBEQkcoJnF1b3Q7JXAmcXVvdDssIG1v
ZGVtKTs8L2Rpdj48ZGl2PqA8L2Rpdj48ZGl2PqAgoCCgIKAgaWYgKGRhdGEtJmd0O2hhdmVfdm9p
Y2UgPT0gVFJVRSkgezwvZGl2PjxkaXY+QEAgLTgyMiwxMSArODc5LDE1IEBAIHN0YXRpYyB2b2lk
IGh1YXdlaV9wb3N0X3NpbShzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKTwvZGl2Pgo8ZGl2PqA8
L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoCBvZm9ub19zbXNfY3JlYXRlKG1vZGVtLCBPRk9OT19W
RU5ET1JfSFVBV0VJLDwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgJnF1b3Q7YXRtb2RlbSZxdW90OywgZGF0YS0mZ3Q7cGN1aSk7PC9kaXY+
PGRpdj4tPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKAgZ3BycyA9IG9mb25vX2dwcnNfY3JlYXRl
KG1vZGVtLCBPRk9OT19WRU5ET1JfSFVBV0VJLDwvZGl2Pgo8ZGl2PqAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgICZxdW90O2F0bW9kZW0mcXVvdDssIGRhdGEt
Jmd0O3BjdWkpOzwvZGl2PjxkaXY+LSCgIKAgoCCgIKAgoCCgIGdjID0gb2Zvbm9fZ3Byc19jb250
ZXh0X2NyZWF0ZShtb2RlbSwgMCw8L2Rpdj48ZGl2PisgoCCgIKAgoCCgIKAgoCBpZiAoZGF0YS0m
Z3Q7ZGV2aWNlID09IE5VTEwpIHs8L2Rpdj48ZGl2PgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBn
YyA9IG9mb25vX2dwcnNfY29udGV4dF9jcmVhdGUobW9kZW0sIE9GT05PX1ZFTkRPUl9IVUFXRUks
PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAg
oCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBkYXRhLSZndDttb2RlbSk7PC9kaXY+PGRpdj4rIKAgoCCg
IKAgoCCgIKAgfSBlbHNlIHs8L2Rpdj48ZGl2PgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBnYyA9
IG9mb25vX2dwcnNfY29udGV4dF9jcmVhdGUobW9kZW0sIDAsPC9kaXY+PGRpdj4rIKAgoCCgIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCAmcXVvdDtxbWltb2RlbSZxdW90
OywgZGF0YS0mZ3Q7ZGV2aWNlKTs8L2Rpdj48ZGl2PisgoCCgIKAgoCCgIKAgoCB9PC9kaXY+PGRp
dj6gPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKAgaWYgKGdwcnMgJmFtcDsmYW1wOyBnYyk8L2Rp
dj4KPGRpdj6gIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBvZm9ub19ncHJzX2FkZF9jb250ZXh0KGdw
cnMsIGdjKTs8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj4K

--===============0609115070829194950==--

