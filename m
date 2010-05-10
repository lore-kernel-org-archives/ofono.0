Content-Type: multipart/mixed; boundary="===============0659185894418629213=="
MIME-Version: 1.0
From: krishna k <id_kishore@live.in>
Subject: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Mon, 10 May 2010 13:43:09 +0530
Message-ID: <COL106-W4038AFB0D06866E8DA5DA2F6F90@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0659185894418629213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Yoon, =


I placed modem.conf file under /etc/ofono, and i tried with ./test/list-mod=
ems script. Still it is not showing any =

thing on command line.  I tried to enable the phonesim0 modem with followin=
g command and i am getting the same o/p

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

./enable-modem /phonesim0

******************etc.....

dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod: Me=
thod "SetProperty" =

with signature "sb" on interface "org.ofono.Modem" doesn't exist.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The same error as below. It is not able to detect the phonesim0?

regards,
Krishna K Kandula.

Hi Krishna,

You should put your modem.conf file under /etc/ofono/.

Thanks,
Yoon

From: ofono-bounces@ofono.org [mailto:ofono-bounces at ofono.org] On Beh=
alf Of krishna k
Sent: Monday, May 10, 2010 3:43 PM
To: ofono@ofono.org
Subject: How to start ofono-phonesim in ubuntu-10.04 -reg


Hi Zhenhua,

Thanks for your reply..

I added the following code in /usr/share/alsa/pcm/modem.conf file...

1.
#
#Sample for using phone simulator
#
[phonesim]
Driver=3Dphonesim
Address=3D127.0.0.1
port=3D12345

---------------------------------------------------------------------------=
--------------------------------------------------------------
I tried to ./list_modems. I got nothing on command prompt. According to my =
knowledge i should get the available modems (atleast phonesim0)
I tried to enable  the modem using the following command..

./enable-modem /phonesim0

I got =

output as follows...

---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
----------------------------------------

Connecting
 modem /phonesim0...

Traceback =

(most recent call last):

  File =

"./enable-modem", line 20, in <module>

    =

modem.SetProperty("Powered", dbus.Boolean(1))

  File =

"/usr/lib/pymodules/python2.6/dbus/proxies.py", line 68, in __call__

    return
 self._proxy_method(*args, **keywords)

  File =

"/usr/lib/pymodules/python2.6/dbus/proxies.py", line 140, in __call__

    =

**keywords)

  File =

"/usr/lib/pymodules/python2.6/dbus/connection.py", line 620, in =

call_blocking

    =

message, timeout)

dbus.exceptions.DBusException:
 org.freedesktop.DBus.Error.UnknownMethod: Method "SetProperty" with =

signature "sb" on interface "org.ofono.Modem" doesn't exist

---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------------------------------
Have a nice time.

Regards,
Krishna K Kandula
 		 	   		  =

_________________________________________________________________
Bollywood This Decade
http://entertainment.in.msn.com/bollywoodthisdecade/

