Content-Type: multipart/mixed; boundary="===============0583023682163802561=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: commit d37c22be20c83cf370638a9bad243bc5219c5509
Date: Sun, 23 Sep 2018 05:04:49 +0200
Message-ID: <CAKSBH7EX2KRX0ATKGT6BjnPfcxdj+gqw_WuqY_jtvuc60-TRmg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0583023682163802561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear Denis, Marcel,

was it necessary to remove entirely the NEED_THREADS flag?

I was going to use it in the Gemalto driver, to speed up the device
recognition, because for some modules it is hit and miss.
But only as an optional feature, because in some systems it might be
missing.

Also, for some high-speed modems which take long to boot, there is a
potential critical race in the recognition that the use threads can solve
easily. The alternative is to increase the internal timers a lot.

I likely need to add a new flag for it.

Best Regards,
Giacinto

--===============0583023682163802561==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+RGVhciBEZW5pcywgTWFyY2VsLDxkaXY+PGJyPjwvZGl2PjxkaXY+d2Fz
IGl0IG5lY2Vzc2FyeSB0byByZW1vdmUgZW50aXJlbHkgdGhlIE5FRURfVEhSRUFEUyBmbGFnPzwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSB3YXMgZ29pbmcgdG8gdXNlIGl0IGluIHRoZSBHZW1h
bHRvIGRyaXZlciwgdG8gc3BlZWQgdXAgdGhlIGRldmljZSByZWNvZ25pdGlvbiwgYmVjYXVzZSBm
b3Igc29tZSBtb2R1bGVzIGl0IGlzIGhpdCBhbmQgbWlzcy48L2Rpdj48ZGl2PkJ1dCBvbmx5IGFz
IGFuIG9wdGlvbmFsIGZlYXR1cmUsIGJlY2F1c2UgaW4gc29tZSBzeXN0ZW1zIGl0IG1pZ2h0IGJl
IG1pc3NpbmcuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BbHNvLCBmb3Igc29tZSBoaWdoLXNw
ZWVkIG1vZGVtcyB3aGljaCB0YWtlIGxvbmcgdG8gYm9vdCwgdGhlcmUgaXMgYSBwb3RlbnRpYWwg
Y3JpdGljYWwgcmFjZSBpbiB0aGUgcmVjb2duaXRpb24gdGhhdCB0aGUgdXNlIHRocmVhZHMgY2Fu
IHNvbHZlIGVhc2lseS4gVGhlIGFsdGVybmF0aXZlIGlzIHRvIGluY3JlYXNlIHRoZSBpbnRlcm5h
bCB0aW1lcnMgYSBsb3QuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGxpa2VseSBuZWVkIHRv
IGFkZCBhIG5ldyBmbGFnIGZvciBpdC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkJlc3QgUmVn
YXJkcyw8L2Rpdj48ZGl2PkdpYWNpbnRvPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+Cg==

--===============0583023682163802561==--

