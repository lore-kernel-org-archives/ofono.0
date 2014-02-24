Content-Type: multipart/mixed; boundary="===============8109252118383759361=="
MIME-Version: 1.0
From: Homam Dabis <hdabis@digisoft.tv>
Subject: Unable to connect to service
Date: Mon, 24 Feb 2014 18:59:40 +0000
Message-ID: <CAK+sfouMnyyM-YaNveZE57=05fXDk=Wh68Do8LsUMnKm0p1wfA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8109252118383759361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Huawei E303, ofono 1.14, connman 1.20

I am unable to connect to a service.

I do the following:
dbus-send --system --print-reply --dest=3Dorg.ofono /huawei_0
org.ofono.ConnectionManager.GetContexts

I get

method return sender=3D:1.11 -> dest=3D:1.25 reply_serial=3D2
   array [
      struct {
         object path "/huawei_0/context1"
         array [
            dict entry(
               string "Name"
               variant                   string "Internet"
            )
            dict entry(
               string "Active"
               variant                   boolean false
            )
            dict entry(
               string "Type"
               variant                   string "internet"
            )
            dict entry(
               string "Protocol"
               variant                   string "ip"
            )
            dict entry(
               string "AccessPointName"
               variant                   string "3ireland.ie"
            )
            dict entry(
               string "Username"
               variant                   string ""
            )
            dict entry(
               string "Password"
               variant                   string ""
            )
            dict entry(
               string "Settings"
               variant                   array [
                  ]
            )
            dict entry(
               string "IPv6.Settings"
               variant                   array [
                  ]
            )
         ]
      }
   ]

followed by:


ofonod[1407]: PCUI: < \r\n+COPS: 0,0,"3 IRL",2\r\n\r\nOK\r\n
ofonod[1407]:
/ofono/1.14-r0/ofono-1.14/drivers/atmodem/network-registration.c:cops_cb()
cops_cb: 3 IRL, 272 05 2
ofonod[1407]:
/ofono/1.14-r0/ofono-1.14/src/network.c:current_operator_callback()
0x556ea438, (nil)
ofonod[1407]: /ofono/1.14-r0/ofono-1.14/src/cbs.c:cbs_location_changed() 1,
-1, -1, 2, 27205
ofonod[1407]: /ofono/1.14-r0/ofono-1.14/src/cbs.c:cbs_location_changed() 1,
0, 0
ofonod[1407]: /ofono/1.14-r0/ofono-1.14/src/gprs.c:netreg_status_changed() 1
ofonod[1407]:
/ofono/1.14-r0/ofono-1.14/drivers/atmodem/gprs-context.c:at_gprs_activate_p=
rimary()
cid 1
ofonod[1407]: Modem: > AT+CGDCONT=3D1,"IP","3ireland.ie"\r
ofonod[1407]: Modem: < \r\nOK\r\n
ofonod[1407]:
/ofono/1.14-r0/ofono-1.14/drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok
1
ofonod[1407]: Modem: > AT+CGDATA=3D"PPP",1\r
ofonod[1407]: Modem: < \r\n+CME ERROR: 50\r\n
ofonod[1407]:
/ofono/1.14-r0/ofono-1.14/drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 0
ofonod[1407]: Unable to enter data state
ofonod[1407]: /ofono/1.14-r0/ofono-1.14/src/gprs.c:pri_activate_callback()
0x556ecea8
ofonod[1407]: /ofono/1.14-r0/ofono-1.14/src/gprs.c:pri_activate_callback()
Activating context failed with error: Incorrect parameters

The same modem works fine on a different platform.

Is the error related to the modem driver?

Homam

