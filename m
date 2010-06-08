Content-Type: multipart/mixed; boundary="===============0961841423934688116=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: [PATCH] TODO: CBS CMAS
Date: Tue, 08 Jun 2010 15:05:52 -0700
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9C58BCDAD@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0961841423934688116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add CBS CMAS to TODO list.

---
 TODO |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 4a12b6f..ef0bcde 100644
--- a/TODO
+++ b/TODO
@@ -112,6 +112,20 @@ SMS
   Owner: Pasi Miettinen <pasi.miettinen@ixonos.com>
 =

 =

+Cell Broadcast System
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Support for Commercial Mobile Alert System (CMAS) according to 3GPP
+  23.041, 3GPP 22.268 and ATIS/TIA J-STD-100 in addition to Earthquake
+  and Tsunami Warning Service (ETWS). oFono already reports ETWS messages
+  with CBS message identifiers 4352-4356 as EmergencyBroadcast DBUS signal=
s.
+  oFono should be extended with support for CMAS messages which have CBS
+  message identifiers in the range of 4370-4382.
+
+  Priority: Medium
+  Complexity: C1
+
+
 SIM / SIM File system
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.5.4.3

--===============0961841423934688116==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Add-CBS-CMAS-work-item.patch"

RnJvbSBjN2ZjZjZkZWNhNjRjNDNhMWIzODU4YWMyODExYTVjNWUyY2NmOGI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXYWxkbyBCYXN0aWFuIDx3YWxkby5iYXN0aWFuQGludGVsLmNv
bT4KRGF0ZTogVHVlLCA4IEp1biAyMDEwIDE1OjI5OjM3IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0g
QWRkIENCUyBDTUFTIHdvcmsgaXRlbQoKLS0tCiBUT0RPIHwgICAxNCArKysrKysrKysrKysrKwog
MSBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL1RPRE8gYi9UT0RPCmluZGV4IDRhMTJiNmYuLmVmMGJjZGUgMTAwNjQ0Ci0tLSBhL1RP
RE8KKysrIGIvVE9ETwpAQCAtMTEyLDYgKzExMiwyMCBAQCBTTVMKICAgT3duZXI6IFBhc2kgTWll
dHRpbmVuIDxwYXNpLm1pZXR0aW5lbkBpeG9ub3MuY29tPgogCiAKK0NlbGwgQnJvYWRjYXN0IFN5
c3RlbQorPT09PT09PT09PT09PT09PT09PT09CisKKy0gU3VwcG9ydCBmb3IgQ29tbWVyY2lhbCBN
b2JpbGUgQWxlcnQgU3lzdGVtIChDTUFTKSBhY2NvcmRpbmcgdG8gM0dQUAorICAyMy4wNDEsIDNH
UFAgMjIuMjY4IGFuZCBBVElTL1RJQSBKLVNURC0xMDAgaW4gYWRkaXRpb24gdG8gRWFydGhxdWFr
ZQorICBhbmQgVHN1bmFtaSBXYXJuaW5nIFNlcnZpY2UgKEVUV1MpLiBvRm9ubyBhbHJlYWR5IHJl
cG9ydHMgRVRXUyBtZXNzYWdlcworICB3aXRoIENCUyBtZXNzYWdlIGlkZW50aWZpZXJzIDQzNTIt
NDM1NiBhcyBFbWVyZ2VuY3lCcm9hZGNhc3QgREJVUyBzaWduYWxzLgorICBvRm9ubyBzaG91bGQg
YmUgZXh0ZW5kZWQgd2l0aCBzdXBwb3J0IGZvciBDTUFTIG1lc3NhZ2VzIHdoaWNoIGhhdmUgQ0JT
CisgIG1lc3NhZ2UgaWRlbnRpZmllcnMgaW4gdGhlIHJhbmdlIG9mIDQzNzAtNDM4Mi4KKworICBQ
cmlvcml0eTogTWVkaXVtCisgIENvbXBsZXhpdHk6IEMxCisKKwogU0lNIC8gU0lNIEZpbGUgc3lz
dGVtCiA9PT09PT09PT09PT09PT09PT09PT0KIAotLSAKMS41LjQuMwoK

--===============0961841423934688116==--

