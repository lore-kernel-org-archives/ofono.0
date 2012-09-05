Content-Type: multipart/mixed; boundary="===============6574117615417765525=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: context activation quickly after context deactivation fails
Date: Wed, 05 Sep 2012 14:41:31 -0500
Message-ID: <5047AAEB.8080203@gmail.com>
In-Reply-To: <CABvLYuD17J3urLnbzDuzM95BPbRDs1Y6Mgi9=6yX3wPunxz6LA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6574117615417765525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

On 09/03/2012 07:50 AM, Cedric Jehasse wrote:
> Hi,
>
> When i want to change a Property (eg. APN) of an Active
> ConnectionContext. I first deactivate the context, wait for a reply
> then set the property and re-activate the context.
> The problem is i'm already trying to re-activate the context, before
> oFono gets a "NO CARRIER" from the modem. oFono tries to send
> AT+CGDCONT, but get's a "NO CARRIER" response and fails to activate
> the context.
> Is there a way to tell if it's ready to re-activate? Should oFono wait
> for the "NO CARRIER" before it sends a reply to the deactivation?
>
> Here's a log of the problem
> Jan  4 22:14:38 ofonod[3022]:
> drivers/atmodem/gprs-context.c:at_gprs_deactivate_primary() cid 1
> Jan  4 22:14:38 ofonod[3022]: PPP: lcp: pppcp_generate_event: current
> state 9:OPENED
> Jan  4 22:14:38 ofonod[3022]: PPP: event: 3 (Close), action: 8224,
> new_state: 4 (CLOSING)
> Jan  4 22:14:38 ofonod[3022]: PPP: lcp:
> pppcp_initialize_restart_count: current state 9:OPENED
> Jan  4 22:14:38 ofonod[3022]: PPP: lcp: pppcp_send_terminate_request:
> current state 9:OPENED
> Jan  4 22:14:38 ofonod[3022]: PPP: ipcp: pppcp_generate_event: current
> state 9:OPENED
> Jan  4 22:14:38 ofonod[3022]: PPP: event: 1 (Down), action: 201,
> new_state: 1 (STARTING)
> Jan  4 22:14:38 ofonod[3022]: PPP: gatchat/gatppp.c:ppp_enter_phase() 5
> Jan  4 22:14:38 ofonod[3022]: plugins/udevng.c:remove_device()
> /sys/devices/virtual/net/ppp0
> Jan  4 22:14:38 ofonod[3022]: plugins/udev.c:udev_event() subsystem net r=
emove
> Jan  4 22:14:38 ofonod[3022]: plugins/udev.c:remove_modem()
> /devices/virtual/net/ppp0
> Jan  4 22:14:38 ofonod[3022]: plugins/udev.c:udev_event() subsystem net f=
inished
> Jan  4 22:14:38 ofonod[3022]: PPP: lcp: pppcp_process_terminate_ack:
> current state 4:CLOSING
> Jan  4 22:14:38 ofonod[3022]: PPP: lcp: pppcp_generate_event: current
> state 4:CLOSING
> Jan  4 22:14:38 ofonod[3022]: PPP: event: 11 (RTA), action: 802,
> new_state: 2 (CLOSED)
> Jan  4 22:14:38 ofonod[3022]: PPP: lcp: pppcp_this_layer_finished:
> current state 2:CLOSED
> Jan  4 22:14:38 ofonod[3022]: PPP: gatchat/gatppp.c:ppp_enter_phase() 0
> Jan  4 22:14:38 ofonod[3022]: PPP: gatchat/gatppp.c:ppp_dead()
> Jan  4 22:14:38 ofonod[3022]: src/gprs.c:assign_context()
> Jan  4 22:14:38 ofonod[3022]: src/gprs.c:assign_context()
> gprs[0x557f80] context_driver[0x556a40]
> Jan  4 22:14:38 ofonod[3022]:
> drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
> Jan  4 22:14:38 ofonod[3022]: Modem:>  AT+CGDCONT=3D1,"IP","test"\r
> Jan  4 22:14:39 ofonod[3022]: PCUI:<  \r\n^RSSI:17\r\n
> Jan  4 22:14:40 ofonod[3022]: PCUI:<  \r\n^MODE:5,4\r\n
> Jan  4 22:14:40 ofonod[3022]: Modem:<  \r\nNO CARRIER\r\n
> Jan  4 22:14:40 ofonod[3022]:
> drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 0
> Jan  4 22:14:40 ofonod[3022]: src/gprs.c:pri_activate_callback() 0x55dc88
> Jan  4 22:14:40 ofonod[3022]: src/gprs.c:pri_activate_callback()
> Activating context failed with error: Unknown error type
>

It does indeed sound like oFono is not waiting for the final response, =

in this case a 'NO CARRIER'.  Can you try a highly experimental patch =

(attached) and tell me if something along these lines would work for =

your case?

Regards,
-Denis



--===============6574117615417765525==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-gprs-experimental-no-carrier-fix.patch"

