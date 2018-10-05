Content-Type: multipart/mixed; boundary="===============5333746895691093143=="
MIME-Version: 1.0
From: Mustafa =?unknown-8bit?b?w5Z6w6dlbGlrw7Zycw==?= <mustafa.ozcelikors@redpine.com.tr>
Subject: Pulseaudio crashes when headset connection is turned off
Date: Fri, 05 Oct 2018 13:09:20 +0300
Message-ID: <CAEO5tXuU7aP6roJnfdCKH9rrkj3rt8rayzNf1hJoqSGTRKwj1w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5333746895691093143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello all,

I am trying to establish HFP connection with my phone using pulseaudio-12
ofono-1.18 libqofono-0.92 and bluez5-5.41, and handle basic functions such
as dialing, answering, hanging up through an app that I wrote. I use iMX8
board and Yocto Linux. While it works normally when there is no
interruption, there are some problems, especially with the ofono and
pulseaudio.

The biggest problem is pulseaudio crashing, if I disable Bluetooth/HFP from
phone while in a call. Suddenly everything crashes, leaving me with the
following outputs:

E: [bluetooth] module-bluez5-device.c: Failed to read data from SCO socket:
Connection reset by peer
...
E: [pulseaudio] backend-ofono.c: Deferred setup failed on fd -1: Transport
endpoint is not connected
...
W: [pulseaudio] backend-ofono.c: New audio connection invalid arguments
(path=3D/card_1 fd=3D31, codec=3D1)

While I got the following in ofono:

