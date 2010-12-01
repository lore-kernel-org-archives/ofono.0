Content-Type: multipart/mixed; boundary="===============1268200875711193976=="
MIME-Version: 1.0
From: Sankar <gsankar.gs@gmail.com>
Subject: Need Clarification on DCS handling in Status Report for SMS
Date: Wed, 01 Dec 2010 19:25:08 +0530
Message-ID: <AANLkTi=6dWWZXF_rdUy1adGYu4oFX-YUtsvcpTUww33Z@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1268200875711193976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

While doing a code reading for ofono SMS, it is observed that there seems to
be an issue with the way DCS is handled for SMS status report notify.

In the decode SMS function, there is a check to find out if there is a PI
(parameter identifier). If there is a PI and no DCS flag set, then the ofono
core sets the dcs to default. If the PI itself is missing in the PDU
received from the network, then the dcs values are not set to default.

This seems to cause a problem, where, the decoding of dcs fails, and results
in not sending the delivery notification to clients.

Can some one please comment on this.

Thanks,
Sankar.

--===============1268200875711193976==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGksPGJyPjxicj5XaGlsZSBkb2luZyBhIGNvZGUgcmVhZGluZyBmb3Igb2Zvbm8gU01TLCBpdCBp
cyBvYnNlcnZlZCB0aGF0IHRoZXJlIHNlZW1zIHRvIGJlIGFuIGlzc3VlIHdpdGggdGhlIHdheSBE
Q1MgaXMgaGFuZGxlZCBmb3IgU01TIHN0YXR1cyByZXBvcnQgbm90aWZ5Ljxicj48YnI+SW4gdGhl
IGRlY29kZSBTTVMgZnVuY3Rpb24sIHRoZXJlIGlzIGEgY2hlY2sgdG8gZmluZCBvdXQgaWYgdGhl
cmUgaXMgYSBQSSAocGFyYW1ldGVyIGlkZW50aWZpZXIpLiBJZiB0aGVyZSBpcyBhIFBJIGFuZCBu
byBEQ1MgZmxhZyBzZXQsIHRoZW4gdGhlIG9mb25vIGNvcmUgc2V0cyB0aGUgZGNzIHRvIGRlZmF1
bHQuIElmIHRoZSBQSSBpdHNlbGYgaXMgbWlzc2luZyBpbiB0aGUgUERVIHJlY2VpdmVkIGZyb20g
dGhlIG5ldHdvcmssIHRoZW4gdGhlIGRjcyB2YWx1ZXMgYXJlIG5vdCBzZXQgdG8gZGVmYXVsdC48
YnI+Cjxicj5UaGlzIHNlZW1zIHRvIGNhdXNlIGEgcHJvYmxlbSwgd2hlcmUsIHRoZSBkZWNvZGlu
ZyBvZiBkY3MgZmFpbHMsIGFuZCByZXN1bHRzIGluIG5vdCBzZW5kaW5nIHRoZSBkZWxpdmVyeSBu
b3RpZmljYXRpb24gdG8gY2xpZW50cy48YnI+PGJyPkNhbiBzb21lIG9uZSBwbGVhc2UgY29tbWVu
dCBvbiB0aGlzLjxicj48YnI+VGhhbmtzLDxicj5TYW5rYXIuPGJyPgo=

--===============1268200875711193976==--

