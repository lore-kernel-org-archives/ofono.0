Content-Type: multipart/mixed; boundary="===============7799754758864555920=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: Clarification on USSD support in ofono
Date: Tue, 31 Aug 2010 11:58:57 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA8029A8D64@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7799754758864555920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

  Currently, oFono expects the USSD string in UTF-8. ofono(Atom driver -
AT or ISI) converts the UTF-8 string to GSM 7-bit default alphabet and
sends it to the network. In this way, we will always send the data
coding scheme as GSM 7-bit default alphabet or whatever the character
set modem is configured. Why are we not sending the USSD string with
DCS(Data coding scheme) as is to the network? There are USIM conformance
test cases which expects the DCS(Data coding scheme) and USSD string
sent as it is to the network. Also, as per the 3GPP TS 24.090, DCS and
USSD string are sent as part of UnstructuredSS-Request to the network
and MT is not expected to interpret the string. But ,here oFono doesn't
have the interface to accept DCS(Data coding scheme) and also it expects
the USSD string to be in UTF-8. =

 =

Thanks and Regards,
jeevaka



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


--===============7799754758864555920==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDMuMi8vRU4iPgo8SFRNTD4K
PEhFQUQ+CjxNRVRBIEhUVFAtRVFVSVY9IkNvbnRlbnQtVHlwZSIgQ09OVEVOVD0idGV4dC9odG1s
OyBjaGFyc2V0PXVzLWFzY2lpIj4KPE1FVEEgTkFNRT0iR2VuZXJhdG9yIiBDT05URU5UPSJNUyBF
eGNoYW5nZSBTZXJ2ZXIgdmVyc2lvbiA2LjUuNzY1NC4xMiI+CjxUSVRMRT5DbGFyaWZpY2F0aW9u
IG9uIFVTU0Qgc3VwcG9ydCBpbiBvZm9ubzwvVElUTEU+CjwvSEVBRD4KPEJPRFk+CjwhLS0gQ29u
dmVydGVkIGZyb20gdGV4dC9ydGYgZm9ybWF0IC0tPgo8QlI+Cgo8UD48U1BBTiBMQU5HPSJmaSI+
PEZPTlQgRkFDRT0iVGltZXMgTmV3IFJvbWFuIj5IaSw8L0ZPTlQ+PC9TUEFOPgo8L1A+Cgo8UD48
U1BBTiBMQU5HPSJmaSI+PEZPTlQgRkFDRT0iVGltZXMgTmV3IFJvbWFuIj4mbmJzcDsgQ3VycmVu
dGx5LCBvRm9ubyBleHBlY3RzIHRoZSBVU1NEIHN0cmluZyBpbiBVVEYtOC4gb2Zvbm8oQXRvbSBk
cml2ZXIgLSBBVCBvciBJU0kpIGNvbnZlcnRzIHRoZSBVVEYtOCBzdHJpbmcgdG8gR1NNIDctYml0
IGRlZmF1bHQgYWxwaGFiZXQgYW5kIHNlbmRzIGl0IHRvIHRoZSBuZXR3b3JrLiBJbiB0aGlzIHdh
eSwgd2Ugd2lsbCBhbHdheXMgc2VuZCB0aGUgZGF0YSBjb2Rpbmcgc2NoZW1lIGFzIEdTTSA3LWJp
dCBkZWZhdWx0IGFscGhhYmV0IG9yIHdoYXRldmVyIHRoZSBjaGFyYWN0ZXIgc2V0IG1vZGVtIGlz
IGNvbmZpZ3VyZWQuIFdoeSBhcmUgd2Ugbm90IHNlbmRpbmcgdGhlIFVTU0Qgc3RyaW5nIHdpdGgg
RENTKERhdGEgY29kaW5nIHNjaGVtZSkgYXMgaXMgdG8gdGhlIG5ldHdvcms/IFRoZXJlIGFyZSBV
U0lNIGNvbmZvcm1hbmNlIHRlc3QgY2FzZXMgd2hpY2ggZXhwZWN0cyB0aGUgRENTKERhdGEgY29k
aW5nIHNjaGVtZSkgYW5kIFVTU0Qgc3RyaW5nIHNlbnQgYXMgaXQgaXMgdG8gdGhlIG5ldHdvcmsu
IEFsc28sIGFzIHBlciB0aGUgM0dQUCBUUyAyNC4wOTAsIERDUyBhbmQgVVNTRCBzdHJpbmcgYXJl
IHNlbnQgYXMgcGFydCBvZiBVbnN0cnVjdHVyZWRTUy1SZXF1ZXN0IHRvIHRoZSBuZXR3b3JrIGFu
ZCBNVCBpcyBub3QgZXhwZWN0ZWQgdG8gaW50ZXJwcmV0IHRoZSBzdHJpbmcuIEJ1dCAsaGVyZSBv
Rm9ubyBkb2Vzbid0IGhhdmUgdGhlIGludGVyZmFjZSB0byBhY2NlcHQgRENTKERhdGEgY29kaW5n
IHNjaGVtZSkgYW5kIGFsc28gaXQgZXhwZWN0cyB0aGUgVVNTRCBzdHJpbmcgdG8gYmUgaW4gVVRG
LTguIDwvRk9OVD48L1NQQU4+PC9QPgoKPFA+PFNQQU4gTEFORz0iZmkiPjxGT05UIEZBQ0U9IlRp
bWVzIE5ldyBSb21hbiI+Jm5ic3A7PC9GT05UPjwvU1BBTj4KCjxCUj48U1BBTiBMQU5HPSJmaSI+
PEZPTlQgRkFDRT0iVGltZXMgTmV3IFJvbWFuIj5UaGFua3MgYW5kIFJlZ2FyZHMsPC9GT05UPjwv
U1BBTj4KCjxCUj48U1BBTiBMQU5HPSJmaSI+PEZPTlQgRkFDRT0iVGltZXMgTmV3IFJvbWFuIj5q
ZWV2YWthPC9GT05UPjwvU1BBTj48U1BBTiBMQU5HPSJlbi11cyI+PC9TUEFOPgo8L1A+Cgo8cHJl
PgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tClBsZWFzZSBub3RlOiBUaGlzIGUtbWFpbCBtYXkgY29udGFpbiBjb25maWRlbnRp
YWwgaW5mb3JtYXRpb24KaW50ZW5kZWQgc29sZWx5IGZvciB0aGUgYWRkcmVzc2VlLiBJZiB5b3Ug
aGF2ZSByZWNlaXZlZCB0aGlzCmUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIGRvIG5vdCBkaXNjbG9z
ZSBpdCB0byBhbnlvbmUsIG5vdGlmeQp0aGUgc2VuZGVyIHByb21wdGx5LCBhbmQgZGVsZXRlIHRo
ZSBtZXNzYWdlIGZyb20geW91ciBzeXN0ZW0uClRoYW5rIHlvdS4KPC9wcmU+Cgo8cHJlPgotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tClBsZWFzZSBub3RlOiBUaGlzIGUtbWFpbCBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgaW5m
b3JtYXRpb24KaW50ZW5kZWQgc29sZWx5IGZvciB0aGUgYWRkcmVzc2VlLiBJZiB5b3UgaGF2ZSBy
ZWNlaXZlZCB0aGlzCmUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIGRvIG5vdCBkaXNjbG9zZSBpdCB0
byBhbnlvbmUsIG5vdGlmeQp0aGUgc2VuZGVyIHByb21wdGx5LCBhbmQgZGVsZXRlIHRoZSBtZXNz
YWdlIGZyb20geW91ciBzeXN0ZW0uClRoYW5rIHlvdS4KPC9wcmU+Cgo8L0JPRFk+CjwvSFRNTD4=
--===============7799754758864555920==--

