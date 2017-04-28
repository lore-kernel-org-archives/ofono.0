Content-Type: multipart/mixed; boundary="===============5373998456374490193=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: qmimodem: GPRS context stay Active when GPRS attach is lost
Date: Fri, 28 Apr 2017 16:28:58 +0200
Message-ID: <acc564b8-0170-aeed-da59-397de3f49a68@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5373998456374490193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Even with detach_shutdown method implemented in qmimodem (patch done by =

Jonas Bonn two or three weeks ago), I still sometimes have problems when =

I have a lot of GPRS deconnections.

I use a MC7304 modem and to simulate short GPRS network losses, I simply =

unplug and replug modem antenna.

I figured out that my problems come from QMI_WDS_PKT_STATUS_IND that is =

received after GPRS network is back and context activation started once =

again (by connman).

I have posted a trace with connman and ofono traces here (available for =

the next 7 days): https://we.tl/FliZAdaVN5

I have added some additional traces in ofono to narrow down the problem.

Here is the trace explanation:


What happens before Apr 27 16:05:59:
1) Apr 27 16:05:44: GPRS attach lost, we asked to deactivate GPRS context.
2) Apr 27 16:05:53: GPRS attach is back

What happens at Apr 27 16:05:59:
1) Answer OK to qmi_deactivate_primary (stop_net_cb without error)
2) ofono_gprs_context_deactivated called with correct cid, property =

Active set to False
3) Connman immediately reacts and ask for context reactivation. =

qmi_activate_primary is called
4) pkt_status_notify received to say that packet status is disconnected =

=3D> ofono_gprs_context_deactivated called again but context not activated =

yet. Nothing happens outside of gprs-context driver but active_context =

is set to 0.

What happens at Apr 27 16:10:28:
1) GPRS attach lost, we asked to deactivate GPRS context.
2) stop_net_cb called without error BUT active_context is 0.
3) ofono_gprs_context_deactivated called with wrong context id, nothing =

happens

And property Active of gprs context is not modified. Connman will never =

try to reconnect the service when GPRS attach is back (Apr 27 16:10:39).


I've done a patch that seems to correct the problem for me. I simply do =

not handle anymore QMI_WDS_PKT_STATUS_IND notifications. I assume it is =

not needed anymore (after Jonas Bonn patch implementing detach_shutdown =

method in qmimodem driver). But I might be wrong...

I'll send the patch after this message.


Best Regards,


Christophe


