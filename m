Content-Type: multipart/mixed; boundary="===============8466276718830050291=="
MIME-Version: 1.0
From: M. Dietrich <ofono@emdete.de>
Subject: fix for +CMER parser of AT driver (fixes registration)
Date: Mon, 07 Jan 2013 21:58:23 +0100
Message-ID: <20130107205823.GI7263@emdete.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8466276718830050291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,


i recently noticed that the at driver did not reach the state "registered".
marcel pointer me to the message

	+CMER not supported by this modem.  If this is an error please submit
	patches to support this hardware

and i started digging. problem was parsing of the response

	+CMER: (0,3),(0,2),0,(0-1),0

that expresses the allowed options of CMER. neither (a list of) single inte=
ger
"(0,3)" (in opposite to range "(0-1)") nor missing brackets "0" were suppor=
ted
by ofono so i added this (see patch).

i'm not sure if missing brackets are allowed or espress something different,
maybe a AT-guru can tell. for now "(0)" behaves like "0".

i assume that also other response-parsing flows in ofono have that problem
so either a generic aproach should be implemented or other places be review=
ed.

marcel already pointer out that a generic aproach may be unnecessarily comp=
lex
where i agree if it comes to strings and nested brackets but for plain inte=
ger
cases it would be quite useful to get this done in one place for all. if
interested i could implement such stuff into gatchat/gatresult.c which then=
 can
be used for the integer-only cases. what do you think?


regards,
	michael

-- =

M. Dietrich

--===============8466276718830050291==
Content-Type: text/x-diff
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-enhance-parser-for-CMER-response.patch"

PkZyb20gMjMyOGIwMzA2N2EwZDk4MmZmMmNhMDhmMTEwYWM0YjBmYTIzMDAyYSBNb24gU2VwIDE3
IDAwOjAwOjAwIDIwMDEKRnJvbTogIk0uIERpZXRyaWNoIiA8bWR0QHB5bmVvLm9yZz4KRGF0ZTog
U3VuLCAzMCBEZWMgMjAxMiAyMToyNjozMyArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIGVuaGFuY2Ug
cGFyc2VyIGZvciBDTUVSIHJlc3BvbnNlCgotLS0KIGRyaXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJl
Z2lzdHJhdGlvbi5jIHwgICAzOSArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvYXRtb2RlbS9uZXR3b3JrLXJlZ2lzdHJhdGlvbi5jIGIvZHJpdmVycy9hdG1v
ZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmMKaW5kZXggMTliMTliMi4uMzEyOGQ1ZiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9hdG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmMKKysrIGIvZHJpdmVy
cy9hdG1vZGVtL25ldHdvcmstcmVnaXN0cmF0aW9uLmMKQEAgLTE2MTUsMjYgKzE2MTUsNDUgQEAg
c3RhdGljIHZvaWQgYXRfY21lcl9xdWVyeV9jYihvZm9ub19ib29sX3Qgb2ssIEdBdFJlc3VsdCAq
cmVzdWx0LAogCiAJZ19hdF9yZXN1bHRfaXRlcl9pbml0KCZpdGVyLCByZXN1bHQpOwogCi0JaWYg
KCFnX2F0X3Jlc3VsdF9pdGVyX25leHQoJml0ZXIsICIrQ01FUjoiKSkKKwlpZiAoIWdfYXRfcmVz
dWx0X2l0ZXJfbmV4dCgmaXRlciwgIitDTUVSOiIpKSB7CisJCURCRygicGFyc2luZyBlcnJvciwg
cHJvYmFibHkgYmVnaW4gdGFnIG5vdCBmb3VuZCIpOwogCQlnb3RvIGVycm9yOworCX0KIAogCWZv
ciAob3B0ID0gMDsgb3B0IDwgY21lcl9vcHRzX2NudDsgb3B0KyspIHsKIAkJaW50IG1pbiwgbWF4
OwogCi0JCWlmICghZ19hdF9yZXN1bHRfaXRlcl9vcGVuX2xpc3QoJml0ZXIpKQotCQkJZ290byBl
cnJvcjsKLQotCQl3aGlsZSAoZ19hdF9yZXN1bHRfaXRlcl9uZXh0X3JhbmdlKCZpdGVyLCAmbWlu
LCAmbWF4KSkgewotCQkJZm9yIChtb2RlID0gbWluOyBtb2RlIDw9IG1heDsgbW9kZSsrKQotCQkJ
CWNtZXJfb3B0c1tvcHRdIHw9IDEgPDwgbW9kZTsKKwkJaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX29w
ZW5fbGlzdCgmaXRlcikpIHsKKwkJCW1heCA9IC0xOworCQkJd2hpbGUgKGdfYXRfcmVzdWx0X2l0
ZXJfbmV4dF9udW1iZXIoJml0ZXIsICZtaW4pKSB7CisJCQkJaWYgKG1heCA8IDApCisJCQkJCW1h
eCA9IG1pbjsKKwkJCQlmb3IgKG1vZGUgPSBtaW47IG1vZGUgPD0gbWF4OyBtb2RlKyspCisJCQkJ
CWNtZXJfb3B0c1tvcHRdIHw9IDEgPDwgbW9kZTsKKwkJCX0KIAkJfQorCQllbHNlCisJCXsKKwkJ
CW1heCA9IC0xOworCQkJd2hpbGUgKGdfYXRfcmVzdWx0X2l0ZXJfbmV4dF9yYW5nZSgmaXRlciwg
Jm1pbiwgJm1heCkKKwkJCXx8IGdfYXRfcmVzdWx0X2l0ZXJfbmV4dF9udW1iZXIoJml0ZXIsICZt
aW4pKSB7CisJCQkJaWYgKG1heCA8IDApCisJCQkJCW1heCA9IG1pbjsKKwkJCQlmb3IgKG1vZGUg
PSBtaW47IG1vZGUgPD0gbWF4OyBtb2RlKyspCisJCQkJCWNtZXJfb3B0c1tvcHRdIHw9IDEgPDwg
bW9kZTsKKwkJCX0KIAotCQlpZiAoIWdfYXRfcmVzdWx0X2l0ZXJfY2xvc2VfbGlzdCgmaXRlcikp
Ci0JCQlnb3RvIGVycm9yOworCQkJaWYgKCFnX2F0X3Jlc3VsdF9pdGVyX2Nsb3NlX2xpc3QoJml0
ZXIpKSB7CisJCQkJREJHKCJwYXJzaW5nIGVycm9yOiBlbmQgbm90IGZvdW5kIik7CisJCQkJZ290
byBlcnJvcjsKKwkJCX0KKwkJfQogCX0KIAotCWlmIChidWlsZF9jbWVyX3N0cmluZyhidWYsIGNt
ZXJfb3B0cywgbmQpID09IEZBTFNFKQorCWlmIChidWlsZF9jbWVyX3N0cmluZyhidWYsIGNtZXJf
b3B0cywgbmQpID09IEZBTFNFKSB7CisJCURCRygiY291bGQgbm90IGJ1aWxkIGNtZXIiKTsKIAkJ
Z290byBlcnJvcjsKKwl9CiAKIAlnX2F0X2NoYXRfc2VuZChuZC0+Y2hhdCwgYnVmLCBjbWVyX3By
ZWZpeCwKIAkJCWF0X2NtZXJfc2V0X2NiLCBuZXRyZWcsIE5VTEwpOwotLSAKMS43LjEwLjQKCg==

--===============8466276718830050291==--

