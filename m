Content-Type: multipart/mixed; boundary="===============4733963534870611231=="
MIME-Version: 1.0
From: Jeevaka Prabu Badrappan <jeevakaprabu@gmail.com>
Subject: Re: [PATCH v2] Add CDMA extension tasks
Date: Wed, 25 Aug 2010 12:46:09 +0300
Message-ID: <AANLkTimtk2J5vxeXhzM01jYLjhSi+6oznBkqoX5bqodW@mail.gmail.com>
In-Reply-To: <1282646541-1655-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4733963534870611231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

---
>  TODO |   76
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 76 insertions(+), 0 deletions(-)
>
> diff --git a/TODO b/TODO
> index a97f076..b159c07 100644
> --- a/TODO
> +++ b/TODO
> @@ -614,3 +614,79 @@ Miscellaneous
>
>   Priority: Low
>   Complexity: C4
> +
> +
> +CDMA/EVDO
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- Extend modem interface with a 'Type' property to indicate the modem
> type.
> +
> +  Priority: High
> +  Complexity: C1
> +
> +- Add UIM support. UIM support change pin, enter pin, reset pin, set pin
> lock, get pin lock setting,
> +  get pin remain retry time, and get information that stored in UIM,
> include MCC/MNC, ruimid, IMSI,
> +  MDN, PRL version etc.
> +
> +  Priority: High
> +  Complexity: C4
> +
> +- Add CDMA SMS support, include broadcast short message. In CDMA,
> broadcast short message is
> +  a kind of SMS. CDMA SMS manager atom will support SMS sending and
> receiving. Many CDMA modems
> +  may only support text mode and other modems only support PDU mode. In
> CDMA SMS manage atom will
> +  define a data structure that contain every parameters and subparameters
> defined in C.S0015. In
> +  relative modem driver plug-in, the relevant fields(text mode) or PDU(m=
ay
> be manufacturer
> +  specific) will be parsed and filled into the data structure, then it
> will be proceed in CDMA
> +  SMS manager atom.
> +
> +  Special SMSs, SCPT, CATPT and voice mail notification(VMN)(please refer
> to C.S0015 section 4.3.8,
> +  4.3.9, 4.3.5)will be processed in ofono, and other messages with a port
> number (include WAP push
> +  message) will be processed by external plug-ins. CDMA SMS manager atom
> offer an API for register
> +  external plug-in.
> +
> +  Priority: High
> +  Complexity: C8
> +
> +- Add CDMA voice call support. CDMA voice call will support
> originate/end/hold a call,
> +  transfer a call, 3WC(three-way calling), conference call and DTMF. For=
 a
> voice call, can get
> +  its status, CLI and ending result(if it is end).
> +
> +  Priority: High
> +  Complexity: C6
> +
> +- Add CDMA Data connection support. CDMA data connection manager support
> start/end a data connect
> +  according to the settings from other module(upper layer or ConnMan)and
> get/set Qos.
> +
> +  Priority: High
> +  Complexity: C4
> +
> +- Add SIM/UIM data access support. Add a card atom, it will support
> read/update/delete/add conatact
> +  add SMS in SIM/UIM card.
> +
> +  Priority: High
> +  Complexity: C6
> +
> +- Add CTCC modem driver. The CTCC modem driver will totally obey <China
> Telecom CDMA terminal
> +  requirement specification -- 1xEV-DORevA Data Terminal AT command
> Interface fascicule V1.1>
> +
> +  Priority: High
> +  Complexity: C10
> +
> --
> 1.7.0.4
>
>
It looks like you are providing new dbus interface for UIM(SimManager),
DataConnection(DataConnectionManager), etc...
If so, what is the need for providing a new interface, why can't we extend
the existing SimManager, DataConnectionManager etc... to support CDMA
usecases.
If we provide new interfaces, there could be changes needed in upper layers
for eg: ConnMan.

Could you clarify?

Thanks and Regards,
jeevaka

