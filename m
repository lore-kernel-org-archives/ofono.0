Content-Type: multipart/mixed; boundary="===============5855338407162047688=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: [PATCH 2/2] Telit HE910 general fixes for gprs, sms and voicecall
Date: Fri, 06 Mar 2015 17:07:38 +0100
Message-ID: <CAH4ZQwvt95iLKpd2-LLqW7-APGyyhqs-g7iOdn8pFxxaDybCQw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5855338407162047688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index f93dd23..7aa90dc 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -396,7 +396,7 @@ static void at_cds_notify(GAtResult *result, gpointer
user_data)
        decode_hex_own_buf(hexpdu, -1, &pdu_len, 0, pdu);
        ofono_sms_status_notify(sms, pdu, pdu_len, tpdu_len);

-       if (data->cnma_enabled)
+       if (data->cnma_enabled && data->vendor !=3D OFONO_VENDOR_TELIT)
                at_ack_delivery(sms);

        return;
@@ -429,7 +429,8 @@ static void at_cmt_notify(GAtResult *result, gpointer
user_data)
        decode_hex_own_buf(hexpdu, -1, &pdu_len, 0, pdu);
        ofono_sms_deliver_notify(sms, pdu, pdu_len, tpdu_len);

-       if (data->vendor !=3D OFONO_VENDOR_SIMCOM)
+       if (data->vendor !=3D OFONO_VENDOR_SIMCOM &&
+               data->vendor !=3D OFONO_VENDOR_TELIT)
                at_ack_delivery(sms);
 }

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 2e45317..7c6cd43 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -63,6 +63,18 @@ static void read_charset_cb(gboolean ok, GAtResult
*result,
        at_util_parse_cscs_query(result, &data->charset);
 }

+static void charset_cb(gboolean ok, GAtResult *result,
+                               gpointer user_data)
+{
+       struct ussd_data *data =3D user_data;
+
+       if (!ok)
+               return;
+
+       g_at_chat_send(data->chat, "AT+CSCS?", cscs_prefix,
+                       read_charset_cb, data, NULL);
+}
+
 static const unsigned char *ucs2_gsm_to_packed(const char *content,
                                                long *msg_len,
                                                unsigned char *msg)
