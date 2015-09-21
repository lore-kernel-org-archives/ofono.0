Content-Type: multipart/mixed; boundary="===============5400723481000685888=="
MIME-Version: 1.0
From: Jason Gauthier <jagauthier@gmail.com>
Subject: Re: Hands Free/Pulse - not working well
Date: Mon, 21 Sep 2015 07:05:44 -0400
Message-ID: <CAHY_EhU1M97b_NVt8F4AQ2VhvBpqtxsSd1StTEMRRiWuJ_9CoA@mail.gmail.com>
In-Reply-To: <55FF97ED.5030604@chini.tk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5400723481000685888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2015 at 1:38 AM, Georg Chini <georg@chini.tk> wrote:

> On 21.09.2015 02:40, Jason Gauthier wrote:
>
>
> On Sun, Sep 20, 2015 at 3:04 PM, Georg Chini <georg@chini.tk> wrote:
>
>> On 20.09.2015 20:27, Jason Gauthier wrote:
>>
>> Follow up:
>>
>> I rebooted and I was able to make and hang up 5 calls in a row.   All the
>> audio was redirected correctly.
>> I had some of the  "SCO packet" errors.
>>
>>
>> >What kind of bluetooth dongle are you using? I had completely unreliable
>> >behavior with a Belkin dongle while others (MSI, Gembird) work fine.
>>
>>
> Bus 001 Device 006: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
> Dongle (HCI mode)
> According to lsusb.
>
> >Further down I read that you are trying this on a virtual machine. Maybe
>> >the virtualization layer is the reason for the kernel crashes. Did you
>> also
>> >test it on a physical machine?
>>
>
>
> You are correct.  I do a bunch of my R&D on a VM because the hardware is
> so much faster than the pi.. and I try not to compile over and over on the
> pi.
> So, I went through the set up this on my pi, to verify functionality.
>
> It really does work much better. As far as stability and functionality I
> would say it works like it should.
> After the first call, the audio is broken and distorted.  the A2DP profile
> still plays perfectly though.
>
> I don't know which layer this is happening it.  I restarted pulse, ofono,
> and bluetoothd methodically testing after each and could not improve it.
> So, that could at any layer.
>
> Thanks for your help.  I've been struggling with this setup for a few
> weeks, trying to get it all to work.
>
>
> >The remaining problem is probably somewhere in the audio stack of the PI.
> As far as I understand
> >audio works well on your VM but you get crashes there. Can you run
> pulseaudio with debugging
> >(pulseaudio -vvv) on your PI and post the relevant parts of the output?
> Maybe you can even see
> >some difference for the second call when you compare the output of the PI
> to that of the VM.
>

You led me down the right path.  I'm using a USB audio device.  These are
typically a higher quality than the built in Pi audio.
However, I switched my config to use the built in bcm chip instead of my
USB device... and the audio was perfect after 3 calls.
Nice! I still want to use a USB device because (from my reading) the build
in sound chip is not suitable for a car stereo.
I am going to try another one. If it doesn't work, I will have to do some
"on the fly" audio sink changing and use both.
Thanks again!