--===============5373998456374490193==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CgogICAgPG1ldGEgaHR0cC1lcXVpdj0iY29udGVudC10eXBlIiBjb250
ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPgogIDwvaGVhZD4KICA8Ym9keSB0ZXh0PSIj
MDAwMDAwIiBiZ2NvbG9yPSIjRkZGRkZGIj4KICAgIDxwPkhlbGxvLDwvcD4KICAgIDxwPkV2ZW4g
d2l0aCBkZXRhY2hfc2h1dGRvd24gbWV0aG9kIGltcGxlbWVudGVkIGluIHFtaW1vZGVtIChwYXRj
aAogICAgICBkb25lIGJ5IEpvbmFzIEJvbm4gdHdvIG9yIHRocmVlIHdlZWtzIGFnbyksIEkgc3Rp
bGwgc29tZXRpbWVzIGhhdmUKICAgICAgcHJvYmxlbXMgd2hlbiBJIGhhdmUgYSBsb3Qgb2YgR1BS
UyBkZWNvbm5lY3Rpb25zLjwvcD4KICAgIDxwPkkgdXNlIGEgTUM3MzA0IG1vZGVtIGFuZCB0byBz
aW11bGF0ZSBzaG9ydCBHUFJTIG5ldHdvcmsgbG9zc2VzLCBJCiAgICAgIHNpbXBseSB1bnBsdWcg
YW5kIHJlcGx1ZyBtb2RlbSBhbnRlbm5hLjxicj4KICAgIDwvcD4KICAgIDxwPkkgZmlndXJlZCBv
dXQgdGhhdCBteSBwcm9ibGVtcyBjb21lIGZyb20gUU1JX1dEU19QS1RfU1RBVFVTX0lORAogICAg
ICB0aGF0IGlzIHJlY2VpdmVkIGFmdGVyIEdQUlMgbmV0d29yayBpcyBiYWNrIGFuZCBjb250ZXh0
IGFjdGl2YXRpb24KICAgICAgc3RhcnRlZCBvbmNlIGFnYWluIChieSBjb25ubWFuKS48L3A+CiAg
ICA8cD5JIGhhdmUgcG9zdGVkIGEgdHJhY2Ugd2l0aCBjb25ubWFuIGFuZCBvZm9ubyB0cmFjZXMg
aGVyZQogICAgICAoYXZhaWxhYmxlIGZvciB0aGUgbmV4dCA3IGRheXMpOiA8YSBjbGFzcz0iZG93
bmxvYWRfbGlua19saW5rIgogICAgICAgIGhyZWY9Imh0dHBzOi8vd2UudGwvRmxpWkFkYVZONSIg
c3R5bGU9ImNvbG9yOiAjMTcxODFBOwogICAgICAgIGZvbnQtZmFtaWx5OiAnRmFrdCBQcm8gTWVk
aXVtJywgJ1NlZ29lIFVJJywgJ1NhbkZyYW5jaXNjbwogICAgICAgIERpc3BsYXknLCBBcmlhbCwg
c2Fucy1zZXJpZjsgZm9udC13ZWlnaHQ6IG5vcm1hbDsKICAgICAgICB0ZXh0LWRlY29yYXRpb246
IHVuZGVybGluZTsgd29yZC13cmFwOiBicmVhay13b3JkOyI+PHNwYW4KICAgICAgICAgIGNsYXNz
PSJkb3dubG9hZF9saW5rX2xpbmsiIHN0eWxlPSJjb2xvcjogIzQwOUZGRjsgZm9udC13ZWlnaHQ6
CiAgICAgICAgICBub3JtYWw7IHRleHQtZGVjb3JhdGlvbjogdW5kZXJsaW5lOyB3b3JkLXdyYXA6
IGJyZWFrLXdvcmQ7Ij5odHRwczovL3dlLnRsL0ZsaVpBZGFWTjU8L3NwYW4+PC9hPjwvcD4KICAg
IDxwPkkgaGF2ZSBhZGRlZCBzb21lIGFkZGl0aW9uYWwgdHJhY2VzIGluIG9mb25vIHRvIG5hcnJv
dyBkb3duIHRoZQogICAgICBwcm9ibGVtLjwvcD4KICAgIDxwPkhlcmUgaXMgdGhlIHRyYWNlIGV4
cGxhbmF0aW9uOjwvcD4KICAgIDxwPjxicj4KICAgICAgV2hhdCBoYXBwZW5zIGJlZm9yZSBBcHIg
MjcgMTY6MDU6NTk6PGJyPgogICAgICAxKSBBcHIgMjcgMTY6MDU6NDQ6IEdQUlMgYXR0YWNoIGxv
c3QsIHdlIGFza2VkIHRvIGRlYWN0aXZhdGUgR1BSUwogICAgICBjb250ZXh0Ljxicj4KICAgICAg
MikgQXByIDI3IDE2OjA1OjUzOiBHUFJTIGF0dGFjaCBpcyBiYWNrPGJyPgogICAgICA8YnI+CiAg
ICAgIFdoYXQgaGFwcGVucyBhdCBBcHIgMjcgMTY6MDU6NTk6PGJyPgogICAgICAxKSBBbnN3ZXIg
T0sgdG8gcW1pX2RlYWN0aXZhdGVfcHJpbWFyeSAoc3RvcF9uZXRfY2Igd2l0aG91dCBlcnJvcik8
YnI+CiAgICAgIDIpIG9mb25vX2dwcnNfY29udGV4dF9kZWFjdGl2YXRlZCBjYWxsZWQgd2l0aCBj
b3JyZWN0IGNpZCwKICAgICAgcHJvcGVydHkgQWN0aXZlIHNldCB0byBGYWxzZTxicj4KICAgICAg
MykgQ29ubm1hbiBpbW1lZGlhdGVseSByZWFjdHMgYW5kIGFzayBmb3IgY29udGV4dCByZWFjdGl2
YXRpb24uCiAgICAgIHFtaV9hY3RpdmF0ZV9wcmltYXJ5IGlzIGNhbGxlZDxicj4KICAgICAgNCkg
cGt0X3N0YXR1c19ub3RpZnkgcmVjZWl2ZWQgdG8gc2F5IHRoYXQgcGFja2V0IHN0YXR1cyBpcwog
ICAgICBkaXNjb25uZWN0ZWQgPSZndDsgb2Zvbm9fZ3Byc19jb250ZXh0X2RlYWN0aXZhdGVkIGNh
bGxlZCBhZ2FpbiBidXQKICAgICAgY29udGV4dCBub3QgYWN0aXZhdGVkIHlldC4gTm90aGluZyBo
YXBwZW5zIG91dHNpZGUgb2YgZ3Bycy1jb250ZXh0CiAgICAgIGRyaXZlciBidXQgYWN0aXZlX2Nv
bnRleHQgaXMgc2V0IHRvIDAuPGJyPgogICAgICA8YnI+CiAgICAgIFdoYXQgaGFwcGVucyBhdCBB
cHIgMjcgMTY6MTA6Mjg6PGJyPgogICAgICAxKSBHUFJTIGF0dGFjaCBsb3N0LCB3ZSBhc2tlZCB0
byBkZWFjdGl2YXRlIEdQUlMgY29udGV4dC48YnI+CiAgICAgIDIpIHN0b3BfbmV0X2NiIGNhbGxl
ZCB3aXRob3V0IGVycm9yIEJVVCBhY3RpdmVfY29udGV4dCBpcyAwLjxicj4KICAgICAgMykgb2Zv
bm9fZ3Byc19jb250ZXh0X2RlYWN0aXZhdGVkIGNhbGxlZCB3aXRoIHdyb25nIGNvbnRleHQgaWQs
CiAgICAgIG5vdGhpbmcgaGFwcGVuczxicj4KICAgICAgPGJyPgogICAgICBBbmQgcHJvcGVydHkg
QWN0aXZlIG9mIGdwcnMgY29udGV4dCBpcyBub3QgbW9kaWZpZWQuIENvbm5tYW4gd2lsbAogICAg
ICBuZXZlciB0cnkgdG8gcmVjb25uZWN0IHRoZSBzZXJ2aWNlIHdoZW4gR1BSUyBhdHRhY2ggaXMg
YmFjayAoQXByCiAgICAgIDI3IDE2OjEwOjM5KS48YnI+CiAgICA8L3A+CiAgICA8cD48YnI+CiAg
ICA8L3A+CiAgICA8cD5JJ3ZlIGRvbmUgYSBwYXRjaCB0aGF0IHNlZW1zIHRvIGNvcnJlY3QgdGhl
IHByb2JsZW0gZm9yIG1lLiBJCiAgICAgIHNpbXBseSBkbyBub3QgaGFuZGxlIGFueW1vcmUgUU1J
X1dEU19QS1RfU1RBVFVTX0lORCBub3RpZmljYXRpb25zLgogICAgICBJIGFzc3VtZSBpdCBpcyBu
b3QgbmVlZGVkIGFueW1vcmUgKGFmdGVyIEpvbmFzIEJvbm4gcGF0Y2gKICAgICAgaW1wbGVtZW50
aW5nIGRldGFjaF9zaHV0ZG93biBtZXRob2QgaW4gcW1pbW9kZW0gZHJpdmVyKS4gQnV0IEkKICAg
ICAgbWlnaHQgYmUgd3JvbmcuLi48L3A+CiAgICA8cD5JJ2xsIHNlbmQgdGhlIHBhdGNoIGFmdGVy
IHRoaXMgbWVzc2FnZS48L3A+CiAgICA8cD48YnI+CiAgICA8L3A+CiAgICA8cD5CZXN0IFJlZ2Fy
ZHMsPC9wPgogICAgPHA+PGJyPgogICAgPC9wPgogICAgPHA+Q2hyaXN0b3BoZTxicj4KICAgIDwv
cD4KICA8L2JvZHk+CjwvaHRtbD4K

--===============5373998456374490193==--