@@ -308,8 +320,12 @@ static int at_ussd_probe(struct ofono_ussd *ussd,
unsigned int vendor,

        ofono_ussd_set_data(ussd, data);

-       g_at_chat_send(data->chat, "AT+CSCS?", cscs_prefix,
-                       read_charset_cb, data, NULL);
+       if(vendor =3D=3D OFONO_VENDOR_TELIT)
+               g_at_chat_send(data->chat, "AT+CSCS=3DGSM", cscs_prefix,
+                                       charset_cb, data, NULL);
+       else
+               g_at_chat_send(data->chat, "AT+CSCS?", cscs_prefix,
+                               read_charset_cb, data, NULL);

        g_at_chat_send(data->chat, "AT+CUSD=3D1", NULL,
                        at_ussd_register, ussd, NULL);
diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 7d823a2..7bfa65f 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -1116,8 +1116,12 @@ static int at_voicecall_probe(struct ofono_voicecall
*vc, unsigned int vendor
        g_at_chat_send(vd->chat, "AT+CRC=3D1", NULL, NULL, NULL, NULL);
        g_at_chat_send(vd->chat, "AT+CLIP=3D1", NULL, NULL, NULL, NULL);
-       g_at_chat_send(vd->chat, "AT+CDIP=3D1", NULL, NULL, NULL, NULL);
-       g_at_chat_send(vd->chat, "AT+CNAP=3D1", NULL, NULL, NULL, NULL);
+
+       if (vd->vendor !=3D OFONO_VENDOR_TELIT)
+       {
+               g_at_chat_send(vd->chat, "AT+CDIP=3D1", NULL, NULL, NULL,
NULL);
+               g_at_chat_send(vd->chat, "AT+CNAP=3D1", NULL, NULL, NULL,
NULL);
+       }

        switch (vd->vendor) {
        case OFONO_VENDOR_QUALCOMM_MSM:

--===============5855338407162047688==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGRpdiBjbGFz
cz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRtb2RlbS9zbXMuYyBiL2RyaXZlcnMvYXRtb2RlbS9zbXMu
YzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNl
PSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj5pbmRleCBmOTNkZDIzLi43YWE5MGRjIDEwMDY0NDwvZm9u
dD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJk
YW5hLCBzYW5zLXNlcmlmIj4tLS0gYS9kcml2ZXJzL2F0bW9kZW0vc21zLmM8L2ZvbnQ+PC9kaXY+
PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fu
cy1zZXJpZiI+KysrIGIvZHJpdmVycy9hdG1vZGVtL3Ntcy5jPC9mb250PjwvZGl2PjxkaXYgY2xh
c3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYi
PkBAIC0zOTYsNyArMzk2LDcgQEAgc3RhdGljIHZvaWQgYXRfY2RzX25vdGlmeShHQXRSZXN1bHQg
KnJlc3VsdCwgZ3BvaW50ZXIgdXNlcl9kYXRhKTwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj7CoCDCoCDC
oCDCoCBkZWNvZGVfaGV4X293bl9idWYoaGV4cGR1LCAtMSwgJmFtcDtwZHVfbGVuLCAwLCBwZHUp
OzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNl
PSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj7CoCDCoCDCoCDCoCBvZm9ub19zbXNfc3RhdHVzX25vdGlm
eShzbXMsIHBkdSwgcGR1X2xlbiwgdHBkdV9sZW4pOzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJn
bWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj48YnI+
PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9
InZlcmRhbmEsIHNhbnMtc2VyaWYiPi0gwqAgwqAgwqAgaWYgKGRhdGEtJmd0O2NubWFfZW5hYmxl
ZCk8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFj
ZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+KyDCoCDCoCDCoCBpZiAoZGF0YS0mZ3Q7Y25tYV9lbmFi
bGVkICZhbXA7JmFtcDsgZGF0YS0mZ3Q7dmVuZG9yICE9IE9GT05PX1ZFTkRPUl9URUxJVCk8L2Zv
bnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVy
ZGFuYSwgc2Fucy1zZXJpZiI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYXRfYWNrX2RlbGl2ZXJ5
KHNtcyk7PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250
IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPjxicj48L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0i
Z21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+wqAg
wqAgwqAgwqAgcmV0dXJuOzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBz
dHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj5AQCAtNDI5LDcgKzQyOSw4IEBA
IHN0YXRpYyB2b2lkIGF0X2NtdF9ub3RpZnkoR0F0UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVyIHVz
ZXJfZGF0YSk8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZv
bnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+wqAgwqAgwqAgwqAgZGVjb2RlX2hleF9vd25f
YnVmKGhleHBkdSwgLTEsICZhbXA7cGR1X2xlbiwgMCwgcGR1KTs8L2ZvbnQ+PC9kaXY+PGRpdiBj
bGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJp
ZiI+wqAgwqAgwqAgwqAgb2Zvbm9fc21zX2RlbGl2ZXJfbm90aWZ5KHNtcywgcGR1LCBwZHVfbGVu
LCB0cGR1X2xlbik7PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxl
Pjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPjxicj48L2ZvbnQ+PC9kaXY+PGRpdiBj
bGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJp
ZiI+LSDCoCDCoCDCoCBpZiAoZGF0YS0mZ3Q7dmVuZG9yICE9IE9GT05PX1ZFTkRPUl9TSU1DT00p
PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9
InZlcmRhbmEsIHNhbnMtc2VyaWYiPisgwqAgwqAgwqAgaWYgKGRhdGEtJmd0O3ZlbmRvciAhPSBP
Rk9OT19WRU5ET1JfU0lNQ09NICZhbXA7JmFtcDs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+KyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBkYXRhLSZndDt2ZW5kb3IgIT0gT0ZPTk9fVkVORE9SX1RFTElUKTwv
Zm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2
ZXJkYW5hLCBzYW5zLXNlcmlmIj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhdF9hY2tfZGVsaXZl
cnkoc21zKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZv
bnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+wqB9PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9
ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPjxi
cj48L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFj
ZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRtb2RlbS91c3Nk
LmMgYi9kcml2ZXJzL2F0bW9kZW0vdXNzZC5jPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWls
X2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPmluZGV4IDJl
NDUzMTcuLjdjNmNkNDMgMTAwNjQ0PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1
bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPi0tLSBhL2RyaXZlcnMv
YXRtb2RlbS91c3NkLmM8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5
bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+KysrIGIvZHJpdmVycy9hdG1vZGVt
L3Vzc2QuYzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9u
dCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj5AQCAtNjMsNiArNjMsMTggQEAgc3RhdGljIHZv
aWQgcmVhZF9jaGFyc2V0X2NiKGdib29sZWFuIG9rLCBHQXRSZXN1bHQgKnJlc3VsdCw8L2ZvbnQ+
PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFu
YSwgc2Fucy1zZXJpZiI+wqAgwqAgwqAgwqAgYXRfdXRpbF9wYXJzZV9jc2NzX3F1ZXJ5KHJlc3Vs
dCwgJmFtcDtkYXRhLSZndDtjaGFyc2V0KTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+wqB9PC9mb250
PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRh
bmEsIHNhbnMtc2VyaWYiPjxicj48L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVs
dCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+K3N0YXRpYyB2b2lkIGNo
YXJzZXRfY2IoZ2Jvb2xlYW4gb2ssIEdBdFJlc3VsdCAqcmVzdWx0LDwvZm9udD48L2Rpdj48ZGl2
IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNl
cmlmIj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdwb2lu
dGVyIHVzZXJfZGF0YSk8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5
bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+K3s8L2ZvbnQ+PC9kaXY+PGRpdiBj
bGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJp
ZiI+KyDCoCDCoCDCoCBzdHJ1Y3QgdXNzZF9kYXRhICpkYXRhID0gdXNlcl9kYXRhOzwvZm9udD48
L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5h
LCBzYW5zLXNlcmlmIj4rPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0
eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPisgwqAgwqAgwqAgaWYgKCFvayk8
L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0i
dmVyZGFuYSwgc2Fucy1zZXJpZiI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm47PC9mb250
PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRh
bmEsIHNhbnMtc2VyaWYiPis8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIg
c3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+KyDCoCDCoCDCoCBnX2F0X2No
YXRfc2VuZChkYXRhLSZndDtjaGF0LCAmcXVvdDtBVCtDU0NTPyZxdW90OywgY3Njc19wcmVmaXgs
PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9
InZlcmRhbmEsIHNhbnMtc2VyaWYiPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cmVhZF9jaGFyc2V0X2NiLCBkYXRhLCBOVUxMKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+K308L2Zv
bnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVy
ZGFuYSwgc2Fucy1zZXJpZiI+KzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0
IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj7CoHN0YXRpYyBjb25zdCB1
bnNpZ25lZCBjaGFyICp1Y3MyX2dzbV90b19wYWNrZWQoY29uc3QgY2hhciAqY29udGVudCw8L2Zv
bnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVy
ZGFuYSwgc2Fucy1zZXJpZiI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbG9uZyAqbXNnX2xlbiw8L2ZvbnQ+PC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwg
c2Fucy1zZXJpZiI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdW5zaWduZWQgY2hhciAqbXNnKTwvZm9udD48L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBz
YW5zLXNlcmlmIj5AQCAtMzA4LDggKzMyMCwxMiBAQCBzdGF0aWMgaW50IGF0X3Vzc2RfcHJvYmUo
c3RydWN0IG9mb25vX3Vzc2QgKnVzc2QsIHVuc2lnbmVkIGludCB2ZW5kb3IsPC9mb250PjwvZGl2
PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNh
bnMtc2VyaWYiPjxicj48L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5
bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+wqAgwqAgwqAgwqAgb2Zvbm9fdXNz
ZF9zZXRfZGF0YSh1c3NkLCBkYXRhKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVm
YXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+PGJyPjwvZm9udD48
L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5h
LCBzYW5zLXNlcmlmIj4tIMKgIMKgIMKgIGdfYXRfY2hhdF9zZW5kKGRhdGEtJmd0O2NoYXQsICZx
dW90O0FUK0NTQ1M/JnF1b3Q7LCBjc2NzX3ByZWZpeCw8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0i
Z21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+LSDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZWFkX2NoYXJzZXRfY2IsIGRhdGEsIE5V
TEwpOzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBm
YWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rIMKgIMKgIMKgIGlmKHZlbmRvciA9PSBPRk9OT19W
RU5ET1JfVEVMSVQpPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxl
Pjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
Z19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7Y2hhdCwgJnF1b3Q7QVQrQ1NDUz1HU00mcXVvdDssIGNz
Y3NfcHJlZml4LDwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48
Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNoYXJzZXRfY2IsIGRhdGEsIE5VTEwp
OzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNl
PSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rIMKgIMKgIMKgIGVsc2U8L2ZvbnQ+PC9kaXY+PGRpdiBj
bGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJp
ZiI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnX2F0X2NoYXRfc2VuZChkYXRhLSZndDtjaGF0LCAm
cXVvdDtBVCtDU0NTPyZxdW90OywgY3Njc19wcmVmaXgsPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9
ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPisg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmVhZF9jaGFyc2V0
X2NiLCBkYXRhLCBOVUxMKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIg
c3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+PGJyPjwvZm9udD48L2Rpdj48
ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5z
LXNlcmlmIj7CoCDCoCDCoCDCoCBnX2F0X2NoYXRfc2VuZChkYXRhLSZndDtjaGF0LCAmcXVvdDtB
VCtDVVNEPTEmcXVvdDssIE5VTEwsPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1
bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGF0X3Vzc2RfcmVnaXN0ZXIsIHVzc2QsIE5VTEwpOzwvZm9u
dD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJk
YW5hLCBzYW5zLXNlcmlmIj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9hdG1vZGVtL3ZvaWNlY2FsbC5j
IGIvZHJpdmVycy9hdG1vZGVtL3ZvaWNlY2FsbC5jPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9Imdt
YWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPmluZGV4
IDdkODIzYTIuLjdiZmE2NWYgMTAwNjQ0PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2Rl
ZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPi0tLSBhL2RyaXZl
cnMvYXRtb2RlbS92b2ljZWNhbGwuYzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZh
dWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rKysgYi9kcml2ZXJz
L2F0bW9kZW0vdm9pY2VjYWxsLmM8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVs
dCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+QEAgLTExMTYsOCArMTEx
NiwxMiBAQCBzdGF0aWMgaW50IGF0X3ZvaWNlY2FsbF9wcm9iZShzdHJ1Y3Qgb2Zvbm9fdm9pY2Vj
YWxsICp2YywgdW5zaWduZWQgaW50IHZlbmRvcjwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj7CoCDCoCDC
oCDCoCBnX2F0X2NoYXRfc2VuZCh2ZC0mZ3Q7Y2hhdCwgJnF1b3Q7QVQrQ1JDPTEmcXVvdDssIE5V
TEwsIE5VTEwsIE5VTEwsIE5VTEwpOzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZh
dWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj7CoCDCoCDCoCDCoCBn
X2F0X2NoYXRfc2VuZCh2ZC0mZ3Q7Y2hhdCwgJnF1b3Q7QVQrQ0xJUD0xJnF1b3Q7LCBOVUxMLCBO
VUxMLCBOVUxMLCBOVUxMKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIg
c3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+LSDCoCDCoCDCoCBnX2F0X2No
YXRfc2VuZCh2ZC0mZ3Q7Y2hhdCwgJnF1b3Q7QVQrQ0RJUD0xJnF1b3Q7LCBOVUxMLCBOVUxMLCBO
VUxMLCBOVUxMKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+
PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+LSDCoCDCoCDCoCBnX2F0X2NoYXRfc2Vu
ZCh2ZC0mZ3Q7Y2hhdCwgJnF1b3Q7QVQrQ05BUD0xJnF1b3Q7LCBOVUxMLCBOVUxMLCBOVUxMLCBO
VUxMKTs8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQg
ZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+KzwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFp
bF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj4rIMKgIMKg
IMKgIGlmICh2ZC0mZ3Q7dmVuZG9yICE9IE9GT05PX1ZFTkRPUl9URUxJVCk8L2ZvbnQ+PC9kaXY+
PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fu
cy1zZXJpZiI+KyDCoCDCoCDCoCB7PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1
bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPisgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZ19hdF9jaGF0X3NlbmQodmQtJmd0O2NoYXQsICZxdW90O0FUK0NESVA9MSZxdW90
OywgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCk7PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9ImdtYWls
X2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPisgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgZ19hdF9jaGF0X3NlbmQodmQtJmd0O2NoYXQsICZxdW90O0FUK0NOQVA9
MSZxdW90OywgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCk7PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9
ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPisg
wqAgwqAgwqAgfTwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48
Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlmIj48YnI+PC9mb250PjwvZGl2PjxkaXYgY2xh
c3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYi
PsKgIMKgIMKgIMKgIHN3aXRjaCAodmQtJmd0O3ZlbmRvcikgezwvZm9udD48L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT48Zm9udCBmYWNlPSJ2ZXJkYW5hLCBzYW5zLXNlcmlm
Ij7CoCDCoCDCoCDCoCBjYXNlIE9GT05PX1ZFTkRPUl9RVUFMQ09NTV9NU006PC9mb250PjwvZGl2
PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+PGJyPjwvZGl2Pjwv
ZGl2Pgo8L2Rpdj4K

--===============5855338407162047688==--

