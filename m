Content-Type: multipart/mixed; boundary="===============6469768347863164238=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: Patch for Timeout Issue when Importing Phonebook
Date: Thu, 06 Aug 2009 14:47:27 +0800
Message-ID: <38D9F46DFF92C54980D2F2C1E8EE313001A7604F9F@pdsmsx503.ccr.corp.intel.com>
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE313001A7604D4E@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6469768347863164238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It often needs a long time (more than default timeout of D-Bus) to retrieve=
 all the entries from phonebook. This patch is to set the timeout to 100 se=
conds so that the operation has enough time to get the result. =


Regards,
-Yang


>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf
>Of Gu, Yang
>Sent: Thursday, August 06, 2009 12:10 AM
>To: ofono(a)ofono.org
>Subject: RE: light test report for ofono v0.2
>
>>4) timeout when reading records at the first time
>Reading records from SIM card requires more time than default timeout of
>D-Bus, so you will get timeout error when you invoke the method via D-Bus
>for the first time. The result will be cached once oFono gets all the reco=
rds,
>thus you may get the records very quickly for the second, third, .., time.
>I will try to update the test case to retrieve the records in an asynchron=
ous
>way.
>
>Regards,
>-Yang
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============6469768347863164238==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Enlarge-the-timeout-for-phonebook-import.patch"

RnJvbSBmODdlZTdjYzVhNGViMmI4MTQxMGI0MzVkYWYwMDhiMzRmNjliZmYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZYW5nIEd1IDx5YW5nLmd1QGludGVsLmNvbT4KRGF0ZTogVGh1
LCA2IEF1ZyAyMDA5IDExOjQwOjQ5ICswODAwClN1YmplY3Q6IFtQQVRDSF0gRW5sYXJnZSB0aGUg
dGltZW91dCBmb3IgcGhvbmVib29rIGltcG9ydAoKLS0tCiB0ZXN0L3Rlc3QtcGhvbmVib29rIHwg
ICAgMiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvdGVzdC90ZXN0LXBob25lYm9vayBiL3Rlc3QvdGVzdC1waG9uZWJvb2sK
aW5kZXggZmI3YTdkNi4uNTIwMDRlOCAxMDA3NTUKLS0tIGEvdGVzdC90ZXN0LXBob25lYm9vawor
KysgYi90ZXN0L3Rlc3QtcGhvbmVib29rCkBAIC0xOCw0ICsxOCw0IEBAIGlmIF9fbmFtZV9fID09
ICJfX21haW5fXyI6CiAJcGhvbmVib29rID0gZGJ1cy5JbnRlcmZhY2UoYnVzLmdldF9vYmplY3Qo
J29yZy5vZm9ubycsIG1vZGVtc1swXSksCiAJCQkJJ29yZy5vZm9uby5QaG9uZWJvb2snKQogCi0J
cHJpbnQgcGhvbmVib29rLkltcG9ydCgpCisJcHJpbnQgcGhvbmVib29rLkltcG9ydCh0aW1lb3V0
PTEwMCkKLS0gCjEuNi4wLjYKCg==

--===============6469768347863164238==--

