Content-Type: multipart/mixed; boundary="===============2692065488436570629=="
MIME-Version: 1.0
From: Etienne Mabille <mabille.etienne@gmail.com>
Subject: Telit HE910 : how to get the network interface name
Date: Tue, 21 May 2013 12:05:26 +0200
Message-ID: <CAMtf1D-1Hf+zm_tG6JnRsreNFVH6qhwXbUPR0nOVq3iq-e0EaA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2692065488436570629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I am using ofono and the Telit HE910, configured and running fine.
I am now working on a program thats monitors the connection and initiates
the reconnection when it is lost.

This program uses the network interface name : usually ppp0.
I am looking for a clean way of getting this name for the telit, and not
just hard-code it in case this name changes.

I see that in several modems (hs0 and samsung at least), this is done in
the setup_* function in udevng.c
For these modems, the NetworkInterface field is retrieved from the device.
However, in the telit documentation, it specifies that out of the seven
devices created for the modem (/dev/ttyACM0-6)
only 2 can be used : the data port for ppp connections and the generic port
for AT commands.

Is there another way of retrieving this information ?

I saw that it appears in gatchat/ppp_net.c: in the function ppp_net_new
where it submits the name "ppp%d".
My understanding is that the kernel (or pppd) fills out the number with the
first one available.
But this is general code in which we don't have access to the modem
anyway...

Thanks for your help
Best regards.

Etienne

--===============2692065488436570629==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+SGkgZXZlcnlvbmUsPGJyPjxicj48L2Rpdj5J
IGFtIHVzaW5nIG9mb25vIGFuZCB0aGUgVGVsaXQgSEU5MTAsIGNvbmZpZ3VyZWQgYW5kIHJ1bm5p
bmcgZmluZS48YnI+PC9kaXY+SSBhbSBub3cgd29ya2luZyBvbiBhIHByb2dyYW0gdGhhdHMgbW9u
aXRvcnMgdGhlIGNvbm5lY3Rpb24gYW5kIGluaXRpYXRlcyB0aGUgcmVjb25uZWN0aW9uIHdoZW4g
aXQgaXMgbG9zdC48YnI+Cjxicj5UaGlzIHByb2dyYW0gdXNlcyB0aGUgbmV0d29yayBpbnRlcmZh
Y2UgbmFtZSA6IHVzdWFsbHkgcHBwMC4gPGJyPkkgYW0gbG9va2luZyBmb3IgYSBjbGVhbiB3YXkg
b2YgZ2V0dGluZyB0aGlzIG5hbWUgZm9yIHRoZSB0ZWxpdCwgYW5kIG5vdCBqdXN0IGhhcmQtY29k
ZSBpdCBpbiBjYXNlIHRoaXMgbmFtZSBjaGFuZ2VzLjxicj48L2Rpdj48ZGl2Pjxicj5JIHNlZSB0
aGF0IGluIHNldmVyYWwgbW9kZW1zIChoczAgYW5kIHNhbXN1bmcgYXQgbGVhc3QpLCB0aGlzIGlz
IGRvbmUgaW4gdGhlIHNldHVwXyogZnVuY3Rpb24gaW4gdWRldm5nLmM8YnI+CkZvciB0aGVzZSBt
b2RlbXMsIHRoZSBOZXR3b3JrSW50ZXJmYWNlIGZpZWxkIGlzIHJldHJpZXZlZCBmcm9tIHRoZSBk
ZXZpY2UuPGJyPkhvd2V2ZXIsIGluIHRoZSB0ZWxpdCBkb2N1bWVudGF0aW9uLCBpdCBzcGVjaWZp
ZXMgdGhhdCBvdXQgb2YgdGhlIHNldmVuIGRldmljZXMgY3JlYXRlZCBmb3IgdGhlIG1vZGVtICgv
ZGV2L3R0eUFDTTAtNik8YnI+PC9kaXY+PGRpdj5vbmx5IDIgY2FuIGJlIHVzZWQgOiB0aGUgZGF0
YSBwb3J0IGZvciBwcHAgY29ubmVjdGlvbnMgYW5kIHRoZSBnZW5lcmljIHBvcnQgZm9yIEFUIGNv
bW1hbmRzLjxicj4KPC9kaXY+PGRpdj48YnI+SXMgdGhlcmUgYW5vdGhlciB3YXkgb2YgcmV0cmll
dmluZyB0aGlzIGluZm9ybWF0aW9uID8gPGJyPjxicj48L2Rpdj48ZGl2Pkkgc2F3IHRoYXQgaXQg
YXBwZWFycyBpbiBnYXRjaGF0L3BwcF9uZXQuYzogaW4gdGhlIGZ1bmN0aW9uIHBwcF9uZXRfbmV3
PGJyPjwvZGl2PjxkaXY+d2hlcmUgaXQgc3VibWl0cyB0aGUgbmFtZSAmcXVvdDtwcHAlZCZxdW90
Oy4gPGJyPgo8L2Rpdj48ZGl2Pk15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUga2VybmVsIChv
ciBwcHBkKSBmaWxscyBvdXQgdGhlIG51bWJlciB3aXRoIHRoZSBmaXJzdCBvbmUgYXZhaWxhYmxl
Ljxicj48L2Rpdj48ZGl2PkJ1dCB0aGlzIGlzIGdlbmVyYWwgY29kZSBpbiB3aGljaCB3ZSBkb24m
IzM5O3QgaGF2ZSBhY2Nlc3MgdG8gdGhlIG1vZGVtIGFueXdheS4uLjxicj48YnI+PC9kaXY+PGRp
dj4KVGhhbmtzIGZvciB5b3VyIGhlbHA8YnI+PC9kaXY+PGRpdj5CZXN0IHJlZ2FyZHMuPGJyPjxi
cj48L2Rpdj48ZGl2PkV0aWVubmU8YnI+PC9kaXY+PC9kaXY+Cg==

--===============2692065488436570629==--

