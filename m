Content-Type: multipart/mixed; boundary="===============4720896240591360888=="
MIME-Version: 1.0
From: nick83ola <nick83ola@gmail.com>
Subject: Re: Telit ME910C1-WW not detected
Date: Wed, 02 Oct 2019 14:59:48 +0100
Message-ID: <CABPh3UMAoOOy6f9zdBNmnaus5BFgtJBGc3v9R-q=QWFdnm00pw@mail.gmail.com>
In-Reply-To: <20191001215613.17538.73482@new-ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4720896240591360888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anibal,
I'm interested as well in the patch

I saw that there you have two branches (me910 and v1.30+me910) can you tell
me what branch have you tested?
the diff is this

git diff me910
diff --git a/plugins/telit.c b/plugins/telit.c
index f36995dc..50344281 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -239,16 +239,19 @@ static void cfun_enable_cb(gboolean ok, GAtResult
*result, gpointer user_data)

        ofono_modem_set_powered(modem, TRUE);

-       /*
-        * Tell the modem not to automatically initiate auto-attach
-        * proceedures on its own.
-        */
-       if (data->model =3D=3D ME910C1)
-               g_at_chat_send(data->chat, "AT+CGATT=3D0", NULL, NULL, NULL,
NULL);
-       else
-
+       if (data->model =3D=3D ME910C1) {
+               /*
+                * Telit ME910C1 needs to activate the GPRS to auto-attach
the network.
+                */
+               g_at_chat_send(data->chat, "AT+CGATT=3D1", NULL, NULL, NULL,
NULL);
+       } else {
+               /*
+                * Tell the modem not to automatically initiate auto-attach
+                * proceedures on its own.
+                */
                g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix,
                                        NULL, NULL, NULL);
