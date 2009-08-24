Content-Type: multipart/mixed; boundary="===============3632060463560648397=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Read messages left over in ME storage on startup.
Date: Mon, 24 Aug 2009 18:32:04 -0500
Message-ID: <9b1cac640908241632n6584836eu9cf59091124295ee@mail.gmail.com>
In-Reply-To: <1250908524-10518-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3632060463560648397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Aug 21, 2009 at 9:35 PM, Andrzej Zaborowski <
andrew.zaborowski@intel.com> wrote:

> On modems that don't support +CMT (or for class 2 SMSes) the messages are
> stored in the modem and then read and deleted from there in two separate
> steps with no warranty that deletion succeeds or (more likely) power is
> cut before the deletion happens.  Over time the memory may become full
> and if we don't want to deal with this condition we need to check on
> startup if there are messages we haven't deleted.
>
> We can't differentiate between those messages and those the user already
> had on the SIM / modem before installing ofono or switching phones, so we
> might want to deliver messages with REC READ status with some kind of
> indication that these are potentially old so the UI doesn't emit spurious
> alerts.  We don't do this now and just deliver as usual.


So the patch isn't going to work as intended.  See below for exact reasons:

+               hexpdu =3D g_at_result_pdu(result);


You can't use g_at_result_pdu on messages that haven't been flagged to
expect a PDU.  Right now this only works for g_at_chat_register style
unsolicited notifications for which the 'expect_pdu' has been set to TRUE.


> +
> +       g_at_chat_send(at->parser, "AT+CMGL=3D4", cmgl_prefix,
> +                       at_cmgl_cb, modem, NULL);


Again, this is actually filtering anything that doesn't start with a prefix
in the list given by cmgl_prefix.  Namely anything that doesn't start with
+CMGL: or is a known final response gets filtered out.

One way to go would be to use NULL for cmgl_prefix and update the parse loop
in the callback accordingly.  However, this means that the entire response
will be waited on and given once.

It might be worthwhile to support CMGL listings using something similar to
g_at_chat_send_listing.


>        ofono_sms_manager_register(modem, &ops);
> +
> +       /* Inspect and free the incoming SMS storage */
> +       if (at->sms->incoming =3D=3D MT_STORE)
> +               at_cmgl_set_cpms(modem, ME_STORE);
> +       else
> +               at_cmgl_set_cpms(modem, at->sms->incoming);
>  }


It might be worth to scan both ME & SM stores.  Especially since MT
literally means combined SM + ME store.

Regards,
-Denis

