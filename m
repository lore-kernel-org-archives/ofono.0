Content-Type: multipart/mixed; boundary="===============5147235388299754434=="
MIME-Version: 1.0
From: Bruno Bruzzano <brunano21@gmail.com>
Subject: Re: Unable to hang up a call.
Date: Tue, 04 Feb 2014 09:37:10 -0500
Message-ID: <CACA6DsXHOU8_4UunGp8U4wvjMMC0vc+-m5M5sUO1vZB1Acqzhg@mail.gmail.com>
In-Reply-To: <CACA6DsXssq1gpa22v8G=VDQ6hwv4USM=hDnrzttqYzmngVtbew@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5147235388299754434==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Edit:
I tried with a Nexus5 and an iPhone4, but in both cases I got the same
result. Furthermore, I think the problem is related to a not-responsiveness
by oFono, since after I accept the call, the status should pass from
'incoming' to 'active', but unfortunately it is not so. In fact, if I try
to retrieve the voicecalls, using the getCalls() method, it does not give
nothing.



2014-02-03 Bruno Bruzzano <brunano21@gmail.com>:

> Hi everyone,
>
> I'm writing you since denkenz (on IRC channel) suggested me.
> I'm using oFono 1.14. My issue is that, basically, I'm not able to hang up
> an active call.
> Here I made a pastebin of oFono daemon. - http://pastebin.com/h8x6uk1d
>
> When I call the Hangup() method, I get the following
> org.freedesktop.DBus.Error.NoReply.
> The problem is present also using d-feet. A timeout expires.
>
> By the way, if I retry to call the method again I
> get:  org.ofono.Error.InProgress.
>
> Could I have missed something?
>
> If you require more information, please let me know.
> Thanks.
>
> Best Regards.
>

--===============5147235388299754434==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+RWRpdDo8ZGl2PkkgdHJpZWQgd2l0aCBhIE5leHVzNSBhbmQgYW4gaVBo
b25lNCwgYnV0IGluIGJvdGggY2FzZXMgSSBnb3QgdGhlIHNhbWUgcmVzdWx0LiBGdXJ0aGVybW9y
ZSwgSSB0aGluayB0aGUgcHJvYmxlbSBpcyByZWxhdGVkIHRvIGEgbm90LXJlc3BvbnNpdmVuZXNz
IGJ5IG9Gb25vLCBzaW5jZSBhZnRlciBJIGFjY2VwdCB0aGUgY2FsbCwgdGhlIHN0YXR1cyBzaG91
bGQgcGFzcyBmcm9tICYjMzk7aW5jb21pbmcmIzM5OyB0byAmIzM5O2FjdGl2ZSYjMzk7LCBidXQg
dW5mb3J0dW5hdGVseSBpdCBpcyBub3Qgc28uIEluIGZhY3QsIGlmIEkgdHJ5IHRvIHJldHJpZXZl
IHRoZSB2b2ljZWNhbGxzLCB1c2luZyB0aGUgZ2V0Q2FsbHMoKSBtZXRob2QsIGl0IGRvZXMgbm90
IGdpdmUgbm90aGluZy48L2Rpdj4KCjxkaXY+oDxicj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+
PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+MjAxNC0wMi0wMyBCcnVubyBCcnV6emFu
byA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpicnVuYW5vMjFAZ21haWwuY29t
IiB0YXJnZXQ9Il9ibGFuayI+YnJ1bmFubzIxQGdtYWlsLmNvbTwvYT4mZ3Q7PC9zcGFuPjo8YnI+
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7
Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+Cgo8ZGl2IGRpcj0i
bHRyIj5IaSBldmVyeW9uZSw8ZGl2Pjxicj48L2Rpdj48ZGl2PkkmIzM5O20gd3JpdGluZyB5b3Ug
c2luY2UgZGVua2VueiAob24gSVJDIGNoYW5uZWwpIHN1Z2dlc3RlZCBtZS48L2Rpdj48ZGl2Pkkm
IzM5O20gdXNpbmcgb0Zvbm8gMS4xNC4gTXkgaXNzdWUgaXMgdGhhdCwgYmFzaWNhbGx5LCBJJiMz
OTttIG5vdCBhYmxlIHRvIGhhbmcgdXAgYW4gYWN0aXZlIGNhbGwuoDwvZGl2PgoKCjxkaXY+SGVy
ZSBJIG1hZGUgYSBwYXN0ZWJpbiBvZiBvRm9ubyBkYWVtb24uIC2gPGEgaHJlZj0iaHR0cDovL3Bh
c3RlYmluLmNvbS9oOHg2dWsxZCIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly9wYXN0ZWJpbi5jb20v
aDh4NnVrMWQ8L2E+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5XaGVuIEkgY2FsbCB0aGUgSGFu
Z3VwKCkgbWV0aG9kLCBJIGdldCB0aGUgZm9sbG93aW5nIG9yZy5mcmVlZGVza3RvcC5EQnVzLkVy
cm9yLk5vUmVwbHkuPC9kaXY+CgoKPGRpdj5UaGUgcHJvYmxlbSBpcyBwcmVzZW50IGFsc28gdXNp
bmcgZC1mZWV0LiBBIHRpbWVvdXQgZXhwaXJlcy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkJ5
IHRoZSB3YXksIGlmIEkgcmV0cnkgdG8gY2FsbCB0aGUgbWV0aG9kIGFnYWluIEkgZ2V0OqCgb3Jn
Lm9mb25vLkVycm9yLkluUHJvZ3Jlc3MuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Db3VsZCBJ
IGhhdmUgbWlzc2VkIHNvbWV0aGluZz88L2Rpdj4KCgo8ZGl2Pjxicj48L2Rpdj48ZGl2PklmIHlv
dSByZXF1aXJlIG1vcmUgaW5mb3JtYXRpb24sIHBsZWFzZSBsZXQgbWUga25vdy48L2Rpdj48ZGl2
PlRoYW5rcy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkJlc3QgUmVnYXJkcy48L2Rpdj48L2Rp
dj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj48L2Rpdj48L2Rpdj4K

--===============5147235388299754434==--

