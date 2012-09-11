Content-Type: multipart/mixed; boundary="===============1622151472527343490=="
MIME-Version: 1.0
From: Erik <stimpit@gmail.com>
Subject: Getting started (serial GPRS modem)
Date: Tue, 11 Sep 2012 15:17:59 +0200
Message-ID: <CAK2MJLofabWuABc8vOnZ+tF_p4nMHugoMoSYTmK1wm0KFE3+EQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1622151472527343490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

I've been looking at ofono for quite some time now. A couple of years ago I
wrote a lot of code to interface a GPRS modem. Now I need to do basically
the same again and I wonder if ofono would be a good idea to use.

The modem is not supported by ofono out of the box (no driver for it in the
tree).

First of all, I must say that I really miss some kind of "getting started"
information on the home page. Maybe I have just not found it. Is there such
a thing?

Second, the modem is a serial GPRS modem connected through a serial line.
This has to be farily common. Isn't there a simple way of just testing
ofono without adding udev rules, writing drivers, etc? What I would like is
basically to start ofonod with a path to the serial device, telling it to
use only standard (not device-specific) AT commands.

I don't think what I'd like to do is possible. So I added an udev rule in
the form of:

KERNEL=3D=3D"ttyUSB*", ENV{OFONO_DRIVER}=3D"nokia"

This gives me some indication that something happens when I start ofonod:

ofonod[21742]: plugins/udev.c:add_modem()
/devices/pci0000:00/0000:00:06.0/usb2/2-2/2-2:1.0/ttyUSB0/tty/ttyUSB0
(atmodem)

How do I proceed from here?

test/llist-modems gives me nothing.

Do the existing drivers check that the modem is actually a modem of that
type (nokia in this case)?

I am not looking for anything fancy. I basically only want to set up a GPRS
connection and maybe do operator selection.
No voice, no SMS, nothing more.

I tried this with the ofono-1.10 release.

Thanks,
Erik

--===============1622151472527343490==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkhPGJyPjxicj5JJiMzOTt2ZSBiZWVuIGxvb2tpbmcgYXQgb2Zvbm8gZm9yIHF1aXRlIHNvbWUg
dGltZSBub3cuIEEgY291cGxlIG9mIHllYXJzIGFnbyBJIHdyb3RlIGEgbG90IG9mIGNvZGUgdG8g
aW50ZXJmYWNlIGEgR1BSUyBtb2RlbS4gTm93IEkgbmVlZCB0byBkbyBiYXNpY2FsbHkgdGhlIHNh
bWUgYWdhaW4gYW5kIEkgd29uZGVyIGlmIG9mb25vIHdvdWxkIGJlIGEgZ29vZCBpZGVhIHRvIHVz
ZS48YnI+Cjxicj5UaGUgbW9kZW0gaXMgbm90IHN1cHBvcnRlZCBieSBvZm9ubyBvdXQgb2YgdGhl
IGJveCAobm8gZHJpdmVyIGZvciBpdCBpbiB0aGUgdHJlZSkuPGJyPjxicj5GaXJzdCBvZiBhbGws
IEkgbXVzdCBzYXkgdGhhdCBJIHJlYWxseSBtaXNzIHNvbWUga2luZCBvZiAmcXVvdDtnZXR0aW5n
IHN0YXJ0ZWQmcXVvdDsgaW5mb3JtYXRpb24gb24gdGhlIGhvbWUgcGFnZS4gTWF5YmUgSSBoYXZl
IGp1c3Qgbm90IGZvdW5kIGl0LiBJcyB0aGVyZSBzdWNoIGEgdGhpbmc/PGJyPgo8YnI+U2Vjb25k
LCB0aGUgbW9kZW0gaXMgYSBzZXJpYWwgR1BSUyBtb2RlbSBjb25uZWN0ZWQgdGhyb3VnaCBhIHNl
cmlhbCBsaW5lLiBUaGlzIGhhcyB0byBiZSBmYXJpbHkgY29tbW9uLiBJc24mIzM5O3QgdGhlcmUg
YSBzaW1wbGUgd2F5IG9mIGp1c3QgdGVzdGluZyBvZm9ubyB3aXRob3V0IGFkZGluZyB1ZGV2IHJ1
bGVzLCB3cml0aW5nIGRyaXZlcnMsIGV0Yz8gV2hhdCBJIHdvdWxkIGxpa2UgaXMgYmFzaWNhbGx5
IHRvIHN0YXJ0IG9mb25vZCB3aXRoIGEgcGF0aCB0byB0aGUgc2VyaWFsIGRldmljZSwgdGVsbGlu
ZyBpdCB0byB1c2Ugb25seSBzdGFuZGFyZCAobm90IGRldmljZS1zcGVjaWZpYykgQVQgY29tbWFu
ZHMuPGJyPgo8YnI+SSBkb24mIzM5O3QgdGhpbmsgd2hhdCBJJiMzOTtkIGxpa2UgdG8gZG8gaXMg
cG9zc2libGUuIFNvIEkgYWRkZWQgYW4gdWRldiBydWxlIGluIHRoZSBmb3JtIG9mOjxicj48YnI+
S0VSTkVMPT0mcXVvdDt0dHlVU0IqJnF1b3Q7LCBFTlZ7T0ZPTk9fRFJJVkVSfT0mcXVvdDtub2tp
YSZxdW90Ozxicj48YnI+VGhpcyBnaXZlcyBtZSBzb21lIGluZGljYXRpb24gdGhhdCBzb21ldGhp
bmcgaGFwcGVucyB3aGVuIEkgc3RhcnQgb2Zvbm9kOjxicj4KPGJyPm9mb25vZFsyMTc0Ml06IHBs
dWdpbnMvdWRldi5jOmFkZF9tb2RlbSgpIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDowNi4w
L3VzYjIvMi0yLzItMjoxLjAvdHR5VVNCMC90dHkvdHR5VVNCMCAoYXRtb2RlbSk8YnI+PGJyPkhv
dyBkbyBJIHByb2NlZWQgZnJvbSBoZXJlPzxicj48YnI+dGVzdC9sbGlzdC1tb2RlbXMgZ2l2ZXMg
bWUgbm90aGluZy48YnI+PGJyPkRvIHRoZSBleGlzdGluZyBkcml2ZXJzIGNoZWNrIHRoYXQgdGhl
IG1vZGVtIGlzIGFjdHVhbGx5IGEgbW9kZW0gb2YgdGhhdCB0eXBlIChub2tpYSBpbiB0aGlzIGNh
c2UpPzxicj4KPGJyPkkgYW0gbm90IGxvb2tpbmcgZm9yIGFueXRoaW5nIGZhbmN5LiBJIGJhc2lj
YWxseSBvbmx5IHdhbnQgdG8gc2V0IHVwIGEgR1BSUyBjb25uZWN0aW9uIGFuZCBtYXliZSBkbyBv
cGVyYXRvciBzZWxlY3Rpb24uPGJyPk5vIHZvaWNlLCBubyBTTVMsIG5vdGhpbmcgbW9yZS48YnI+
PGJyPkkgdHJpZWQgdGhpcyB3aXRoIHRoZSBvZm9uby0xLjEwIHJlbGVhc2UuPGJyPjxicj5UaGFu
a3MsPGJyPgpFcmlrPGJyPjxicj48YnI+Cg==

--===============1622151472527343490==--

