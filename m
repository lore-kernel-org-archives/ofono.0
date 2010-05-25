Content-Type: multipart/mixed; boundary="===============1779432611081720278=="
MIME-Version: 1.0
From: Naresh Mehta <nareshtechs@gmail.com>
Subject: Ofono - Quering PIN authentication state failed
Date: Tue, 25 May 2010 16:11:51 +0200
Message-ID: <AANLkTinqHj40b3H0Zjg2ecS_3Ttzb0fqz-2N1Q1KoP-j@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1779432611081720278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

I am new to Ofono development but am very interested in checking it out and
see if I can contribute with something. I have pulled the ofono source and
am able to build the daemon. I have also been able to connect to the
AT-Modem interface on /generic (as defined in the modem.conf) file.

Below is the sequence of prints that I get on the daemon terminal after I
execute enable-modem in another terminal:

sudo ./src/ofonod -n -d 'plugins/*'
ofonod[8592]: oFono version 0.20
ofonod[8592]: plugins/atgen.c:atgen_enable() 0x93e9418
ofonod[8592]: plugins/atgen.c:atgen_pre_sim() 0x93e9418
ofonod[8592]: Querying PIN authentication state failed
ofonod[8592]: Querying PIN authentication state failed

I also do a GetProperties on SimManager which shows the following:

sudo dbus-send --print-reply --system --dest=3Dorg.ofono /generic
org.ofono.SimManager.GetProperties
method return sender=3D:1.165 -> dest=3D:1.169 reply_serial=3D2
   array [
      dict entry(
         string "Present"
         variant             boolean true
      )
      dict entry(
         string "SubscriberNumbers"
         variant             array [
            ]
      )
      dict entry(
         string "LockedPins"
         variant             array [
            ]
      )
      dict entry(
         string "PinRequired"
         variant             string "none"
      )
   ]

The problem that I have is that I can't see any more interfaces in either
the /generic or / path. The only interfaces it shows on / is
org.ofon.Manager. And on /generic it shows org.ofono.Modem and
org.ofono.SimManager. I saw the SimManager methods and since there is no PIN
set, I should be able to see further interfaces like VoiceCallManager and
SmsManager. But I am not able to see that.

Anybody has any ideas/paths for guiding me? I am stuck here and am not able
to send any dbus messages or execute the test scripts as the interfaces
themselves do not exists.

Thanks in advance.

BR; Naresh

