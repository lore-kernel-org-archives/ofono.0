Content-Type: multipart/mixed; boundary="===============0383444821070715010=="
MIME-Version: 1.0
From: vicamo@gmail.com
Subject: add gtk-doc support
Date: Thu, 25 Dec 2014 01:31:10 +0800
Message-ID: <CAJ-KqdzJhY+JZ-sn7vuz1XCXa=YcSPpQP92jgwM_acGPSB7aNg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0383444821070715010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi there,

Merry Christmas!

I'm working on adding gtk-doc support to oFono and is available publicly on
github [1]. This job is currently based on my previous patches to clean up
Makefile.am.

So far the biggest problem is that it's going to add yet another
Makefile.am inside doc/, which breaks no-recursive make rule that is
currently enforced. However, that seems to be an inevitable side effect
when somebody is going to include gtk-doc in his project. I'd like to know
if you has other concerns before going ahead and posting the patches. For
me, oFono has done a great job in implementing core functions and bringing
support to various hardware. It just needs some more refactoring and
polishments to lower the effort to use it, and documentation is one of the
most important tasks on my list. What do you think?

[1]: https://github.com/vicamo/ofono/tree/for/upstream/gtk-doc

Regards,
Vicamo Yang

--===============0383444821070715010==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+SGkgdGhlcmUsPGJyPjxicj48L2Rpdj5NZXJy
eSBDaHJpc3RtYXMhPGJyPjxicj48L2Rpdj5JJiMzOTttIHdvcmtpbmcgb24gYWRkaW5nIGd0ay1k
b2Mgc3VwcG9ydCB0byBvRm9ubyBhbmQgaXMgYXZhaWxhYmxlIHB1YmxpY2x5IG9uIGdpdGh1YiBb
MV0uIFRoaXMgam9iIGlzIGN1cnJlbnRseSBiYXNlZCBvbiBteSBwcmV2aW91cyBwYXRjaGVzIHRv
IGNsZWFuIHVwIE1ha2VmaWxlLmFtLjxicj48YnI+U28gZmFyIHRoZSBiaWdnZXN0IHByb2JsZW0g
aXMgdGhhdCBpdCYjMzk7cyBnb2luZyB0byBhZGQgeWV0IGFub3RoZXIgTWFrZWZpbGUuYW0gaW5z
aWRlIGRvYy8sIHdoaWNoIGJyZWFrcyBuby1yZWN1cnNpdmUgbWFrZSBydWxlIHRoYXQgaXMgY3Vy
cmVudGx5IGVuZm9yY2VkLiBIb3dldmVyLCB0aGF0IHNlZW1zIHRvIGJlIGFuIGluZXZpdGFibGUg
c2lkZSBlZmZlY3Qgd2hlbiBzb21lYm9keSBpcyBnb2luZyB0byBpbmNsdWRlIGd0ay1kb2MgaW4g
aGlzIHByb2plY3QuIEkmIzM5O2QgbGlrZSB0byBrbm93IGlmIHlvdSBoYXMgb3RoZXIgY29uY2Vy
bnMgYmVmb3JlIGdvaW5nIGFoZWFkIGFuZCBwb3N0aW5nIHRoZSBwYXRjaGVzLiBGb3IgbWUsIG9G
b25vIGhhcyBkb25lIGEgZ3JlYXQgam9iIGluIGltcGxlbWVudGluZyBjb3JlIGZ1bmN0aW9ucyBh
bmQgYnJpbmdpbmcgc3VwcG9ydCB0byB2YXJpb3VzIGhhcmR3YXJlLiBJdCBqdXN0IG5lZWRzIHNv
bWUgbW9yZSByZWZhY3RvcmluZyBhbmQgcG9saXNobWVudHMgdG8gbG93ZXIgdGhlIGVmZm9ydCB0
byB1c2UgaXQsIGFuZCBkb2N1bWVudGF0aW9uIGlzIG9uZSBvZiB0aGUgbW9zdCBpbXBvcnRhbnQg
dGFza3Mgb24gbXkgbGlzdC4gV2hhdCBkbyB5b3UgdGhpbms/PGJyPjxicj5bMV06IDxhIGhyZWY9
Imh0dHBzOi8vZ2l0aHViLmNvbS92aWNhbW8vb2Zvbm8vdHJlZS9mb3IvdXBzdHJlYW0vZ3RrLWRv
YyI+aHR0cHM6Ly9naXRodWIuY29tL3ZpY2Ftby9vZm9uby90cmVlL2Zvci91cHN0cmVhbS9ndGst
ZG9jPC9hPjxicj48YnI+PC9kaXY+UmVnYXJkcyw8YnI+VmljYW1vIFlhbmc8YnI+PC9kaXY+Cg==

--===============0383444821070715010==--

