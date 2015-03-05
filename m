Content-Type: multipart/mixed; boundary="===============7008375515038756102=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: Re: telit he910 activate-context issue
Date: Thu, 05 Mar 2015 17:30:40 +0100
Message-ID: <CAH4ZQwvs_ENN4y3_Jpz8OgyFs9VhF_m-gamFp1DXcbbvMO0-Ew@mail.gmail.com>
In-Reply-To: <54F87E2B.7030102@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7008375515038756102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

=E2=80=8BHi Denis,
sorry, I forgot the top-post rule.
=E2=80=8B


> g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);
>>
>
> Was this change required?  I didn't think Telit suffered from dropping
> carrier issue.  If so, feel free to send a patch.
>
>>
>> =E2=80=8BThis change was necessary because the he910 was putting the DCD=
 signal
to low after ppp session, so it was impossible to connect again to that
port.=E2=80=8B
=E2=80=8BSetting &C0 in the modem port forces DCD to stay high.
=E2=80=8B

>
> oFono expects auto-attach to be disabled.  So this change is actually
> incorrect.  What was going wrong that was fixed by this change?
>

=E2=80=8BRegarding the AUTOATT change, I had to move it to post_online sect=
ion
because it was issued too early in modem startup and it always returned an
error.
Then I changed it to 1 because there was some misalignment between modem
attachment status and ofono variables.
I didn't go to deep in this problem but putting AUTOATT to 1 solved my
problem and is good for me.

=E2=80=8BEnrico=E2=80=8B

--===============7008375515038756102==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj48ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWls
eTp2ZXJkYW5hLHNhbnMtc2VyaWY7ZGlzcGxheTppbmxpbmUiPuKAi0hpIERlbmlzLDwvZGl2Pjwv
ZGl2PjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZl
cmRhbmEsc2Fucy1zZXJpZjtkaXNwbGF5OmlubGluZSI+c29ycnksIEkgZm9yZ290IHRoZSB0b3At
cG9zdCBydWxlLjwvZGl2PjwvZGl2PjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5
bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZjtkaXNwbGF5OmlubGluZSI+4oCLPC9k
aXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48
c3Bhbj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAg
LjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij4KZ19hdF9j
aGF0X3NlbmQoZGF0YS0mZ3Q7bW9kZW0sICZxdW90O0FUJmFtcDtDMCZxdW90OywgTlVMTCwgTlVM
TCwgTlVMTCwgTlVMTCk7PGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj48L3NwYW4+CldhcyB0aGlzIGNo
YW5nZSByZXF1aXJlZD/CoCBJIGRpZG4mIzM5O3QgdGhpbmsgVGVsaXQgc3VmZmVyZWQgZnJvbSBk
cm9wcGluZyBjYXJyaWVyIGlzc3VlLsKgIElmIHNvLCBmZWVsIGZyZWUgdG8gc2VuZCBhIHBhdGNo
Ljxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAg
LjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48c3Bhbj48
YnI+PC9zcGFuPjwvYmxvY2txdW90ZT48L2Jsb2NrcXVvdGU+PGRpdj48ZGl2IGNsYXNzPSJnbWFp
bF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj7igItUaGlz
IGNoYW5nZSB3YXMgbmVjZXNzYXJ5IGJlY2F1c2UgdGhlIGhlOTEwIHdhcyBwdXR0aW5nIHRoZSBE
Q0Qgc2lnbmFsIHRvIGxvdyBhZnRlciBwcHAgc2Vzc2lvbiwgc28gaXQgd2FzIGltcG9zc2libGUg
dG8gY29ubmVjdCBhZ2FpbiB0byB0aGF0IHBvcnQu4oCLPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+4oCLU2V0dGlu
ZyAmYW1wO0MwIGluIHRoZSBtb2RlbSBwb3J0IGZvcmNlcyBEQ0QgdG8gc3RheSBoaWdoLjwvZGl2
PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNh
bnMtc2VyaWYiPuKAizwvZGl2PjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIg
c3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRp
bmctbGVmdDoxZXgiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgi
PjxzcGFuPgo8L3NwYW4+PC9ibG9ja3F1b3RlPgo8YnI+Cm9Gb25vIGV4cGVjdHMgYXV0by1hdHRh
Y2ggdG8gYmUgZGlzYWJsZWQuwqAgU28gdGhpcyBjaGFuZ2UgaXMgYWN0dWFsbHkgaW5jb3JyZWN0
LsKgIFdoYXQgd2FzIGdvaW5nIHdyb25nIHRoYXQgd2FzIGZpeGVkIGJ5IHRoaXMgY2hhbmdlPzxi
cj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZh
dWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmO2Rpc3BsYXk6aW5saW5l
Ij7igItSZWdhcmRpbmcgdGhlIEFVVE9BVFQgY2hhbmdlLCBJIGhhZCB0byBtb3ZlIGl0IHRvIHBv
c3Rfb25saW5lIHNlY3Rpb24gYmVjYXVzZSBpdCB3YXMgaXNzdWVkIHRvbyBlYXJseSBpbiBtb2Rl
bSBzdGFydHVwIGFuZCBpdCBhbHdheXMgcmV0dXJuZWQgYW4gZXJyb3IuPC9kaXY+PC9kaXY+PGRp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxz
YW5zLXNlcmlmO2Rpc3BsYXk6aW5saW5lIj5UaGVuIEkgY2hhbmdlZCBpdCB0byAxIGJlY2F1c2Ug
dGhlcmUgd2FzIHNvbWUgbWlzYWxpZ25tZW50IGJldHdlZW4gbW9kZW0gYXR0YWNobWVudCBzdGF0
dXMgYW5kIG9mb25vIHZhcmlhYmxlcy48L2Rpdj48L2Rpdj48ZGl2PjxkaXYgY2xhc3M9ImdtYWls
X2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWY7ZGlzcGxheTpp
bmxpbmUiPkkgZGlkbiYjMzk7dCBnbyB0byBkZWVwIGluIHRoaXMgcHJvYmxlbSBidXQgcHV0dGlu
ZyBBVVRPQVRUIHRvIDEgc29sdmVkIG15IHByb2JsZW0gYW5kIGlzIGdvb2QgZm9yIG1lLjwvZGl2
PjwvZGl2PjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5
OnZlcmRhbmEsc2Fucy1zZXJpZjtkaXNwbGF5OmlubGluZSI+PGJyPjwvZGl2PjwvZGl2PjxkaXYg
Y2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2Vy
aWYiPuKAi0Vucmljb+KAizwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============7008375515038756102==--

