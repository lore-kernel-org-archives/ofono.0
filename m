Content-Type: multipart/mixed; boundary="===============1020991405635753798=="
MIME-Version: 1.0
From: Alexey Mednyy <swexru@gmail.com>
Subject: Re: Query on ppp0 interface for HE910 device
Date: Fri, 29 May 2015 21:32:27 +0300
Message-ID: <CAC3zGv8bGVJ71eoxca2j6HqDOF7QPv8W49UMuGmLtf900cKbcg@mail.gmail.com>
In-Reply-To: <CANPyyuOxuvE8dxOQR8+CQJRzXek291_3GuDsNhPAf2ONFccU3Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1020991405635753798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mike,
AFAIK if you want to connman and ofono work well together, your modem must
implement set_online interface in driver.

I've posted patch for he910

https://lists.ofono.org/pipermail/ofono/2014-December/015527.html

But it works only if you have recent firmware version.

_________________________________
Best regards, Mednyy Alexey.

On Fri, May 29, 2015 at 8:24 PM, Mike Williams <mike@mikebwilliams.com>
wrote:

> >Whenever the connman daemon switches from cellular to wifi automatically,
> ofonod >removes the ppp0 interface.
> >On the oterhway round the ofono daemon is not doing the addition of the
> ppp0 interface.
>
> I can reproduce this on an HE910 I just started testing. Basically,
> the ofono cellular service never reappears to connman after connman
> disconnects it.
>
> # connmanctl technologies
> /net/connman/technology/cellular
>  Name =3D Cellular
>  Type =3D cellular
>  Powered =3D True
>  Connected =3D False
>  Tethering =3D False
> /net/connman/technology/ethernet
>  Name =3D Wired
>  Type =3D ethernet
>  Powered =3D True
>  Connected =3D False
>  Tethering =3D False
> # connmanctl services
> *AR Wired                ethernet_001122edb058_cable
> *A  T-Mobile             cellular_310260008772362_context1
> # connmanctl disable ethernet
> Disabled ethernet
> # macb f0028000.ethernet eth0: link down
> # connmanctl services
> *AR T-Mobile             cellular_310260008772362_context1
> # connmanctl enable ethernet
> IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> Enabled ethernet
> # macb f0028000.ethernet eth0: link up (100/Full)
> IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> # connmanctl services
> *AR Wired                ethernet_001122edb058_cable
> #
>
> The cellular service will never reappear.
>
> ofono debug log:
>
> ofonod[1543]: PPP: lcp: pppcp_process_terminate_ack: current state
> 4:CLOSING
> ofonod[1543]: PPP: lcp: pppcp_generate_event: current state 4:CLOSING
> ofonod[1543]: PPP: event: 11 (RTA), action: 802, new_state: 2 (CLOSED)
> ofonod[1543]: PPP: lcp: pppcp_this_layer_finished: current state 2:CLOSED
> ofonod[1543]: PPP: gatchat/gatppp.c:ppp_enter_phase() 0
> ofonod[1543]: PPP: gatchat/gatppp.c:ppp_dead()
> ofonod[1543]: drivers/atmodem/gprs-context.c:ppp_disconnect() Reason: 6
> ofonod[1543]: Aux: < \r\n+CGEV: ME DEACT IP, "22.226.202.227", 1\r\n
> ofonod[1543]: Aux: < \r\n
> ofonod[1543]: Aux: < +CGREG: 0\r\n\r\n+CGEV: NW DETACH\r\n
> ofonod[1543]: src/gprs.c:ofono_gprs_status_notify() /he910_0 status 0
> ofonod[1543]: src/gprs.c:ofono_gprs_detached_notify() /he910_0
> ofonod[1543]: Aux: < \r\n
> ofonod[1543]: Aux: < +CGREG: 0\r\n\r\n+CREG: 1,"2004","076277F",2\r\n
> ofonod[1543]: src/gprs.c:ofono_gprs_status_notify() /he910_0 status 0
> ofonod[1543]: src/network.c:ofono_netreg_status_notify() /he910_0
> status 1 tech 2
> ofonod[1543]: src/gprs.c:netreg_status_changed() 1
> ofonod[1543]: Aux: > AT+COPS=3D3,2\r
> ofonod[1543]: Aux: < \r\nOK\r\n
> ofonod[1543]: Aux: > AT+COPS?\r
> ofonod[1543]: Aux: < \r\n
> ofonod[1543]: Aux: < +COPS: 0,2,"310260",2\r\n\r\nOK\r\n
> ofonod[1543]: drivers/atmodem/network-registration.c:cops_numeric_cb()
> Cops numeric got mcc: 310, mnc: 260
> ofonod[1543]: Aux: > AT+CIND?\r
> ofonod[1543]: Aux: < \r\n
> ofonod[1543]: Aux: < +CIND: 0,3,1,0,0,0,0,0,2\r\n\r\nOK\r\n
> ofonod[1543]: Aux: > AT+COPS=3D3,0\r
> ofonod[1543]: Aux: < \r\nOK\r\n
> ofonod[1543]: Aux: > AT+COPS?\r
> ofonod[1543]: Aux: < \r\n
> ofonod[1543]: Aux: < +COPS: 0,0,"T-Mobile",2\r\n\r\nOK\r\n
> ofonod[1543]: drivers/atmodem/network-registration.c:cops_cb()
> cops_cb: T-Mobile, 310 260 2
> ofonod[1543]: src/network.c:current_operator_callback() 0xcb600, 0xd0cb0
>
>
> Contexts for that modem still appear when when listing them via dbus:
> dbus-send --system --print-reply --dest=3Dorg.ofono /he910_0
> org.ofono.ConnectionManager.GetContexts
>
>
> method return sender=3D:1.36 -> dest=3D:1.48 reply_serial=3D2
>   array [
>      struct {
>         object path "/he910_0/context1"
>         array [
>            dict entry(
>               string "Name"
>               variant                   string "LTE"
>            )
>            dict entry(
>               string "Active"
>               variant                   boolean false
>            )
>            dict entry(
>               string "Type"
>               variant                   string "internet"
>            )
> <Truncated>
>
>
> Manually trying to activate that context fails:
> # dbus-send --system --print-reply --dest=3Dorg.ofono /he910_0/context1
> org.ofono.
> ConnectionContext.SetProperty string:Active variant:boolean:true
> Error org.ofono.Error.NotAttached: GPRS is not attached
>
>
> Thanks,
> Mike
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>

--===============1020991405635753798==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+SGVsbG8gTWlrZSw8YnI+PC9kaXY+QUZBSUsg
aWYgeW91IHdhbnQgdG8gY29ubm1hbiBhbmQgb2Zvbm8gd29yayB3ZWxsIHRvZ2V0aGVyLCB5b3Vy
IG1vZGVtIG11c3QgaW1wbGVtZW50IHNldF9vbmxpbmUgaW50ZXJmYWNlIGluIGRyaXZlci48YnI+
PGJyPjwvZGl2PkkmIzM5O3ZlIHBvc3RlZCBwYXRjaCBmb3IgaGU5MTA8YnI+PGJyPjxhIGhyZWY9
Imh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL3BpcGVybWFpbC9vZm9uby8yMDE0LURlY2VtYmVyLzAx
NTUyNy5odG1sIj5odHRwczovL2xpc3RzLm9mb25vLm9yZy9waXBlcm1haWwvb2Zvbm8vMjAxNC1E
ZWNlbWJlci8wMTU1MjcuaHRtbDwvYT48YnI+PGJyPjwvZGl2PkJ1dCBpdCB3b3JrcyBvbmx5IGlm
IHlvdSBoYXZlIHJlY2VudCBmaXJtd2FyZSB2ZXJzaW9uLjxicj48L2Rpdj48ZGl2IGNsYXNzPSJn
bWFpbF9leHRyYSI+PGJyIGNsZWFyPSJhbGwiPjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfc2lnbmF0
dXJlIj48ZGl2Pjxmb250IGNvbG9yPSIjOTk5OTk5Ij5fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX188c3Bhbj48L3NwYW4+PC9mb250PjwvZGl2Pjxmb250IGNvbG9yPSIjOTk5OTk5Ij5C
ZXN0IHJlZ2FyZHMsIE1lZG55eSBBbGV4ZXkuPC9mb250PjwvZGl2PjwvZGl2Pgo8YnI+PGRpdiBj
bGFzcz0iZ21haWxfcXVvdGUiPk9uIEZyaSwgTWF5IDI5LCAyMDE1IGF0IDg6MjQgUE0sIE1pa2Ug
V2lsbGlhbXMgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86bWlrZUBtaWtlYndp
bGxpYW1zLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm1pa2VAbWlrZWJ3aWxsaWFtcy5jb208L2E+Jmd0
Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVm
dDoxZXgiPiZndDtXaGVuZXZlciB0aGUgY29ubm1hbiBkYWVtb24gc3dpdGNoZXMgZnJvbSBjZWxs
dWxhciB0byB3aWZpIGF1dG9tYXRpY2FsbHksIG9mb25vZCAmZ3Q7cmVtb3ZlcyB0aGUgcHBwMCBp
bnRlcmZhY2UuPGJyPgomZ3Q7T24gdGhlIG90ZXJod2F5IHJvdW5kIHRoZSBvZm9ubyBkYWVtb24g
aXMgbm90IGRvaW5nIHRoZSBhZGRpdGlvbiBvZiB0aGUgcHBwMCBpbnRlcmZhY2UuPGJyPgo8YnI+
CkkgY2FuIHJlcHJvZHVjZSB0aGlzIG9uIGFuIEhFOTEwIEkganVzdCBzdGFydGVkIHRlc3Rpbmcu
IEJhc2ljYWxseSw8YnI+CnRoZSBvZm9ubyBjZWxsdWxhciBzZXJ2aWNlIG5ldmVyIHJlYXBwZWFy
cyB0byBjb25ubWFuIGFmdGVyIGNvbm5tYW48YnI+CmRpc2Nvbm5lY3RzIGl0Ljxicj4KPGJyPgoj
IGNvbm5tYW5jdGwgdGVjaG5vbG9naWVzPGJyPgovbmV0L2Nvbm5tYW4vdGVjaG5vbG9neS9jZWxs
dWxhcjxicj4KwqBOYW1lID0gQ2VsbHVsYXI8YnI+CsKgVHlwZSA9IGNlbGx1bGFyPGJyPgrCoFBv
d2VyZWQgPSBUcnVlPGJyPgrCoENvbm5lY3RlZCA9IEZhbHNlPGJyPgrCoFRldGhlcmluZyA9IEZh
bHNlPGJyPgovbmV0L2Nvbm5tYW4vdGVjaG5vbG9neS9ldGhlcm5ldDxicj4KwqBOYW1lID0gV2ly
ZWQ8YnI+CsKgVHlwZSA9IGV0aGVybmV0PGJyPgrCoFBvd2VyZWQgPSBUcnVlPGJyPgrCoENvbm5l
Y3RlZCA9IEZhbHNlPGJyPgrCoFRldGhlcmluZyA9IEZhbHNlPGJyPgojIGNvbm5tYW5jdGwgc2Vy
dmljZXM8YnI+CipBUiBXaXJlZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGV0aGVybmV0XzAwMTEy
MmVkYjA1OF9jYWJsZTxicj4KKkHCoCBULU1vYmlsZcKgIMKgIMKgIMKgIMKgIMKgIMKgY2VsbHVs
YXJfMzEwMjYwMDA4NzcyMzYyX2NvbnRleHQxPGJyPgojIGNvbm5tYW5jdGwgZGlzYWJsZSBldGhl
cm5ldDxicj4KRGlzYWJsZWQgZXRoZXJuZXQ8YnI+CiMgbWFjYiBmMDAyODAwMC5ldGhlcm5ldCBl
dGgwOiBsaW5rIGRvd248YnI+CiMgY29ubm1hbmN0bCBzZXJ2aWNlczxicj4KKkFSIFQtTW9iaWxl
wqAgwqAgwqAgwqAgwqAgwqAgwqBjZWxsdWxhcl8zMTAyNjAwMDg3NzIzNjJfY29udGV4dDE8YnI+
CiMgY29ubm1hbmN0bCBlbmFibGUgZXRoZXJuZXQ8YnI+CklQdjY6IEFERFJDT05GKE5FVERFVl9V
UCk6IGV0aDA6IGxpbmsgaXMgbm90IHJlYWR5PGJyPgpFbmFibGVkIGV0aGVybmV0PGJyPgojIG1h
Y2IgZjAwMjgwMDAuZXRoZXJuZXQgZXRoMDogbGluayB1cCAoMTAwL0Z1bGwpPGJyPgpJUHY2OiBB
RERSQ09ORihORVRERVZfQ0hBTkdFKTogZXRoMDogbGluayBiZWNvbWVzIHJlYWR5PGJyPgojIGNv
bm5tYW5jdGwgc2VydmljZXM8YnI+CipBUiBXaXJlZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGV0
aGVybmV0XzAwMTEyMmVkYjA1OF9jYWJsZTxicj4KIzxicj4KPGJyPgpUaGUgY2VsbHVsYXIgc2Vy
dmljZSB3aWxsIG5ldmVyIHJlYXBwZWFyLjxicj4KPGJyPgpvZm9ubyBkZWJ1ZyBsb2c6PGJyPgo8
YnI+Cm9mb25vZFsxNTQzXTogUFBQOiBsY3A6IHBwcGNwX3Byb2Nlc3NfdGVybWluYXRlX2Fjazog
Y3VycmVudCBzdGF0ZSA0OkNMT1NJTkc8YnI+Cm9mb25vZFsxNTQzXTogUFBQOiBsY3A6IHBwcGNw
X2dlbmVyYXRlX2V2ZW50OiBjdXJyZW50IHN0YXRlIDQ6Q0xPU0lORzxicj4Kb2Zvbm9kWzE1NDNd
OiBQUFA6IGV2ZW50OiAxMSAoUlRBKSwgYWN0aW9uOiA4MDIsIG5ld19zdGF0ZTogMiAoQ0xPU0VE
KTxicj4Kb2Zvbm9kWzE1NDNdOiBQUFA6IGxjcDogcHBwY3BfdGhpc19sYXllcl9maW5pc2hlZDog
Y3VycmVudCBzdGF0ZSAyOkNMT1NFRDxicj4Kb2Zvbm9kWzE1NDNdOiBQUFA6IGdhdGNoYXQvZ2F0
cHBwLmM6cHBwX2VudGVyX3BoYXNlKCkgMDxicj4Kb2Zvbm9kWzE1NDNdOiBQUFA6IGdhdGNoYXQv
Z2F0cHBwLmM6cHBwX2RlYWQoKTxicj4Kb2Zvbm9kWzE1NDNdOiBkcml2ZXJzL2F0bW9kZW0vZ3By
cy1jb250ZXh0LmM6cHBwX2Rpc2Nvbm5lY3QoKSBSZWFzb246IDY8YnI+Cm9mb25vZFsxNTQzXTog
QXV4OiAmbHQ7IFxyXG4rQ0dFVjogTUUgREVBQ1QgSVAsICZxdW90OzIyLjIyNi4yMDIuMjI3JnF1
b3Q7LCAxXHJcbjxicj4Kb2Zvbm9kWzE1NDNdOiBBdXg6ICZsdDsgXHJcbjxicj4Kb2Zvbm9kWzE1
NDNdOiBBdXg6ICZsdDsgK0NHUkVHOiAwXHJcblxyXG4rQ0dFVjogTlcgREVUQUNIXHJcbjxicj4K
b2Zvbm9kWzE1NDNdOiBzcmMvZ3Bycy5jOm9mb25vX2dwcnNfc3RhdHVzX25vdGlmeSgpIC9oZTkx
MF8wIHN0YXR1cyAwPGJyPgpvZm9ub2RbMTU0M106IHNyYy9ncHJzLmM6b2Zvbm9fZ3Byc19kZXRh
Y2hlZF9ub3RpZnkoKSAvaGU5MTBfMDxicj4Kb2Zvbm9kWzE1NDNdOiBBdXg6ICZsdDsgXHJcbjxi
cj4Kb2Zvbm9kWzE1NDNdOiBBdXg6ICZsdDsgK0NHUkVHOiAwXHJcblxyXG4rQ1JFRzogMSwmcXVv
dDsyMDA0JnF1b3Q7LCZxdW90OzA3NjI3N0YmcXVvdDssMlxyXG48YnI+Cm9mb25vZFsxNTQzXTog
c3JjL2dwcnMuYzpvZm9ub19ncHJzX3N0YXR1c19ub3RpZnkoKSAvaGU5MTBfMCBzdGF0dXMgMDxi
cj4Kb2Zvbm9kWzE1NDNdOiBzcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19zdGF0dXNfbm90aWZ5
KCkgL2hlOTEwXzA8YnI+CnN0YXR1cyAxIHRlY2ggMjxicj4Kb2Zvbm9kWzE1NDNdOiBzcmMvZ3By
cy5jOm5ldHJlZ19zdGF0dXNfY2hhbmdlZCgpIDE8YnI+Cm9mb25vZFsxNTQzXTogQXV4OiAmZ3Q7
IEFUK0NPUFM9MywyXHI8YnI+Cm9mb25vZFsxNTQzXTogQXV4OiAmbHQ7IFxyXG5PS1xyXG48YnI+
Cm9mb25vZFsxNTQzXTogQXV4OiAmZ3Q7IEFUK0NPUFM/XHI8YnI+Cm9mb25vZFsxNTQzXTogQXV4
OiAmbHQ7IFxyXG48YnI+Cm9mb25vZFsxNTQzXTogQXV4OiAmbHQ7ICtDT1BTOiAwLDIsJnF1b3Q7
MzEwMjYwJnF1b3Q7LDJcclxuXHJcbk9LXHJcbjxicj4Kb2Zvbm9kWzE1NDNdOiBkcml2ZXJzL2F0
bW9kZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYzpjb3BzX251bWVyaWNfY2IoKTxicj4KQ29wcyBu
dW1lcmljIGdvdCBtY2M6IDMxMCwgbW5jOiAyNjA8YnI+Cm9mb25vZFsxNTQzXTogQXV4OiAmZ3Q7
IEFUK0NJTkQ/XHI8YnI+Cm9mb25vZFsxNTQzXTogQXV4OiAmbHQ7IFxyXG48YnI+Cm9mb25vZFsx
NTQzXTogQXV4OiAmbHQ7ICtDSU5EOiAwLDMsMSwwLDAsMCwwLDAsMlxyXG5cclxuT0tcclxuPGJy
PgpvZm9ub2RbMTU0M106IEF1eDogJmd0OyBBVCtDT1BTPTMsMFxyPGJyPgpvZm9ub2RbMTU0M106
IEF1eDogJmx0OyBcclxuT0tcclxuPGJyPgpvZm9ub2RbMTU0M106IEF1eDogJmd0OyBBVCtDT1BT
P1xyPGJyPgpvZm9ub2RbMTU0M106IEF1eDogJmx0OyBcclxuPGJyPgpvZm9ub2RbMTU0M106IEF1
eDogJmx0OyArQ09QUzogMCwwLCZxdW90O1QtTW9iaWxlJnF1b3Q7LDJcclxuXHJcbk9LXHJcbjxi
cj4Kb2Zvbm9kWzE1NDNdOiBkcml2ZXJzL2F0bW9kZW0vbmV0d29yay1yZWdpc3RyYXRpb24uYzpj
b3BzX2NiKCk8YnI+CmNvcHNfY2I6IFQtTW9iaWxlLCAzMTAgMjYwIDI8YnI+Cm9mb25vZFsxNTQz
XTogc3JjL25ldHdvcmsuYzpjdXJyZW50X29wZXJhdG9yX2NhbGxiYWNrKCkgMHhjYjYwMCwgMHhk
MGNiMDxicj4KPGJyPgo8YnI+CkNvbnRleHRzIGZvciB0aGF0IG1vZGVtIHN0aWxsIGFwcGVhciB3
aGVuIHdoZW4gbGlzdGluZyB0aGVtIHZpYSBkYnVzOjxicj4KZGJ1cy1zZW5kIC0tc3lzdGVtIC0t
cHJpbnQtcmVwbHkgLS1kZXN0PW9yZy5vZm9ubyAvaGU5MTBfMDxicj4Kb3JnLm9mb25vLkNvbm5l
Y3Rpb25NYW5hZ2VyLkdldENvbnRleHRzPGJyPgo8YnI+Cjxicj4KbWV0aG9kIHJldHVybiBzZW5k
ZXI9OjEuMzYgLSZndDsgZGVzdD06MS40OCByZXBseV9zZXJpYWw9Mjxicj4KwqAgYXJyYXkgWzxi
cj4KwqAgwqAgwqBzdHJ1Y3Qgezxicj4KwqAgwqAgwqAgwqAgb2JqZWN0IHBhdGggJnF1b3Q7L2hl
OTEwXzAvY29udGV4dDEmcXVvdDs8YnI+CsKgIMKgIMKgIMKgIGFycmF5IFs8YnI+CsKgIMKgIMKg
IMKgIMKgIMKgZGljdCBlbnRyeSg8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cmluZyAmcXVv
dDtOYW1lJnF1b3Q7PGJyPgrCoCDCoCDCoCDCoCDCoCDCoCDCoCB2YXJpYW50wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBzdHJpbmcgJnF1b3Q7TFRFJnF1b3Q7PGJyPgrCoCDCoCDCoCDCoCDC
oCDCoCk8YnI+CsKgIMKgIMKgIMKgIMKgIMKgZGljdCBlbnRyeSg8YnI+CsKgIMKgIMKgIMKgIMKg
IMKgIMKgIHN0cmluZyAmcXVvdDtBY3RpdmUmcXVvdDs8YnI+CsKgIMKgIMKgIMKgIMKgIMKgIMKg
IHZhcmlhbnTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJvb2xlYW4gZmFsc2U8YnI+CsKg
IMKgIMKgIMKgIMKgIMKgKTxicj4KwqAgwqAgwqAgwqAgwqAgwqBkaWN0IGVudHJ5KDxicj4KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgc3RyaW5nICZxdW90O1R5cGUmcXVvdDs8YnI+CsKgIMKgIMKgIMKg
IMKgIMKgIMKgIHZhcmlhbnTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cmluZyAmcXVv
dDtpbnRlcm5ldCZxdW90Ozxicj4KwqAgwqAgwqAgwqAgwqAgwqApPGJyPgombHQ7VHJ1bmNhdGVk
Jmd0Ozxicj4KPGJyPgo8YnI+Ck1hbnVhbGx5IHRyeWluZyB0byBhY3RpdmF0ZSB0aGF0IGNvbnRl
eHQgZmFpbHM6PGJyPgojIGRidXMtc2VuZCAtLXN5c3RlbSAtLXByaW50LXJlcGx5IC0tZGVzdD1v
cmcub2Zvbm8gL2hlOTEwXzAvY29udGV4dDEgb3JnLm9mb25vLjxicj4KQ29ubmVjdGlvbkNvbnRl
eHQuU2V0UHJvcGVydHkgc3RyaW5nOkFjdGl2ZSB2YXJpYW50OmJvb2xlYW46dHJ1ZTxicj4KRXJy
b3Igb3JnLm9mb25vLkVycm9yLk5vdEF0dGFjaGVkOiBHUFJTIGlzIG5vdCBhdHRhY2hlZDxicj4K
PGJyPgo8YnI+ClRoYW5rcyw8YnI+Ck1pa2U8YnI+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fPGJyPgpvZm9ubyBtYWlsaW5nIGxpc3Q8YnI+CjxhIGhyZWY9
Im1haWx0bzpvZm9ub0BvZm9uby5vcmciPm9mb25vQG9mb25vLm9yZzwvYT48YnI+CjxhIGhyZWY9
Imh0dHBzOi8vbGlzdHMub2Zvbm8ub3JnL21haWxtYW4vbGlzdGluZm8vb2Zvbm8iIHRhcmdldD0i
X2JsYW5rIj5odHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vPC9h
Pjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj4K

--===============1020991405635753798==--

