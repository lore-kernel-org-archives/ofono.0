Content-Type: multipart/mixed; boundary="===============3904784938699238080=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: Patch on unsupported AT command
Date: Mon, 23 Nov 2009 10:41:04 +0800
Message-ID: <38D9F46DFF92C54980D2F2C1E8EE313001B4CCBCF2@pdsmsx503.ccr.corp.intel.com>
In-Reply-To: <1258800093.25879.37.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3904784938699238080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Marcel Holtmann
>Sent: Saturday, November 21, 2009 6:42 PM
>To: ofono(a)ofono.org
>Subject: RE: Patch on unsupported AT command
>
>Hi Yang,
>
>> >> >> >+	g_at_chat_add_terminator(chat, "+EXT ERROR:", 11, FALSE);
>> >> >> >+	g_at_chat_add_terminator(chat, "+CME ERROR:", 11, FALSE);
>> >> >> >+	g_at_chat_add_terminator(chat, "+CMS ERROR:", 11, FALSE);
>> >> >> >+	g_at_chat_add_terminator(chat, "NO ANSWER", -1, FALSE);
>> >> >> >+	g_at_chat_add_terminator(chat, "CONNECT", -1, TRUE);
>> >> >> >+	g_at_chat_add_terminator(chat, "NO CARRIER", -1, FALSE);
>> >> >> >+	g_at_chat_add_terminator(chat, "BUSY", -1, FALSE);
>> >> >> >+	g_at_chat_add_terminator(chat, "NO DIALTONE", -1, FALSE);
>> >> >> >+	g_at_chat_add_terminator(chat, "ERROR", -1, FALSE);
>> >> >> >+	g_at_chat_add_terminator(chat, "OK", -1, TRUE);
>> >> >>
>> >> >> I really don't like this.  Lets keep the non-standard terminators =
in a
>> >> >> separate list.  I don't want the vast majority of the drivers incu=
rring the
>> >> >> cost of multiple g_new/g_frees.
>> >> >
>> >> >I have to agree on this. We should keep the penalty for well behaving
>> >> >cards as small as possible.
>> >>
>> >> Thank you for the comments. Modified patches are attached!
>> >
>> >please do casts with a space between. Like (char *) terminator etc. Also
>> >why do you bother with making it const. Just leave that out. Since you
>> >do actually copy the string anyway.
>>
>> Fixed!
>
>I don't like this casting at all actually. Please just store the
>terminator as char and not const char. That is internal code anyway and
>you do allocate it. So no need to mark it as read-only. Also please use
>g_strdup since you are using g_free to free it.
>
>+static gboolean meet_terminator(GAtChat *chat,
>+                               struct terminator_info *info, char *line)
>
>About this function name, I don't really like it since it confuses the
>hell out of me what it is meant do be doing. I do get what you are
>trying to do here, but I would just name it check_terminator and then
>leave the g_at_chat_finish_command() call in the original code.

Code is modified according to your comment. Please have a review!

>Regards
>
>Marcel
>
>
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>http://lists.ofono.org/listinfo/ofono

--===============3904784938699238080==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Framework-to-support-non-standard-terminator.patch"