--===============3632060463560648397==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgQW5kcmV3LDxicj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIEZyaSwgQXVnIDIx
LCAyMDA5IGF0IDk6MzUgUE0sIEFuZHJ6ZWogWmFib3Jvd3NraSA8c3BhbiBkaXI9Imx0ciI+Jmx0
OzxhIGhyZWY9Im1haWx0bzphbmRyZXcuemFib3Jvd3NraUBpbnRlbC5jb20iPmFuZHJldy56YWJv
cm93c2tpQGludGVsLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleDsiPgpPbiBtb2RlbXMgdGhhdCBkb24mIzM5O3Qg
c3VwcG9ydCArQ01UIChvciBmb3IgY2xhc3MgMiBTTVNlcykgdGhlIG1lc3NhZ2VzIGFyZTxicj4K
c3RvcmVkIGluIHRoZSBtb2RlbSBhbmQgdGhlbiByZWFkIGFuZCBkZWxldGVkIGZyb20gdGhlcmUg
aW4gdHdvIHNlcGFyYXRlPGJyPgpzdGVwcyB3aXRoIG5vIHdhcnJhbnR5IHRoYXQgZGVsZXRpb24g
c3VjY2VlZHMgb3IgKG1vcmUgbGlrZWx5KSBwb3dlciBpczxicj4KY3V0IGJlZm9yZSB0aGUgZGVs
ZXRpb24gaGFwcGVucy4goE92ZXIgdGltZSB0aGUgbWVtb3J5IG1heSBiZWNvbWUgZnVsbDxicj4K
YW5kIGlmIHdlIGRvbiYjMzk7dCB3YW50IHRvIGRlYWwgd2l0aCB0aGlzIGNvbmRpdGlvbiB3ZSBu
ZWVkIHRvIGNoZWNrIG9uPGJyPgpzdGFydHVwIGlmIHRoZXJlIGFyZSBtZXNzYWdlcyB3ZSBoYXZl
biYjMzk7dCBkZWxldGVkLjxicj4KPGJyPgpXZSBjYW4mIzM5O3QgZGlmZmVyZW50aWF0ZSBiZXR3
ZWVuIHRob3NlIG1lc3NhZ2VzIGFuZCB0aG9zZSB0aGUgdXNlciBhbHJlYWR5PGJyPgpoYWQgb24g
dGhlIFNJTSAvIG1vZGVtIGJlZm9yZSBpbnN0YWxsaW5nIG9mb25vIG9yIHN3aXRjaGluZyBwaG9u
ZXMsIHNvIHdlPGJyPgptaWdodCB3YW50IHRvIGRlbGl2ZXIgbWVzc2FnZXMgd2l0aCBSRUMgUkVB
RCBzdGF0dXMgd2l0aCBzb21lIGtpbmQgb2Y8YnI+CmluZGljYXRpb24gdGhhdCB0aGVzZSBhcmUg
cG90ZW50aWFsbHkgb2xkIHNvIHRoZSBVSSBkb2VzbiYjMzk7dCBlbWl0IHNwdXJpb3VzPGJyPgph
bGVydHMuIKBXZSBkb24mIzM5O3QgZG8gdGhpcyBub3cgYW5kIGp1c3QgZGVsaXZlciBhcyB1c3Vh
bC48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5TbyB0aGUgcGF0Y2ggaXNuJiMzOTt0
IGdvaW5nIHRvIHdvcmsgYXMgaW50ZW5kZWQuIKBTZWUgYmVsb3cgZm9yIGV4YWN0IHJlYXNvbnM6
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1s
ZWZ0OjFleDsiPgorIKAgoCCgIKAgoCCgIKAgaGV4cGR1ID0gZ19hdF9yZXN1bHRfcGR1KHJlc3Vs
dCk7PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+WW91IGNhbiYjMzk7dCB1c2UgZ19h
dF9yZXN1bHRfcGR1IG9uIG1lc3NhZ2VzIHRoYXQgaGF2ZW4mIzM5O3QgYmVlbiBmbGFnZ2VkIHRv
IGV4cGVjdCBhIFBEVS4goFJpZ2h0IG5vdyB0aGlzIG9ubHkgd29ya3MgZm9yIGdfYXRfY2hhdF9y
ZWdpc3RlciBzdHlsZSB1bnNvbGljaXRlZCBub3RpZmljYXRpb25zIGZvciB3aGljaCB0aGUgJiMz
OTtleHBlY3RfcGR1JiMzOTsgaGFzIGJlZW4gc2V0IHRvIFRSVUUuPC9kaXY+CjxkaXY+oDwvZGl2
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4
O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXg7Ij4rPGJyPgorIKAg
oCCgIGdfYXRfY2hhdF9zZW5kKGF0LSZndDtwYXJzZXIsICZxdW90O0FUK0NNR0w9NCZxdW90Oywg
Y21nbF9wcmVmaXgsPGJyPgorIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBhdF9jbWdsX2NiLCBtb2Rl
bSwgTlVMTCk7PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+QWdhaW4sIHRoaXMgaXMg
YWN0dWFsbHkgZmlsdGVyaW5nIGFueXRoaW5nIHRoYXQgZG9lc24mIzM5O3Qgc3RhcnQgd2l0aCBh
IHByZWZpeCBpbiB0aGUgbGlzdCBnaXZlbiBieSBjbWdsX3ByZWZpeC4goE5hbWVseSBhbnl0aGlu
ZyB0aGF0IGRvZXNuJiMzOTt0IHN0YXJ0IHdpdGggK0NNR0w6IG9yIGlzIGEga25vd24gZmluYWwg
cmVzcG9uc2UgZ2V0cyBmaWx0ZXJlZCBvdXQuPC9kaXY+CjxkaXY+PGJyPjwvZGl2PjxkaXY+T25l
IHdheSB0byBnbyB3b3VsZCBiZSB0byB1c2UgTlVMTCBmb3IgY21nbF9wcmVmaXggYW5kIHVwZGF0
ZSB0aGUgcGFyc2UgbG9vcCBpbiB0aGUgY2FsbGJhY2sgYWNjb3JkaW5nbHkuIKBIb3dldmVyLCB0
aGlzIG1lYW5zIHRoYXQgdGhlIGVudGlyZSByZXNwb25zZSB3aWxsIGJlIHdhaXRlZCBvbiBhbmQg
Z2l2ZW4gb25jZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj4KPGRpdj5JdCBtaWdodCBiZSB3b3J0aHdo
aWxlIHRvIHN1cHBvcnQgQ01HTCBsaXN0aW5ncyB1c2luZyBzb21ldGhpbmcgc2ltaWxhciB0byBn
X2F0X2NoYXRfc2VuZF9saXN0aW5nLqA8L2Rpdj48ZGl2PqA8L2Rpdj48YmxvY2txdW90ZSBjbGFz
cz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHgg
I2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4OyI+CgogoCCgIKAgoG9mb25vX3Ntc19tYW5hZ2Vy
X3JlZ2lzdGVyKG1vZGVtLCAmYW1wO29wcyk7PGJyPgorPGJyPgorIKAgoCCgIC8qIEluc3BlY3Qg
YW5kIGZyZWUgdGhlIGluY29taW5nIFNNUyBzdG9yYWdlICovPGJyPgorIKAgoCCgIGlmIChhdC0m
Z3Q7c21zLSZndDtpbmNvbWluZyA9PSBNVF9TVE9SRSk8YnI+CisgoCCgIKAgoCCgIKAgoCBhdF9j
bWdsX3NldF9jcG1zKG1vZGVtLCBNRV9TVE9SRSk7PGJyPgorIKAgoCCgIGVsc2U8YnI+CisgoCCg
IKAgoCCgIKAgoCBhdF9jbWdsX3NldF9jcG1zKG1vZGVtLCBhdC0mZ3Q7c21zLSZndDtpbmNvbWlu
Zyk7PGJyPgqgfaA8L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5JdCBtaWdodCBiZSB3
b3J0aCB0byBzY2FuIGJvdGggTUUgJmFtcDsgU00gc3RvcmVzLiCgRXNwZWNpYWxseSBzaW5jZSBN
VCBsaXRlcmFsbHkgbWVhbnMgY29tYmluZWQgU00gKyBNRSBzdG9yZS48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj4tRGVuaXM8L2Rpdj48ZGl2Pjxicj48L2Rpdj48
L2Rpdj4K

--===============3632060463560648397==--

