Content-Type: multipart/mixed; boundary="===============7166480019658399972=="
MIME-Version: 1.0
From: Marko Saukko <marko.saukko@gmail.com>
Subject: [PATCH] SetProperty method and Powered property missing from
 modem-api doc.
Date: Mon, 19 Oct 2009 16:06:51 +0300
Message-ID: <ae5fd6e50910190606m88b1ed9w2f7b1741ec4e01c@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7166480019658399972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

SetProperty method and Powered Property where missing from modem-api.txt

Question:

I'm not sure if the "On success a PropertyChanged signal will be emitted."
message is valid, as the PropertyChanged signal is sent only once when doing
for example the following:

$ dbus-send --print-reply --system --dest=3Dorg.ofono /atgen0
org.ofono.Modem.SetProperty string:Powered variant:boolean:true
method return sender=3D:1.160 -> dest=3D:1.227 reply_serial=3D2
$ dbus-send --print-reply --system --dest=3Dorg.ofono /atgen0
org.ofono.Modem.SetProperty string:Powered variant:boolean:true
method return sender=3D:1.160 -> dest=3D:1.228 reply_serial=3D2

If I understood correctly the second method call is also successfull
eventhough no PropertyChanged signal is emitted.

Regards,
Marko

---
 doc/modem-api.txt |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/doc/modem-api.txt b/doc/modem-api.txt
index 3058880..06a4ada 100644
--- a/doc/modem-api.txt
+++ b/doc/modem-api.txt
@@ -12,12 +12,27 @@ Methods             dict GetProperties()

                        Possible Errors: [service].Error.InvalidArguments

+               void SetProperty(string property, variant value)
+
+                       Changes the value of the specified property. Only
+                       properties that are listed as read-write are
+                       changeable. On success a PropertyChanged signal
+                       will be emitted.
+
+                       Possible Errors: [service].Error.InvalidArguments
+                                        [service].Error.DoesNotExist
+
 Signals                PropertyChanged(string name, variant value)

                        This signal indicates a changed value of the given
                        property.

-Properties     string Manufacturer [readonly, optional]
+Properties     boolean Powered [readwrite]
+
+                       Boolean representing the power state of the modem
+                       device.
+
+               string Manufacturer [readonly, optional]

                        String representing the manufacturer of the modem
                        device.
--
1.6.0.4