RnJvbSAzMDFkNmI3ZWM1YzhhMjJlMGFhZjRiZTU4YmMzOTk1NjY3N2Y2N2I0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZYW5nIEd1IDx5YW5nLmd1QGludGVsLmNvbT4KRGF0ZTogTW9u
LCAyMyBOb3YgMjAwOSAwOTo1ODozMiArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8yXSBGcmFtZXdv
cmsgdG8gc3VwcG9ydCBub24tc3RhbmRhcmQgdGVybWluYXRvcgoKLS0tCiBnYXRjaGF0L2dhdGNo
YXQuYyB8ICAgNTcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLQogZ2F0Y2hhdC9nYXRjaGF0LmggfCAgICAzICsrCiAyIGZpbGVzIGNoYW5nZWQsIDUw
IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dhdGNoYXQvZ2F0
Y2hhdC5jIGIvZ2F0Y2hhdC9nYXRjaGF0LmMKaW5kZXggMzIwMTUwYS4uMzIxOGQwMiAxMDA2NDQK
LS0tIGEvZ2F0Y2hhdC9nYXRjaGF0LmMKKysrIGIvZ2F0Y2hhdC9nYXRjaGF0LmMKQEAgLTg4LDYg
Kzg4LDEzIEBAIHN0cnVjdCBfR0F0Q2hhdCB7CiAJR1RpbWVyICp3YWtldXBfdGltZXI7CQkJLyog
S2VlcCB0cmFjayBvZiBlbGFwc2VkIHRpbWUgKi8KIAlHQXRTeW50YXggKnN5bnRheDsKIAlnYm9v
bGVhbiBkZXN0cm95ZWQ7CQkJLyogUmUtZW50cmFuY3kgZ3VhcmQgKi8KKwlHU0xpc3QgKnRlcm1p
bmF0b3JfbGlzdDsJCS8qIE5vbi1zdGFuZGFyZCB0ZXJtaW5hdG9yICovCit9OworCitzdHJ1Y3Qg
dGVybWluYXRvcl9pbmZvIHsKKwljaGFyICp0ZXJtaW5hdG9yOworCWludCBsZW47CisJZ2Jvb2xl
YW4gc3VjY2VzczsKIH07CiAKIHN0YXRpYyBnaW50IGF0X25vdGlmeV9ub2RlX2NvbXBhcmVfYnlf
aWQoZ2NvbnN0cG9pbnRlciBhLCBnY29uc3Rwb2ludGVyIGIpCkBAIC0yMDQsNiArMjExLDE0IEBA
IHN0YXRpYyB2b2lkIGF0X2NvbW1hbmRfZGVzdHJveShzdHJ1Y3QgYXRfY29tbWFuZCAqY21kKQog
CWdfZnJlZShjbWQpOwogfQogCitzdGF0aWMgdm9pZCBmcmVlX3Rlcm1pbmF0b3Ioc3RydWN0IHRl
cm1pbmF0b3JfaW5mbyAqaW5mbykKK3sKKwlnX2ZyZWUoaW5mby0+dGVybWluYXRvcik7CisJaW5m
by0+dGVybWluYXRvciA9IE5VTEw7CisJZ19mcmVlKGluZm8pOworCWluZm8gPSBOVUxMOworfQor
CiBzdGF0aWMgdm9pZCBnX2F0X2NoYXRfY2xlYW51cChHQXRDaGF0ICpjaGF0KQogewogCXN0cnVj
dCBhdF9jb21tYW5kICpjOwpAQCAtMjUxLDYgKzI2NiwxMyBAQCBzdGF0aWMgdm9pZCBnX2F0X2No
YXRfY2xlYW51cChHQXRDaGF0ICpjaGF0KQogCWNoYXQtPnN5bnRheCA9IE5VTEw7CiAKIAljaGF0
LT5jaGFubmVsID0gTlVMTDsKKworCWlmIChjaGF0LT50ZXJtaW5hdG9yX2xpc3QpIHsKKwkJZ19z
bGlzdF9mb3JlYWNoKGNoYXQtPnRlcm1pbmF0b3JfbGlzdCwKKwkJCQkJKEdGdW5jKWZyZWVfdGVy
bWluYXRvciwgTlVMTCk7CisJCWdfc2xpc3RfZnJlZShjaGF0LT50ZXJtaW5hdG9yX2xpc3QpOwor
CQljaGF0LT50ZXJtaW5hdG9yX2xpc3QgPSBOVUxMOworCX0KIH0KIAogc3RhdGljIHZvaWQgcmVh
ZF93YXRjaGVyX2Rlc3Ryb3lfbm90aWZ5KEdBdENoYXQgKmNoYXQpCkBAIC0zNTksMTIgKzM4MSw2
IEBAIHN0YXRpYyB2b2lkIGdfYXRfY2hhdF9maW5pc2hfY29tbWFuZChHQXRDaGF0ICpwLCBnYm9v
bGVhbiBvaywKIAlhdF9jb21tYW5kX2Rlc3Ryb3koY21kKTsKIH0KIAotc3RydWN0IHRlcm1pbmF0
b3JfaW5mbyB7Ci0JY29uc3QgY2hhciAqdGVybWluYXRvcjsKLQlpbnQgbGVuOwotCWdib29sZWFu
IHN1Y2Nlc3M7Ci19OwotCiBzdGF0aWMgc3RydWN0IHRlcm1pbmF0b3JfaW5mbyB0ZXJtaW5hdG9y
X3RhYmxlW10gPSB7CiAJeyAiT0siLCAtMSwgVFJVRSB9LAogCXsgIkVSUk9SIiwgLTEsIEZBTFNF
IH0sCkBAIC0zNzgsNiArMzk0LDI1IEBAIHN0YXRpYyBzdHJ1Y3QgdGVybWluYXRvcl9pbmZvIHRl
cm1pbmF0b3JfdGFibGVbXSA9IHsKIAl7ICIrRVhUIEVSUk9SOiIsIDExLCBGQUxTRSB9CiB9Owog
Cit2b2lkIGdfYXRfY2hhdF9hZGRfdGVybWluYXRvcihHQXRDaGF0ICpjaGF0LCBjaGFyICp0ZXJt
aW5hdG9yLAorCQkJCQlpbnQgbGVuLCBnYm9vbGVhbiBzdWNjZXNzKQoreworCXN0cnVjdCB0ZXJt
aW5hdG9yX2luZm8gKmluZm8gPSBnX25ldzAoc3RydWN0IHRlcm1pbmF0b3JfaW5mbywgMSk7CisJ
aW5mby0+dGVybWluYXRvciA9IGdfc3RyZHVwKHRlcm1pbmF0b3IpOworCWluZm8tPmxlbiA9IGxl
bjsKKwlpbmZvLT5zdWNjZXNzID0gc3VjY2VzczsKKwljaGF0LT50ZXJtaW5hdG9yX2xpc3QgPSBn
X3NsaXN0X3ByZXBlbmQoY2hhdC0+dGVybWluYXRvcl9saXN0LCBpbmZvKTsKK30KKworc3RhdGlj
IGdib29sZWFuIGNoZWNrX3Rlcm1pbmF0b3Ioc3RydWN0IHRlcm1pbmF0b3JfaW5mbyAqaW5mbywg
Y2hhciAqbGluZSkKK3sKKwlpZiAoKGluZm8tPmxlbiA9PSAtMSAmJiAhc3RyY21wKGxpbmUsIGlu
Zm8tPnRlcm1pbmF0b3IpKSB8fAorCQkoaW5mby0+bGVuID4gMCAmJiAhc3RybmNtcChsaW5lLCBp
bmZvLT50ZXJtaW5hdG9yLCBpbmZvLT5sZW4pKSkKKwkJcmV0dXJuIFRSVUU7CisJZWxzZQorCQly
ZXR1cm4gRkFMU0U7Cit9CisKIHN0YXRpYyBnYm9vbGVhbiBnX2F0X2NoYXRfaGFuZGxlX2NvbW1h
bmRfcmVzcG9uc2UoR0F0Q2hhdCAqcCwKIAkJCQkJCQlzdHJ1Y3QgYXRfY29tbWFuZCAqY21kLAog
CQkJCQkJCWNoYXIgKmxpbmUpCkBAIC0zODUsMTcgKzQyMCwxOSBAQCBzdGF0aWMgZ2Jvb2xlYW4g
Z19hdF9jaGF0X2hhbmRsZV9jb21tYW5kX3Jlc3BvbnNlKEdBdENoYXQgKnAsCiAJaW50IGk7CiAJ
aW50IHNpemUgPSBzaXplb2YodGVybWluYXRvcl90YWJsZSkgLyBzaXplb2Yoc3RydWN0IHRlcm1p
bmF0b3JfaW5mbyk7CiAJaW50IGhpbnQ7CisJR1NMaXN0ICpsOwogCiAJZm9yIChpID0gMDsgaSA8
IHNpemU7IGkrKykgewogCQlzdHJ1Y3QgdGVybWluYXRvcl9pbmZvICppbmZvID0gJnRlcm1pbmF0
b3JfdGFibGVbaV07Ci0KLQkJaWYgKGluZm8tPmxlbiA9PSAtMSAmJiAhc3RyY21wKGxpbmUsIGlu
Zm8tPnRlcm1pbmF0b3IpKSB7CisJCWlmIChjaGVja190ZXJtaW5hdG9yKGluZm8sIGxpbmUpKSB7
CiAJCQlnX2F0X2NoYXRfZmluaXNoX2NvbW1hbmQocCwgaW5mby0+c3VjY2VzcywgbGluZSk7CiAJ
CQlyZXR1cm4gVFJVRTsKIAkJfQorCX0KIAotCQlpZiAoaW5mby0+bGVuID4gMCAmJgotCQkJIXN0
cm5jbXAobGluZSwgaW5mby0+dGVybWluYXRvciwgaW5mby0+bGVuKSkgeworCWZvciAobCA9IHAt
PnRlcm1pbmF0b3JfbGlzdDsgbDsgbCA9IGwtPm5leHQpIHsKKwkJc3RydWN0IHRlcm1pbmF0b3Jf
aW5mbyAqaW5mbyA9IGwtPmRhdGE7CisJCWlmIChjaGVja190ZXJtaW5hdG9yKGluZm8sIGxpbmUp
KSB7CiAJCQlnX2F0X2NoYXRfZmluaXNoX2NvbW1hbmQocCwgaW5mby0+c3VjY2VzcywgbGluZSk7
CiAJCQlyZXR1cm4gVFJVRTsKIAkJfQpkaWZmIC0tZ2l0IGEvZ2F0Y2hhdC9nYXRjaGF0LmggYi9n
YXRjaGF0L2dhdGNoYXQuaAppbmRleCBmZTViOTdiLi4yNDljOGNmIDEwMDY0NAotLS0gYS9nYXRj
aGF0L2dhdGNoYXQuaAorKysgYi9nYXRjaGF0L2dhdGNoYXQuaApAQCAtMTI4LDYgKzEyOCw5IEBA
IGdib29sZWFuIGdfYXRfY2hhdF91bnJlZ2lzdGVyKEdBdENoYXQgKmNoYXQsIGd1aW50IGlkKTsK
IGdib29sZWFuIGdfYXRfY2hhdF9zZXRfd2FrZXVwX2NvbW1hbmQoR0F0Q2hhdCAqY2hhdCwgY29u
c3QgY2hhciAqY21kLAogCQkJCQlndWludCB0aW1lb3V0LCBndWludCBtc2VjKTsKIAordm9pZCBn
X2F0X2NoYXRfYWRkX3Rlcm1pbmF0b3IoR0F0Q2hhdCAqY2hhdCwgY2hhciAqdGVybWluYXRvciwK
KwkJCQlpbnQgbGVuLCBnYm9vbGVhbiBzdWNjZXNzKTsKKwogCiAjaWZkZWYgX19jcGx1c3BsdXMK
IH0KLS0gCjEuNi41LjIKCg==

