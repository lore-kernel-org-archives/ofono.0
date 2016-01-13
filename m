Content-Type: multipart/mixed; boundary="===============8624233554840886403=="
MIME-Version: 1.0
From: matti kaasinen <matti.kaasinen@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Wed, 13 Jan 2016 12:40:20 +0200
Message-ID: <CADnUhn3Q2dMD69JVdhyX1Pz0PjzEQ3fjmrnKxjscwV51JgKDHw@mail.gmail.com>
In-Reply-To: <569535E7.3020000@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8624233554840886403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,
I made this change. I did not see any change in logs apart from in
"atmodem" had changed to "huaweimodem". However, at commands were the same
in there. One difference was that test/activate-context did not return with
error messages. In fact it did not print anything. Also no at commands were
produced. Also no service was produced visible from connmand.

I made more of these "atmodem" -> "huaweimodem" modifications. All Error
messages from ofono logs apart from one were removed. However, operation
was the same.

I did not find AT^NDISDUP from log even though it seemed to be some in
drivers/huaweimodem/gprs-context.c.

Please find the patch below, if you can find any use of it as it really was
not enough making things work.
I must try something else as I'm running out of time now.
Anyhow, thank for your assistance Denis.

Thanks,
Matti

----- patch ----
diff --git a/plugins/huawei.c b/plugins/huawei.c
index 59995b3..5bf903e 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -791,9 +791,9 @@ static void huawei_pre_sim(struct ofono_modem *modem)
     DBG("%p", modem);

     if (data->have_gsm =3D=3D TRUE) {
-        ofono_devinfo_create(modem, 0, "atmodem", data->pcui);
+        ofono_devinfo_create(modem, 0, "huaweimodem", data->pcui);
         sim =3D ofono_sim_create(modem, OFONO_VENDOR_HUAWEI,
-                        "atmodem", data->pcui);
+                        "huaweimodem", data->pcui);
     } else if (data->have_cdma =3D=3D TRUE) {
         ofono_devinfo_create(modem, 0, "cdmamodem", data->pcui);

@@ -823,17 +823,17 @@ static void huawei_post_sim(struct ofono_modem *modem)
         struct ofono_gprs *gprs;
         struct ofono_gprs_context *gc;

-        ofono_phonebook_create(modem, 0, "atmodem", data->pcui);
+        ofono_phonebook_create(modem, 0, "huaweimodem", data->pcui);
         ofono_radio_settings_create(modem, 0,
                         "huaweimodem", data->pcui);

         ofono_sms_create(modem, OFONO_VENDOR_HUAWEI,
-                        "atmodem", data->pcui);
+                        "huaweimodem", data->pcui);

         gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI,
-                        "atmodem", data->pcui);
+                        "huaweimodem", data->pcui);
         gc =3D ofono_gprs_context_create(modem, 0,
-                        "atmodem", data->modem);
+                        "huaweimodem", data->modem);

         if (gprs && gc)
             ofono_gprs_add_context(gprs, gc);
@@ -848,7 +848,7 @@ static void huawei_post_online(struct ofono_modem
*modem)

     if (data->have_gsm =3D=3D TRUE) {
         ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI,
-                        "atmodem", data->pcui);
+                        "huaweimodem", data->pcui);

         ofono_cbs_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
                         "atmodem", data->pcui);