ofonod[8891]: Service level connection established
ofonod[8891]:
../ofono-1.18/drivers/hfpmodem/call-volume.c:hfp_call_volume_register()
ofonod[8891]:
../ofono-1.18/drivers/hfpmodem/voicecall.c:hfp_voicecall_initialized()
hfp_voicecall_init: registering to notifications
ofonod[8891]: ../ofono-1.18/src/siri.c:siri_remove() atom: 0x8cd9720
ofonod[8891]: ../ofono-1.18/src/network.c:ofono_netreg_status_notify()
/hfp/org/bluez/hci0/dev_D8_5B_2A_5B_7B_E6 status 1 tech -1
ofonod[8891]: ../ofono-1.18/src/voicecall.c:ofono_voicecall_mpty_hint()
ids: 0
ofonod[8891]: ../ofono-1.18/src/network.c:current_operator_callback()
0x8d2d830, (nil)
ofonod[8891]:
../ofono-1.18/drivers/hfpmodem/network-registration.c:signal_strength_cb()
signal_strength_cb: 5
ofonod[8891]: ../ofono-1.18/src/network.c:ofono_netreg_strength_notify()
strength 100
ofonod[8891]:
../ofono-1.18/drivers/hfpmodem/network-registration.c:signal_strength_cb()
signal_strength_cb: 5
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8d32130 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8d2fdd0 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8cde110 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8d7f7d0 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8cdfb20 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8d32130 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8d2fdd0 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8cde110 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8d7f7d0 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8cdfb20 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8d32130 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8d2fdd0 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8cde110 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8d7f7d0 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8cdfb20 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8d32130 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8d2fdd0 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8cde110 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8d7f7d0 property DevicePath
ofonod[8891]: ../ofono-1.18/src/modem.c:get_modem_property() modem
0x8cdfb20 property DevicePath
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:sco_accept() SCO
connection setup between local: 00:1A:7D:DA:71:15 and remote:
D8:5B:2A:5B:7B:E6
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:send_new_connection()
0x8ce5530, fd: 11, codec: 1
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:sco_accept() SCO
connection setup between local: 00:1A:7D:DA:71:15 and remote:
D8:5B:2A:5B:7B:E6
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:send_new_connection()
0x8ce5530, fd: 11, codec: 1
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:sco_accept() SCO
connection setup between local: 00:1A:7D:DA:71:15 and remote:
D8:5B:2A:5B:7B:E6
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:send_new_connection()
0x8ce5530, fd: 11, codec: 1
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:sco_accept() SCO
connection setup between local: 00:1A:7D:DA:71:15 and remote:
D8:5B:2A:5B:7B:E6
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:send_new_connection()
0x8ce5530, fd: 11, codec: 1
ofonod[8891]: ../ofono-1.18/drivers/hfpmodem/voicecall.c:clip_notify()
clip_notify: +905548212706 145 0
ofonod[8891]: ../ofono-1.18/src/voicecall.c:ofono_voicecall_notify() Got a
voicecall event, status: 4, id: 1, number: +905548212706 called_number: ,
called_name
ofonod[8891]: ../ofono-1.18/src/voicecall.c:ofono_voicecall_notify() Did
not find a call with id: 1
ofonod[8891]: ../ofono-1.18/src/voicecall.c:ofono_voicecall_notify() Got a
voicecall event, status: 0, id: 1, number: +905548212706 called_number: ,
called_name
ofonod[8891]: ../ofono-1.18/src/voicecall.c:ofono_voicecall_notify() Found
call with id: 1
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:sco_accept() SCO
connection setup between local: 00:1A:7D:DA:71:15 and remote:
D8:5B:2A:5B:7B:E6
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:send_new_connection()
0x8ce5530, fd: 11, codec: 1
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:sco_accept() SCO
connection setup between local: 00:1A:7D:DA:71:15 and remote:
D8:5B:2A:5B:7B:E6
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:send_new_connection()
0x8ce5530, fd: 11, codec: 1
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:sco_accept() SCO
connection setup between local: 00:1A:7D:DA:71:15 and remote:
D8:5B:2A:5B:7B:E6
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:send_new_connection()
0x8ce5530, fd: 11, codec: 1
ofonod[8891]: ../ofono-1.18/src/voicecall.c:ofono_voicecall_disconnected()
Got disconnection event for id: 1, reason: 2
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:sco_accept() SCO
connection setup between local: 00:1A:7D:DA:71:15 and remote:
D8:5B:2A:5B:7B:E6
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:send_new_connection()
0x8ce5530, fd: 11, codec: 1
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:sco_accept() SCO
connection setup between local: 00:1A:7D:DA:71:15 and remote:
D8:5B:2A:5B:7B:E6
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:send_new_connection()
0x8ce5530, fd: 11, codec: 1
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:sco_accept() SCO
connection setup between local: 00:1A:7D:DA:71:15 and remote:
D8:5B:2A:5B:7B:E6
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:send_new_connection()
0x8ce5530, fd: 11, codec: 1
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:sco_accept() SCO
connection setup between local: 00:1A:7D:DA:71:15 and remote:
D8:5B:2A:5B:7B:E6
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:send_new_connection()
0x8ce5530, fd: 11, codec: 1
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:sco_accept() SCO
connection setup between local: 00:1A:7D:DA:71:15 and remote:
D8:5B:2A:5B:7B:E6
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:send_new_connection()
0x8ce5530, fd: 11, codec: 1
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:sco_accept() SCO
connection setup between local: 00:1A:7D:DA:71:15 and remote:
D8:5B:2A:5B:7B:E6
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:send_new_connection()
0x8ce5530, fd: 11, codec: 1
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:sco_accept() SCO
connection setup between local: 00:1A:7D:DA:71:15 and remote:
D8:5B:2A:5B:7B:E6
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:send_new_connection()
0x8ce5530, fd: 11, codec: 1
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:agent_disconnect() Agent
:1.16 disconnected
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:am_agent_register() Agent
:1.22 registered with the CODECs: CVSD
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:am_agent_register()
Wideband speech disabled: no mSBC support
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:sco_accept() SCO
connection setup between local: 00:1A:7D:DA:71:15 and remote:
D8:5B:2A:5B:7B:E6
ofonod[8891]: ../ofono-1.18/src/handsfree-audio.c:send_new_connection()
0x8ce5530, fd: 11, codec: 1

There is no anomallity in the bluetooth logs, I am willing to provide more
information upon your request.

Is this maybe because my CSR v4.0 module do not support HFP completely?
Or is there a faulty setup in the PulseAudio or Ofono side?

Thanks for the help,