_______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============4733963534870611231==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgQ2Fpd2VuLDxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGJyPjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjogMHB0IDBwdCAwcHQgMC44ZXg7IGJvcmRl
ci1sZWZ0OiAxcHggc29saWQgcmdiKDIwNCwgMjA0LCAyMDQpOyBwYWRkaW5nLWxlZnQ6IDFleDsi
Pi0tLTxicj4KoFRPRE8gfCCgIDc2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKzxicj4KoDEgZmlsZXMgY2hhbmdlZCwgNzYg
aW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSk8YnI+Cjxicj4KZGlmZiAtLWdpdCBhL1RPRE8g
Yi9UT0RPPGJyPgppbmRleCBhOTdmMDc2Li5iMTU5YzA3IDEwMDY0NDxicj4KLS0tIGEvVE9ETzxi
cj4KKysrIGIvVE9ETzxicj4KQEAgLTYxNCwzICs2MTQsNzkgQEAgTWlzY2VsbGFuZW91czxicj4K
PGJyPgogoCBQcmlvcml0eTogTG93PGJyPgogoCBDb21wbGV4aXR5OiBDNDxicj4KKzxicj4KKzxi
cj4KK0NETUEvRVZETzxicj4KKz09PT09PT09PTxicj4KKzxicj4KKy0gRXh0ZW5kIG1vZGVtIGlu
dGVyZmFjZSB3aXRoIGEgJiMzOTtUeXBlJiMzOTsgcHJvcGVydHkgdG8gaW5kaWNhdGUgdGhlIG1v
ZGVtIHR5cGUuPGJyPgorPGJyPgorIKBQcmlvcml0eTogSGlnaDxicj4KKyCgQ29tcGxleGl0eTog
QzE8YnI+Cis8YnI+CistIEFkZCBVSU0gc3VwcG9ydC4gVUlNIHN1cHBvcnQgY2hhbmdlIHBpbiwg
ZW50ZXIgcGluLCByZXNldCBwaW4sIHNldCBwaW4gbG9jaywgZ2V0IHBpbiBsb2NrIHNldHRpbmcs
PGJyPgorIKBnZXQgcGluIHJlbWFpbiByZXRyeSB0aW1lLCBhbmQgZ2V0IGluZm9ybWF0aW9uIHRo
YXQgc3RvcmVkIGluIFVJTSwgaW5jbHVkZSBNQ0MvTU5DLCBydWltaWQsIElNU0ksPGJyPgorIKBN
RE4sIFBSTCB2ZXJzaW9uIGV0Yy48YnI+Cis8YnI+CisgoFByaW9yaXR5OiBIaWdoPGJyPgorIKBD
b21wbGV4aXR5OiBDNDxicj4KKzxicj4KKy0gQWRkIENETUEgU01TIHN1cHBvcnQsIGluY2x1ZGUg
YnJvYWRjYXN0IHNob3J0IG1lc3NhZ2UuIEluIENETUEsIGJyb2FkY2FzdCBzaG9ydCBtZXNzYWdl
IGlzPGJyPgorIKBhIGtpbmQgb2YgU01TLiBDRE1BIFNNUyBtYW5hZ2VyIGF0b20gd2lsbCBzdXBw
b3J0IFNNUyBzZW5kaW5nIGFuZCByZWNlaXZpbmcuIE1hbnkgQ0RNQSBtb2RlbXM8YnI+CisgoG1h
eSBvbmx5IHN1cHBvcnQgdGV4dCBtb2RlIGFuZCBvdGhlciBtb2RlbXMgb25seSBzdXBwb3J0IFBE
VSBtb2RlLiBJbiBDRE1BIFNNUyBtYW5hZ2UgYXRvbSB3aWxsPGJyPgorIKBkZWZpbmUgYSBkYXRh
IHN0cnVjdHVyZSB0aGF0IGNvbnRhaW4gZXZlcnkgcGFyYW1ldGVycyBhbmQgc3VicGFyYW1ldGVy
cyBkZWZpbmVkIGluIEMuUzAwMTUuIEluPGJyPgorIKByZWxhdGl2ZSBtb2RlbSBkcml2ZXIgcGx1
Zy1pbiwgdGhlIHJlbGV2YW50IGZpZWxkcyh0ZXh0IG1vZGUpIG9yIFBEVShtYXkgYmUgbWFudWZh
Y3R1cmVyPGJyPgorIKBzcGVjaWZpYykgd2lsbCBiZSBwYXJzZWQgYW5kIGZpbGxlZCBpbnRvIHRo
ZSBkYXRhIHN0cnVjdHVyZSwgdGhlbiBpdCB3aWxsIGJlIHByb2NlZWQgaW4gQ0RNQTxicj4KKyCg
U01TIG1hbmFnZXIgYXRvbS48YnI+Cis8YnI+CisgoFNwZWNpYWwgU01TcywgU0NQVCwgQ0FUUFQg
YW5kIHZvaWNlIG1haWwgbm90aWZpY2F0aW9uKFZNTikocGxlYXNlIHJlZmVyIHRvIEMuUzAwMTUg
c2VjdGlvbiA0LjMuOCw8YnI+CisgoDQuMy45LCA0LjMuNSl3aWxsIGJlIHByb2Nlc3NlZCBpbiBv
Zm9ubywgYW5kIG90aGVyIG1lc3NhZ2VzIHdpdGggYSBwb3J0IG51bWJlciAoaW5jbHVkZSBXQVAg
cHVzaDxicj4KKyCgbWVzc2FnZSkgd2lsbCBiZSBwcm9jZXNzZWQgYnkgZXh0ZXJuYWwgcGx1Zy1p
bnMuIENETUEgU01TIG1hbmFnZXIgYXRvbSBvZmZlciBhbiBBUEkgZm9yIHJlZ2lzdGVyPGJyPgor
IKBleHRlcm5hbCBwbHVnLWluLjxicj4KKzxicj4KKyCgUHJpb3JpdHk6IEhpZ2g8YnI+CisgoENv
bXBsZXhpdHk6IEM4PGJyPgorPGJyPgorLSBBZGQgQ0RNQSB2b2ljZSBjYWxsIHN1cHBvcnQuIENE
TUEgdm9pY2UgY2FsbCB3aWxsIHN1cHBvcnQgb3JpZ2luYXRlL2VuZC9ob2xkIGEgY2FsbCw8YnI+
CisgoHRyYW5zZmVyIGEgY2FsbCwgM1dDKHRocmVlLXdheSBjYWxsaW5nKSwgY29uZmVyZW5jZSBj
YWxsIGFuZCBEVE1GLiBGb3IgYSB2b2ljZSBjYWxsLCBjYW4gZ2V0PGJyPgorIKBpdHMgc3RhdHVz
LCBDTEkgYW5kIGVuZGluZyByZXN1bHQoaWYgaXQgaXMgZW5kKS48YnI+Cis8YnI+CisgoFByaW9y
aXR5OiBIaWdoPGJyPgorIKBDb21wbGV4aXR5OiBDNjxicj4KKzxicj4KKy0gQWRkIENETUEgRGF0
YSBjb25uZWN0aW9uIHN1cHBvcnQuIENETUEgZGF0YSBjb25uZWN0aW9uIG1hbmFnZXIgc3VwcG9y
dCBzdGFydC9lbmQgYSBkYXRhIGNvbm5lY3Q8YnI+CisgoGFjY29yZGluZyB0byB0aGUgc2V0dGlu
Z3MgZnJvbSBvdGhlciBtb2R1bGUodXBwZXIgbGF5ZXIgb3IgQ29ubk1hbilhbmQgZ2V0L3NldCBR
b3MuPGJyPgorPGJyPgorIKBQcmlvcml0eTogSGlnaDxicj4KKyCgQ29tcGxleGl0eTogQzQ8YnI+
Cis8YnI+CistIEFkZCBTSU0vVUlNIGRhdGEgYWNjZXNzIHN1cHBvcnQuIEFkZCBhIGNhcmQgYXRv
bSwgaXQgd2lsbCBzdXBwb3J0IHJlYWQvdXBkYXRlL2RlbGV0ZS9hZGQgY29uYXRhY3Q8YnI+Cisg
oGFkZCBTTVMgaW4gU0lNL1VJTSBjYXJkLjxicj4KKzxicj4KKyCgUHJpb3JpdHk6IEhpZ2g8YnI+
CisgoENvbXBsZXhpdHk6IEM2PGJyPgorPGJyPgorLSBBZGQgQ1RDQyBtb2RlbSBkcml2ZXIuIFRo
ZSBDVENDIG1vZGVtIGRyaXZlciB3aWxsIHRvdGFsbHkgb2JleSAmbHQ7Q2hpbmEgVGVsZWNvbSBD
RE1BIHRlcm1pbmFsPGJyPgorIKByZXF1aXJlbWVudCBzcGVjaWZpY2F0aW9uIC0tIDF4RVYtRE9S
ZXZBIERhdGEgVGVybWluYWwgQVQgY29tbWFuZCBJbnRlcmZhY2UgZmFzY2ljdWxlIFYxLjEmZ3Q7
PGJyPgorPGJyPgorIKBQcmlvcml0eTogSGlnaDxicj4KKyCgQ29tcGxleGl0eTogQzEwPGJyPgor
PGJyPgo8Zm9udCBjb2xvcj0iIzg4ODg4OCI+LS08YnI+CjEuNy4wLjQ8YnI+Cjxicj48L2ZvbnQ+
PC9ibG9ja3F1b3RlPjxkaXY+oDwvZGl2PjxkaXY+SXQgbG9va3MgbGlrZSB5b3UgYXJlIHByb3Zp
ZGluZyBuZXcgZGJ1cyBpbnRlcmZhY2UgZm9yIFVJTShTaW1NYW5hZ2VyKSwgRGF0YUNvbm5lY3Rp
b24oRGF0YUNvbm5lY3Rpb25NYW5hZ2VyKSwgZXRjLi4uPGJyPklmIHNvLCB3aGF0IGlzIHRoZSBu
ZWVkIGZvciBwcm92aWRpbmcgYSBuZXcgaW50ZXJmYWNlLCB3aHkgY2FuJiMzOTt0IHdlIGV4dGVu
ZCB0aGUgZXhpc3RpbmcgU2ltTWFuYWdlciwgRGF0YUNvbm5lY3Rpb25NYW5hZ2VyIGV0Yy4uLiB0
byBzdXBwb3J0IENETUEgdXNlY2FzZXMuPGJyPgoKSWYgd2UgcHJvdmlkZSBuZXcgaW50ZXJmYWNl
cywgdGhlcmUgY291bGQgYmUgY2hhbmdlcyBuZWVkZWQgaW4gdXBwZXIgbGF5ZXJzIGZvciBlZzog
Q29ubk1hbi48YnI+PGJyPkNvdWxkIHlvdSBjbGFyaWZ5Pzxicj48YnI+VGhhbmtzIGFuZCBSZWdh
cmRzLDxicj5qZWV2YWthPGJyPjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46IDBwdCAwcHQgMHB0IDAuOGV4OyBib3JkZXItbGVmdDogMXB4IHNv
bGlkIHJnYigyMDQsIDIwNCwgMjA0KTsgcGFkZGluZy1sZWZ0OiAxZXg7Ij4KPGZvbnQgY29sb3I9
IiM4ODg4ODgiPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBocmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8u
b3JnIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBocmVmPSJodHRwOi8vbGlzdHMub2Zvbm8u
b3JnL2xpc3RpbmZvL29mb25vIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL2xpc3RzLm9mb25vLm9y
Zy9saXN0aW5mby9vZm9ubzwvYT48YnI+CjwvZm9udD48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPgo=

--===============4733963534870611231==--