--===============0659185894418629213==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8c3R5bGU+PCEtLQouaG1tZXNzYWdlIFAKewptYXJnaW46MHB4OwpwYWRk
aW5nOjBweAp9CmJvZHkuaG1tZXNzYWdlCnsKZm9udC1zaXplOiAxMHB0Owpmb250LWZhbWlseTpW
ZXJkYW5hCn0KLS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBjbGFzcz0naG1tZXNzYWdlJz4KPHBy
ZT5IaSBZb29uLCA8YnI+PGJyPkkgcGxhY2VkIG1vZGVtLmNvbmYgZmlsZSB1bmRlciAvZXRjL29m
b25vLCBhbmQgaSB0cmllZCB3aXRoIC4vdGVzdC9saXN0LW1vZGVtcyBzY3JpcHQuIFN0aWxsIGl0
IGlzIG5vdCBzaG93aW5nIGFueSA8YnI+dGhpbmcgb24gY29tbWFuZCBsaW5lLiAgSSB0cmllZCB0
byBlbmFibGUgdGhlIHBob25lc2ltMCBtb2RlbSB3aXRoIGZvbGxvd2luZyBjb21tYW5kIGFuZCBp
IGFtIGdldHRpbmcgdGhlIHNhbWUgby9wPGJyPjxicj49PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PGJyPjxicj4uL2VuYWJsZS1tb2Rl
bSAvcGhvbmVzaW0wPGJyPjxicj4qKioqKioqKioqKioqKioqKipldGMuLi4uLjxicj48YnI+ZGJ1
cy5leGNlcHRpb25zLkRCdXNFeGNlcHRpb246IG9yZy5mcmVlZGVza3RvcC5EQnVzLkVycm9yLlVu
a25vd25NZXRob2Q6IE1ldGhvZCAiU2V0UHJvcGVydHkiIDxicj53aXRoIHNpZ25hdHVyZSAic2Ii
IG9uIGludGVyZmFjZSAib3JnLm9mb25vLk1vZGVtIiBkb2Vzbid0IGV4aXN0Ljxicj48YnI+PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PTxicj48YnI+VGhlIHNhbWUgZXJyb3IgYXMgYmVsb3cuIEl0IGlzIG5vdCBhYmxlIHRvIGRldGVj
dCB0aGUgcGhvbmVzaW0wPzxicj48YnI+cmVnYXJkcyw8YnI+S3Jpc2huYSBLIEthbmR1bGEuPGJy
Pjxicj5IaSBLcmlzaG5hLDxicj48YnI+WW91IHNob3VsZCBwdXQgeW91ciBtb2RlbS5jb25mIGZp
bGUgdW5kZXIgL2V0Yy9vZm9uby8uPGJyPjxicj5UaGFua3MsPGJyPllvb248YnI+PGJyPkZyb206
IDxhIGhyZWY9Imh0dHA6Ly9saXN0cy5vZm9uby5vcmcvbGlzdGluZm8vb2Zvbm8iPm9mb25vLWJv
dW5jZXMgYXQgb2Zvbm8ub3JnPC9hPiBbbWFpbHRvOjxhIGhyZWY9Imh0dHA6Ly9saXN0cy5vZm9u
by5vcmcvbGlzdGluZm8vb2Zvbm8iPm9mb25vLWJvdW5jZXMgYXQgb2Zvbm8ub3JnPC9hPl0gT24g
QmVoYWxmIE9mIGtyaXNobmEgazxicj5TZW50OiBNb25kYXksIE1heSAxMCwgMjAxMCAzOjQzIFBN
PGJyPlRvOiA8YSBocmVmPSJodHRwOi8vbGlzdHMub2Zvbm8ub3JnL2xpc3RpbmZvL29mb25vIj5v
Zm9ubyBhdCBvZm9uby5vcmc8L2E+PGJyPlN1YmplY3Q6IEhvdyB0byBzdGFydCBvZm9uby1waG9u
ZXNpbSBpbiB1YnVudHUtMTAuMDQgLXJlZzxicj48YnI+PGJyPkhpIFpoZW5odWEsPGJyPjxicj5U
aGFua3MgZm9yIHlvdXIgcmVwbHkuLjxicj48YnI+SSBhZGRlZCB0aGUgZm9sbG93aW5nIGNvZGUg
aW4gL3Vzci9zaGFyZS9hbHNhL3BjbS9tb2RlbS5jb25mIGZpbGUuLi48YnI+PGJyPjEuPGJyPiM8
YnI+I1NhbXBsZSBmb3IgdXNpbmcgcGhvbmUgc2ltdWxhdG9yPGJyPiM8YnI+W3Bob25lc2ltXTxi
cj5Ecml2ZXI9cGhvbmVzaW08YnI+QWRkcmVzcz0xMjcuMC4wLjE8YnI+cG9ydD0xMjM0NTxicj48
YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+SSB0cmllZCB0byAuL2xpc3RfbW9kZW1zLiBJ
IGdvdCBub3RoaW5nIG9uIGNvbW1hbmQgcHJvbXB0LiBBY2NvcmRpbmcgdG8gbXkga25vd2xlZGdl
IGkgc2hvdWxkIGdldCB0aGUgYXZhaWxhYmxlIG1vZGVtcyAoYXRsZWFzdCBwaG9uZXNpbTApPGJy
PkkgdHJpZWQgdG8gZW5hYmxlICB0aGUgbW9kZW0gdXNpbmcgdGhlIGZvbGxvd2luZyBjb21tYW5k
Li48YnI+PGJyPi4vZW5hYmxlLW1vZGVtIC9waG9uZXNpbTA8YnI+PGJyPkkgZ290IDxicj5vdXRw
dXQgYXMgZm9sbG93cy4uLjxicj48YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj48YnI+Q29ubmVj
dGluZzxicj4gbW9kZW0gL3Bob25lc2ltMC4uLjxicj48YnI+VHJhY2ViYWNrIDxicj4obW9zdCBy
ZWNlbnQgY2FsbCBsYXN0KTo8YnI+PGJyPiZuYnNwOyBGaWxlIDxicj4iLi9lbmFibGUtbW9kZW0i
LCBsaW5lIDIwLCBpbiAmbHQ7bW9kdWxlJmd0Ozxicj48YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IDxi
cj5tb2RlbS5TZXRQcm9wZXJ0eSgiUG93ZXJlZCIsIGRidXMuQm9vbGVhbigxKSk8YnI+PGJyPiZu
YnNwOyBGaWxlIDxicj4iL3Vzci9saWIvcHltb2R1bGVzL3B5dGhvbjIuNi9kYnVzL3Byb3hpZXMu
cHkiLCBsaW5lIDY4LCBpbiBfX2NhbGxfXzxicj48YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IHJldHVy
bjxicj4gc2VsZi5fcHJveHlfbWV0aG9kKCphcmdzLCAqKmtleXdvcmRzKTxicj48YnI+Jm5ic3A7
IEZpbGUgPGJyPiIvdXNyL2xpYi9weW1vZHVsZXMvcHl0aG9uMi42L2RidXMvcHJveGllcy5weSIs
IGxpbmUgMTQwLCBpbiBfX2NhbGxfXzxicj48YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IDxicj4qKmtl
eXdvcmRzKTxicj48YnI+Jm5ic3A7IEZpbGUgPGJyPiIvdXNyL2xpYi9weW1vZHVsZXMvcHl0aG9u
Mi42L2RidXMvY29ubmVjdGlvbi5weSIsIGxpbmUgNjIwLCBpbiA8YnI+Y2FsbF9ibG9ja2luZzxi
cj48YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IDxicj5tZXNzYWdlLCB0aW1lb3V0KTxicj48YnI+ZGJ1
cy5leGNlcHRpb25zLkRCdXNFeGNlcHRpb246PGJyPiBvcmcuZnJlZWRlc2t0b3AuREJ1cy5FcnJv
ci5Vbmtub3duTWV0aG9kOiBNZXRob2QgIlNldFByb3BlcnR5IiB3aXRoIDxicj5zaWduYXR1cmUg
InNiIiBvbiBpbnRlcmZhY2UgIm9yZy5vZm9uby5Nb2RlbSIgZG9lc24ndCBleGlzdDxicj48YnI+
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+SGF2ZSBhIG5pY2UgdGltZS48YnI+PGJyPlJlZ2Fy
ZHMsPGJyPktyaXNobmEgSyBLYW5kdWxhPGJyPjwvcHJlPiAJCSAJICAgCQkgIDxiciAvPjxociAv
PlRoZSBiYXR0bGUgZm9yIHRoZSBGSUggSG9ja2V5IFdvcmxkIEN1cCA8YSBocmVmPSdodHRwOi8v
c3BlY2lhbHMubXNuLmNvLmluL3NwMTAvaG9ja2V5L2luZGV4LmFzcHgnIHRhcmdldD0nX25ldyc+
RHJhZyBuJyBkcm9wPC9hPjwvYm9keT4KPC9odG1sPg==
--===============0659185894418629213==--

