Content-Type: multipart/mixed; boundary="===============1211937130144525780=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: Re: Alcatel Onetouch X515 support
Date: Thu, 08 Nov 2012 16:02:03 +0100
Message-ID: <CABvLYuB6O8xvbaK9LtoYec8i_7x3N1RE5B7+6tjKXDt4+KgRPg@mail.gmail.com>
In-Reply-To: <509BBECB.80809@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1211937130144525780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I've just seen the same issue on a huawei E369. So i'm not so sure fixing
it in the plugin is the best way.
What i've done now is reschedule calling __ofono_sim_recheck after 5
seconds if sim_pin_query_cb get's a CME Error 14.
Is it ok to do it like this?

diff --git a/src/sim.c b/src/sim.c
index 8059d2b..46b0880 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -2689,6 +2689,13 @@ ofono_bool_t ofono_sim_remove_spn_watch(struct
ofono_sim *sim, unsigned int *id)
        return ret;
 }

+static gboolean sim_busy_poll(gpointer data)
+{
+       struct ofono_sim *sim =3D data;
+       __ofono_sim_recheck_pin(sim);
+       return FALSE;
+}
+
 static void sim_pin_query_cb(const struct ofono_error *error,
                                enum ofono_sim_password_type pin_type,
                                void *data)
@@ -2698,8 +2705,12 @@ static void sim_pin_query_cb(const struct
ofono_error *error,
        const char *path =3D __ofono_atom_get_path(sim->atom);
        const char *pin_name;

+
        if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-               ofono_error("Querying PIN authentication state failed");
+               if (error->type =3D=3D OFONO_ERROR_TYPE_CME && error->error=
 =3D=3D
14)
+                       g_timeout_add_seconds(5, sim_busy_poll, sim);
+               else
+                       ofono_error("Querying PIN authentication state
failed");
                return;
        }

Thanks,
Cedric

--===============1211937130144525780==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdj5IaSBEZW5pcyw8L2Rpdj48ZGl2Pjxicj48L2Rpdj5JJiMzOTt2ZSBqdXN0IHNlZW4gdGhl
IHNhbWUgaXNzdWUgb24gYSBodWF3ZWkgRTM2OS4gU28gaSYjMzk7bSBub3Qgc28gc3VyZSBmaXhp
bmcgaXQgaW4gdGhlIHBsdWdpbiBpcyB0aGUgYmVzdCB3YXkuPGRpdj5XaGF0IGkmIzM5O3ZlIGRv
bmUgbm93IGlzIHJlc2NoZWR1bGUgY2FsbGluZyBfX29mb25vX3NpbV9yZWNoZWNrIGFmdGVyIDUg
c2Vjb25kcyBpZiBzaW1fcGluX3F1ZXJ5X2NiIGdldCYjMzk7cyBhIENNRSBFcnJvciAxNC48L2Rp
dj4KPGRpdj5JcyBpdCBvayB0byBkbyBpdCBsaWtlIHRoaXM/PC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj48ZGl2PjxkaXY+PGRpdj5kaWZmIC0tZ2l0IGEvc3JjL3NpbS5jIGIvc3JjL3NpbS5jPC9k
aXY+PGRpdj5pbmRleCA4MDU5ZDJiLi40NmIwODgwIDEwMDY0NDwvZGl2PjxkaXY+LS0tIGEvc3Jj
L3NpbS5jPC9kaXY+PGRpdj4rKysgYi9zcmMvc2ltLmM8L2Rpdj48ZGl2PkBAIC0yNjg5LDYgKzI2
ODksMTMgQEAgb2Zvbm9fYm9vbF90IG9mb25vX3NpbV9yZW1vdmVfc3BuX3dhdGNoKHN0cnVjdCBv
Zm9ub19zaW0gKnNpbSwgdW5zaWduZWQgaW50ICppZCk8L2Rpdj4KPGRpdj6gIKAgoCCgIHJldHVy
biByZXQ7PC9kaXY+PGRpdj6gfTwvZGl2PjxkaXY+oDwvZGl2PjxkaXY+K3N0YXRpYyBnYm9vbGVh
biBzaW1fYnVzeV9wb2xsKGdwb2ludGVyIGRhdGEpPC9kaXY+PGRpdj4rezwvZGl2PjxkaXY+KyCg
IKAgoCBzdHJ1Y3Qgb2Zvbm9fc2ltICpzaW0gPSBkYXRhOzwvZGl2PjxkaXY+KyCgIKAgoCBfX29m
b25vX3NpbV9yZWNoZWNrX3BpbihzaW0pOzwvZGl2PjxkaXY+CisgoCCgIKAgcmV0dXJuIEZBTFNF
OzwvZGl2PjxkaXY+K308L2Rpdj48ZGl2Pis8L2Rpdj48ZGl2PqBzdGF0aWMgdm9pZCBzaW1fcGlu
X3F1ZXJ5X2NiKGNvbnN0IHN0cnVjdCBvZm9ub19lcnJvciAqZXJyb3IsPC9kaXY+PGRpdj6gIKAg
oCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIGVudW0gb2Zvbm9fc2ltX3Bhc3N3b3JkX3R5cGUg
cGluX3R5cGUsPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIHZvaWQg
KmRhdGEpPC9kaXY+CjxkaXY+QEAgLTI2OTgsOCArMjcwNSwxMiBAQCBzdGF0aWMgdm9pZCBzaW1f
cGluX3F1ZXJ5X2NiKGNvbnN0IHN0cnVjdCBvZm9ub19lcnJvciAqZXJyb3IsPC9kaXY+PGRpdj6g
IKAgoCCgIGNvbnN0IGNoYXIgKnBhdGggPSBfX29mb25vX2F0b21fZ2V0X3BhdGgoc2ltLSZndDth
dG9tKTs8L2Rpdj48ZGl2PqAgoCCgIKAgY29uc3QgY2hhciAqcGluX25hbWU7PC9kaXY+PGRpdj6g
PC9kaXY+CjxkaXY+KzwvZGl2PjxkaXY+oCCgIKAgoCBpZiAoZXJyb3ItJmd0O3R5cGUgIT0gT0ZP
Tk9fRVJST1JfVFlQRV9OT19FUlJPUikgezwvZGl2PjxkaXY+LSCgIKAgoCCgIKAgoCCgIG9mb25v
X2Vycm9yKCZxdW90O1F1ZXJ5aW5nIFBJTiBhdXRoZW50aWNhdGlvbiBzdGF0ZSBmYWlsZWQmcXVv
dDspOzwvZGl2PjxkaXY+KyCgIKAgoCCgIKAgoCCgIGlmIChlcnJvci0mZ3Q7dHlwZSA9PSBPRk9O
T19FUlJPUl9UWVBFX0NNRSAmYW1wOyZhbXA7IGVycm9yLSZndDtlcnJvciA9PSAxNCk8L2Rpdj4K
PGRpdj4rIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBnX3RpbWVvdXRfYWRkX3NlY29uZHMoNSwgc2lt
X2J1c3lfcG9sbCwgc2ltKTs8L2Rpdj48ZGl2PisgoCCgIKAgoCCgIKAgoCBlbHNlPC9kaXY+PGRp
dj4rIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBvZm9ub19lcnJvcigmcXVvdDtRdWVyeWluZyBQSU4g
YXV0aGVudGljYXRpb24gc3RhdGUgZmFpbGVkJnF1b3Q7KTs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCg
IKAgoCByZXR1cm47PC9kaXY+CjxkaXY+oCCgIKAgoCB9PC9kaXY+PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5UaGFua3MsPC9kaXY+PGRpdj5DZWRyaWM8L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rp
dj48L2Rpdj4K

--===============1211937130144525780==--