--===============1779432611081720278==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgQWxsLDxicj48YnI+SSBhbSBuZXcgdG8gT2Zvbm8gZGV2ZWxvcG1lbnQgYnV0IGFtIHZlcnkg
aW50ZXJlc3RlZCBpbiBjaGVja2luZyBpdCBvdXQgYW5kIHNlZSBpZiBJIGNhbiBjb250cmlidXRl
IHdpdGggc29tZXRoaW5nLiBJIGhhdmUgcHVsbGVkIHRoZSBvZm9ubyBzb3VyY2UgYW5kIGFtIGFi
bGUgdG8gYnVpbGQgdGhlIGRhZW1vbi4gSSBoYXZlIGFsc28gYmVlbiBhYmxlIHRvIGNvbm5lY3Qg
dG8gdGhlIEFULU1vZGVtIGludGVyZmFjZSBvbiAvZ2VuZXJpYyAoYXMgZGVmaW5lZCBpbiB0aGUg
bW9kZW0uY29uZikgZmlsZS48YnI+Cjxicj5CZWxvdyBpcyB0aGUgc2VxdWVuY2Ugb2YgcHJpbnRz
IHRoYXQgSSBnZXQgb24gdGhlIGRhZW1vbiB0ZXJtaW5hbCBhZnRlciBJIGV4ZWN1dGUgZW5hYmxl
LW1vZGVtIGluIGFub3RoZXIgdGVybWluYWw6PGJyPjxicj5zdWRvIC4vc3JjL29mb25vZCAtbiAt
ZCAmIzM5O3BsdWdpbnMvKiYjMzk7PGJyPm9mb25vZFs4NTkyXTogb0Zvbm8gdmVyc2lvbiAwLjIw
PGJyPm9mb25vZFs4NTkyXTogcGx1Z2lucy9hdGdlbi5jOmF0Z2VuX2VuYWJsZSgpIDB4OTNlOTQx
ODxicj4Kb2Zvbm9kWzg1OTJdOiBwbHVnaW5zL2F0Z2VuLmM6YXRnZW5fcHJlX3NpbSgpIDB4OTNl
OTQxODxicj5vZm9ub2RbODU5Ml06IFF1ZXJ5aW5nIFBJTiBhdXRoZW50aWNhdGlvbiBzdGF0ZSBm
YWlsZWQ8YnI+b2Zvbm9kWzg1OTJdOiBRdWVyeWluZyBQSU4gYXV0aGVudGljYXRpb24gc3RhdGUg
ZmFpbGVkPGJyPjxicj5JIGFsc28gZG8gYSBHZXRQcm9wZXJ0aWVzIG9uIFNpbU1hbmFnZXIgd2hp
Y2ggc2hvd3MgdGhlIGZvbGxvd2luZzo8YnI+Cjxicj5zdWRvIGRidXMtc2VuZCAtLXByaW50LXJl
cGx5IC0tc3lzdGVtIC0tZGVzdD1vcmcub2Zvbm8gL2dlbmVyaWMgb3JnLm9mb25vLlNpbU1hbmFn
ZXIuR2V0UHJvcGVydGllczxicj5tZXRob2QgcmV0dXJuIHNlbmRlcj06MS4xNjUgLSZndDsgZGVz
dD06MS4xNjkgcmVwbHlfc2VyaWFsPTI8YnI+oKAgYXJyYXkgWzxicj6goKCgoCBkaWN0IGVudHJ5
KDxicj6goKCgoKCgoCBzdHJpbmcgJnF1b3Q7UHJlc2VudCZxdW90Ozxicj4KoKCgoKCgoKAgdmFy
aWFudKCgoKCgoKCgoKCgoCBib29sZWFuIHRydWU8YnI+oKCgoKAgKTxicj6goKCgoCBkaWN0IGVu
dHJ5KDxicj6goKCgoKCgoCBzdHJpbmcgJnF1b3Q7U3Vic2NyaWJlck51bWJlcnMmcXVvdDs8YnI+
oKCgoKCgoKAgdmFyaWFudKCgoKCgoKCgoKCgoCBhcnJheSBbPGJyPqCgoKCgoKCgoKCgIF08YnI+
oKCgoKAgKTxicj6goKCgoCBkaWN0IGVudHJ5KDxicj6goKCgoKCgoCBzdHJpbmcgJnF1b3Q7TG9j
a2VkUGlucyZxdW90Ozxicj4KoKCgoKCgoKAgdmFyaWFudKCgoKCgoKCgoKCgoCBhcnJheSBbPGJy
PqCgoKCgoKCgoKCgIF08YnI+oKCgoKAgKTxicj6goKCgoCBkaWN0IGVudHJ5KDxicj6goKCgoKCg
oCBzdHJpbmcgJnF1b3Q7UGluUmVxdWlyZWQmcXVvdDs8YnI+oKCgoKCgoKAgdmFyaWFudKCgoKCg
oKCgoKCgoCBzdHJpbmcgJnF1b3Q7bm9uZSZxdW90Ozxicj6goKCgoCApPGJyPqCgIF08YnI+PGJy
PlRoZSBwcm9ibGVtIHRoYXQgSSBoYXZlIGlzIHRoYXQgSSBjYW4mIzM5O3Qgc2VlIGFueSBtb3Jl
IGludGVyZmFjZXMgaW4gZWl0aGVyIHRoZSAvZ2VuZXJpYyBvciAvIHBhdGguIFRoZSBvbmx5IGlu
dGVyZmFjZXMgaXQgc2hvd3Mgb24gLyBpcyBvcmcub2Zvbi5NYW5hZ2VyLiBBbmQgb24gL2dlbmVy
aWMgaXQgc2hvd3Mgb3JnLm9mb25vLk1vZGVtIGFuZCBvcmcub2Zvbm8uU2ltTWFuYWdlci4gSSBz
YXcgdGhlIFNpbU1hbmFnZXIgbWV0aG9kcyBhbmQgc2luY2UgdGhlcmUgaXMgbm8gUElOIHNldCwg
SSBzaG91bGQgYmUgYWJsZSB0byBzZWUgZnVydGhlciBpbnRlcmZhY2VzIGxpa2UgVm9pY2VDYWxs
TWFuYWdlciBhbmQgU21zTWFuYWdlci4gQnV0IEkgYW0gbm90IGFibGUgdG8gc2VlIHRoYXQuPGJy
Pgo8YnI+QW55Ym9keSBoYXMgYW55IGlkZWFzL3BhdGhzIGZvciBndWlkaW5nIG1lPyBJIGFtIHN0
dWNrIGhlcmUgYW5kIGFtIG5vdCBhYmxlIHRvIHNlbmQgYW55IGRidXMgbWVzc2FnZXMgb3IgZXhl
Y3V0ZSB0aGUgdGVzdCBzY3JpcHRzIGFzIHRoZSBpbnRlcmZhY2VzIHRoZW1zZWx2ZXMgZG8gbm90
IGV4aXN0cy48YnI+PGJyPlRoYW5rcyBpbiBhZHZhbmNlLjxicj48YnI+QlI7IE5hcmVzaDxicj4K

--===============1779432611081720278==--