PkZyb20gZWMwNzk4NjQzY2FkOTRjNWYzMzdjODkxZmU3NDQ3MDAzNjEzY2E1NCBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogRGVuaXMgS2VuemlvciA8ZGVua2VuekBnbWFpbC5jb20+CkRh
dGU6IFdlZCwgNSBTZXAgMjAxMiAxNDo0MDowNiAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIGdwcnM6
IGV4cGVyaW1lbnRhbCBubyBjYXJyaWVyIGZpeAoKLS0tCiBkcml2ZXJzL2F0bW9kZW0vZ3Bycy1j
b250ZXh0LmMgfCAgIDIxICsrKysrKysrKysrKysrKy0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAx
NSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRt
b2RlbS9ncHJzLWNvbnRleHQuYyBiL2RyaXZlcnMvYXRtb2RlbS9ncHJzLWNvbnRleHQuYwppbmRl
eCAzNjk0YzI3Li40ZDVlZDkxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2F0bW9kZW0vZ3Bycy1jb250
ZXh0LmMKKysrIGIvZHJpdmVycy9hdG1vZGVtL2dwcnMtY29udGV4dC5jCkBAIC0xMTAsNiArMTEw
LDE5IEBAIHN0YXRpYyB2b2lkIHBwcF9kaXNjb25uZWN0KEdBdFBQUERpc2Nvbm5lY3RSZWFzb24g
cmVhc29uLCBncG9pbnRlciB1c2VyX2RhdGEpCiAJZ19hdF9wcHBfdW5yZWYoZ2NkLT5wcHApOwog
CWdjZC0+cHBwID0gTlVMTDsKIAorCS8qCisJICogSWYgdGhlIGNoYW5uZWwgb2YgZ2NkLT5jaGF0
IGlzIE5VTEwsIGl0IG1pZ2h0IGNhdXNlCisJICogZ3Byc19jb250ZXh0X3JlbW92ZSBnZXQgY2Fs
bGVkIGFuZCB0aGUgZ3BycyBjb250ZXh0IHdpbGwgYmUKKwkgKiByZW1vdmVkLgorCSAqLworCWdf
YXRfY2hhdF9yZXN1bWUoZ2NkLT5jaGF0KTsKK30KKworc3RhdGljIHZvaWQgbm9fY2Fycmllcl9u
b3RpZnkoR0F0UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0YSkKK3sKKwlzdHJ1Y3Qg
b2Zvbm9fZ3Byc19jb250ZXh0ICpnYyA9IHVzZXJfZGF0YTsKKwlzdHJ1Y3QgZ3Byc19jb250ZXh0
X2RhdGEgKmdjZCA9IG9mb25vX2dwcnNfY29udGV4dF9nZXRfZGF0YShnYyk7CisKIAlzd2l0Y2gg
KGdjZC0+c3RhdGUpIHsKIAljYXNlIFNUQVRFX0VOQUJMSU5HOgogCQlDQUxMQkFDS19XSVRIX0ZB
SUxVUkUoZ2NkLT5jYiwgZ2NkLT5jYl9kYXRhKTsKQEAgLTEyNCwxMiArMTM3LDYgQEAgc3RhdGlj
IHZvaWQgcHBwX2Rpc2Nvbm5lY3QoR0F0UFBQRGlzY29ubmVjdFJlYXNvbiByZWFzb24sIGdwb2lu
dGVyIHVzZXJfZGF0YSkKIAogCWdjZC0+YWN0aXZlX2NvbnRleHQgPSAwOwogCWdjZC0+c3RhdGUg
PSBTVEFURV9JRExFOwotCS8qCi0JICogSWYgdGhlIGNoYW5uZWwgb2YgZ2NkLT5jaGF0IGlzIE5V
TEwsIGl0IG1pZ2h0IGNhdXNlCi0JICogZ3Byc19jb250ZXh0X3JlbW92ZSBnZXQgY2FsbGVkIGFu
ZCB0aGUgZ3BycyBjb250ZXh0IHdpbGwgYmUKLQkgKiByZW1vdmVkLgotCSAqLwotCWdfYXRfY2hh
dF9yZXN1bWUoZ2NkLT5jaGF0KTsKIH0KIAogc3RhdGljIGdib29sZWFuIHNldHVwX3BwcChzdHJ1
Y3Qgb2Zvbm9fZ3Byc19jb250ZXh0ICpnYykKQEAgLTM2Myw2ICszNzAsOCBAQCBzdGF0aWMgaW50
IGF0X2dwcnNfY29udGV4dF9wcm9iZShzdHJ1Y3Qgb2Zvbm9fZ3Byc19jb250ZXh0ICpnYywKIAkJ
cmV0dXJuIDA7CiAKIAlnX2F0X2NoYXRfcmVnaXN0ZXIoY2hhdCwgIitDR0VWOiIsIGNnZXZfbm90
aWZ5LCBGQUxTRSwgZ2MsIE5VTEwpOworCWdfYXRfY2hhdF9yZWdpc3RlcihjaGF0LCAiTk8gQ0FS
UklFUiIsIG5vX2NhcnJpZXJfbm90aWZ5LAorCQkJCUZBTFNFLCBnYywgTlVMTCk7CiAKIAlyZXR1
cm4gMDsKIH0KLS0gCjEuNy44LjYKCg==

--===============6574117615417765525==--

