Content-Type: multipart/mixed; boundary="===============1302938073605237583=="
MIME-Version: 1.0
From: Arun.Ravindran@elektrobit.com
Subject: Implementing support for a  new modem- how to?
Date: Wed, 25 Aug 2010 11:39:54 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA8029A85B1@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1302938073605237583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi All,

We are working with this type of modem,  and would like to submit
patches to oFono. We found that we have to make few modifications to
some of the AT command responses and also may have to introduce to
support for a few new commands. =


We found that in network registration sms, call meter and gprs there are
few AT command responses which differ from what is available in the
generic AT modem of ofono. There are few new commands to be supported in
network registration, gprs context etc, in order to support this modem.

Do we need write new atom drivers even though the change is only in one
of the AT command response?, or can we use the vendor variable (where
ever available) to include this, as part of the generic at modem
drivers?

What is the recommended way to implement support for such a modem, so
that we can start submitting patches?

------------------------------------------------------------------------
---------------------

Regards
Arun Ravindran
Specialist, Elektrobit OYJ
Keilasatama 5, Espoo
M: +358403445507



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============1302938073605237583==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDMuMi8vRU4iPgo8SFRNTD4K
PEhFQUQ+CjxNRVRBIEhUVFAtRVFVSVY9IkNvbnRlbnQtVHlwZSIgQ09OVEVOVD0idGV4dC9odG1s
OyBjaGFyc2V0PXVzLWFzY2lpIj4KPE1FVEEgTkFNRT0iR2VuZXJhdG9yIiBDT05URU5UPSJNUyBF
eGNoYW5nZSBTZXJ2ZXIgdmVyc2lvbiA2LjUuNzY1NC4xMiI+CjxUSVRMRT5JbXBsZW1lbnRpbmcg
c3VwcG9ydCBmb3IgYSAgbmV3IG1vZGVtLSBob3cgdG8/PC9USVRMRT4KPC9IRUFEPgo8Qk9EWT4K
PCEtLSBDb252ZXJ0ZWQgZnJvbSB0ZXh0L3J0ZiBmb3JtYXQgLS0+CjxCUj4KCjxQPjxTUEFOIExB
Tkc9ImZpIj48Rk9OVCBTSVpFPTIgRkFDRT0iQXJpYWwiPkhpIEFsbCw8L0ZPTlQ+PC9TUEFOPgo8
L1A+Cgo8UD48U1BBTiBMQU5HPSJmaSI+PEZPTlQgU0laRT0yIEZBQ0U9IkFyaWFsIj5XZSBhcmUg
d29ya2luZyB3aXRoIHRoaXMgdHlwZSBvZiBtb2RlbSwmbmJzcDsgYW5kIHdvdWxkIGxpa2UgdG8g
c3VibWl0IHBhdGNoZXMgdG8gb0Zvbm8uIFdlIGZvdW5kIHRoYXQgd2UgaGF2ZSB0byBtYWtlIGZl
dyBtb2RpZmljYXRpb25zIHRvIHNvbWUgb2YgdGhlIEFUIGNvbW1hbmQgcmVzcG9uc2VzIGFuZCBh
bHNvIG1heSBoYXZlIHRvIGludHJvZHVjZSB0byBzdXBwb3J0IGZvciBhIGZldyBuZXcgY29tbWFu
ZHMuIDwvRk9OVD48L1NQQU4+PC9QPgoKPFA+PFNQQU4gTEFORz0iZmkiPjxGT05UIFNJWkU9MiBG
QUNFPSJBcmlhbCI+V2UgZm91bmQgdGhhdCBpbiBuZXR3b3JrIHJlZ2lzdHJhdGlvbiBzbXMsIGNh
bGwgbWV0ZXIgYW5kIGdwcnMgdGhlcmUgYXJlIGZldyBBVCBjb21tYW5kIHJlc3BvbnNlcyB3aGlj
aCBkaWZmZXIgZnJvbSB3aGF0IGlzIGF2YWlsYWJsZSBpbiB0aGUgZ2VuZXJpYyBBVCBtb2RlbSBv
ZiBvZm9uby4gVGhlcmUgYXJlIGZldyBuZXcgY29tbWFuZHMgdG8gYmUgc3VwcG9ydGVkIGluIG5l
dHdvcmsgcmVnaXN0cmF0aW9uLCBncHJzIGNvbnRleHQgZXRjLCBpbiBvcmRlciB0byBzdXBwb3J0
IHRoaXMgbW9kZW0uPC9GT05UPjwvU1BBTj48L1A+Cgo8UD48U1BBTiBMQU5HPSJmaSI+PEZPTlQg
U0laRT0yIEZBQ0U9IkFyaWFsIj5EbyB3ZSBuZWVkIHdyaXRlIG5ldyBhdG9tIGRyaXZlcnMgZXZl
biB0aG91Z2ggdGhlIGNoYW5nZSBpcyBvbmx5IGluIG9uZSBvZiB0aGUgQVQgY29tbWFuZCByZXNw
b25zZT8sIG9yIGNhbiB3ZSB1c2UgdGhlIHZlbmRvciB2YXJpYWJsZSAod2hlcmUgZXZlciBhdmFp
bGFibGUpIHRvIGluY2x1ZGUgdGhpcywgYXMgcGFydCBvZiB0aGUgZ2VuZXJpYyBhdCBtb2RlbSBk
cml2ZXJzPzwvRk9OVD48L1NQQU4+PC9QPgoKPFA+PFNQQU4gTEFORz0iZmkiPjxGT05UIFNJWkU9
MiBGQUNFPSJBcmlhbCI+V2hhdCBpcyB0aGUgcmVjb21tZW5kZWQgd2F5IHRvIGltcGxlbWVudCBz
dXBwb3J0IGZvciBzdWNoIGEgbW9kZW0sIHNvIHRoYXQgd2UgY2FuIHN0YXJ0IHN1Ym1pdHRpbmcg
cGF0Y2hlcz88L0ZPTlQ+PC9TUEFOPgo8L1A+Cgo8UD48Qj48ST48U1BBTiBMQU5HPSJmaSI+PEZP
TlQgQ09MT1I9IiMwMDAwRkYiIEZBQ0U9IkFyaWFsIj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS08L0ZPTlQ+PC9TUEFOPjwvST48L0I+CjwvUD4KCjxQPjxCPjxJPjxTUEFOIExB
Tkc9ImZpIj48Rk9OVCBDT0xPUj0iIzAwMDBGRiIgRkFDRT0iQXJpYWwiPlJlZ2FyZHM8L0ZPTlQ+
PC9TUEFOPjwvST48L0I+Cgo8QlI+PEI+PEk+PFNQQU4gTEFORz0iZmkiPjxGT05UIENPTE9SPSIj
MDAwMEZGIiBGQUNFPSJBcmlhbCI+QXJ1biBSYXZpbmRyYW48L0ZPTlQ+PC9TUEFOPjwvST48L0I+
Cgo8QlI+PEI+PEk+PFNQQU4gTEFORz0iZmkiPjxGT05UIENPTE9SPSIjMDAwMEZGIiBGQUNFPSJB
cmlhbCI+U3BlY2lhbGlzdCwgRWxla3Ryb2JpdCBPWUo8L0ZPTlQ+PC9TUEFOPjwvST48L0I+Cgo8
QlI+PEI+PEk+PFNQQU4gTEFORz0iZmkiPjxGT05UIENPTE9SPSIjMDAwMEZGIiBGQUNFPSJBcmlh
bCI+S2VpbGFzYXRhbWEgNSwgRXNwb288L0ZPTlQ+PC9TUEFOPjwvST48L0I+Cgo8QlI+PEI+PEk+
PFNQQU4gTEFORz0iZmkiPjxGT05UIENPTE9SPSIjMDAwMEZGIiBGQUNFPSJBcmlhbCI+TTogKzM1
ODQwMzQ0NTUwNzwvRk9OVD48L1NQQU4+PC9JPjwvQj48ST48U1BBTiBMQU5HPSJmaSI+PC9TUEFO
PjwvST48U1BBTiBMQU5HPSJmaSI+PC9TUEFOPjxTUEFOIExBTkc9ImVuLXVzIj48L1NQQU4+Cjwv
UD4KCjxwcmU+Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KUGxlYXNlIG5vdGU6IFRoaXMgZS1tYWlsIG1heSBjb250YWluIGNv
bmZpZGVudGlhbCBpbmZvcm1hdGlvbgppbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSBhZGRyZXNzZWUu
IElmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMKZS1tYWlsIGluIGVycm9yLCBwbGVhc2UgZG8gbm90
IGRpc2Nsb3NlIGl0IHRvIGFueW9uZSwgbm90aWZ5CnRoZSBzZW5kZXIgcHJvbXB0bHksIGFuZCBk
ZWxldGUgdGhlIG1lc3NhZ2UgZnJvbSB5b3VyIHN5c3RlbS4KVGhhbmsgeW91Lgo8L3ByZT4KCjxw
cmU+Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KUGxlYXNlIG5vdGU6IFRoaXMgZS1tYWlsIG1heSBjb250YWluIGNvbmZpZGVu
dGlhbCBpbmZvcm1hdGlvbgppbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSBhZGRyZXNzZWUuIElmIHlv
dSBoYXZlIHJlY2VpdmVkIHRoaXMKZS1tYWlsIGluIGVycm9yLCBwbGVhc2UgZG8gbm90IGRpc2Ns
b3NlIGl0IHRvIGFueW9uZSwgbm90aWZ5CnRoZSBzZW5kZXIgcHJvbXB0bHksIGFuZCBkZWxldGUg
dGhlIG1lc3NhZ2UgZnJvbSB5b3VyIHN5c3RlbS4KVGhhbmsgeW91Lgo8L3ByZT4KCjwvQk9EWT4K
PC9IVE1MPg==
--===============1302938073605237583==--