--===============5400723481000685888==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPk9uIE1vbiwgU2VwIDIxLCAyMDE1IGF0IDE6MzggQU0sIEdlb3JnIENo
aW5pIDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmdlb3JnQGNoaW5pLnRrIiB0
YXJnZXQ9Il9ibGFuayI+Z2VvcmdAY2hpbmkudGs8L2E+Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxi
bG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2Jv
cmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgogIAogICAgCiAgCiAg
PGRpdiBiZ2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMDAwMDAwIj4KICAgIDxkaXY+T24gMjEuMDku
MjAxNSAwMjo0MCwgSmFzb24gR2F1dGhpZXIKICAgICAgd3JvdGU6PGJyPgogICAgPC9kaXY+CiAg
ICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgPGRpdiBkaXI9Imx0ciI+CiAgICAgICAg
PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxicj4KICAgICAgICAgIDxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj5PbiBTdW4sIFNlcCAyMCwgMjAxNSBhdCAzOjA0IFBNLAogICAgICAgICAgICBHZW9y
ZyBDaGluaSA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpnZW9yZ0BjaGluaS50
ayIgdGFyZ2V0PSJfYmxhbmsiPmdlb3JnQGNoaW5pLnRrPC9hPiZndDs8L3NwYW4+CiAgICAgICAg
ICAgIHdyb3RlOjxicj4KICAgICAgICAgICAgPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFweDti
b3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO2JvcmRlci1sZWZ0LXN0eWxlOnNvbGlk
O3BhZGRpbmctbGVmdDoxZXgiPgogICAgICAgICAgICAgIDxkaXYgYmdjb2xvcj0iI0ZGRkZGRiIg
dGV4dD0iIzAwMDAwMCI+CiAgICAgICAgICAgICAgICA8ZGl2Pk9uIDIwLjA5LjIwMTUgMjA6Mjcs
IEphc29uIEdhdXRoaWVyIHdyb3RlOjxicj4KICAgICAgICAgICAgICAgIDwvZGl2PgogICAgICAg
ICAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgICAgICAgICAgIDxkaXYg
ZGlyPSJsdHIiPkZvbGxvdyB1cDoKICAgICAgICAgICAgICAgICAgICA8ZGl2Pjxicj4KICAgICAg
ICAgICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgICAgICAgICA8ZGl2PkkgcmVib290ZWQg
YW5kIEkgd2FzIGFibGUgdG8gbWFrZSBhbmQgaGFuZyB1cCA1CiAgICAgICAgICAgICAgICAgICAg
ICBjYWxscyBpbiBhIHJvdy4gwqAgQWxsIHRoZSBhdWRpbyB3YXMgcmVkaXJlY3RlZAogICAgICAg
ICAgICAgICAgICAgICAgY29ycmVjdGx5LjwvZGl2PgogICAgICAgICAgICAgICAgICAgIDxkaXY+
SSBoYWQgc29tZSBvZiB0aGUgwqAmcXVvdDtTQ08gcGFja2V0JnF1b3Q7IGVycm9ycy48L2Rpdj4K
ICAgICAgICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAg
ICAgICAgICAgICAgICA8YnI+CiAgICAgICAgICAgICAgICAmZ3Q7V2hhdCBraW5kIG9mIGJsdWV0
b290aCBkb25nbGUgYXJlIHlvdSB1c2luZz8gSSBoYWQKICAgICAgICAgICAgICAgIGNvbXBsZXRl
bHkgdW5yZWxpYWJsZTxicj4KICAgICAgICAgICAgICAgICZndDtiZWhhdmlvciB3aXRoIGEgQmVs
a2luIGRvbmdsZSB3aGlsZSBvdGhlcnMgKE1TSSwKICAgICAgICAgICAgICAgIEdlbWJpcmQpIHdv
cmsgZmluZS48YnI+CiAgICAgICAgICAgICAgICA8YnI+CiAgICAgICAgICAgICAgPC9kaXY+CiAg
ICAgICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAgICAgPGRpdj48YnI+CiAgICAgICAgICAg
IDwvZGl2PgogICAgICAgICAgICA8ZGl2PgogICAgICAgICAgICAgIDxkaXY+QnVzIDAwMSBEZXZp
Y2UgMDA2OiBJRCAwYTEyOjAwMDEgQ2FtYnJpZGdlIFNpbGljb24KICAgICAgICAgICAgICAgIFJh
ZGlvLCBMdGQgQmx1ZXRvb3RoIERvbmdsZSAoSENJIG1vZGUpPC9kaXY+CiAgICAgICAgICAgIDwv
ZGl2PgogICAgICAgICAgICA8ZGl2PkFjY29yZGluZyB0byBsc3VzYi48L2Rpdj4KICAgICAgICAg
ICAgPGRpdj48YnI+CiAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICA8YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVy
LWxlZnQtd2lkdGg6MXB4O2JvcmRlci1sZWZ0LWNvbG9yOnJnYigyMDQsMjA0LDIwNCk7Ym9yZGVy
LWxlZnQtc3R5bGU6c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+CiAgICAgICAgICAgICAgPGRpdiBi
Z2NvbG9yPSIjRkZGRkZGIiB0ZXh0PSIjMDAwMDAwIj4mZ3Q7RnVydGhlciBkb3duIEkKICAgICAg
ICAgICAgICAgIHJlYWQgdGhhdCB5b3UgYXJlIHRyeWluZyB0aGlzIG9uIGEgdmlydHVhbCBtYWNo
aW5lLgogICAgICAgICAgICAgICAgTWF5YmU8YnI+CiAgICAgICAgICAgICAgICAmZ3Q7dGhlIHZp
cnR1YWxpemF0aW9uIGxheWVyIGlzIHRoZSByZWFzb24gZm9yIHRoZQogICAgICAgICAgICAgICAg
a2VybmVsIGNyYXNoZXMuIERpZCB5b3UgYWxzbzxicj4KICAgICAgICAgICAgICAgICZndDt0ZXN0
IGl0IG9uIGEgcGh5c2ljYWwgbWFjaGluZT88YnI+CiAgICAgICAgICAgICAgPC9kaXY+CiAgICAg
ICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAgICAgPGRpdj48YnI+CiAgICAgICAgICAgIDwv
ZGl2PgogICAgICAgICAgICA8ZGl2Pjxicj4KICAgICAgICAgICAgPC9kaXY+CiAgICAgICAgICAg
IDxkaXY+WW91IGFyZSBjb3JyZWN0LsKgIEkgZG8gYSBidW5jaCBvZiBteSBSJmFtcDtEIG9uIGEg
Vk0KICAgICAgICAgICAgICBiZWNhdXNlIHRoZSBoYXJkd2FyZSBpcyBzbyBtdWNoIGZhc3RlciB0
aGFuIHRoZSBwaS4uIGFuZCBJCiAgICAgICAgICAgICAgdHJ5IG5vdCB0byBjb21waWxlIG92ZXIg
YW5kIG92ZXIgb24gdGhlIHBpLjwvZGl2PgogICAgICAgICAgICA8ZGl2PlNvLCBJIHdlbnQgdGhy
b3VnaCB0aGUgc2V0IHVwIHRoaXMgb24gbXkgcGksIHRvIHZlcmlmeQogICAgICAgICAgICAgIGZ1
bmN0aW9uYWxpdHkuPC9kaXY+CiAgICAgICAgICAgIDxkaXY+PGJyPgogICAgICAgICAgICA8L2Rp
dj4KICAgICAgICAgICAgPGRpdj5JdCByZWFsbHkgZG9lcyB3b3JrIG11Y2ggYmV0dGVyLiBBcyBm
YXIgYXMgc3RhYmlsaXR5CiAgICAgICAgICAgICAgYW5kIGZ1bmN0aW9uYWxpdHkgSSB3b3VsZCBz
YXkgaXQgd29ya3MgbGlrZSBpdCBzaG91bGQuPC9kaXY+CiAgICAgICAgICAgIDxkaXY+QWZ0ZXIg
dGhlIGZpcnN0IGNhbGwsIHRoZSBhdWRpbyBpcyBicm9rZW4gYW5kCiAgICAgICAgICAgICAgZGlz
dG9ydGVkLiDCoHRoZSBBMkRQIHByb2ZpbGUgc3RpbGwgcGxheXMgcGVyZmVjdGx5IHRob3VnaC48
L2Rpdj4KICAgICAgICAgICAgPGRpdj48YnI+CiAgICAgICAgICAgIDwvZGl2PgogICAgICAgICAg
ICA8ZGl2PkkgZG9uJiMzOTt0IGtub3cgd2hpY2ggbGF5ZXIgdGhpcyBpcyBoYXBwZW5pbmcgaXQu
wqAgSQogICAgICAgICAgICAgIHJlc3RhcnRlZCBwdWxzZSwgb2Zvbm8sIGFuZCBibHVldG9vdGhk
IG1ldGhvZGljYWxseQogICAgICAgICAgICAgIHRlc3RpbmcgYWZ0ZXIgZWFjaCBhbmQgY291bGQg
bm90IGltcHJvdmUgaXQuPC9kaXY+CiAgICAgICAgICAgIDxkaXY+U28sIHRoYXQgY291bGQgYXQg
YW55IGxheWVyLjwvZGl2PgogICAgICAgICAgICA8ZGl2Pjxicj4KICAgICAgICAgICAgPC9kaXY+
CiAgICAgICAgICAgIDxkaXY+VGhhbmtzIGZvciB5b3VyIGhlbHAuwqAgSSYjMzk7dmUgYmVlbiBz
dHJ1Z2dsaW5nIHdpdGggdGhpcwogICAgICAgICAgICAgIHNldHVwIGZvciBhIGZldyB3ZWVrcywg
dHJ5aW5nIHRvIGdldCBpdCBhbGwgdG8gd29yay48L2Rpdj4KICAgICAgICAgICAgPGRpdj48YnI+
CiAgICAgICAgICAgIDwvZGl2Pjxicj48L2Rpdj4KICAgICAgICA8L2Rpdj4KICAgICAgPC9kaXY+
CiAgICA8L2Jsb2NrcXVvdGU+Jmd0O1RoZSByZW1haW5pbmcgcHJvYmxlbSBpcyBwcm9iYWJseSBz
b21ld2hlcmUgaW4gdGhlIGF1ZGlvIHN0YWNrIG9mCiAgICB0aGUgUEkuIEFzIGZhciBhcyBJIHVu
ZGVyc3RhbmQ8YnI+Jmd0O2F1ZGlvIHdvcmtzIHdlbGwgb24geW91ciBWTSBidXQgeW91IGdldCBj
cmFzaGVzIHRoZXJlLiBDYW4geW91IHJ1bgogICAgcHVsc2VhdWRpbyB3aXRoIGRlYnVnZ2luZzxi
cj4mZ3Q7KHB1bHNlYXVkaW8gLXZ2dikgb24geW91ciBQSSBhbmQgcG9zdCB0aGUgcmVsZXZhbnQg
cGFydHMgb2YgdGhlCiAgICBvdXRwdXQ/IE1heWJlIHlvdSBjYW4gZXZlbiBzZWU8YnI+Jmd0O3Nv
bWUgZGlmZmVyZW5jZSBmb3IgdGhlIHNlY29uZCBjYWxsIHdoZW4geW91IGNvbXBhcmUgdGhlIG91
dHB1dCBvZgogICAgdGhlIFBJIHRvIHRoYXQgb2YgdGhlIFZNLsKgIDxicj4KICA8L2Rpdj4KCjwv
YmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPllvdSBs
ZWQgbWUgZG93biB0aGUgcmlnaHQgcGF0aC7CoCBJJiMzOTttIHVzaW5nIGEgVVNCIGF1ZGlvIGRl
dmljZS7CoCBUaGVzZSBhcmUgdHlwaWNhbGx5IGEgaGlnaGVyIHF1YWxpdHkgdGhhbiB0aGUgYnVp
bHQgaW4gUGkgYXVkaW8uPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPkhvd2V2ZXIsIEkg
c3dpdGNoZWQgbXkgY29uZmlnIHRvIHVzZSB0aGUgYnVpbHQgaW4gYmNtwqBjaGlwIGluc3RlYWQg
b2YgbXkgVVNCIGRldmljZS4uLiBhbmQgdGhlIGF1ZGlvIHdhcyBwZXJmZWN0IGFmdGVyIDMgY2Fs
bHMuPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPk5pY2UhIEkgc3RpbGwgd2FudCB0byB1
c2UgYSBVU0IgZGV2aWNlIGJlY2F1c2UgKGZyb20gbXkgcmVhZGluZykgdGhlIGJ1aWxkIGluIHNv
dW5kIGNoaXAgaXMgbm90IHN1aXRhYmxlIGZvciBhIGNhciBzdGVyZW8uPC9kaXY+PGRpdiBjbGFz
cz0iZ21haWxfZXh0cmEiPkkgYW0gZ29pbmcgdG8gdHJ5IGFub3RoZXIgb25lLiBJZiBpdCBkb2Vz
biYjMzk7dCB3b3JrLCBJIHdpbGwgaGF2ZSB0byBkbyBzb21lICZxdW90O29uIHRoZSBmbHkmcXVv
dDsgYXVkaW8gc2luayBjaGFuZ2luZyBhbmQgdXNlIGJvdGguwqA8L2Rpdj48ZGl2IGNsYXNzPSJn
bWFpbF9leHRyYSI+VGhhbmtzIGFnYWluITwvZGl2PjwvZGl2Pgo=

--===============5400723481000685888==--

