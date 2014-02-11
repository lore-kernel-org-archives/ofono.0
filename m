Content-Type: multipart/mixed; boundary="===============4563243190827338253=="
MIME-Version: 1.0
From: Brian Ruptash <bruptash@gmail.com>
Subject: No D-Bus Reply to Activating Context
Date: Tue, 11 Feb 2014 13:32:28 +0100
Message-ID: <056e01cf2725$54cc6bb0$fe654310$@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4563243190827338253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm having a spurious problem where the D-Bus error reply to a context
activation isn't being sent back.  This is happenning in the following
sequence, where registration is lost while in the midst of activating the
context.  Not like I can recreate this, but I've received a log from an
occurance in the field.  I'm running ofono 1.12 with a Cinterion PH8-P
driver that I wrote.

 =


Here's a trace of the relevant sequence.  I should receive a D-Bus reply
from the last line's pri_activate_callback() but I don't.  Does anyone see
anything odd here, and any reason why the reply wouldn't be being sent?
Thanks.

 =


09:20:42.300 gprs-context.c:317          at_gprs_activate_primary cid 1

09:20:42.302 ph8.c:122                   ph8_debug Mdm: >
AT+CGDCONT=3D1,"IP","xxxxxxxx"\r

09:20:42.531 ph8.c:122                   ph8_debug App: < \r\n+CGREG:
0\r\n\r\n+CREG: 0\r\n\r\n+CIEV: psinfo,6\r\n

09:20:42.531 gprs.c:2148                 ofono_gprs_status_notify /ph8_1
status 0

09:20:42.533 network.c:1349              ofono_netreg_status_notify /ph8_1
status 0 tech -1

09:20:42.536 network.c:1219              current_operator_callback 0x128198,
0x1260b8

09:20:42.540 gprs.c:1606                 netreg_status_changed 0

09:20:42.540 gprs.c:1606                 netreg_status_changed 0

09:20:42.540 network-registration.c:2134 ph8_handle_sind_ciev tech 2

09:20:42.541 gprs.c:340                  ph8_ciev_notify bearer 3 (umts)

09:20:42.542 ph8.c:208                   ciev_notify =


09:20:42.543 ph8.c:122                   ph8_debug App: > AT+CGATT=3D0\r

09:20:42.581 ph8.c:122                   ph8_debug Mdm: < \r\nOK\r\n

09:20:42.581 gprs-context.c:281          at_cgdcont_cb ok 1

09:20:42.581 ph8.c:122                   ph8_debug App: < \r\nOK\r\n

09:20:42.581 gprs.c:1545                 gprs_attach_callback /ph8_1 error =
=3D
0

09:20:42.581 ph8.c:122                   ph8_debug Mdm: >
AT+CGDATA=3D"PPP",1\r

09:20:42.582 ph8.c:122                   ph8_debug App: > AT+CGREG?\r

09:20:42.591 ph8.c:122                   ph8_debug App: < \r\n+CGREG:
1,0\r\n\r\nOK\r\n

09:20:42.591 gprs.c:1526                 registration_status_cb /ph8_1 error
0 status 0

09:20:42.591 gprs.c:2148                 ofono_gprs_status_notify /ph8_1
status 0

09:20:42.611 ph8.c:122                   ph8_debug Mdm: < \r\nNO CARRIER\r\n

09:20:42.611 gprs-context.c:258          at_cgdata_cb Unable to enter data
state

09:20:42.611 gprs-context.c:266          at_cgdata_cb not ok, <NO CARRIER>,
error 5/0

09:20:42.611 gprs.c:859                  pri_activate_callback 0x12c980 -
error 5/0

09:20:42.611 gprs.c:863                  pri_activate_callback Activating
context failed with error: Unknown error type

 =


 =


-- Brian

 =