--===============7166480019658399972==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PHNwYW4gaWQ9IjpxeCIgY2xhc3M9InA5IiB0YWJpbmRleD0iMCI+SGksPGJyPjxicj5TZXRQcm9w
ZXJ0eSBtZXRob2QgYW5kIFBvd2VyZWQgUHJvcGVydHkgd2hlcmUgbWlzc2luZyBmcm9tIG1vZGVt
LWFwaS50eHQ8YnI+PGJyPlF1ZXN0aW9uOjxicj48YnI+SSYjMzk7bSBub3Qgc3VyZSBpZiB0aGUg
JnF1b3Q7PC9zcGFuPjxzcGFuIGlkPSI6cXgiIGNsYXNzPSJwOSIgdGFiaW5kZXg9IjAiPk9uIHN1
Y2Nlc3MgYSBQcm9wZXJ0eUNoYW5nZWQgc2lnbmFsIHdpbGwgYmUgZW1pdHRlZC48L3NwYW4+JnF1
b3Q7IG1lc3NhZ2UgaXMgdmFsaWQsIGFzIHRoZSBQcm9wZXJ0eUNoYW5nZWQgc2lnbmFsIGlzIHNl
bnQgb25seSBvbmNlIHdoZW4gZG9pbmcgZm9yIGV4YW1wbGUgdGhlIGZvbGxvd2luZzo8YnI+Cjxi
cj4kIGRidXMtc2VuZCAtLXByaW50LXJlcGx5IC0tc3lzdGVtIC0tZGVzdD1vcmcub2Zvbm8gL2F0
Z2VuMCBvcmcub2Zvbm8uTW9kZW0uU2V0UHJvcGVydHkgc3RyaW5nOlBvd2VyZWQgdmFyaWFudDpi
b29sZWFuOnRydWU8YnI+bWV0aG9kIHJldHVybiBzZW5kZXI9OjEuMTYwIC0mZ3Q7IGRlc3Q9OjEu
MjI3IHJlcGx5X3NlcmlhbD0yPGJyPiQgZGJ1cy1zZW5kIC0tcHJpbnQtcmVwbHkgLS1zeXN0ZW0g
LS1kZXN0PW9yZy5vZm9ubyAvYXRnZW4wIG9yZy5vZm9uby5Nb2RlbS5TZXRQcm9wZXJ0eSBzdHJp
bmc6UG93ZXJlZCB2YXJpYW50OmJvb2xlYW46dHJ1ZTxicj4KbWV0aG9kIHJldHVybiBzZW5kZXI9
OjEuMTYwIC0mZ3Q7IGRlc3Q9OjEuMjI4IHJlcGx5X3NlcmlhbD0yPGJyPjxicj5JZiBJIHVuZGVy
c3Rvb2QgY29ycmVjdGx5IHRoZSBzZWNvbmQgbWV0aG9kIGNhbGwgaXMgYWxzbyBzdWNjZXNzZnVs
bCBldmVudGhvdWdoIG5vIFByb3BlcnR5Q2hhbmdlZCBzaWduYWwgaXMgZW1pdHRlZC48YnI+PHNw
YW4gaWQ9IjpxeCIgY2xhc3M9InA5IiB0YWJpbmRleD0iMCI+PGJyPgpSZWdhcmRzLDxicj5NYXJr
bzxicj48YnI+LS0tPGJyPqBkb2MvbW9kZW0tYXBpLnR4dCB8oKAgMTcgKysrKysrKysrKysrKysr
Ky08YnI+oDEgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSk8
YnI+PGJyPmRpZmYgLS1naXQgYS9kb2MvbW9kZW0tYXBpLnR4dCBiL2RvYy9tb2RlbS1hcGkudHh0
PGJyPmluZGV4IDMwNTg4ODAuLjA2YTRhZGEgMTAwNjQ0PGJyPgotLS0gYS9kb2MvbW9kZW0tYXBp
LnR4dDxicj4rKysgYi9kb2MvbW9kZW0tYXBpLnR4dDxicj5AQCAtMTIsMTIgKzEyLDI3IEBAIE1l
dGhvZHOgoKCgoKCgoKCgoKAgZGljdCBHZXRQcm9wZXJ0aWVzKCk8YnI+PGJyPqCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgIFBvc3NpYmxlIEVycm9yczogW3NlcnZpY2VdLkVycm9yLkludmFsaWRBcmd1
bWVudHM8YnI+PGJyPiugoKCgoKCgoKCgoKCgoCB2b2lkIFNldFByb3BlcnR5KHN0cmluZyBwcm9w
ZXJ0eSwgdmFyaWFudCB2YWx1ZSk8YnI+Cis8YnI+K6CgoKCgoKCgoKCgoKCgoKCgoKCgoKAgQ2hh
bmdlcyB0aGUgdmFsdWUgb2YgdGhlIHNwZWNpZmllZCBwcm9wZXJ0eS4gT25seTxicj4roKCgoKCg
oKCgoKCgoKCgoKCgoKCgoCBwcm9wZXJ0aWVzIHRoYXQgYXJlIGxpc3RlZCBhcyByZWFkLXdyaXRl
IGFyZTxicj4roKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBjaGFuZ2VhYmxlLiBPbiBzdWNjZXNzIGEg
UHJvcGVydHlDaGFuZ2VkIHNpZ25hbDxicj4KK6CgoKCgoKCgoKCgoKCgoKCgoKCgoKAgd2lsbCBi
ZSBlbWl0dGVkLjxicj4rPGJyPiugoKCgoKCgoKCgoKCgoKCgoKCgoKCgIFBvc3NpYmxlIEVycm9y
czogW3NlcnZpY2VdLkVycm9yLkludmFsaWRBcmd1bWVudHM8YnI+K6CgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBbc2VydmljZV0uRXJyb3IuRG9lc05vdEV4aXN0PGJyPis8
YnI+oFNpZ25hbHOgoKCgoKCgoKCgoKCgoKAgUHJvcGVydHlDaGFuZ2VkKHN0cmluZyBuYW1lLCB2
YXJpYW50IHZhbHVlKTxicj4KPGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgIFRoaXMgc2lnbmFs
IGluZGljYXRlcyBhIGNoYW5nZWQgdmFsdWUgb2YgdGhlIGdpdmVuPGJyPqCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgIHByb3BlcnR5Ljxicj48YnI+LVByb3BlcnRpZXOgoKCgIHN0cmluZyBNYW51ZmFj
dHVyZXIgW3JlYWRvbmx5LCBvcHRpb25hbF08YnI+K1Byb3BlcnRpZXOgoKCgIGJvb2xlYW4gUG93
ZXJlZCBbcmVhZHdyaXRlXTxicj4KKzxicj4roKCgoKCgoKCgoKCgoKCgoKCgoKCgoCBCb29sZWFu
IHJlcHJlc2VudGluZyB0aGUgcG93ZXIgc3RhdGUgb2YgdGhlIG1vZGVtPGJyPiugoKCgoKCgoKCg
oKCgoKCgoKCgoKCgIGRldmljZS48YnI+Kzxicj4roKCgoKCgoKCgoKCgoKAgc3RyaW5nIE1hbnVm
YWN0dXJlciBbcmVhZG9ubHksIG9wdGlvbmFsXTxicj48YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKAgU3RyaW5nIHJlcHJlc2VudGluZyB0aGUgbWFudWZhY3R1cmVyIG9mIHRoZSBtb2RlbTxicj4K
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgZGV2aWNlLjxicj4tLTxicj4xLjYuMC40PGJyPjxicj48
L3NwYW4+Cg==

--===============7166480019658399972==--

