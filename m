Content-Type: multipart/mixed; boundary="===============7482134460676136731=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: Re: [PATCH 1/2] sms: SMS-DELIVER TP-OA Alphanum decoding and encoding
 fix
Date: Fri, 13 Feb 2015 11:49:13 +0200
Message-ID: <CAAVgdeH6qA7-AX-fHvvHOEBXswX_ZupB1O+LSib7ZCWoVHgT5g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7482134460676136731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>
> Date: Thu, 12 Feb 2015 12:59:18 -0600
> From: Denis Kenzior <denkenz@gmail.com>
> To: ofono(a)ofono.org
> Subject: Re: [PATCH 1/2] sms: SMS-DELIVER TP-OA Alphanum decoding and
>         encoding fix
> Message-ID: <54DCF806.5060609@gmail.com>
> Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed
>
> Hi Tommi,
>
> On 02/12/2015 09:09 AM, Tommi Kenakkala wrote:
> > Ofono ignores receved SMS if they have a long alphanum address with
> > extended ascii characters:
> > 1) sms_encode_address_field: TP-OA max length comparison before encoding
> > is incorrect because TP-OA's 11 octets are 7-bit coded and thus transpo=
rt
> > twelve 8-bit chars. Change ofono to compare character count to character
> > limit instead of octet limit.
>
> How did you arrive at 11 octet figure? TP-OA is limited to 12 bytes.  So
> 12 - TON - LEN =3D 10 bytes payload.
>

Apologies, I did develop this using those values but apparently had a
glitch in my thought-generator during patch creation. I'll re-submit a
better patch.
Thanks for the quick comments.

Br.
-- =

Tommi

--===============7482134460676136731==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAw
IDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij5EYXRl
OiBUaHUsIDEyIEZlYiAyMDE1IDEyOjU5OjE4IC0wNjAwPGJyPgpGcm9tOiBEZW5pcyBLZW56aW9y
ICZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFpbC5jb20iPmRlbmtlbnpAZ21haWwuY29t
PC9hPiZndDs8YnI+ClRvOiA8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIj5vZm9ub0Bv
Zm9uby5vcmc8L2E+PGJyPgpTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gc21zOiBTTVMtREVMSVZF
UiBUUC1PQSBBbHBoYW51bSBkZWNvZGluZyBhbmQ8YnI+CsKgIMKgIMKgIMKgIGVuY29kaW5nIGZp
eDxicj4KTWVzc2FnZS1JRDogJmx0OzxhIGhyZWY9Im1haWx0bzo1NERDRjgwNi41MDYwNjA5QGdt
YWlsLmNvbSI+NTREQ0Y4MDYuNTA2MDYwOUBnbWFpbC5jb208L2E+Jmd0Ozxicj4KQ29udGVudC1U
eXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PUlTTy04ODU5LTE7IGZvcm1hdD1mbG93ZWQ8YnI+Cjxi
cj4KSGkgVG9tbWksPGJyPgo8YnI+Ck9uIDAyLzEyLzIwMTUgMDk6MDkgQU0sIFRvbW1pIEtlbmFr
a2FsYSB3cm90ZTo8YnI+CiZndDsgT2Zvbm8gaWdub3JlcyByZWNldmVkIFNNUyBpZiB0aGV5IGhh
dmUgYSBsb25nIGFscGhhbnVtIGFkZHJlc3Mgd2l0aDxicj4KJmd0OyBleHRlbmRlZCBhc2NpaSBj
aGFyYWN0ZXJzOjxicj4KJmd0OyAxKSBzbXNfZW5jb2RlX2FkZHJlc3NfZmllbGQ6IFRQLU9BIG1h
eCBsZW5ndGggY29tcGFyaXNvbiBiZWZvcmUgZW5jb2Rpbmc8YnI+CiZndDsgaXMgaW5jb3JyZWN0
IGJlY2F1c2UgVFAtT0EmIzM5O3MgMTEgb2N0ZXRzIGFyZSA3LWJpdCBjb2RlZCBhbmQgdGh1cyB0
cmFuc3BvcnQ8YnI+CiZndDsgdHdlbHZlIDgtYml0IGNoYXJzLiBDaGFuZ2Ugb2Zvbm8gdG8gY29t
cGFyZSBjaGFyYWN0ZXIgY291bnQgdG8gY2hhcmFjdGVyPGJyPgomZ3Q7IGxpbWl0IGluc3RlYWQg
b2Ygb2N0ZXQgbGltaXQuPGJyPgo8YnI+CkhvdyBkaWQgeW91IGFycml2ZSBhdCAxMSBvY3RldCBm
aWd1cmU/IFRQLU9BIGlzIGxpbWl0ZWQgdG8gMTIgYnl0ZXMuwqAgU288YnI+CjEyIC0gVE9OIC0g
TEVOID0gMTAgYnl0ZXMgcGF5bG9hZC48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2Pjxk
aXY+QXBvbG9naWVzLCBJIGRpZCBkZXZlbG9wIHRoaXMgdXNpbmcgdGhvc2UgdmFsdWVzIGJ1dCBh
cHBhcmVudGx5IGhhZCBhIGdsaXRjaCBpbiBteSB0aG91Z2h0LWdlbmVyYXRvciBkdXJpbmcgcGF0
Y2ggY3JlYXRpb24uIEkmIzM5O2xsIHJlLXN1Ym1pdCBhIGJldHRlciBwYXRjaC7CoDwvZGl2Pjxk
aXY+VGhhbmtzIGZvciB0aGUgcXVpY2sgY29tbWVudHMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9k
aXY+QnIuPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPi0twqA8L2Rpdj48ZGl2IGNsYXNz
PSJnbWFpbF9leHRyYSI+VG9tbWk8L2Rpdj48L2Rpdj4K

--===============7482134460676136731==--