--===============4563243190827338253==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj1Db250ZW50LVR5cGUgY29udGVu
dD0idGV4dC9odG1sOyBjaGFyc2V0PXVzLWFzY2lpIj48bWV0YSBuYW1lPUdlbmVyYXRvciBjb250
ZW50PSJNaWNyb3NvZnQgV29yZCAxNCAoZmlsdGVyZWQgbWVkaXVtKSI+PHN0eWxlPjwhLS0KLyog
Rm9udCBEZWZpbml0aW9ucyAqLwpAZm9udC1mYWNlCgl7Zm9udC1mYW1pbHk6Q2FsaWJyaTsKCXBh
bm9zZS0xOjIgMTUgNSAyIDIgMiA0IDMgMiA0O30KLyogU3R5bGUgRGVmaW5pdGlvbnMgKi8KcC5N
c29Ob3JtYWwsIGxpLk1zb05vcm1hbCwgZGl2Lk1zb05vcm1hbAoJe21hcmdpbjowaW47CgltYXJn
aW4tYm90dG9tOi4wMDAxcHQ7Cglmb250LXNpemU6MTAuMHB0OwoJZm9udC1mYW1pbHk6IkNvdXJp
ZXIgTmV3IjsKCWNvbG9yOmJsdWU7fQphOmxpbmssIHNwYW4uTXNvSHlwZXJsaW5rCgl7bXNvLXN0
eWxlLXByaW9yaXR5Ojk5OwoJY29sb3I6Ymx1ZTsKCXRleHQtZGVjb3JhdGlvbjp1bmRlcmxpbmU7
fQphOnZpc2l0ZWQsIHNwYW4uTXNvSHlwZXJsaW5rRm9sbG93ZWQKCXttc28tc3R5bGUtcHJpb3Jp
dHk6OTk7Cgljb2xvcjpwdXJwbGU7Cgl0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lO30Kc3Bhbi5F
bWFpbFN0eWxlMTcKCXttc28tc3R5bGUtdHlwZTpwZXJzb25hbC1jb21wb3NlOwoJZm9udC1mYW1p
bHk6IkNvdXJpZXIgTmV3IjsKCWNvbG9yOmJsdWU7Cglmb250LXdlaWdodDpub3JtYWw7Cglmb250
LXN0eWxlOm5vcm1hbDt9Ci5Nc29DaHBEZWZhdWx0Cgl7bXNvLXN0eWxlLXR5cGU6ZXhwb3J0LW9u
bHk7Cglmb250LWZhbWlseToiQ2FsaWJyaSIsInNhbnMtc2VyaWYiO30KQHBhZ2UgV29yZFNlY3Rp
b24xCgl7c2l6ZTo4LjVpbiAxMS4waW47CgltYXJnaW46MS4waW4gMS4waW4gMS4waW4gMS4waW47
fQpkaXYuV29yZFNlY3Rpb24xCgl7cGFnZTpXb3JkU2VjdGlvbjE7fQotLT48L3N0eWxlPjwhLS1b
aWYgZ3RlIG1zbyA5XT48eG1sPgo8bzpzaGFwZWRlZmF1bHRzIHY6ZXh0PSJlZGl0IiBzcGlkbWF4
PSIxMDI2IiAvPgo8L3htbD48IVtlbmRpZl0tLT48IS0tW2lmIGd0ZSBtc28gOV0+PHhtbD4KPG86
c2hhcGVsYXlvdXQgdjpleHQ9ImVkaXQiPgo8bzppZG1hcCB2OmV4dD0iZWRpdCIgZGF0YT0iMSIg
Lz4KPC9vOnNoYXBlbGF5b3V0PjwveG1sPjwhW2VuZGlmXS0tPjwvaGVhZD48Ym9keSBsYW5nPUVO
LVVTIGxpbms9Ymx1ZSB2bGluaz1wdXJwbGU+PGRpdiBjbGFzcz1Xb3JkU2VjdGlvbjE+PHAgY2xh
c3M9TXNvTm9ybWFsPkknbSBoYXZpbmcgYSBzcHVyaW91cyBwcm9ibGVtIHdoZXJlIHRoZSBELUJ1
cyBlcnJvciByZXBseSB0byBhIGNvbnRleHQgYWN0aXZhdGlvbiBpc24ndCBiZWluZyBzZW50IGJh
Y2suJm5ic3A7IFRoaXMgaXMgaGFwcGVubmluZyBpbiB0aGUgZm9sbG93aW5nIHNlcXVlbmNlLCB3
aGVyZSByZWdpc3RyYXRpb24gaXMgbG9zdCB3aGlsZSBpbiB0aGUgbWlkc3Qgb2YgYWN0aXZhdGlu
ZyB0aGUgY29udGV4dC4mbmJzcDsgTm90IGxpa2UgSSBjYW4gcmVjcmVhdGUgdGhpcywgYnV0IEkn
dmUgcmVjZWl2ZWQgYSBsb2cgZnJvbSBhbiBvY2N1cmFuY2UgaW4gdGhlIGZpZWxkLiZuYnNwOyBJ
J20gcnVubmluZyBvZm9ubyAxLjEyIHdpdGggYSBDaW50ZXJpb24gUEg4LVAgZHJpdmVyIHRoYXQg
SSB3cm90ZS48bzpwPjwvbzpwPjwvcD48cCBjbGFzcz1Nc29Ob3JtYWw+PG86cD4mbmJzcDs8L286
cD48L3A+PHAgY2xhc3M9TXNvTm9ybWFsPkhlcmUncyBhIHRyYWNlIG9mIHRoZSByZWxldmFudCBz
ZXF1ZW5jZS4mbmJzcDsgSSBzaG91bGQgcmVjZWl2ZSBhIEQtQnVzIHJlcGx5IGZyb20gdGhlIGxh
c3QgbGluZSdzIHByaV9hY3RpdmF0ZV9jYWxsYmFjaygpIGJ1dCBJIGRvbid0LiZuYnNwOyBEb2Vz
IGFueW9uZSBzZWUgYW55dGhpbmcgb2RkIGhlcmUsIGFuZCBhbnkgcmVhc29uIHdoeSB0aGUgcmVw
bHkgd291bGRuJ3QgYmUgYmVpbmcgc2VudD8mbmJzcDsgVGhhbmtzLjxvOnA+PC9vOnA+PC9wPjxw
IGNsYXNzPU1zb05vcm1hbD48bzpwPiZuYnNwOzwvbzpwPjwvcD48cCBjbGFzcz1Nc29Ob3JtYWw+
MDk6MjA6NDIuMzAwIGdwcnMtY29udGV4dC5jOjMxNyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhdF9ncHJzX2FjdGl2YXRlX3ByaW1hcnkgY2lk
IDE8bzpwPjwvbzpwPjwvcD48cCBjbGFzcz1Nc29Ob3JtYWw+MDk6MjA6NDIuMzAyIHBoOC5jOjEy
MiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBwaDhf
ZGVidWcgTWRtOiAmZ3Q7IEFUK0NHRENPTlQ9MSwmcXVvdDtJUCZxdW90OywmcXVvdDt4eHh4eHh4
eCZxdW90O1xyPG86cD48L286cD48L3A+PHAgY2xhc3M9TXNvTm9ybWFsPjA5OjIwOjQyLjUzMSBw
aDguYzoxMjImbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgcGg4X2RlYnVnIEFwcDogJmx0OyBcclxuK0NHUkVHOiAwXHJcblxyXG4rQ1JFRzogMFxyXG5c
clxuK0NJRVY6IHBzaW5mbyw2XHJcbjxvOnA+PC9vOnA+PC9wPjxwIGNsYXNzPU1zb05vcm1hbD4w
OToyMDo0Mi41MzEgZ3Bycy5jOjIxNDgmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsgb2Zvbm9fZ3Byc19zdGF0dXNfbm90aWZ5IC9waDhfMSBzdGF0dXMgMDxvOnA+PC9vOnA+
PC9wPjxwIGNsYXNzPU1zb05vcm1hbD4wOToyMDo0Mi41MzMgbmV0d29yay5jOjEzNDkmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgb2Zvbm9fbmV0cmVnX3N0YXR1c19ub3RpZnkgL3BoOF8xIHN0YXR1cyAw
IHRlY2ggLTE8bzpwPjwvbzpwPjwvcD48cCBjbGFzcz1Nc29Ob3JtYWw+MDk6MjA6NDIuNTM2IG5l
dHdvcmsuYzoxMjE5Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGN1cnJlbnRfb3BlcmF0b3JfY2FsbGJh
Y2sgMHgxMjgxOTgsIDB4MTI2MGI4PG86cD48L286cD48L3A+PHAgY2xhc3M9TXNvTm9ybWFsPjA5
OjIwOjQyLjU0MCBncHJzLmM6MTYwNiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBuZXRyZWdfc3RhdHVzX2NoYW5nZWQgMDxvOnA+PC9vOnA+PC9wPjxwIGNsYXNzPU1zb05v
cm1hbD4wOToyMDo0Mi41NDAgZ3Bycy5jOjE2MDYmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgbmV0cmVnX3N0YXR1c19jaGFuZ2VkIDA8bzpwPjwvbzpwPjwvcD48cCBjbGFz
cz1Nc29Ob3JtYWw+MDk6MjA6NDIuNTQwIG5ldHdvcmstcmVnaXN0cmF0aW9uLmM6MjEzNCBwaDhf
aGFuZGxlX3NpbmRfY2lldiB0ZWNoIDI8bzpwPjwvbzpwPjwvcD48cCBjbGFzcz1Nc29Ob3JtYWw+
MDk6MjA6NDIuNTQxIGdwcnMuYzozNDAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgcGg4X2NpZXZfbm90aWZ5IGJlYXJlciAzICh1bXRzKTxvOnA+PC9vOnA+PC9w
PjxwIGNsYXNzPU1zb05vcm1hbD4wOToyMDo0Mi41NDIgcGg4LmM6MjA4Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGNpZXZfbm90aWZ5IDxvOnA+PC9v
OnA+PC9wPjxwIGNsYXNzPU1zb05vcm1hbD4wOToyMDo0Mi41NDMgcGg4LmM6MTIyJm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHBoOF9kZWJ1ZyBBcHA6
ICZndDsgQVQrQ0dBVFQ9MFxyPG86cD48L286cD48L3A+PHAgY2xhc3M9TXNvTm9ybWFsPjA5OjIw
OjQyLjU4MSBwaDguYzoxMjImbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgcGg4X2RlYnVnIE1kbTogJmx0OyBcclxuT0tcclxuPG86cD48L286cD48L3A+
PHAgY2xhc3M9TXNvTm9ybWFsPjA5OjIwOjQyLjU4MSBncHJzLWNvbnRleHQuYzoyODEmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYXRfY2dkY29u
dF9jYiBvayAxPG86cD48L286cD48L3A+PHAgY2xhc3M9TXNvTm9ybWFsPjA5OjIwOjQyLjU4MSBw
aDguYzoxMjImbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsgcGg4X2RlYnVnIEFwcDogJmx0OyBcclxuT0tcclxuPG86cD48L286cD48L3A+PHAgY2xhc3M9
TXNvTm9ybWFsPjA5OjIwOjQyLjU4MSBncHJzLmM6MTU0NSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBncHJzX2F0dGFjaF9jYWxsYmFjayAvcGg4XzEgZXJyb3IgPSAwPG86
cD48L286cD48L3A+PHAgY2xhc3M9TXNvTm9ybWFsPjA5OjIwOjQyLjU4MSBwaDguYzoxMjImbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcGg4X2RlYnVn
IE1kbTogJmd0OyBBVCtDR0RBVEE9JnF1b3Q7UFBQJnF1b3Q7LDFccjxvOnA+PC9vOnA+PC9wPjxw
IGNsYXNzPU1zb05vcm1hbD4wOToyMDo0Mi41ODIgcGg4LmM6MTIyJm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IHBoOF9kZWJ1ZyBBcHA6ICZndDsgQVQr
Q0dSRUc/XHI8bzpwPjwvbzpwPjwvcD48cCBjbGFzcz1Nc29Ob3JtYWw+MDk6MjA6NDIuNTkxIHBo
OC5jOjEyMiZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDtwaDhfZGVidWcgQXBwOiAmbHQ7IFxyXG4rQ0dSRUc6IDEsMFxyXG5cclxuT0tcclxuPG86cD48
L286cD48L3A+PHAgY2xhc3M9TXNvTm9ybWFsPjA5OjIwOjQyLjU5MSBncHJzLmM6MTUyNiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyByZWdpc3RyYXRpb25fc3RhdHVzX2Ni
IC9waDhfMSBlcnJvciAwIHN0YXR1cyAwPG86cD48L286cD48L3A+PHAgY2xhc3M9TXNvTm9ybWFs
PjA5OjIwOjQyLjU5MSBncHJzLmM6MjE0OCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBvZm9ub19ncHJzX3N0YXR1c19ub3RpZnkgL3BoOF8xIHN0YXR1cyAwPG86cD48L286
cD48L3A+PHAgY2xhc3M9TXNvTm9ybWFsPjA5OjIwOjQyLjYxMSBwaDguYzoxMjImbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcGg4X2RlYnVnIE1kbTog
Jmx0OyBcclxuTk8gQ0FSUklFUlxyXG48bzpwPjwvbzpwPjwvcD48cCBjbGFzcz1Nc29Ob3JtYWw+
MDk6MjA6NDIuNjExIGdwcnMtY29udGV4dC5jOjI1OCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBhdF9jZ2RhdGFfY2IgVW5hYmxlIHRvIGVudGVy
IGRhdGEgc3RhdGU8bzpwPjwvbzpwPjwvcD48cCBjbGFzcz1Nc29Ob3JtYWw+MDk6MjA6NDIuNjEx
IGdwcnMtY29udGV4dC5jOjI2NiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBhdF9jZ2RhdGFfY2Igbm90IG9rLCAmbHQ7Tk8gQ0FSUklFUiZndDss
IGVycm9yIDUvMDxvOnA+PC9vOnA+PC9wPjxwIGNsYXNzPU1zb05vcm1hbD4wOToyMDo0Mi42MTEg
Z3Bycy5jOjg1OSZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtw
cmlfYWN0aXZhdGVfY2FsbGJhY2sgMHgxMmM5ODAgLSBlcnJvciA1LzA8bzpwPjwvbzpwPjwvcD48
cCBjbGFzcz1Nc29Ob3JtYWw+MDk6MjA6NDIuNjExIGdwcnMuYzo4NjMmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgcHJpX2FjdGl2YXRlX2NhbGxiYWNrIEFjdGl2
YXRpbmcgY29udGV4dCBmYWlsZWQgd2l0aCBlcnJvcjogVW5rbm93biBlcnJvciB0eXBlPG86cD48
L286cD48L3A+PHAgY2xhc3M9TXNvTm9ybWFsPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPjxwIGNsYXNz
PU1zb05vcm1hbD48bzpwPiZuYnNwOzwvbzpwPjwvcD48cCBjbGFzcz1Nc29Ob3JtYWw+LS0gQnJp
YW48bzpwPjwvbzpwPjwvcD48cCBjbGFzcz1Nc29Ob3JtYWw+PG86cD4mbmJzcDs8L286cD48L3A+
PC9kaXY+PC9ib2R5PjwvaHRtbD4=
--===============4563243190827338253==--

