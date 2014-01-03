Content-Type: multipart/mixed; boundary="===============5784612189489595755=="
MIME-Version: 1.0
From: Ignazio Chiappone <gnz.chp@gmail.com>
Subject: oFono issue: Reject SCO: Agent not registered
Date: Fri, 03 Jan 2014 17:16:01 -0500
Message-ID: <CANhWJ4gCop1pjGr6T4tBJ=iGicCsvqfNnrhr6UqCv3qVv6PJ2Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5784612189489595755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello everyone,

my goal is to use the bluetooth HFP to make/receive a call, however I have
a problem with oFono.
Actually I'm working on Fedora 20 with blueZ 5.12 and oFono 1.14 .

When I start ofonod I see this: http://pastebin.com/AsukjcXx .

Using test script enable-modem, after pair my device with linux, everything
seems to work fine, on ofonod in debug mode, I see this:
http://pastebin.com/2GBmZERk .

Now, using my device I try to make/receive a call, but I see in both cases
this error:

Reject SCO: Agent not registered
Reject SCO: Agent not registered
Reject SCO: Agent not registered .

I don't understand if that kind of problem is related to oFono or blueZ,
because I think it's blueZ duty to establish the SCO link, but the agent
reported on the error message is a particular blueZ agent or an oFono agent?

Have anyone an idea to solve my problem?

Please if you need more details let me know.

Thanks in advance
Ignazio

--===============5784612189489595755==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGVsbG8gZXZlcnlvbmUsPGRpdj48YnI+PC9kaXY+PGRpdj5teSBnb2Fs
IGlzIHRvIHVzZSB0aGUgYmx1ZXRvb3RoIEhGUCB0byBtYWtlL3JlY2VpdmUgYSBjYWxsLCBob3dl
dmVyIEkgaGF2ZSBhIHByb2JsZW0gd2l0aCBvRm9uby48L2Rpdj48ZGl2PkFjdHVhbGx5IEkmIzM5
O20gd29ya2luZyBvbiBGZWRvcmEgMjAgd2l0aCBibHVlWiA1LjEyIGFuZCBvRm9ubyAxLjE0IC48
L2Rpdj4KCjxkaXY+PGJyPjwvZGl2PjxkaXY+V2hlbiBJIHN0YXJ0IG9mb25vZCBJIHNlZSB0aGlz
OqA8YSBocmVmPSJodHRwOi8vcGFzdGViaW4uY29tL0FzdWtqY1h4Ij5odHRwOi8vcGFzdGViaW4u
Y29tL0FzdWtqY1h4PC9hPqAuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Vc2luZyB0ZXN0IHNj
cmlwdCBlbmFibGUtbW9kZW0sIGFmdGVyIHBhaXIgbXkgZGV2aWNlIHdpdGggbGludXgsIGV2ZXJ5
dGhpbmcgc2VlbXMgdG8gd29yayBmaW5lLCBvbiBvZm9ub2QgaW4gZGVidWcgbW9kZSwgSSBzZWUg
dGhpczqgPGEgaHJlZj0iaHR0cDovL3Bhc3RlYmluLmNvbS8yR0JtWkVSayI+aHR0cDovL3Bhc3Rl
YmluLmNvbS8yR0JtWkVSazwvYT6gLjwvZGl2PgoKPGRpdj48YnI+PC9kaXY+PGRpdj5Ob3csIHVz
aW5nIG15IGRldmljZSBJIHRyeSB0byBtYWtlL3JlY2VpdmUgYSBjYWxsLCBidXQgSSBzZWUgaW4g
Ym90aCBjYXNlcyB0aGlzIGVycm9yOjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVqZWN0IFND
TzogQWdlbnQgbm90IHJlZ2lzdGVyZWQ8L2Rpdj48ZGl2PlJlamVjdCBTQ086IEFnZW50IG5vdCBy
ZWdpc3RlcmVkPC9kaXY+PGRpdj5SZWplY3QgU0NPOiBBZ2VudCBub3QgcmVnaXN0ZXJlZCAuPC9k
aXY+Cgo8ZGl2Pjxicj48L2Rpdj48ZGl2PkkgZG9uJiMzOTt0IHVuZGVyc3RhbmQgaWYgdGhhdCBr
aW5kIG9mIHByb2JsZW0gaXMgcmVsYXRlZCB0byBvRm9ubyBvciBibHVlWiwgYmVjYXVzZSBJIHRo
aW5rIGl0JiMzOTtzIGJsdWVaoGR1dHkgdG8gZXN0YWJsaXNoIHRoZSBTQ08gbGluaywgYnV0IHRo
ZSBhZ2VudCByZXBvcnRlZCBvbiB0aGUgZXJyb3IgbWVzc2FnZSBpcyBhIHBhcnRpY3VsYXIgYmx1
ZVogYWdlbnQgb3IgYW4gb0Zvbm8gYWdlbnQ/PC9kaXY+Cgo8ZGl2Pjxicj48L2Rpdj48ZGl2Pkhh
dmUgYW55b25lIGFuIGlkZWEgdG8gc29sdmUgbXkgcHJvYmxlbT88L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PlBsZWFzZSBpZiB5b3UgbmVlZCBtb3JlIGRldGFpbHMgbGV0IG1lIGtub3cuPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3MgaW4gYWR2YW5jZTwvZGl2PjxkaXY+SWduYXppbzwv
ZGl2PjwvZGl2Pgo=

--===============5784612189489595755==--