@@ -861,7 +861,7 @@ static void huawei_post_online(struct ofono_modem
*modem)
         ofono_cdma_netreg_create(modem, 0, "huaweimodem", data->pcui);

         ofono_cdma_connman_create(modem, OFONO_VENDOR_HUAWEI,
-                        "cdmamodem", data->modem);
+                        "huaweimodem", data->modem);
     }

     if (data->have_voice =3D=3D TRUE) {
diff --git a/plugins/udevng.c b/plugins/udevng.c
index e43d045..976f209 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -321,6 +321,7 @@ static gboolean setup_huawei(struct modem_info *modem)
                 g_strcmp0(info->interface, "255/1/51") =3D=3D 0) {
             diag =3D info->devnode;
         } else if (g_strcmp0(info->interface, "255/1/8") =3D=3D 0 ||
+                g_strcmp0(info->interface, "255/2/22") =3D=3D 0 ||
                 g_strcmp0(info->interface, "255/1/56") =3D=3D 0) {
             net =3D info->devnode;
         } else if (g_strcmp0(info->interface, "255/1/9") =3D=3D 0 ||
@@ -1104,6 +1105,7 @@ static struct {
     { "huawei",    "cdc_ether",    "12d1"        },
     { "huawei",    "qmi_wwan",    "12d1"        },
     { "huawei",    "option",    "12d1"        },
+    { "huawei",    "huawei_cdc_ncm",    "12d1"        },
     { "speedupcdma","option",    "1c9e", "9e00"    },
     { "speedup",    "option",    "1c9e"        },
     { "speedup",    "option",    "2020"        },


2016-01-12 19:20 GMT+02:00 Denis Kenzior <denkenz@gmail.com>:

> Hi Matti,
>
> On 01/12/2016 10:56 AM, matti kaasinen wrote:
>
>> Denis,
>>
>> 2016-01-12 18:46 GMT+02:00 matti kaasinen <matti.kaasinen@gmail.com
>> <mailto:matti.kaasinen@gmail.com>>:
>>
>>             activate-context
>>             =3D>
>>             Error activating /huawei_0/context1:
>>             org.ofono.Error.NotImplemented:
>>             Implementation not provided
>>
>>
>>         There is no gprs context driver provided or it failed to setup.
>>         Do you have TUN/TAP in the kernel or kernel module?
>>
>>     It was not loaded, but I modprobed it now manually and got different
>>     error message:
>>     Error activating /huawei_1/context1: org.ofono.Error.Failed:
>>     Operation failed
>>
>>
>> Ofono log gave now some error messages:
>> ..ofonod: drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
>> ..ofonod: Modem: > AT+CGDCONT=3D1,"IP","internet"\r
>> ..ofonod: Modem: < \r\nOK\r\n
>> ..ofonod: drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
>> ..ofonod: Modem: > AT+CGDATA=3D"PPP",1\r
>> ..ofonod: Modem: < \r\n+CME ERROR: 50\r\n
>> ..ofonod: drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 0
>> ..ofonod: Unable to enter data state
>> ..ofonod: src/gprs.c:pri_activate_callback() 0x122580
>> ..ofonod: src/gprs.c:pri_activate_callback() Activating context failed
>> with error: Incorrect parameters
>>
>>
> Looks like your modem has a newer / different firmware.  in
> plugins/huawei.c, line:
>                 gc =3D ofono_gprs_context_create(modem, 0,
>                                                 "atmodem", data->modem);
>
> Can you try changing "atmodem" to "huaweimodem" and see if it works after
> that?
>
> Regards,
> -Denis
>

--===============8624233554840886403==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+PGRpdj48ZGl2PjxkaXY+RGVuaXMsPGJyPkkg
bWFkZSB0aGlzIGNoYW5nZS4gSSBkaWQgbm90IHNlZSBhbnkgY2hhbmdlIGluIGxvZ3MgYXBhcnQg
ZnJvbSBpbiAmcXVvdDthdG1vZGVtJnF1b3Q7IGhhZCBjaGFuZ2VkIHRvICZxdW90O2h1YXdlaW1v
ZGVtJnF1b3Q7LiBIb3dldmVyLCBhdCBjb21tYW5kcyB3ZXJlIHRoZSBzYW1lIGluIHRoZXJlLiBP
bmUgZGlmZmVyZW5jZSB3YXMgdGhhdCB0ZXN0L2FjdGl2YXRlLWNvbnRleHQgZGlkIG5vdCByZXR1
cm4gd2l0aCBlcnJvciBtZXNzYWdlcy4gSW4gZmFjdCBpdCBkaWQgbm90IHByaW50IGFueXRoaW5n
LiBBbHNvIG5vIGF0IGNvbW1hbmRzIHdlcmUgcHJvZHVjZWQuIEFsc28gbm8gc2VydmljZSB3YXMg
cHJvZHVjZWQgdmlzaWJsZSBmcm9tIGNvbm5tYW5kLjxicj48YnI+PC9kaXY+SSBtYWRlIG1vcmUg
b2YgdGhlc2UgJnF1b3Q7YXRtb2RlbSZxdW90OyAtJmd0OyAmcXVvdDtodWF3ZWltb2RlbSZxdW90
OyBtb2RpZmljYXRpb25zLiBBbGwgRXJyb3IgbWVzc2FnZXMgZnJvbSBvZm9ubyBsb2dzIGFwYXJ0
IGZyb20gb25lIHdlcmUgcmVtb3ZlZC4gSG93ZXZlciwgb3BlcmF0aW9uIHdhcyB0aGUgc2FtZS48
YnI+PGJyPjwvZGl2PjxkaXY+SSBkaWQgbm90IGZpbmQgQVReTkRJU0RVUCBmcm9tIGxvZyBldmVu
IHRob3VnaCBpdCBzZWVtZWQgdG8gYmUgc29tZSBpbiBkcml2ZXJzL2h1YXdlaW1vZGVtL2dwcnMt
Y29udGV4dC5jLjxicj48L2Rpdj48YnI+UGxlYXNlIGZpbmQgdGhlIHBhdGNoIGJlbG93LCBpZiB5
b3UgY2FuIGZpbmQgYW55IHVzZSBvZiBpdCBhcyBpdCByZWFsbHkgd2FzIG5vdCBlbm91Z2ggbWFr
aW5nIHRoaW5ncyB3b3JrLjxicj48L2Rpdj48ZGl2PkkgbXVzdCB0cnkgc29tZXRoaW5nIGVsc2Ug
YXMgSSYjMzk7bSBydW5uaW5nIG91dCBvZiB0aW1lIG5vdy48YnI+PC9kaXY+QW55aG93LCB0aGFu
ayBmb3IgeW91ciBhc3Npc3RhbmNlIERlbmlzLjxicj48YnI+PC9kaXY+VGhhbmtzLDxicj48L2Rp
dj5NYXR0aTxicj48YnI+PC9kaXY+LS0tLS0gcGF0Y2ggLS0tLTxicj5kaWZmIC0tZ2l0IGEvcGx1
Z2lucy9odWF3ZWkuYyBiL3BsdWdpbnMvaHVhd2VpLmM8YnI+aW5kZXggNTk5OTViMy4uNWJmOTAz
ZSAxMDA2NDQ8YnI+LS0tIGEvcGx1Z2lucy9odWF3ZWkuYzxicj4rKysgYi9wbHVnaW5zL2h1YXdl
aS5jPGJyPkBAIC03OTEsOSArNzkxLDkgQEAgc3RhdGljIHZvaWQgaHVhd2VpX3ByZV9zaW0oc3Ry
dWN0IG9mb25vX21vZGVtICptb2RlbSk8YnI+wqDCoMKgwqAgREJHKCZxdW90OyVwJnF1b3Q7LCBt
b2RlbSk7PGJyPsKgPGJyPsKgwqDCoMKgIGlmIChkYXRhLSZndDtoYXZlX2dzbSA9PSBUUlVFKSB7
PGJyPi3CoMKgwqAgwqDCoMKgIG9mb25vX2RldmluZm9fY3JlYXRlKG1vZGVtLCAwLCAmcXVvdDth
dG1vZGVtJnF1b3Q7LCBkYXRhLSZndDtwY3VpKTs8YnI+K8KgwqDCoCDCoMKgwqAgb2Zvbm9fZGV2
aW5mb19jcmVhdGUobW9kZW0sIDAsICZxdW90O2h1YXdlaW1vZGVtJnF1b3Q7LCBkYXRhLSZndDtw
Y3VpKTs8YnI+wqDCoMKgwqAgwqDCoMKgIHNpbSA9IG9mb25vX3NpbV9jcmVhdGUobW9kZW0sIE9G
T05PX1ZFTkRPUl9IVUFXRUksPGJyPi3CoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKg
IMKgwqDCoCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBkYXRhLSZndDtwY3VpKTs8YnI+K8KgwqDCoCDC
oMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgICZxdW90O2h1YXdlaW1vZGVtJnF1b3Q7
LCBkYXRhLSZndDtwY3VpKTs8YnI+wqDCoMKgwqAgfSBlbHNlIGlmIChkYXRhLSZndDtoYXZlX2Nk
bWEgPT0gVFJVRSkgezxicj7CoMKgwqDCoCDCoMKgwqAgb2Zvbm9fZGV2aW5mb19jcmVhdGUobW9k
ZW0sIDAsICZxdW90O2NkbWFtb2RlbSZxdW90OywgZGF0YS0mZ3Q7cGN1aSk7PGJyPsKgPGJyPkBA
IC04MjMsMTcgKzgyMywxNyBAQCBzdGF0aWMgdm9pZCBodWF3ZWlfcG9zdF9zaW0oc3RydWN0IG9m
b25vX21vZGVtICptb2RlbSk8YnI+wqDCoMKgwqAgwqDCoMKgIHN0cnVjdCBvZm9ub19ncHJzICpn
cHJzOzxicj7CoMKgwqDCoCDCoMKgwqAgc3RydWN0IG9mb25vX2dwcnNfY29udGV4dCAqZ2M7PGJy
PsKgPGJyPi3CoMKgwqAgwqDCoMKgIG9mb25vX3Bob25lYm9va19jcmVhdGUobW9kZW0sIDAsICZx
dW90O2F0bW9kZW0mcXVvdDssIGRhdGEtJmd0O3BjdWkpOzxicj4rwqDCoMKgIMKgwqDCoCBvZm9u
b19waG9uZWJvb2tfY3JlYXRlKG1vZGVtLCAwLCAmcXVvdDtodWF3ZWltb2RlbSZxdW90OywgZGF0
YS0mZ3Q7cGN1aSk7PGJyPsKgwqDCoMKgIMKgwqDCoCBvZm9ub19yYWRpb19zZXR0aW5nc19jcmVh
dGUobW9kZW0sIDAsPGJyPsKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKg
wqAgJnF1b3Q7aHVhd2VpbW9kZW0mcXVvdDssIGRhdGEtJmd0O3BjdWkpOzxicj7CoDxicj7CoMKg
wqDCoCDCoMKgwqAgb2Zvbm9fc21zX2NyZWF0ZShtb2RlbSwgT0ZPTk9fVkVORE9SX0hVQVdFSSw8
YnI+LcKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgICZxdW90O2F0bW9k
ZW0mcXVvdDssIGRhdGEtJmd0O3BjdWkpOzxicj4rwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKg
IMKgwqDCoCDCoMKgwqAgJnF1b3Q7aHVhd2VpbW9kZW0mcXVvdDssIGRhdGEtJmd0O3BjdWkpOzxi
cj7CoDxicj7CoMKgwqDCoCDCoMKgwqAgZ3BycyA9IG9mb25vX2dwcnNfY3JlYXRlKG1vZGVtLCBP
Rk9OT19WRU5ET1JfSFVBV0VJLDxicj4twqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgJnF1b3Q7YXRtb2RlbSZxdW90OywgZGF0YS0mZ3Q7cGN1aSk7PGJyPivCoMKgwqAg
wqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCAmcXVvdDtodWF3ZWltb2RlbSZxdW90
OywgZGF0YS0mZ3Q7cGN1aSk7PGJyPsKgwqDCoMKgIMKgwqDCoCBnYyA9IG9mb25vX2dwcnNfY29u
dGV4dF9jcmVhdGUobW9kZW0sIDAsPGJyPi3CoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDC
oMKgIMKgwqDCoCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBkYXRhLSZndDttb2RlbSk7PGJyPivCoMKg
wqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCAmcXVvdDtodWF3ZWltb2RlbSZx
dW90OywgZGF0YS0mZ3Q7bW9kZW0pOzxicj7CoDxicj7CoMKgwqDCoCDCoMKgwqAgaWYgKGdwcnMg
JmFtcDsmYW1wOyBnYyk8YnI+wqDCoMKgwqAgwqDCoMKgIMKgwqDCoCBvZm9ub19ncHJzX2FkZF9j
b250ZXh0KGdwcnMsIGdjKTs8YnI+QEAgLTg0OCw3ICs4NDgsNyBAQCBzdGF0aWMgdm9pZCBodWF3
ZWlfcG9zdF9vbmxpbmUoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSk8YnI+wqA8YnI+wqDCoMKg
wqAgaWYgKGRhdGEtJmd0O2hhdmVfZ3NtID09IFRSVUUpIHs8YnI+wqDCoMKgwqAgwqDCoMKgIG9m
b25vX25ldHJlZ19jcmVhdGUobW9kZW0sIE9GT05PX1ZFTkRPUl9IVUFXRUksPGJyPi3CoMKgwqAg
wqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCAmcXVvdDthdG1vZGVtJnF1b3Q7LCBk
YXRhLSZndDtwY3VpKTs8YnI+K8KgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDC
oMKgICZxdW90O2h1YXdlaW1vZGVtJnF1b3Q7LCBkYXRhLSZndDtwY3VpKTs8YnI+wqA8YnI+wqDC
oMKgwqAgwqDCoMKgIG9mb25vX2Nic19jcmVhdGUobW9kZW0sIE9GT05PX1ZFTkRPUl9RVUFMQ09N
TV9NU00sPGJyPsKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgJnF1
b3Q7YXRtb2RlbSZxdW90OywgZGF0YS0mZ3Q7cGN1aSk7PGJyPkBAIC04NjEsNyArODYxLDcgQEAg
c3RhdGljIHZvaWQgaHVhd2VpX3Bvc3Rfb25saW5lKHN0cnVjdCBvZm9ub19tb2RlbSAqbW9kZW0p
PGJyPsKgwqDCoMKgIMKgwqDCoCBvZm9ub19jZG1hX25ldHJlZ19jcmVhdGUobW9kZW0sIDAsICZx
dW90O2h1YXdlaW1vZGVtJnF1b3Q7LCBkYXRhLSZndDtwY3VpKTs8YnI+wqA8YnI+wqDCoMKgwqAg
wqDCoMKgIG9mb25vX2NkbWFfY29ubm1hbl9jcmVhdGUobW9kZW0sIE9GT05PX1ZFTkRPUl9IVUFX
RUksPGJyPi3CoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCAmcXVvdDtj
ZG1hbW9kZW0mcXVvdDssIGRhdGEtJmd0O21vZGVtKTs8YnI+K8KgwqDCoCDCoMKgwqAgwqDCoMKg
IMKgwqDCoCDCoMKgwqAgwqDCoMKgICZxdW90O2h1YXdlaW1vZGVtJnF1b3Q7LCBkYXRhLSZndDtt
b2RlbSk7PGJyPsKgwqDCoMKgIH08YnI+wqA8YnI+wqDCoMKgwqAgaWYgKGRhdGEtJmd0O2hhdmVf
dm9pY2UgPT0gVFJVRSkgezxicj5kaWZmIC0tZ2l0IGEvcGx1Z2lucy91ZGV2bmcuYyBiL3BsdWdp
bnMvdWRldm5nLmM8YnI+aW5kZXggZTQzZDA0NS4uOTc2ZjIwOSAxMDA2NDQ8YnI+LS0tIGEvcGx1
Z2lucy91ZGV2bmcuYzxicj4rKysgYi9wbHVnaW5zL3VkZXZuZy5jPGJyPkBAIC0zMjEsNiArMzIx
LDcgQEAgc3RhdGljIGdib29sZWFuIHNldHVwX2h1YXdlaShzdHJ1Y3QgbW9kZW1faW5mbyAqbW9k
ZW0pPGJyPsKgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIGdfc3RyY21wMChpbmZvLSZndDtp
bnRlcmZhY2UsICZxdW90OzI1NS8xLzUxJnF1b3Q7KSA9PSAwKSB7PGJyPsKgwqDCoMKgIMKgwqDC
oCDCoMKgwqAgZGlhZyA9IGluZm8tJmd0O2Rldm5vZGU7PGJyPsKgwqDCoMKgIMKgwqDCoCB9IGVs
c2UgaWYgKGdfc3RyY21wMChpbmZvLSZndDtpbnRlcmZhY2UsICZxdW90OzI1NS8xLzgmcXVvdDsp
ID09IDAgfHw8YnI+K8KgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCBnX3N0cmNtcDAoaW5mby0m
Z3Q7aW50ZXJmYWNlLCAmcXVvdDsyNTUvMi8yMiZxdW90OykgPT0gMCB8fDxicj7CoMKgwqDCoCDC
oMKgwqAgwqDCoMKgIMKgwqDCoCBnX3N0cmNtcDAoaW5mby0mZ3Q7aW50ZXJmYWNlLCAmcXVvdDsy
NTUvMS81NiZxdW90OykgPT0gMCkgezxicj7CoMKgwqDCoCDCoMKgwqAgwqDCoMKgIG5ldCA9IGlu
Zm8tJmd0O2Rldm5vZGU7PGJyPsKgwqDCoMKgIMKgwqDCoCB9IGVsc2UgaWYgKGdfc3RyY21wMChp
bmZvLSZndDtpbnRlcmZhY2UsICZxdW90OzI1NS8xLzkmcXVvdDspID09IDAgfHw8YnI+QEAgLTEx
MDQsNiArMTEwNSw3IEBAIHN0YXRpYyBzdHJ1Y3Qgezxicj7CoMKgwqDCoCB7ICZxdW90O2h1YXdl
aSZxdW90OyzCoMKgwqAgJnF1b3Q7Y2RjX2V0aGVyJnF1b3Q7LMKgwqDCoCAmcXVvdDsxMmQxJnF1
b3Q7wqDCoMKgIMKgwqDCoCB9LDxicj7CoMKgwqDCoCB7ICZxdW90O2h1YXdlaSZxdW90OyzCoMKg
wqAgJnF1b3Q7cW1pX3d3YW4mcXVvdDsswqDCoMKgICZxdW90OzEyZDEmcXVvdDvCoMKgwqAgwqDC
oMKgIH0sPGJyPsKgwqDCoMKgIHsgJnF1b3Q7aHVhd2VpJnF1b3Q7LMKgwqDCoCAmcXVvdDtvcHRp
b24mcXVvdDsswqDCoMKgICZxdW90OzEyZDEmcXVvdDvCoMKgwqAgwqDCoMKgIH0sPGJyPivCoMKg
wqAgeyAmcXVvdDtodWF3ZWkmcXVvdDsswqDCoMKgICZxdW90O2h1YXdlaV9jZGNfbmNtJnF1b3Q7
LMKgwqDCoCAmcXVvdDsxMmQxJnF1b3Q7wqDCoMKgIMKgwqDCoCB9LDxicj7CoMKgwqDCoCB7ICZx
dW90O3NwZWVkdXBjZG1hJnF1b3Q7LCZxdW90O29wdGlvbiZxdW90OyzCoMKgwqAgJnF1b3Q7MWM5
ZSZxdW90OywgJnF1b3Q7OWUwMCZxdW90O8KgwqDCoCB9LDxicj7CoMKgwqDCoCB7ICZxdW90O3Nw
ZWVkdXAmcXVvdDsswqDCoMKgICZxdW90O29wdGlvbiZxdW90OyzCoMKgwqAgJnF1b3Q7MWM5ZSZx
dW90O8KgwqDCoCDCoMKgwqAgfSw8YnI+wqDCoMKgwqAgeyAmcXVvdDtzcGVlZHVwJnF1b3Q7LMKg
wqDCoCAmcXVvdDtvcHRpb24mcXVvdDsswqDCoMKgICZxdW90OzIwMjAmcXVvdDvCoMKgwqAgwqDC
oMKgIH0sPGJyPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIj4yMDE2LTAxLTEyIDE5OjIwIEdNVCswMjowMCBEZW5pcyBLZW56aW9y
IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIiB0
YXJnZXQ9Il9ibGFuayI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozwvc3Bhbj46PGJyPjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRl
ci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPkhpIE1hdHRpLDxzcGFuIGNs
YXNzPSIiPjxicj4KPGJyPgpPbiAwMS8xMi8yMDE2IDEwOjU2IEFNLCBtYXR0aSBrYWFzaW5lbiB3
cm90ZTo8YnI+Cjwvc3Bhbj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij48c3BhbiBjbGFzcz0iIj4KRGVuaXMsPGJyPgo8YnI+CjIwMTYtMDEtMTIgMTg6NDYgR01U
KzAyOjAwIG1hdHRpIGthYXNpbmVuICZsdDs8YSBocmVmPSJtYWlsdG86bWF0dGkua2Fhc2luZW5A
Z21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bWF0dGkua2Fhc2luZW5AZ21haWwuY29tPC9hPjxi
cj48L3NwYW4+CiZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRvOm1hdHRpLmthYXNpbmVuQGdtYWls
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm1hdHRpLmthYXNpbmVuQGdtYWlsLmNvbTwvYT4mZ3Q7Jmd0
Ozo8c3BhbiBjbGFzcz0iIj48YnI+Cjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgYWN0aXZhdGUtY29u
dGV4dDxicj4KwqAgwqAgwqAgwqAgwqAgwqAgPSZndDs8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIEVy
cm9yIGFjdGl2YXRpbmcgL2h1YXdlaV8wL2NvbnRleHQxOjxicj4KwqAgwqAgwqAgwqAgwqAgwqAg
b3JnLm9mb25vLkVycm9yLk5vdEltcGxlbWVudGVkOjxicj4KwqAgwqAgwqAgwqAgwqAgwqAgSW1w
bGVtZW50YXRpb24gbm90IHByb3ZpZGVkPGJyPgo8YnI+Cjxicj4KwqAgwqAgwqAgwqAgVGhlcmUg
aXMgbm8gZ3BycyBjb250ZXh0IGRyaXZlciBwcm92aWRlZCBvciBpdCBmYWlsZWQgdG8gc2V0dXAu
PGJyPgrCoCDCoCDCoCDCoCBEbyB5b3UgaGF2ZSBUVU4vVEFQIGluIHRoZSBrZXJuZWwgb3Iga2Vy
bmVsIG1vZHVsZT88YnI+Cjxicj4KwqAgwqAgSXQgd2FzIG5vdCBsb2FkZWQsIGJ1dCBJIG1vZHBy
b2JlZCBpdCBub3cgbWFudWFsbHkgYW5kIGdvdCBkaWZmZXJlbnQ8YnI+CsKgIMKgIGVycm9yIG1l
c3NhZ2U6PGJyPgrCoCDCoCBFcnJvciBhY3RpdmF0aW5nIC9odWF3ZWlfMS9jb250ZXh0MTogb3Jn
Lm9mb25vLkVycm9yLkZhaWxlZDo8YnI+CsKgIMKgIE9wZXJhdGlvbiBmYWlsZWQ8YnI+Cjxicj4K
PGJyPgpPZm9ubyBsb2cgZ2F2ZSBub3cgc29tZSBlcnJvciBtZXNzYWdlczo8YnI+Ci4ub2Zvbm9k
OiBkcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmM6YXRfZ3Byc19hY3RpdmF0ZV9wcmltYXJ5
KCkgY2lkIDE8YnI+Ci4ub2Zvbm9kOiBNb2RlbTogJmd0OyBBVCtDR0RDT05UPTEsJnF1b3Q7SVAm
cXVvdDssJnF1b3Q7aW50ZXJuZXQmcXVvdDtccjxicj4KLi5vZm9ub2Q6IE1vZGVtOiAmbHQ7IFxy
XG5PS1xyXG48YnI+Ci4ub2Zvbm9kOiBkcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmM6YXRf
Y2dkY29udF9jYigpIG9rIDE8YnI+Ci4ub2Zvbm9kOiBNb2RlbTogJmd0OyBBVCtDR0RBVEE9JnF1
b3Q7UFBQJnF1b3Q7LDFccjxicj4KLi5vZm9ub2Q6IE1vZGVtOiAmbHQ7IFxyXG4rQ01FIEVSUk9S
OiA1MFxyXG48YnI+Ci4ub2Zvbm9kOiBkcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250ZXh0LmM6YXRf
Y2dkYXRhX2NiKCkgb2sgMDxicj4KLi5vZm9ub2Q6IFVuYWJsZSB0byBlbnRlciBkYXRhIHN0YXRl
PGJyPgouLm9mb25vZDogc3JjL2dwcnMuYzpwcmlfYWN0aXZhdGVfY2FsbGJhY2soKSAweDEyMjU4
MDxicj4KLi5vZm9ub2Q6IHNyYy9ncHJzLmM6cHJpX2FjdGl2YXRlX2NhbGxiYWNrKCkgQWN0aXZh
dGluZyBjb250ZXh0IGZhaWxlZDxicj4Kd2l0aCBlcnJvcjogSW5jb3JyZWN0IHBhcmFtZXRlcnM8
YnI+Cjxicj4KPC9zcGFuPjwvYmxvY2txdW90ZT4KPGJyPgpMb29rcyBsaWtlIHlvdXIgbW9kZW0g
aGFzIGEgbmV3ZXIgLyBkaWZmZXJlbnQgZmlybXdhcmUuwqAgaW4gcGx1Z2lucy9odWF3ZWkuYywg
bGluZTo8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdjID0gb2Zvbm9fZ3Byc19jb250ZXh0
X2NyZWF0ZShtb2RlbSwgMCw8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O2F0bW9kZW0mcXVvdDss
IGRhdGEtJmd0O21vZGVtKTs8YnI+Cjxicj4KQ2FuIHlvdSB0cnkgY2hhbmdpbmcgJnF1b3Q7YXRt
b2RlbSZxdW90OyB0byAmcXVvdDtodWF3ZWltb2RlbSZxdW90OyBhbmQgc2VlIGlmIGl0IHdvcmtz
IGFmdGVyIHRoYXQ/PGJyPgo8YnI+ClJlZ2FyZHMsPGJyPgotRGVuaXM8YnI+CjwvYmxvY2txdW90
ZT48L2Rpdj48YnI+PC9kaXY+Cg==

--===============8624233554840886403==--