--===============8109252118383759361==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48YnI+PC9kaXY+PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSw8L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkh1YXdlaSBFMzAzLCBvZm9ubyAxLjE0LCBjb25ubWFuIDEu
MjA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgYW0gdW5hYmxlIHRvIGNvbm5lY3QgdG8gYSBz
ZXJ2aWNlLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBkbyB0aGUgZm9sbG93aW5nOjwvZGl2
PgoKPGRpdj5kYnVzLXNlbmQgLS1zeXN0ZW0gLS1wcmludC1yZXBseSAtLWRlc3Q9b3JnLm9mb25v
IC9odWF3ZWlfMCBvcmcub2Zvbm8uQ29ubmVjdGlvbk1hbmFnZXIuR2V0Q29udGV4dHM8YnI+PC9k
aXY+PGRpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgZ2V0PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5tZXRob2QgcmV0dXJuIHNlbmRlcj06MS4xMSAtJmd0OyBkZXN0PToxLjI1IHJlcGx5X3Nlcmlh
bD0yPC9kaXY+Cgo8ZGl2PqAgoGFycmF5IFs8L2Rpdj48ZGl2PqAgoCCgIHN0cnVjdCB7PC9kaXY+
PGRpdj6gIKAgoCCgIKBvYmplY3QgcGF0aCAmcXVvdDsvaHVhd2VpXzAvY29udGV4dDEmcXVvdDs8
L2Rpdj48ZGl2PqAgoCCgIKAgoGFycmF5IFs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIGRpY3QgZW50
cnkoPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7TmFtZSZxdW90OzwvZGl2
PjxkaXY+CgqgIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIHN0cmluZyAm
cXVvdDtJbnRlcm5ldCZxdW90OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgKTwvZGl2PjxkaXY+oCCg
IKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVv
dDtBY3RpdmUmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCg
IKAgoCCgIKAgYm9vbGVhbiBmYWxzZTwvZGl2PgoKPGRpdj6gIKAgoCCgIKAgoCApPC9kaXY+PGRp
dj6gIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgc3RyaW5n
ICZxdW90O1R5cGUmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgIKAgoHZhcmlhbnQgoCCgIKAg
oCCgIKAgoCCgIKAgc3RyaW5nICZxdW90O2ludGVybmV0JnF1b3Q7PC9kaXY+PGRpdj6gIKAgoCCg
IKAgoCApPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDwvZGl2PgoKPGRpdj6gIKAg
oCCgIKAgoCCgIKBzdHJpbmcgJnF1b3Q7UHJvdG9jb2wmcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAg
oCCgIKAgoHZhcmlhbnQgoCCgIKAgoCCgIKAgoCCgIKAgc3RyaW5nICZxdW90O2lwJnF1b3Q7PC9k
aXY+PGRpdj6gIKAgoCCgIKAgoCApPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDwv
ZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgc3RyaW5nICZxdW90O0FjY2Vzc1BvaW50TmFtZSZxdW90
OzwvZGl2PgoKPGRpdj6gIKAgoCCgIKAgoCCgIKB2YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIHN0
cmluZyAmcXVvdDs8YSBocmVmPSJodHRwOi8vM2lyZWxhbmQuaWUiIHRhcmdldD0iX2JsYW5rIj4z
aXJlbGFuZC5pZTwvYT4mcXVvdDs8L2Rpdj48ZGl2PqAgoCCgIKAgoCCgICk8L2Rpdj48ZGl2PqAg
oCCgIKAgoCCgIGRpY3QgZW50cnkoPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1
b3Q7VXNlcm5hbWUmcXVvdDs8L2Rpdj4KCjxkaXY+oCCgIKAgoCCgIKAgoCCgdmFyaWFudCCgIKAg
oCCgIKAgoCCgIKAgoCBzdHJpbmcgJnF1b3Q7JnF1b3Q7PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCAp
PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCBkaWN0IGVudHJ5KDwvZGl2PjxkaXY+oCCgIKAgoCCgIKAg
oCCgc3RyaW5nICZxdW90O1Bhc3N3b3JkJnF1b3Q7PC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKB2
YXJpYW50IKAgoCCgIKAgoCCgIKAgoCCgIHN0cmluZyAmcXVvdDsmcXVvdDs8L2Rpdj4KCjxkaXY+
oCCgIKAgoCCgIKAgKTwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgZGljdCBlbnRyeSg8L2Rpdj48ZGl2
PqAgoCCgIKAgoCCgIKAgoHN0cmluZyAmcXVvdDtTZXR0aW5ncyZxdW90OzwvZGl2PjxkaXY+oCCg
IKAgoCCgIKAgoCCgdmFyaWFudCCgIKAgoCCgIKAgoCCgIKAgoCBhcnJheSBbPC9kaXY+PGRpdj6g
IKAgoCCgIKAgoCCgIKAgoCBdPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCApPC9kaXY+Cgo8ZGl2PqAg
oCCgIKAgoCCgIGRpY3QgZW50cnkoPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKBzdHJpbmcgJnF1
b3Q7SVB2Ni5TZXR0aW5ncyZxdW90OzwvZGl2PjxkaXY+oCCgIKAgoCCgIKAgoCCgdmFyaWFudCCg
IKAgoCCgIKAgoCCgIKAgoCBhcnJheSBbPC9kaXY+PGRpdj6gIKAgoCCgIKAgoCCgIKAgoCBdPC9k
aXY+PGRpdj6gIKAgoCCgIKAgoCApPC9kaXY+PGRpdj6gIKAgoCCgIKBdPC9kaXY+Cgo8ZGl2PqAg
oCCgIH08L2Rpdj48ZGl2PqAgoF08L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PmZvbGxv
d2VkIGJ5OjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj5vZm9u
b2RbMTQwN106IFBDVUk6ICZsdDsgXHJcbitDT1BTOiAwLDAsJnF1b3Q7MyBJUkwmcXVvdDssMlxy
XG5cclxuT0tcclxuPC9kaXY+PGRpdj5vZm9ub2RbMTQwN106IC9vZm9uby8xLjE0LXIwL29mb25v
LTEuMTQvZHJpdmVycy9hdG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmM6Y29wc19jYigpIGNv
cHNfY2I6IDMgSVJMLCAyNzIgMDUgMjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNDA3XTogL29mb25vLzEu
MTQtcjAvb2Zvbm8tMS4xNC9zcmMvbmV0d29yay5jOmN1cnJlbnRfb3BlcmF0b3JfY2FsbGJhY2so
KSAweDU1NmVhNDM4LCAobmlsKTwvZGl2PjxkaXY+b2Zvbm9kWzE0MDddOiAvb2Zvbm8vMS4xNC1y
MC9vZm9uby0xLjE0L3NyYy9jYnMuYzpjYnNfbG9jYXRpb25fY2hhbmdlZCgpIDEsIC0xLCAtMSwg
MiwgMjcyMDU8L2Rpdj48ZGl2Pm9mb25vZFsxNDA3XTogL29mb25vLzEuMTQtcjAvb2Zvbm8tMS4x
NC9zcmMvY2JzLmM6Y2JzX2xvY2F0aW9uX2NoYW5nZWQoKSAxLCAwLCAwPC9kaXY+CjxkaXY+b2Zv
bm9kWzE0MDddOiAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6bmV0cmVnX3N0
YXR1c19jaGFuZ2VkKCkgMTwvZGl2PjxkaXY+b2Zvbm9kWzE0MDddOiAvb2Zvbm8vMS4xNC1yMC9v
Zm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYzphdF9ncHJzX2FjdGl2YXRl
X3ByaW1hcnkoKSBjaWQgMTwvZGl2PjxkaXY+b2Zvbm9kWzE0MDddOiBNb2RlbTogJmd0OyBBVCtD
R0RDT05UPTEsJnF1b3Q7SVAmcXVvdDssJnF1b3Q7PGEgaHJlZj0iaHR0cDovLzNpcmVsYW5kLmll
Ij4zaXJlbGFuZC5pZTwvYT4mcXVvdDtccjwvZGl2Pgo8ZGl2Pm9mb25vZFsxNDA3XTogTW9kZW06
ICZsdDsgXHJcbk9LXHJcbjwvZGl2PjxkaXY+b2Zvbm9kWzE0MDddOiAvb2Zvbm8vMS4xNC1yMC9v
Zm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYzphdF9jZ2Rjb250X2NiKCkg
b2sgMTwvZGl2PjxkaXY+b2Zvbm9kWzE0MDddOiBNb2RlbTogJmd0OyBBVCtDR0RBVEE9JnF1b3Q7
UFBQJnF1b3Q7LDFccjwvZGl2PjxkaXY+b2Zvbm9kWzE0MDddOiBNb2RlbTogJmx0OyBcclxuK0NN
RSBFUlJPUjogNTBcclxuPC9kaXY+CjxkaXY+b2Zvbm9kWzE0MDddOiAvb2Zvbm8vMS4xNC1yMC9v
Zm9uby0xLjE0L2RyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYzphdF9jZ2RhdGFfY2IoKSBv
ayAwPC9kaXY+PGRpdj5vZm9ub2RbMTQwN106IFVuYWJsZSB0byBlbnRlciBkYXRhIHN0YXRlPC9k
aXY+PGRpdj5vZm9ub2RbMTQwN106IC9vZm9uby8xLjE0LXIwL29mb25vLTEuMTQvc3JjL2dwcnMu
YzpwcmlfYWN0aXZhdGVfY2FsbGJhY2soKSAweDU1NmVjZWE4PC9kaXY+CjxkaXY+b2Zvbm9kWzE0
MDddOiAvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L3NyYy9ncHJzLmM6cHJpX2FjdGl2YXRlX2Nh
bGxiYWNrKCkgQWN0aXZhdGluZyBjb250ZXh0IGZhaWxlZCB3aXRoIGVycm9yOiBJbmNvcnJlY3Qg
cGFyYW1ldGVyczwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2PjxkaXY+VGhlIHNhbWUgbW9kZW0g
d29ya3MgZmluZSBvbiBhIGRpZmZlcmVudCBwbGF0Zm9ybS48L2Rpdj4KPGRpdj48YnI+PC9kaXY+
PGRpdj5JcyB0aGUgZXJyb3IgcmVsYXRlZCB0byB0aGUgbW9kZW0gZHJpdmVyPzwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+SG9tYW08L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj4KPC9kaXY+Cg==

--===============8109252118383759361==--

