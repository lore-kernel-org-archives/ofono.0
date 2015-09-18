Content-Type: multipart/mixed; boundary="===============4784802206080015445=="
MIME-Version: 1.0
From: Jason Gauthier <jagauthier@gmail.com>
Subject: Hands Free/Pulse - not working well
Date: Fri, 18 Sep 2015 14:01:56 -0400
Message-ID: <CAHY_EhUkVh3Ve2LgoK3=4iPxnq8nT5HwuFKCF+mUrz0W4EwYpA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4784802206080015445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Greetings,

      I've been working on getting a HFP working with bluez and
pulseaudio.  I'm running into an assortment of issues- I don't even know
where to begin!

To set the stage, I'm running the latest version of bluez (5.33) pulseaudio
(6.0) and ofono
(pulled out of git). I've compiled everything from source.

Using PA and Bluez, I have audio sink working.  So I've verified several
components at this point.
I can connect the HFP.  Once I start making calls, is when things start to
fall apart.

(BTW, this happens with ofono 1.15, and 1.16 as well)

So, as I'm writing this, the last two times after booting (debian jessie),
connecting, and dialing, the system reboots.  I've tried looking at
debugging the kernel crash, and I've just not got very far.

I realize no one can tell me clearly how to fix this, I would appreciate
some suggestions, or ways I can continue to debug this.

Ultimately, my goal is to put this on a raspberry pi for a car stereo. At
the moment, I am just trying to get a proof of concept working.

Thanks!

--===============4784802206080015445==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+R3JlZXRpbmdzLDxkaXY+PGJyPjwvZGl2PjxkaXY+wqAgwqAgwqAgSSYj
Mzk7dmUgYmVlbiB3b3JraW5nIG9uIGdldHRpbmcgYSBIRlAgd29ya2luZyB3aXRoIGJsdWV6IGFu
ZCBwdWxzZWF1ZGlvLsKgIEkmIzM5O20gcnVubmluZyBpbnRvIGFuIGFzc29ydG1lbnQgb2YgaXNz
dWVzLSBJIGRvbiYjMzk7dCBldmVuIGtub3cgd2hlcmUgdG8gYmVnaW4hPC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj5UbyBzZXQgdGhlIHN0YWdlLCBJJiMzOTttIHJ1bm5pbmcgdGhlIGxhdGVzdCB2
ZXJzaW9uIG9mIGJsdWV6ICg1LjMzKSBwdWxzZWF1ZGlvICg2LjApIGFuZCBvZm9ub8KgPC9kaXY+
PGRpdj4ocHVsbGVkIG91dCBvZiBnaXQpLiBJJiMzOTt2ZSBjb21waWxlZCBldmVyeXRoaW5nIGZy
b20gc291cmNlLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VXNpbmcgUEEgYW5kIEJsdWV6LCBJ
IGhhdmUgYXVkaW8gc2luayB3b3JraW5nLsKgIFNvIEkmIzM5O3ZlIHZlcmlmaWVkIHNldmVyYWwg
Y29tcG9uZW50cyBhdCB0aGlzIHBvaW50LjwvZGl2PjxkaXY+SSBjYW4gY29ubmVjdCB0aGUgSEZQ
LsKgIE9uY2UgSSBzdGFydCBtYWtpbmcgY2FsbHMsIGlzIHdoZW4gdGhpbmdzIHN0YXJ0IHRvIGZh
bGwgYXBhcnQuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4oQlRXLCB0aGlzIGhhcHBlbnMgd2l0
aCBvZm9ubyAxLjE1LCBhbmQgMS4xNiBhcyB3ZWxsKTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
U28sIGFzIEkmIzM5O20gd3JpdGluZyB0aGlzLCB0aGUgbGFzdCB0d28gdGltZXMgYWZ0ZXIgYm9v
dGluZyAoZGViaWFuIGplc3NpZSksIGNvbm5lY3RpbmcsIGFuZCBkaWFsaW5nLCB0aGUgc3lzdGVt
IHJlYm9vdHMuwqAgSSYjMzk7dmUgdHJpZWQgbG9va2luZyBhdCBkZWJ1Z2dpbmcgdGhlIGtlcm5l
bCBjcmFzaCwgYW5kIEkmIzM5O3ZlIGp1c3Qgbm90IGdvdCB2ZXJ5IGZhci48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PkkgcmVhbGl6ZSBubyBvbmUgY2FuIHRlbGwgbWUgY2xlYXJseSBob3cgdG8g
Zml4IHRoaXMsIEkgd291bGQgYXBwcmVjaWF0ZSBzb21lIHN1Z2dlc3Rpb25zLCBvciB3YXlzIEkg
Y2FuIGNvbnRpbnVlIHRvIGRlYnVnIHRoaXMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5VbHRp
bWF0ZWx5LCBteSBnb2FsIGlzIHRvIHB1dCB0aGlzIG9uIGEgcmFzcGJlcnJ5IHBpIGZvciBhIGNh
ciBzdGVyZW8uIEF0IHRoZSBtb21lbnQsIEkgYW0ganVzdCB0cnlpbmcgdG8gZ2V0IGEgcHJvb2Yg
b2YgY29uY2VwdCB3b3JraW5nLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzITwvZGl2
PjwvZGl2Pgo=

--===============4784802206080015445==--