+       }

        /* Follow sim state */
        g_at_chat_register(data->chat, "#QSS:", telit_qss_notify,


Thanks
Nicola Lunghi


On Tue, 1 Oct 2019 at 22:54, <limon.anibal@gmail.com> wrote:

> Hi Dresdo,
>
> I have a patch that adds support for Telit ME910 but it is upon Ofono
> 1.30, i plan to send for review.
>
>
> https://github.com/alimon/ofono/commit/920712e184ffaf1143e9ce13c3bec8ac1d=
eeda5c
>
> Regards!,
> Anibal
> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org
>

--===============4720896240591360888==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBBbmliYWwsPC9kaXY+PGRpdj5JJiMzOTttIGludGVyZXN0
ZWQgYXMgd2VsbCBpbiB0aGUgcGF0Y2g8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgc2F3IHRo
YXQgdGhlcmUgeW91IGhhdmUgdHdvIGJyYW5jaGVzIChtZTkxMCBhbmQgdjEuMzArbWU5MTApIGNh
biB5b3UgdGVsbCBtZSB3aGF0IGJyYW5jaCBoYXZlIHlvdSB0ZXN0ZWQ/PC9kaXY+PGRpdj50aGUg
ZGlmZiBpcyB0aGlzPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5naXQgZGlmZiBtZTkxMDxicj5k
aWZmIC0tZ2l0IGEvcGx1Z2lucy90ZWxpdC5jIGIvcGx1Z2lucy90ZWxpdC5jPGJyPmluZGV4IGYz
Njk5NWRjLi41MDM0NDI4MSAxMDA2NDQ8YnI+LS0tIGEvcGx1Z2lucy90ZWxpdC5jPGJyPisrKyBi
L3BsdWdpbnMvdGVsaXQuYzxicj5AQCAtMjM5LDE2ICsyMzksMTkgQEAgc3RhdGljIHZvaWQgY2Z1
bl9lbmFibGVfY2IoZ2Jvb2xlYW4gb2ssIEdBdFJlc3VsdCAqcmVzdWx0LCBncG9pbnRlciB1c2Vy
X2RhdGEpPGJyPsKgPGJyPsKgIMKgIMKgIMKgIG9mb25vX21vZGVtX3NldF9wb3dlcmVkKG1vZGVt
LCBUUlVFKTs8YnI+wqA8YnI+LSDCoCDCoCDCoCAvKjxicj4tIMKgIMKgIMKgIMKgKiBUZWxsIHRo
ZSBtb2RlbSBub3QgdG8gYXV0b21hdGljYWxseSBpbml0aWF0ZSBhdXRvLWF0dGFjaDxicj4tIMKg
IMKgIMKgIMKgKiBwcm9jZWVkdXJlcyBvbiBpdHMgb3duLjxicj4tIMKgIMKgIMKgIMKgKi88YnI+
LSDCoCDCoCDCoCBpZiAoZGF0YS0mZ3Q7bW9kZWwgPT0gTUU5MTBDMSk8YnI+LSDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBnX2F0X2NoYXRfc2VuZChkYXRhLSZndDtjaGF0LCAmcXVvdDtBVCtDR0FUVD0w
JnF1b3Q7LCBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMKTs8YnI+LSDCoCDCoCDCoCBlbHNlPGJyPi08
YnI+KyDCoCDCoCDCoCBpZiAoZGF0YS0mZ3Q7bW9kZWwgPT0gTUU5MTBDMSkgezxicj4rIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIC8qPGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqIFRlbGl0IE1F
OTEwQzEgbmVlZHMgdG8gYWN0aXZhdGUgdGhlIEdQUlMgdG8gYXV0by1hdHRhY2ggdGhlIG5ldHdv
cmsuPGJyPisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqLzxicj4rIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGdfYXRfY2hhdF9zZW5kKGRhdGEtJmd0O2NoYXQsICZxdW90O0FUK0NHQVRUPTEmcXVvdDss
IE5VTEwsIE5VTEwsIE5VTEwsIE5VTEwpOzxicj4rIMKgIMKgIMKgIH0gZWxzZSB7PGJyPisgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgLyo8YnI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCogVGVsbCB0
aGUgbW9kZW0gbm90IHRvIGF1dG9tYXRpY2FsbHkgaW5pdGlhdGUgYXV0by1hdHRhY2g8YnI+KyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCogcHJvY2VlZHVyZXMgb24gaXRzIG93bi48YnI+KyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCovPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdfYXRfY2hh
dF9zZW5kKGRhdGEtJmd0O2NoYXQsICZxdW90O0FUI0FVVE9BVFQ9MCZxdW90Oywgbm9uZV9wcmVm
aXgsPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIE5VTEwsIE5VTEwsIE5VTEwpOzxicj4rIMKgIMKgIMKgIH08YnI+wqA8YnI+wqAg
wqAgwqAgwqAgLyogRm9sbG93IHNpbSBzdGF0ZSAqLzxicj7CoCDCoCDCoCDCoCBnX2F0X2NoYXRf
cmVnaXN0ZXIoZGF0YS0mZ3Q7Y2hhdCwgJnF1b3Q7I1FTUzomcXVvdDssIHRlbGl0X3Fzc19ub3Rp
ZnksPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3M8L2Rpdj48
ZGl2Pk5pY29sYSBMdW5naGk8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24g
VHVlLCAxIE9jdCAyMDE5IGF0IDIyOjU0LCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmxpbW9uLmFuaWJh
bEBnbWFpbC5jb20iPmxpbW9uLmFuaWJhbEBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9k
aXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHgg
MHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmct
bGVmdDoxZXgiPkhpIERyZXNkbyw8YnI+Cjxicj4KSSBoYXZlIGEgcGF0Y2ggdGhhdCBhZGRzIHN1
cHBvcnQgZm9yIFRlbGl0IE1FOTEwIGJ1dCBpdCBpcyB1cG9uIE9mb25vIDEuMzAsIGkgcGxhbiB0
byBzZW5kIGZvciByZXZpZXcuPGJyPgo8YnI+CjxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9h
bGltb24vb2Zvbm8vY29tbWl0LzkyMDcxMmUxODRmZmFmMTE0M2U5Y2UxM2MzYmVjOGFjMWRlZWRh
NWMiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vZ2l0aHViLmNvbS9h
bGltb24vb2Zvbm8vY29tbWl0LzkyMDcxMmUxODRmZmFmMTE0M2U5Y2UxM2MzYmVjOGFjMWRlZWRh
NWM8L2E+PGJyPgo8YnI+ClJlZ2FyZHMhLDxicj4KQW5pYmFsPGJyPgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0IC0t
IDxhIGhyZWY9Im1haWx0bzpvZm9ub0BvZm9uby5vcmciIHRhcmdldD0iX2JsYW5rIj5vZm9ub0Bv
Zm9uby5vcmc8L2E+PGJyPgpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIDxhIGhyZWY9
Im1haWx0bzpvZm9uby1sZWF2ZUBvZm9uby5vcmciIHRhcmdldD0iX2JsYW5rIj5vZm9uby1sZWF2
ZUBvZm9uby5vcmc8L2E+PGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============4720896240591360888==--

