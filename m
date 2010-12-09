Content-Type: multipart/mixed; boundary="===============4200006145926552904=="
MIME-Version: 1.0
From: leena.gunda@wipro.com
Subject: [PATCH] Fix test-sms build failure
Date: Thu, 09 Dec 2010 12:48:51 +0530
Message-ID: <44023195AB5A0F46BEFE3D93A34ABB170A62F0@blr-m3-msg.wipro.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4200006145926552904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix for http://bugs.meego.com/show_bug.cgi?id=3D11081

---
 unit/test-sms.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/unit/test-sms.c b/unit/test-sms.c
index 94b9dbf..239cd4a 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -636,7 +636,7 @@ static void test_sms_charset(gconstpointer param)
        struct sms sms;
        guint8 *pdu;
        guint8 *unpacked;
-       gint64 pdu_len;
+       long pdu_len;
        gint data_len;
        enum sms_charset sms_charset;
        gboolean sms_compressed;
-- =

1.6.3.3


Please do not print this email unless it is absolutely necessary. =


The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and ma=
y contain proprietary, confidential or privileged information. If you are n=
ot the intended recipient, you should not disseminate, distribute or copy t=
his e-mail. Please notify the sender immediately and destroy all copies of =
this message and any attachments. =


WARNING: Computer viruses can be transmitted via email. The recipient shoul=
d check this email and any attachments for the presence of viruses. The com=
pany accepts no liability for any damage caused by any virus transmitted by=
 this email. =


www.wipro.com

--===============4200006145926552904==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDMuMi8vRU4iPgo8SFRNTD4K
PEhFQUQ+CjxNRVRBIEhUVFAtRVFVSVY9IkNvbnRlbnQtVHlwZSIgQ09OVEVOVD0idGV4dC9odG1s
OyBjaGFyc2V0PWlzby04ODU5LTEiPgo8TUVUQSBOQU1FPSJHZW5lcmF0b3IiIENPTlRFTlQ9Ik1T
IEV4Y2hhbmdlIFNlcnZlciB2ZXJzaW9uIDYuNS43NjU0LjEyIj4KPFRJVExFPltQQVRDSF0gRml4
IHRlc3Qtc21zIGJ1aWxkIGZhaWx1cmU8L1RJVExFPgo8L0hFQUQ+CjxCT0RZPgo8IS0tIENvbnZl
cnRlZCBmcm9tIHRleHQvcGxhaW4gZm9ybWF0IC0tPgoKPFA+PEZPTlQgU0laRT0yPkZpeCBmb3Ig
PEEgSFJFRj0iaHR0cDovL2J1Z3MubWVlZ28uY29tL3Nob3dfYnVnLmNnaT9pZD0xMTA4MSI+aHR0
cDovL2J1Z3MubWVlZ28uY29tL3Nob3dfYnVnLmNnaT9pZD0xMTA4MTwvQT48QlI+CjxCUj4KLS0t
PEJSPgombmJzcDt1bml0L3Rlc3Qtc21zLmMgfCZuYnNwOyZuYnNwOyZuYnNwOyAyICstPEJSPgom
bmJzcDsxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSk8QlI+
CjxCUj4KZGlmZiAtLWdpdCBhL3VuaXQvdGVzdC1zbXMuYyBiL3VuaXQvdGVzdC1zbXMuYzxCUj4K
aW5kZXggOTRiOWRiZi4uMjM5Y2Q0YSAxMDA2NDQ8QlI+Ci0tLSBhL3VuaXQvdGVzdC1zbXMuYzxC
Uj4KKysrIGIvdW5pdC90ZXN0LXNtcy5jPEJSPgpAQCAtNjM2LDcgKzYzNiw3IEBAIHN0YXRpYyB2
b2lkIHRlc3Rfc21zX2NoYXJzZXQoZ2NvbnN0cG9pbnRlciBwYXJhbSk8QlI+CiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBzdHJ1Y3Qgc21zIHNtczs8QlI+CiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBndWludDggKnBkdTs8QlI+CiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBndWludDggKnVucGFja2Vk
OzxCUj4KLSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBnaW50NjQgcGR1X2xl
bjs8QlI+CismbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgbG9uZyBwZHVfbGVu
OzxCUj4KJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGdpbnQgZGF0
YV9sZW47PEJSPgombmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZW51
bSBzbXNfY2hhcnNldCBzbXNfY2hhcnNldDs8QlI+CiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBnYm9vbGVhbiBzbXNfY29tcHJlc3NlZDs8QlI+Ci0tPEJSPgoxLjYu
My4zPEJSPgo8QlI+CjwvRk9OVD4KPC9QPgoKPFA+PHN0cm9uZz48c3BhbiBzdHlsZT0nZm9udC1z
aXplOjEwLjBwdDtmb250LWZhbWlseToKIlBhbGF0aW5vIExpbm90eXBlIiwic2VyaWYiO2NvbG9y
OmdyZWVuJz4gUGxlYXNlIGRvIG5vdCBwcmludCB0aGlzIGVtYWlsIHVubGVzcyBpdCBpcyBhYnNv
bHV0ZWx5IG5lY2Vzc2FyeS4gPC9zcGFuPjwvc3Ryb25nPjxzcGFuIHN0eWxlPSdmb250LWZhbWls
eToiQXJpYWwiLCJzYW5zLXNlcmlmIic+PG86cD48L286cD48L3NwYW4+PC9wPgoKCjxwPiBUaGUg
aW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZWxlY3Ryb25pYyBtZXNzYWdlIGFuZCBhbnkg
YXR0YWNobWVudHMgdG8gdGhpcyBtZXNzYWdlIGFyZSBpbnRlbmRlZCBmb3IgdGhlIGV4Y2x1c2l2
ZSB1c2Ugb2YgdGhlIGFkZHJlc3NlZShzKSBhbmQgbWF5IGNvbnRhaW4gcHJvcHJpZXRhcnksIGNv
bmZpZGVudGlhbCBvciBwcml2aWxlZ2VkIGluZm9ybWF0aW9uLiBJZiB5b3UgYXJlIG5vdCB0aGUg
aW50ZW5kZWQgcmVjaXBpZW50LCB5b3Ugc2hvdWxkIG5vdCBkaXNzZW1pbmF0ZSwgZGlzdHJpYnV0
ZSBvciBjb3B5IHRoaXMgZS1tYWlsLiBQbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRl
bHkgYW5kIGRlc3Ryb3kgYWxsIGNvcGllcyBvZiB0aGlzIG1lc3NhZ2UgYW5kIGFueSBhdHRhY2ht
ZW50cy4gPC9wPgoKPHA+V0FSTklORzogQ29tcHV0ZXIgdmlydXNlcyBjYW4gYmUgdHJhbnNtaXR0
ZWQgdmlhIGVtYWlsLiBUaGUgcmVjaXBpZW50IHNob3VsZCBjaGVjayB0aGlzIGVtYWlsIGFuZCBh
bnkgYXR0YWNobWVudHMgZm9yIHRoZSBwcmVzZW5jZSBvZiB2aXJ1c2VzLiBUaGUgY29tcGFueSBh
Y2NlcHRzIG5vIGxpYWJpbGl0eSBmb3IgYW55IGRhbWFnZSBjYXVzZWQgYnkgYW55IHZpcnVzIHRy
YW5zbWl0dGVkIGJ5IHRoaXMgZW1haWwuIDwvcD4KPHA+Cnd3dy53aXByby5jb20KPC9wPgo8L0JP
RFk+CjwvSFRNTD4=
--===============4200006145926552904==--

