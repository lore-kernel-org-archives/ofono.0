Content-Type: multipart/mixed; boundary="===============3338141392731698639=="
MIME-Version: 1.0
From: Arun.Ravindran@elektrobit.com
Subject: Gatmux doubt and suggestion
Date: Thu, 19 Aug 2010 12:27:16 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA8029A7E46@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3338141392731698639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi All,

In mux_query_cb(), the frame size is taken as default (31 or 64). We
have a case where the default values are not accepted by the modem.

Gatmux is a generic component, and so makes all modem to use the default
values, one needs to modify the gatmux to enable for example, a larger
frame size.

Why not let the modem plug-in parse the CMUX query and decide on a
suitable configuration for enabling MUX? =


What is your opinion?


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


--===============3338141392731698639==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDMuMi8vRU4iPgo8SFRNTD4K
PEhFQUQ+CjxNRVRBIEhUVFAtRVFVSVY9IkNvbnRlbnQtVHlwZSIgQ09OVEVOVD0idGV4dC9odG1s
OyBjaGFyc2V0PXVzLWFzY2lpIj4KPE1FVEEgTkFNRT0iR2VuZXJhdG9yIiBDT05URU5UPSJNUyBF
eGNoYW5nZSBTZXJ2ZXIgdmVyc2lvbiA2LjUuNzY1NC4xMiI+CjxUSVRMRT5HYXRtdXggZG91YnQg
YW5kIHN1Z2dlc3Rpb248L1RJVExFPgo8L0hFQUQ+CjxCT0RZPgo8IS0tIENvbnZlcnRlZCBmcm9t
IHRleHQvcnRmIGZvcm1hdCAtLT4KPEJSPgoKPFA+PFNQQU4gTEFORz0iZmkiPjxGT05UIFNJWkU9
MiBGQUNFPSJBcmlhbCI+SGkgQWxsLDwvRk9OVD48L1NQQU4+CjwvUD4KCjxQPjxTUEFOIExBTkc9
ImZpIj48Rk9OVCBTSVpFPTIgRkFDRT0iQXJpYWwiPkluIG11eF9xdWVyeV9jYigpLCB0aGUgZnJh
bWUgc2l6ZSBpcyB0YWtlbiBhcyBkZWZhdWx0ICgzMSBvciA2NCkuIFdlIGhhdmUgYSBjYXNlIHdo
ZXJlIHRoZSBkZWZhdWx0IHZhbHVlcyBhcmUgbm90IGFjY2VwdGVkIGJ5IHRoZSBtb2RlbS48L0ZP
TlQ+PC9TUEFOPjwvUD4KCjxQPjxTUEFOIExBTkc9ImZpIj48Rk9OVCBTSVpFPTIgRkFDRT0iQXJp
YWwiPkdhdG11eCBpcyBhIGdlbmVyaWMgY29tcG9uZW50LCBhbmQgc28gbWFrZXMgYWxsIG1vZGVt
IHRvIHVzZSB0aGUgZGVmYXVsdCB2YWx1ZXMsIG9uZSBuZWVkcyB0byBtb2RpZnkgdGhlIGdhdG11
eCB0byBlbmFibGUgZm9yIGV4YW1wbGUsIGEgbGFyZ2VyIGZyYW1lIHNpemUuPC9GT05UPjwvU1BB
Tj48L1A+Cgo8UD48U1BBTiBMQU5HPSJlbi11cyI+PEZPTlQgU0laRT0yIEZBQ0U9IkFyaWFsIj5X
aHkgbm90IGxldCB0aGUgbW9kZW0gcGx1Zy1pbiBwYXJzZSB0aGUgQ01VWCBxdWVyeSBhbmQgZGVj
aWRlIG9uIGEgc3VpdGFibGUgY29uZmlndXJhdGlvbiBmb3IgZW5hYmxpbmcgTVVYPyA8L0ZPTlQ+
PC9TUEFOPgo8L1A+Cgo8UD48U1BBTiBMQU5HPSJlbi11cyI+PEZPTlQgU0laRT0yIEZBQ0U9IkFy
aWFsIj5XaGF0IGlzIHlvdXIgb3Bpbmlvbj88L0ZPTlQ+PC9TUEFOPgo8L1A+CjxCUj4KCjxQPjxC
PjxJPjxTUEFOIExBTkc9ImZpIj48Rk9OVCBDT0xPUj0iIzAwMDBGRiIgRkFDRT0iQXJpYWwiPi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTwvRk9OVD48L1NQQU4+PC9JPjwvQj4K
PC9QPgoKPFA+PEI+PEk+PFNQQU4gTEFORz0iZmkiPjxGT05UIENPTE9SPSIjMDAwMEZGIiBGQUNF
PSJBcmlhbCI+UmVnYXJkczwvRk9OVD48L1NQQU4+PC9JPjwvQj4KCjxCUj48Qj48ST48U1BBTiBM
QU5HPSJmaSI+PEZPTlQgQ09MT1I9IiMwMDAwRkYiIEZBQ0U9IkFyaWFsIj5BcnVuIFJhdmluZHJh
bjwvRk9OVD48L1NQQU4+PC9JPjwvQj4KCjxCUj48Qj48ST48U1BBTiBMQU5HPSJmaSI+PEZPTlQg
Q09MT1I9IiMwMDAwRkYiIEZBQ0U9IkFyaWFsIj5TcGVjaWFsaXN0LCBFbGVrdHJvYml0IE9ZSjwv
Rk9OVD48L1NQQU4+PC9JPjwvQj4KCjxCUj48Qj48ST48U1BBTiBMQU5HPSJmaSI+PEZPTlQgQ09M
T1I9IiMwMDAwRkYiIEZBQ0U9IkFyaWFsIj5LZWlsYXNhdGFtYSA1LCBFc3BvbzwvRk9OVD48L1NQ
QU4+PC9JPjwvQj4KCjxCUj48Qj48ST48U1BBTiBMQU5HPSJmaSI+PEZPTlQgQ09MT1I9IiMwMDAw
RkYiIEZBQ0U9IkFyaWFsIj5NOiArMzU4NDAzNDQ1NTA3PC9GT05UPjwvU1BBTj48L0k+PC9CPjxJ
PjxTUEFOIExBTkc9ImZpIj48L1NQQU4+PC9JPjxTUEFOIExBTkc9ImZpIj48L1NQQU4+PFNQQU4g
TEFORz0iZW4tdXMiPjwvU1BBTj4KPC9QPgoKPHByZT4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpQbGVhc2Ugbm90ZTogVGhp
cyBlLW1haWwgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uCmludGVuZGVkIHNv
bGVseSBmb3IgdGhlIGFkZHJlc3NlZS4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcwplLW1haWwg
aW4gZXJyb3IsIHBsZWFzZSBkbyBub3QgZGlzY2xvc2UgaXQgdG8gYW55b25lLCBub3RpZnkKdGhl
IHNlbmRlciBwcm9tcHRseSwgYW5kIGRlbGV0ZSB0aGUgbWVzc2FnZSBmcm9tIHlvdXIgc3lzdGVt
LgpUaGFuayB5b3UuCjwvcHJlPgoKPHByZT4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpQbGVhc2Ugbm90ZTogVGhpcyBlLW1h
aWwgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uCmludGVuZGVkIHNvbGVseSBm
b3IgdGhlIGFkZHJlc3NlZS4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcwplLW1haWwgaW4gZXJy
b3IsIHBsZWFzZSBkbyBub3QgZGlzY2xvc2UgaXQgdG8gYW55b25lLCBub3RpZnkKdGhlIHNlbmRl
ciBwcm9tcHRseSwgYW5kIGRlbGV0ZSB0aGUgbWVzc2FnZSBmcm9tIHlvdXIgc3lzdGVtLgpUaGFu
ayB5b3UuCjwvcHJlPgoKPC9CT0RZPgo8L0hUTUw+
--===============3338141392731698639==--

