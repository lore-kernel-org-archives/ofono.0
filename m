Content-Type: multipart/mixed; boundary="===============2836712756521815657=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: Patch on unsupported AT command
Date: Fri, 13 Nov 2009 15:11:33 +0800
Message-ID: <38D9F46DFF92C54980D2F2C1E8EE313001B49C0DD6@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2836712756521815657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,
	If some unsupported AT command is issued, different modem may have their o=
wn response. Now at my hand is a Huawei modem (EM770W), and it returns "COM=
MAND NOT SUPPORT". In my case, this modem doesn't support "AT+CGAUTO=3D0" i=
n atmodem/gprs.c. Current oFono will hang there for it's not a valid return.
	We may have some quirk to handle this problem, the same way as current cod=
e in network-registration.c with CALYPSO. But I wonder if it's better to ad=
d the response string into "terminator table", so that we don't need this k=
ind of quirk here and there. I'm not sure if this is the better/best way to=
 handle this problem. After all, the table may become larger and larger is =
more and more specific terminator like this are added. =

	Comments are welcome!

Regards,
-Yang


--===============2836712756521815657==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Add-terminator-for-unsupported-AT-command-of-Huawei.patch"

RnJvbSA2Nzc2ZjkyZDg3YWZiNTZiMTFkYzhiNDRhMTUzZWI0NmJmMDNmN2RhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZYW5nIEd1IDx5YW5nLmd1QGludGVsLmNvbT4KRGF0ZTogRnJp
LCAxMyBOb3YgMjAwOSAxNDo0ODo1OCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFkZCB0ZXJtaW5h
dG9yIGZvciB1bnN1cHBvcnRlZCBBVCBjb21tYW5kIG9mIEh1YXdlaSBtb2RlbQoKLS0tCiBnYXRj
aGF0L2dhdGNoYXQuYyB8ICAgIDMgKystCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9nYXRjaGF0L2dhdGNoYXQuYyBiL2dhdGNo
YXQvZ2F0Y2hhdC5jCmluZGV4IDMyMDE1MGEuLjg4ODExYmEgMTAwNjQ0Ci0tLSBhL2dhdGNoYXQv
Z2F0Y2hhdC5jCisrKyBiL2dhdGNoYXQvZ2F0Y2hhdC5jCkBAIC0zNzUsNyArMzc1LDggQEAgc3Rh
dGljIHN0cnVjdCB0ZXJtaW5hdG9yX2luZm8gdGVybWluYXRvcl90YWJsZVtdID0gewogCXsgIk5P
IEFOU1dFUiIsIC0xLCBGQUxTRSB9LAogCXsgIitDTVMgRVJST1I6IiwgMTEsIEZBTFNFIH0sCiAJ
eyAiK0NNRSBFUlJPUjoiLCAxMSwgRkFMU0UgfSwKLQl7ICIrRVhUIEVSUk9SOiIsIDExLCBGQUxT
RSB9CisJeyAiK0VYVCBFUlJPUjoiLCAxMSwgRkFMU0UgfSwKKwl7ICJDT01NQU5EIE5PVCBTVVBQ
T1JUIiwgLTEsIEZBTFNFfSwKIH07CiAKIHN0YXRpYyBnYm9vbGVhbiBnX2F0X2NoYXRfaGFuZGxl
X2NvbW1hbmRfcmVzcG9uc2UoR0F0Q2hhdCAqcCwKLS0gCjEuNi4yLjUKCg==

--===============2836712756521815657==--