--===============5333746895691093143==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0
ciI+PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PkhlbGxvIGFsbCw8YnI+PGJyPjwvZGl2PkkgYW0g
dHJ5aW5nIHRvIGVzdGFibGlzaCBIRlAgY29ubmVjdGlvbiB3aXRoIG15IHBob25lIHVzaW5nIHB1
bHNlYXVkaW8tMTIgb2Zvbm8tMS4xOCBsaWJxb2Zvbm8tMC45MiBhbmQgYmx1ZXo1LTUuNDEsIGFu
ZCBoYW5kbGUgYmFzaWMgZnVuY3Rpb25zIHN1Y2ggYXMgZGlhbGluZywgYW5zd2VyaW5nLCBoYW5n
aW5nIHVwIHRocm91Z2ggYW4gYXBwIHRoYXQgSSB3cm90ZS4gSSB1c2UgaU1YOCBib2FyZCBhbmQg
WW9jdG8gTGludXguIFdoaWxlIGl0IHdvcmtzIG5vcm1hbGx5IHdoZW4gdGhlcmUgaXMgbm8gaW50
ZXJydXB0aW9uLCB0aGVyZSBhcmUgc29tZSBwcm9ibGVtcywgZXNwZWNpYWxseSB3aXRoIHRoZSBv
Zm9ubyBhbmQgcHVsc2VhdWRpby48YnI+PGJyPjwvZGl2PlRoZSBiaWdnZXN0IHByb2JsZW0gaXMg
cHVsc2VhdWRpbyBjcmFzaGluZywgaWYgSSBkaXNhYmxlIEJsdWV0b290aC9IRlAgZnJvbSBwaG9u
ZSB3aGlsZSBpbiBhIGNhbGwuIFN1ZGRlbmx5IGV2ZXJ5dGhpbmcgY3Jhc2hlcywgbGVhdmluZyBt
ZSB3aXRoIHRoZSBmb2xsb3dpbmcgb3V0cHV0czo8YnI+PGJyPjxzcGFuIHN0eWxlPSJmb250LWZh
bWlseTptb25vc3BhY2UsbW9ub3NwYWNlIj5FOiBbYmx1ZXRvb3RoXSBtb2R1bGUtYmx1ZXo1LWRl
dmljZS5jOiBGYWlsZWQgdG8gcmVhZCBkYXRhIGZyb20gU0NPIHNvY2tldDogQ29ubmVjdGlvbiBy
ZXNldCBieSBwZWVyPGJyPi4uLjxicj5FOiBbcHVsc2VhdWRpb10gYmFja2VuZC1vZm9uby5jOiBE
ZWZlcnJlZCBzZXR1cCBmYWlsZWQgb24gZmQgLTE6IFRyYW5zcG9ydCBlbmRwb2ludCBpcyBub3Qg
Y29ubmVjdGVkPGJyPi4uLjxicj5XOiBbcHVsc2VhdWRpb10gYmFja2VuZC1vZm9uby5jOiBOZXcg
YXVkaW8gY29ubmVjdGlvbiBpbnZhbGlkIGFyZ3VtZW50cyAocGF0aD0vY2FyZF8xIGZkPTMxLCBj
b2RlYz0xKTwvc3Bhbj48YnI+PGRpdj48ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+V2hpbGUgSSBn
b3QgdGhlIGZvbGxvd2luZyBpbiBvZm9ubzo8YnI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5Om1v
bm9zcGFjZSxtb25vc3BhY2UiPjxicj5vZm9ub2RbODg5MV06IFNlcnZpY2UgbGV2ZWwgY29ubmVj
dGlvbiBlc3RhYmxpc2hlZDxicj5vZm9ub2RbODg5MV06IC4uL29mb25vLTEuMTgvZHJpdmVycy9o
ZnBtb2RlbS9jYWxsLXZvbHVtZS5jOmhmcF9jYWxsX3ZvbHVtZV9yZWdpc3RlcigpIDxicj5vZm9u
b2RbODg5MV06IC4uL29mb25vLTEuMTgvZHJpdmVycy9oZnBtb2RlbS92b2ljZWNhbGwuYzpoZnBf
dm9pY2VjYWxsX2luaXRpYWxpemVkKCkgaGZwX3ZvaWNlY2FsbF9pbml0OiByZWdpc3RlcmluZyB0
byBub3RpZmljYXRpb25zPGJyPm9mb25vZFs4ODkxXTogLi4vb2Zvbm8tMS4xOC9zcmMvc2lyaS5j
OnNpcmlfcmVtb3ZlKCkgYXRvbTogMHg4Y2Q5NzIwPGJyPm9mb25vZFs4ODkxXTogLi4vb2Zvbm8t
MS4xOC9zcmMvbmV0d29yay5jOm9mb25vX25ldHJlZ19zdGF0dXNfbm90aWZ5KCkgL2hmcC9vcmcv
Ymx1ZXovaGNpMC9kZXZfRDhfNUJfMkFfNUJfN0JfRTYgc3RhdHVzIDEgdGVjaCAtMTxicj5vZm9u
b2RbODg5MV06IC4uL29mb25vLTEuMTgvc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9t
cHR5X2hpbnQoKSBpZHM6IDA8YnI+b2Zvbm9kWzg4OTFdOiAuLi9vZm9uby0xLjE4L3NyYy9uZXR3
b3JrLmM6Y3VycmVudF9vcGVyYXRvcl9jYWxsYmFjaygpIDB4OGQyZDgzMCwgKG5pbCk8YnI+b2Zv
bm9kWzg4OTFdOiAuLi9vZm9uby0xLjE4L2RyaXZlcnMvaGZwbW9kZW0vbmV0d29yay1yZWdpc3Ry
YXRpb24uYzpzaWduYWxfc3RyZW5ndGhfY2IoKSBzaWduYWxfc3RyZW5ndGhfY2I6IDU8YnI+b2Zv
bm9kWzg4OTFdOiAuLi9vZm9uby0xLjE4L3NyYy9uZXR3b3JrLmM6b2Zvbm9fbmV0cmVnX3N0cmVu
Z3RoX25vdGlmeSgpIHN0cmVuZ3RoIDEwMDxicj5vZm9ub2RbODg5MV06IC4uL29mb25vLTEuMTgv
ZHJpdmVycy9oZnBtb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5jOnNpZ25hbF9zdHJlbmd0aF9j
YigpIHNpZ25hbF9zdHJlbmd0aF9jYjogNTxicj5vZm9ub2RbODg5MV06IC4uL29mb25vLTEuMTgv
c3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg4ZDMyMTMwIHByb3BlcnR5
IERldmljZVBhdGg8YnI+b2Zvbm9kWzg4OTFdOiAuLi9vZm9uby0xLjE4L3NyYy9tb2RlbS5jOmdl
dF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OGQyZmRkMCBwcm9wZXJ0eSBEZXZpY2VQYXRoPGJy
Pm9mb25vZFs4ODkxXTogLi4vb2Zvbm8tMS4xOC9zcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVy
dHkoKSBtb2RlbSAweDhjZGUxMTAgcHJvcGVydHkgRGV2aWNlUGF0aDxicj5vZm9ub2RbODg5MV06
IC4uL29mb25vLTEuMTgvc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg4
ZDdmN2QwIHByb3BlcnR5IERldmljZVBhdGg8YnI+b2Zvbm9kWzg4OTFdOiAuLi9vZm9uby0xLjE4
L3NyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OGNkZmIyMCBwcm9wZXJ0
eSBEZXZpY2VQYXRoPGJyPm9mb25vZFs4ODkxXTogLi4vb2Zvbm8tMS4xOC9zcmMvbW9kZW0uYzpn
ZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDhkMzIxMzAgcHJvcGVydHkgRGV2aWNlUGF0aDxi
cj5vZm9ub2RbODg5MV06IC4uL29mb25vLTEuMTgvc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3Bl
cnR5KCkgbW9kZW0gMHg4ZDJmZGQwIHByb3BlcnR5IERldmljZVBhdGg8YnI+b2Zvbm9kWzg4OTFd
OiAuLi9vZm9uby0xLjE4L3NyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4
OGNkZTExMCBwcm9wZXJ0eSBEZXZpY2VQYXRoPGJyPm9mb25vZFs4ODkxXTogLi4vb2Zvbm8tMS4x
OC9zcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDhkN2Y3ZDAgcHJvcGVy
dHkgRGV2aWNlUGF0aDxicj5vZm9ub2RbODg5MV06IC4uL29mb25vLTEuMTgvc3JjL21vZGVtLmM6
Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg4Y2RmYjIwIHByb3BlcnR5IERldmljZVBhdGg8
YnI+b2Zvbm9kWzg4OTFdOiAuLi9vZm9uby0xLjE4L3NyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9w
ZXJ0eSgpIG1vZGVtIDB4OGQzMjEzMCBwcm9wZXJ0eSBEZXZpY2VQYXRoPGJyPm9mb25vZFs4ODkx
XTogLi4vb2Zvbm8tMS4xOC9zcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAw
eDhkMmZkZDAgcHJvcGVydHkgRGV2aWNlUGF0aDxicj5vZm9ub2RbODg5MV06IC4uL29mb25vLTEu
MTgvc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0gMHg4Y2RlMTEwIHByb3Bl
cnR5IERldmljZVBhdGg8YnI+b2Zvbm9kWzg4OTFdOiAuLi9vZm9uby0xLjE4L3NyYy9tb2RlbS5j
OmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OGQ3ZjdkMCBwcm9wZXJ0eSBEZXZpY2VQYXRo
PGJyPm9mb25vZFs4ODkxXTogLi4vb2Zvbm8tMS4xOC9zcmMvbW9kZW0uYzpnZXRfbW9kZW1fcHJv
cGVydHkoKSBtb2RlbSAweDhjZGZiMjAgcHJvcGVydHkgRGV2aWNlUGF0aDxicj5vZm9ub2RbODg5
MV06IC4uL29mb25vLTEuMTgvc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9kZW0g
MHg4ZDMyMTMwIHByb3BlcnR5IERldmljZVBhdGg8YnI+b2Zvbm9kWzg4OTFdOiAuLi9vZm9uby0x
LjE4L3NyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4OGQyZmRkMCBwcm9w
ZXJ0eSBEZXZpY2VQYXRoPGJyPm9mb25vZFs4ODkxXTogLi4vb2Zvbm8tMS4xOC9zcmMvbW9kZW0u
YzpnZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDhjZGUxMTAgcHJvcGVydHkgRGV2aWNlUGF0
aDxicj5vZm9ub2RbODg5MV06IC4uL29mb25vLTEuMTgvc3JjL21vZGVtLmM6Z2V0X21vZGVtX3By
b3BlcnR5KCkgbW9kZW0gMHg4ZDdmN2QwIHByb3BlcnR5IERldmljZVBhdGg8YnI+b2Zvbm9kWzg4
OTFdOiAuLi9vZm9uby0xLjE4L3NyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVt
IDB4OGNkZmIyMCBwcm9wZXJ0eSBEZXZpY2VQYXRoPGJyPm9mb25vZFs4ODkxXTogLi4vb2Zvbm8t
MS4xOC9zcmMvaGFuZHNmcmVlLWF1ZGlvLmM6c2NvX2FjY2VwdCgpIFNDTyBjb25uZWN0aW9uIHNl
dHVwIGJldHdlZW4gbG9jYWw6IDAwOjFBOjdEOkRBOjcxOjE1IGFuZCByZW1vdGU6IEQ4OjVCOjJB
OjVCOjdCOkU2PGJyPm9mb25vZFs4ODkxXTogLi4vb2Zvbm8tMS4xOC9zcmMvaGFuZHNmcmVlLWF1
ZGlvLmM6c2VuZF9uZXdfY29ubmVjdGlvbigpIDB4OGNlNTUzMCwgZmQ6IDExLCBjb2RlYzogMTxi
cj5vZm9ub2RbODg5MV06IC4uL29mb25vLTEuMTgvc3JjL2hhbmRzZnJlZS1hdWRpby5jOnNjb19h
Y2NlcHQoKSBTQ08gY29ubmVjdGlvbiBzZXR1cCBiZXR3ZWVuIGxvY2FsOiAwMDoxQTo3RDpEQTo3
MToxNSBhbmQgcmVtb3RlOiBEODo1QjoyQTo1Qjo3QjpFNjxicj5vZm9ub2RbODg5MV06IC4uL29m
b25vLTEuMTgvc3JjL2hhbmRzZnJlZS1hdWRpby5jOnNlbmRfbmV3X2Nvbm5lY3Rpb24oKSAweDhj
ZTU1MzAsIGZkOiAxMSwgY29kZWM6IDE8YnI+b2Zvbm9kWzg4OTFdOiAuLi9vZm9uby0xLjE4L3Ny
Yy9oYW5kc2ZyZWUtYXVkaW8uYzpzY29fYWNjZXB0KCkgU0NPIGNvbm5lY3Rpb24gc2V0dXAgYmV0
d2VlbiBsb2NhbDogMDA6MUE6N0Q6REE6NzE6MTUgYW5kIHJlbW90ZTogRDg6NUI6MkE6NUI6N0I6
RTY8YnI+b2Zvbm9kWzg4OTFdOiAuLi9vZm9uby0xLjE4L3NyYy9oYW5kc2ZyZWUtYXVkaW8uYzpz
ZW5kX25ld19jb25uZWN0aW9uKCkgMHg4Y2U1NTMwLCBmZDogMTEsIGNvZGVjOiAxPGJyPm9mb25v
ZFs4ODkxXTogLi4vb2Zvbm8tMS4xOC9zcmMvaGFuZHNmcmVlLWF1ZGlvLmM6c2NvX2FjY2VwdCgp
IFNDTyBjb25uZWN0aW9uIHNldHVwIGJldHdlZW4gbG9jYWw6IDAwOjFBOjdEOkRBOjcxOjE1IGFu
ZCByZW1vdGU6IEQ4OjVCOjJBOjVCOjdCOkU2PGJyPm9mb25vZFs4ODkxXTogLi4vb2Zvbm8tMS4x
OC9zcmMvaGFuZHNmcmVlLWF1ZGlvLmM6c2VuZF9uZXdfY29ubmVjdGlvbigpIDB4OGNlNTUzMCwg
ZmQ6IDExLCBjb2RlYzogMTxicj5vZm9ub2RbODg5MV06IC4uL29mb25vLTEuMTgvZHJpdmVycy9o
ZnBtb2RlbS92b2ljZWNhbGwuYzpjbGlwX25vdGlmeSgpIGNsaXBfbm90aWZ5OiArOTA1NTQ4MjEy
NzA2IDE0NSAwPGJyPm9mb25vZFs4ODkxXTogLi4vb2Zvbm8tMS4xOC9zcmMvdm9pY2VjYWxsLmM6
b2Zvbm9fdm9pY2VjYWxsX25vdGlmeSgpIEdvdCBhIHZvaWNlY2FsbCBldmVudCwgc3RhdHVzOiA0
LCBpZDogMSwgbnVtYmVyOiArOTA1NTQ4MjEyNzA2IGNhbGxlZF9udW1iZXI6ICwgY2FsbGVkX25h
bWUgPGJyPm9mb25vZFs4ODkxXTogLi4vb2Zvbm8tMS4xOC9zcmMvdm9pY2VjYWxsLmM6b2Zvbm9f
dm9pY2VjYWxsX25vdGlmeSgpIERpZCBub3QgZmluZCBhIGNhbGwgd2l0aCBpZDogMTxicj5vZm9u
b2RbODg5MV06IC4uL29mb25vLTEuMTgvc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9u
b3RpZnkoKSBHb3QgYSB2b2ljZWNhbGwgZXZlbnQsIHN0YXR1czogMCwgaWQ6IDEsIG51bWJlcjog
KzkwNTU0ODIxMjcwNiBjYWxsZWRfbnVtYmVyOiAsIGNhbGxlZF9uYW1lIDxicj5vZm9ub2RbODg5
MV06IC4uL29mb25vLTEuMTgvc3JjL3ZvaWNlY2FsbC5jOm9mb25vX3ZvaWNlY2FsbF9ub3RpZnko
KSBGb3VuZCBjYWxsIHdpdGggaWQ6IDE8YnI+b2Zvbm9kWzg4OTFdOiAuLi9vZm9uby0xLjE4L3Ny
Yy9oYW5kc2ZyZWUtYXVkaW8uYzpzY29fYWNjZXB0KCkgU0NPIGNvbm5lY3Rpb24gc2V0dXAgYmV0
d2VlbiBsb2NhbDogMDA6MUE6N0Q6REE6NzE6MTUgYW5kIHJlbW90ZTogRDg6NUI6MkE6NUI6N0I6
RTY8YnI+b2Zvbm9kWzg4OTFdOiAuLi9vZm9uby0xLjE4L3NyYy9oYW5kc2ZyZWUtYXVkaW8uYzpz
ZW5kX25ld19jb25uZWN0aW9uKCkgMHg4Y2U1NTMwLCBmZDogMTEsIGNvZGVjOiAxPGJyPm9mb25v
ZFs4ODkxXTogLi4vb2Zvbm8tMS4xOC9zcmMvaGFuZHNmcmVlLWF1ZGlvLmM6c2NvX2FjY2VwdCgp
IFNDTyBjb25uZWN0aW9uIHNldHVwIGJldHdlZW4gbG9jYWw6IDAwOjFBOjdEOkRBOjcxOjE1IGFu
ZCByZW1vdGU6IEQ4OjVCOjJBOjVCOjdCOkU2PGJyPm9mb25vZFs4ODkxXTogLi4vb2Zvbm8tMS4x
OC9zcmMvaGFuZHNmcmVlLWF1ZGlvLmM6c2VuZF9uZXdfY29ubmVjdGlvbigpIDB4OGNlNTUzMCwg
ZmQ6IDExLCBjb2RlYzogMTxicj5vZm9ub2RbODg5MV06IC4uL29mb25vLTEuMTgvc3JjL2hhbmRz
ZnJlZS1hdWRpby5jOnNjb19hY2NlcHQoKSBTQ08gY29ubmVjdGlvbiBzZXR1cCBiZXR3ZWVuIGxv
Y2FsOiAwMDoxQTo3RDpEQTo3MToxNSBhbmQgcmVtb3RlOiBEODo1QjoyQTo1Qjo3QjpFNjxicj5v
Zm9ub2RbODg5MV06IC4uL29mb25vLTEuMTgvc3JjL2hhbmRzZnJlZS1hdWRpby5jOnNlbmRfbmV3
X2Nvbm5lY3Rpb24oKSAweDhjZTU1MzAsIGZkOiAxMSwgY29kZWM6IDE8YnI+b2Zvbm9kWzg4OTFd
OiAuLi9vZm9uby0xLjE4L3NyYy92b2ljZWNhbGwuYzpvZm9ub192b2ljZWNhbGxfZGlzY29ubmVj
dGVkKCkgR290IGRpc2Nvbm5lY3Rpb24gZXZlbnQgZm9yIGlkOiAxLCByZWFzb246IDI8YnI+b2Zv
bm9kWzg4OTFdOiAuLi9vZm9uby0xLjE4L3NyYy9oYW5kc2ZyZWUtYXVkaW8uYzpzY29fYWNjZXB0
KCkgU0NPIGNvbm5lY3Rpb24gc2V0dXAgYmV0d2VlbiBsb2NhbDogMDA6MUE6N0Q6REE6NzE6MTUg
YW5kIHJlbW90ZTogRDg6NUI6MkE6NUI6N0I6RTY8YnI+b2Zvbm9kWzg4OTFdOiAuLi9vZm9uby0x
LjE4L3NyYy9oYW5kc2ZyZWUtYXVkaW8uYzpzZW5kX25ld19jb25uZWN0aW9uKCkgMHg4Y2U1NTMw
LCBmZDogMTEsIGNvZGVjOiAxPGJyPm9mb25vZFs4ODkxXTogLi4vb2Zvbm8tMS4xOC9zcmMvaGFu
ZHNmcmVlLWF1ZGlvLmM6c2NvX2FjY2VwdCgpIFNDTyBjb25uZWN0aW9uIHNldHVwIGJldHdlZW4g
bG9jYWw6IDAwOjFBOjdEOkRBOjcxOjE1IGFuZCByZW1vdGU6IEQ4OjVCOjJBOjVCOjdCOkU2PGJy
Pm9mb25vZFs4ODkxXTogLi4vb2Zvbm8tMS4xOC9zcmMvaGFuZHNmcmVlLWF1ZGlvLmM6c2VuZF9u
ZXdfY29ubmVjdGlvbigpIDB4OGNlNTUzMCwgZmQ6IDExLCBjb2RlYzogMTxicj5vZm9ub2RbODg5
MV06IC4uL29mb25vLTEuMTgvc3JjL2hhbmRzZnJlZS1hdWRpby5jOnNjb19hY2NlcHQoKSBTQ08g
Y29ubmVjdGlvbiBzZXR1cCBiZXR3ZWVuIGxvY2FsOiAwMDoxQTo3RDpEQTo3MToxNSBhbmQgcmVt
b3RlOiBEODo1QjoyQTo1Qjo3QjpFNjxicj5vZm9ub2RbODg5MV06IC4uL29mb25vLTEuMTgvc3Jj
L2hhbmRzZnJlZS1hdWRpby5jOnNlbmRfbmV3X2Nvbm5lY3Rpb24oKSAweDhjZTU1MzAsIGZkOiAx
MSwgY29kZWM6IDE8YnI+b2Zvbm9kWzg4OTFdOiAuLi9vZm9uby0xLjE4L3NyYy9oYW5kc2ZyZWUt
YXVkaW8uYzpzY29fYWNjZXB0KCkgU0NPIGNvbm5lY3Rpb24gc2V0dXAgYmV0d2VlbiBsb2NhbDog
MDA6MUE6N0Q6REE6NzE6MTUgYW5kIHJlbW90ZTogRDg6NUI6MkE6NUI6N0I6RTY8YnI+b2Zvbm9k
Wzg4OTFdOiAuLi9vZm9uby0xLjE4L3NyYy9oYW5kc2ZyZWUtYXVkaW8uYzpzZW5kX25ld19jb25u
ZWN0aW9uKCkgMHg4Y2U1NTMwLCBmZDogMTEsIGNvZGVjOiAxPGJyPm9mb25vZFs4ODkxXTogLi4v
b2Zvbm8tMS4xOC9zcmMvaGFuZHNmcmVlLWF1ZGlvLmM6c2NvX2FjY2VwdCgpIFNDTyBjb25uZWN0
aW9uIHNldHVwIGJldHdlZW4gbG9jYWw6IDAwOjFBOjdEOkRBOjcxOjE1IGFuZCByZW1vdGU6IEQ4
OjVCOjJBOjVCOjdCOkU2PGJyPm9mb25vZFs4ODkxXTogLi4vb2Zvbm8tMS4xOC9zcmMvaGFuZHNm
cmVlLWF1ZGlvLmM6c2VuZF9uZXdfY29ubmVjdGlvbigpIDB4OGNlNTUzMCwgZmQ6IDExLCBjb2Rl
YzogMTxicj5vZm9ub2RbODg5MV06IC4uL29mb25vLTEuMTgvc3JjL2hhbmRzZnJlZS1hdWRpby5j
OnNjb19hY2NlcHQoKSBTQ08gY29ubmVjdGlvbiBzZXR1cCBiZXR3ZWVuIGxvY2FsOiAwMDoxQTo3
RDpEQTo3MToxNSBhbmQgcmVtb3RlOiBEODo1QjoyQTo1Qjo3QjpFNjxicj5vZm9ub2RbODg5MV06
IC4uL29mb25vLTEuMTgvc3JjL2hhbmRzZnJlZS1hdWRpby5jOnNlbmRfbmV3X2Nvbm5lY3Rpb24o
KSAweDhjZTU1MzAsIGZkOiAxMSwgY29kZWM6IDE8YnI+b2Zvbm9kWzg4OTFdOiAuLi9vZm9uby0x
LjE4L3NyYy9oYW5kc2ZyZWUtYXVkaW8uYzpzY29fYWNjZXB0KCkgU0NPIGNvbm5lY3Rpb24gc2V0
dXAgYmV0d2VlbiBsb2NhbDogMDA6MUE6N0Q6REE6NzE6MTUgYW5kIHJlbW90ZTogRDg6NUI6MkE6
NUI6N0I6RTY8YnI+b2Zvbm9kWzg4OTFdOiAuLi9vZm9uby0xLjE4L3NyYy9oYW5kc2ZyZWUtYXVk
aW8uYzpzZW5kX25ld19jb25uZWN0aW9uKCkgMHg4Y2U1NTMwLCBmZDogMTEsIGNvZGVjOiAxPGJy
Pm9mb25vZFs4ODkxXTogLi4vb2Zvbm8tMS4xOC9zcmMvaGFuZHNmcmVlLWF1ZGlvLmM6YWdlbnRf
ZGlzY29ubmVjdCgpIEFnZW50IDoxLjE2IGRpc2Nvbm5lY3RlZDxicj5vZm9ub2RbODg5MV06IC4u
L29mb25vLTEuMTgvc3JjL2hhbmRzZnJlZS1hdWRpby5jOmFtX2FnZW50X3JlZ2lzdGVyKCkgQWdl
bnQgOjEuMjIgcmVnaXN0ZXJlZCB3aXRoIHRoZSBDT0RFQ3M6IENWU0Q8YnI+b2Zvbm9kWzg4OTFd
OiAuLi9vZm9uby0xLjE4L3NyYy9oYW5kc2ZyZWUtYXVkaW8uYzphbV9hZ2VudF9yZWdpc3Rlcigp
IFdpZGViYW5kIHNwZWVjaCBkaXNhYmxlZDogbm8gbVNCQyBzdXBwb3J0PGJyPm9mb25vZFs4ODkx
XTogLi4vb2Zvbm8tMS4xOC9zcmMvaGFuZHNmcmVlLWF1ZGlvLmM6c2NvX2FjY2VwdCgpIFNDTyBj
b25uZWN0aW9uIHNldHVwIGJldHdlZW4gbG9jYWw6IDAwOjFBOjdEOkRBOjcxOjE1IGFuZCByZW1v
dGU6IEQ4OjVCOjJBOjVCOjdCOkU2PGJyPm9mb25vZFs4ODkxXTogLi4vb2Zvbm8tMS4xOC9zcmMv
aGFuZHNmcmVlLWF1ZGlvLmM6c2VuZF9uZXdfY29ubmVjdGlvbigpIDB4OGNlNTUzMCwgZmQ6IDEx
LCBjb2RlYzogMTwvc3Bhbj48YnI+PGJyPjwvZGl2PjxkaXY+VGhlcmUgaXMgbm8gYW5vbWFsbGl0
eSBpbiB0aGUgYmx1ZXRvb3RoIGxvZ3MsIEkgYW0gd2lsbGluZyB0byBwcm92aWRlIG1vcmUgaW5m
b3JtYXRpb24gdXBvbiB5b3VyIHJlcXVlc3QuPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
SXMgdGhpcyBtYXliZSBiZWNhdXNlIG15IENTUiB2NC4wIG1vZHVsZSBkbyBub3Qgc3VwcG9ydCBI
RlAgY29tcGxldGVseT88YnI+PC9kaXY+PGRpdj5PciBpcyB0aGVyZSBhIGZhdWx0eSBzZXR1cCBp
biB0aGUgUHVsc2VBdWRpbyBvciBPZm9ubyBzaWRlPzxicj48YnI+PC9kaXY+PGRpdj5UaGFua3Mg
Zm9yIHRoZSBoZWxwLDxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48YnI+PC9kaXY+PC9kaXY+PC9k
aXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============5333746895691093143==--