--===============3904784938699238080==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-Support-Huawei-specific-terminator.patch"

RnJvbSBhMjgyZjNkZjYxM2Q4OWQ5ZWY3MmQ0MzliMzMwN2EzZDc4NjQwYTllIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZYW5nIEd1IDx5YW5nLmd1QGludGVsLmNvbT4KRGF0ZTogTW9u
LCAyMyBOb3YgMjAwOSAwOTo1ODo1NCArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBTdXBwb3J0
IEh1YXdlaSBzcGVjaWZpYyB0ZXJtaW5hdG9yCgotLS0KIHBsdWdpbnMvaHVhd2VpLmMgfCAgICAx
ICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3BsdWdpbnMvaHVhd2VpLmMgYi9wbHVnaW5zL2h1YXdlaS5jCmluZGV4IDA4ZjBl
MDEuLmU4M2Y5YzEgMTAwNjQ0Ci0tLSBhL3BsdWdpbnMvaHVhd2VpLmMKKysrIGIvcGx1Z2lucy9o
dWF3ZWkuYwpAQCAtMTA3LDYgKzEwNyw3IEBAIHN0YXRpYyBpbnQgaHVhd2VpX2VuYWJsZShzdHJ1
Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKQogCiAJc3ludGF4ID0gZ19hdF9zeW50YXhfbmV3X2dzbXYx
KCk7CiAJZGF0YS0+Y2hhdCA9IGdfYXRfY2hhdF9uZXcoY2hhbm5lbCwgc3ludGF4KTsKKwlnX2F0
X2NoYXRfYWRkX3Rlcm1pbmF0b3IoZGF0YS0+Y2hhdCwgIkNPTU1BTkQgTk9UIFNVUFBPUlQiLCAt
MSwgRkFMU0UpOwogCWdfYXRfc3ludGF4X3VucmVmKHN5bnRheCk7CiAJZ19pb19jaGFubmVsX3Vu
cmVmKGNoYW5uZWwpOwogCi0tIAoxLjYuNS4yCgo=

--===============3904784938699238080==--

