Content-Type: multipart/mixed; boundary="===============7208385368326538911=="
MIME-Version: 1.0
From: Frederik Lotter <frederik.lotter@mixtelematics.com>
Subject: Controlling GPRS connections through Ofono in the presence of Connman
Date: Tue, 15 Jul 2014 09:03:05 +0200
Message-ID: <CAEM=xjhG8cOzfYJMPPegFD+15kVXtH1uUxzApXocqFCsNrdKvQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7208385368326538911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I am working on uBlox support in Ofono. My aim is further than the
traditional desktop type use case, so I am extending Ofono with a custom
APN provisioning service.

I want to get some tips on how I should proceed because I do not wish to go
into an unintentional direction.

We have 3rd party software that needs to finely control the GPRS session,
constantly monitoring and switching APN's as the network changes.

I need a way for our software to know when the context has successfully
been activated, for example a post_context_activate() in the driver would
be great, so that I could add a DBUS message in our custom driver which
send states to our software in order to know when a socket could be opened
(not only the post_context_activate() but I also need the other states the
driver will enter).

Is there a better approach than adding a callback for successful context
activation in the driver, in Ofono? I feel like Connman is too distant and
unaware of detailed Ofono states to manage this on the Connman side.

Secondly, I have tested changing states on the Ofono side with the Python
scripts (enable -> online ) and visa versa and connman seems OK with me
doing this. I plan to do this from my 3rd party application to manage APNs
and sockets. Is this an acceptable use case with Connman, it seems like it
has been designed so that Connman always gets updates on Ofono state
changes.

Kind Regards,
Frederik Lotter

--===============7208385368326538911==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGksPGRpdj48YnI+PC9kaXY+PGRpdj5JIGFtIHdvcmtpbmcgb24gdUJs
b3ggc3VwcG9ydCBpbiBPZm9uby4gTXkgYWltIGlzIGZ1cnRoZXIgdGhhbiB0aGUgdHJhZGl0aW9u
YWwgZGVza3RvcCB0eXBlIHVzZSBjYXNlLCBzbyBJIGFtIGV4dGVuZGluZyBPZm9ubyB3aXRoIGEg
Y3VzdG9tIEFQTiBwcm92aXNpb25pbmcgc2VydmljZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj4KPGRp
dj5JIHdhbnQgdG8gZ2V0IHNvbWUgdGlwcyBvbiBob3cgSSBzaG91bGQgcHJvY2VlZCBiZWNhdXNl
IEkgZG8gbm90IHdpc2ggdG8gZ28gaW50byBhbiB1bmludGVudGlvbmFsIGRpcmVjdGlvbi48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PldlIGhhdmUgM3JkIHBhcnR5IHNvZnR3YXJlIHRoYXQgbmVl
ZHMgdG8gZmluZWx5IGNvbnRyb2wgdGhlIEdQUlMgc2Vzc2lvbiwgY29uc3RhbnRseSBtb25pdG9y
aW5nIGFuZCBzd2l0Y2hpbmcgQVBOJiMzOTtzIGFzIHRoZSBuZXR3b3JrIGNoYW5nZXMuwqA8L2Rp
dj4KPGRpdj48YnI+PC9kaXY+PGRpdj5JIG5lZWQgYSB3YXkgZm9yIG91ciBzb2Z0d2FyZSB0byBr
bm93IHdoZW4gdGhlIGNvbnRleHQgaGFzIHN1Y2Nlc3NmdWxseSBiZWVuIGFjdGl2YXRlZCwgZm9y
IGV4YW1wbGUgYSBwb3N0X2NvbnRleHRfYWN0aXZhdGUoKSBpbiB0aGUgZHJpdmVyIHdvdWxkIGJl
IGdyZWF0LCBzbyB0aGF0IEkgY291bGQgYWRkIGEgREJVUyBtZXNzYWdlIGluIG91ciBjdXN0b20g
ZHJpdmVyIHdoaWNoIHNlbmQgc3RhdGVzIHRvIG91ciBzb2Z0d2FyZSBpbiBvcmRlciB0byBrbm93
IHdoZW4gYSBzb2NrZXQgY291bGQgYmUgb3BlbmVkIChub3Qgb25seSB0aGUgcG9zdF9jb250ZXh0
X2FjdGl2YXRlKCkgYnV0IEkgYWxzbyBuZWVkIHRoZSBvdGhlciBzdGF0ZXMgdGhlIGRyaXZlciB3
aWxsIGVudGVyKS7CoDwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2PklzIHRoZXJlIGEgYmV0dGVy
IGFwcHJvYWNoIHRoYW4gYWRkaW5nIGEgY2FsbGJhY2sgZm9yIHN1Y2Nlc3NmdWwgY29udGV4dCBh
Y3RpdmF0aW9uIGluIHRoZSBkcml2ZXIsIGluIE9mb25vPyBJIGZlZWwgbGlrZSBDb25ubWFuIGlz
IHRvbyBkaXN0YW50IGFuZCB1bmF3YXJlIG9mIGRldGFpbGVkIE9mb25vIHN0YXRlcyB0byBtYW5h
Z2UgdGhpcyBvbiB0aGUgQ29ubm1hbiBzaWRlLsKgPC9kaXY+CjxkaXY+PGJyPjwvZGl2PjxkaXY+
U2Vjb25kbHksIEkgaGF2ZSB0ZXN0ZWQgY2hhbmdpbmcgc3RhdGVzIG9uIHRoZSBPZm9ubyBzaWRl
IHdpdGggdGhlIFB5dGhvbiBzY3JpcHRzIChlbmFibGUgLSZndDsgb25saW5lICkgYW5kIHZpc2Eg
dmVyc2EgYW5kIGNvbm5tYW4gc2VlbXMgT0sgd2l0aCBtZSBkb2luZyB0aGlzLiBJIHBsYW4gdG8g
ZG8gdGhpcyBmcm9tIG15IDNyZCBwYXJ0eSBhcHBsaWNhdGlvbiB0byBtYW5hZ2UgQVBOcyBhbmQg
c29ja2V0cy4gSXMgdGhpcyBhbiBhY2NlcHRhYmxlIHVzZSBjYXNlIHdpdGggQ29ubm1hbiwgaXQg
c2VlbXMgbGlrZSBpdCBoYXMgYmVlbiBkZXNpZ25lZCBzbyB0aGF0IENvbm5tYW4gYWx3YXlzIGdl
dHMgdXBkYXRlcyBvbiBPZm9ubyBzdGF0ZSBjaGFuZ2VzLjwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48
ZGl2PktpbmQgUmVnYXJkcyw8L2Rpdj48ZGl2PkZyZWRlcmlrIExvdHRlcjwvZGl2PjwvZGl2Pgo=

--===============7208385368326538911==--

