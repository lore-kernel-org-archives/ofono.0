Content-Type: multipart/mixed; boundary="===============4476074944464854483=="
MIME-Version: 1.0
From: krishna k <id_kishore@live.in>
Subject: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Mon, 10 May 2010 12:12:48 +0530
Message-ID: <COL106-W4521589C7EBB620DF7AE3BF6F90@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4476074944464854483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable





	=

	=

	=

	=



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

--===============4476074944464854483==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8c3R5bGU+PCEtLQouaG1tZXNzYWdlIFAKewptYXJnaW46MHB4OwpwYWRk
aW5nOjBweAp9CmJvZHkuaG1tZXNzYWdlCnsKZm9udC1zaXplOiAxMHB0Owpmb250LWZhbWlseTpW
ZXJkYW5hCn0KLS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBjbGFzcz0naG1tZXNzYWdlJz4KCgoK
CTxtZXRhIGh0dHAtZXF1aXY9IkNPTlRFTlQtVFlQRSIgY29udGVudD0idGV4dC9odG1sOyBjaGFy
c2V0PXV0Zi04Ij4KCTx0aXRsZT48L3RpdGxlPgoJPG1ldGEgbmFtZT0iR0VORVJBVE9SIiBjb250
ZW50PSJPcGVuT2ZmaWNlLm9yZyAzLjIgIChVbml4KSI+Cgk8c3R5bGUgdHlwZT0idGV4dC9jc3Mi
PgoJPCEtLQoJCUBwYWdlIHsgbWFyZ2luOiAyY20gfQoJCVBSRSB7IGZvbnQtZmFtaWx5OiAiTmlt
YnVzIFJvbWFuIE5vOSBMIiB9CgkJUCB7IG1hcmdpbi1ib3R0b206IDAuMjFjbSB9CgktLT4KCTwv
c3R5bGU+Cgo8cHJlPjxmb250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNlPSJWZXJkYW5h
IiBzaXplPSIyIj48YnI+PC9mb250Pjxmb250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNl
PSJWZXJkYW5hIiBzaXplPSIyIj5IaSBaaGVuaHVhLDwvZm9udD48Zm9udCBzdHlsZT0iZm9udC1z
aXplOiAxMHB0OyIgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+PGJyPjwvZm9udD48Zm9udCBzdHls
ZT0iZm9udC1zaXplOiAxMHB0OyIgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+PGJyPjwvZm9udD48
Zm9udCBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyIgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+VGhh
bmtzIGZvciB5b3VyIHJlcGx5Li48L2ZvbnQ+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsi
IGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPjxicj48L2ZvbnQ+PGZvbnQgc3R5bGU9ImZvbnQtc2l6
ZTogMTBwdDsiIGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPjxicj48L2ZvbnQ+PGZvbnQgc3R5bGU9
ImZvbnQtc2l6ZTogMTBwdDsiIGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPkkgYWRkZWQgdGhlIGZv
bGxvd2luZyBjb2RlIGluIC91c3Ivc2hhcmUvYWxzYS9wY20vbW9kZW0uY29uZiBmaWxlLi4uPC9m
b250Pjxmb250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIy
Ij48YnI+PC9mb250Pjxmb250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNlPSJWZXJkYW5h
IiBzaXplPSIyIj48YnI+PC9mb250Pjxmb250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNl
PSJWZXJkYW5hIiBzaXplPSIyIj4xLjwvZm9udD48Zm9udCBzdHlsZT0iZm9udC1zaXplOiAxMHB0
OyIgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+PGJyPjwvZm9udD48Zm9udCBzdHlsZT0iZm9udC1z
aXplOiAxMHB0OyIgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+IzwvZm9udD48Zm9udCBzdHlsZT0i
Zm9udC1zaXplOiAxMHB0OyIgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+PGJyPjwvZm9udD48Zm9u
dCBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyIgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+I1NhbXBs
ZSBmb3IgdXNpbmcgcGhvbmUgc2ltdWxhdG9yPC9mb250Pjxmb250IHN0eWxlPSJmb250LXNpemU6
IDEwcHQ7IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj48YnI+PC9mb250Pjxmb250IHN0eWxlPSJm
b250LXNpemU6IDEwcHQ7IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj4jPC9mb250Pjxmb250IHN0
eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj48YnI+PC9mb250
Pjxmb250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj5b
cGhvbmVzaW1dPC9mb250Pjxmb250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNlPSJWZXJk
YW5hIiBzaXplPSIyIj48YnI+PC9mb250Pjxmb250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBm
YWNlPSJWZXJkYW5hIiBzaXplPSIyIj5Ecml2ZXI9cGhvbmVzaW08L2ZvbnQ+PGZvbnQgc3R5bGU9
ImZvbnQtc2l6ZTogMTBwdDsiIGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPjxicj48L2ZvbnQ+PGZv
bnQgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiIGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPkFkZHJl
c3M9MTI3LjAuMC4xPC9mb250Pjxmb250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNlPSJW
ZXJkYW5hIiBzaXplPSIyIj48YnI+PC9mb250Pjxmb250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7
IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj5wb3J0PTEyMzQ1PC9mb250Pjxmb250IHN0eWxlPSJm
b250LXNpemU6IDEwcHQ7IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj48YnI+PC9mb250Pjxmb250
IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj48YnI+LS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+PC9mb250Pjxmb250IHN0eWxlPSJmb250LXNpemU6IDEw
cHQ7IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj5JIHRyaWVkIHRvIC4vbGlzdF9tb2RlbXMuIEkg
Z290IG5vdGhpbmcgb24gY29tbWFuZCBwcm9tcHQuIEFjY29yZGluZyB0byBteSBrbm93bGVkZ2Ug
aSBzaG91bGQgZ2V0IHRoZSBhdmFpbGFibGUgbW9kZW1zIChhdGxlYXN0IHBob25lc2ltMCk8YnI+
SSB0cmllZCB0byBlbmFibGUgIHRoZSBtb2RlbSB1c2luZyB0aGUgZm9sbG93aW5nIGNvbW1hbmQu
LjwvZm9udD48Zm9udCBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyIgZmFjZT0iVmVyZGFuYSIgc2l6
ZT0iMiI+PGJyPjwvZm9udD48Zm9udCBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyIgZmFjZT0iVmVy
ZGFuYSIgc2l6ZT0iMiI+PGJyPjwvZm9udD48Zm9udCBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyIg
ZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+PGI+Li9lbmFibGUtbW9kZW0gL3Bob25lc2ltMDwvYj48
L2ZvbnQ+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiIGZhY2U9IlZlcmRhbmEiIHNpemU9
IjIiPjxicj48L2ZvbnQ+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiIGZhY2U9IlZlcmRh
bmEiIHNpemU9IjIiPjxicj48L2ZvbnQ+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiIGZh
Y2U9IlZlcmRhbmEiIHNpemU9IjIiPkkgZ290IDxicj5vdXRwdXQgYXMgZm9sbG93cy4uLjwvZm9u
dD48Zm9udCBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyIgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+
PGJyPjxicj48L2ZvbnQ+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiIGZhY2U9IlZlcmRh
bmEiIHNpemU9IjIiPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08L2ZvbnQ+PGZvbnQgc3R5bGU9ImZvbnQt
c2l6ZTogMTBwdDsiIGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPjxicj48YnI+PC9mb250Pjxmb250
IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj5Db25uZWN0
aW5nPGJyPiBtb2RlbSAvcGhvbmVzaW0wLi4uPC9mb250Pjxmb250IHN0eWxlPSJmb250LXNpemU6
IDEwcHQ7IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj48YnI+PGJyPjwvZm9udD48Zm9udCBzdHls
ZT0iZm9udC1zaXplOiAxMHB0OyIgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+VHJhY2ViYWNrIDxi
cj4obW9zdCByZWNlbnQgY2FsbCBsYXN0KTo8L2ZvbnQ+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZTog
MTBwdDsiIGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPjxicj48YnI+PC9mb250Pjxmb250IHN0eWxl
PSJmb250LXNpemU6IDEwcHQ7IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj4mbmJzcDsgRmlsZSA8
YnI+Ii4vZW5hYmxlLW1vZGVtIiwgbGluZSAyMCwgaW4gJmx0O21vZHVsZSZndDs8L2ZvbnQ+PGZv
bnQgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiIGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPjxicj48
YnI+PC9mb250Pjxmb250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNlPSJWZXJkYW5hIiBz
aXplPSIyIj4mbmJzcDsmbmJzcDsmbmJzcDsgPGJyPm1vZGVtLlNldFByb3BlcnR5KCJQb3dlcmVk
IiwgZGJ1cy5Cb29sZWFuKDEpKTwvZm9udD48Zm9udCBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyIg
ZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+PGJyPjxicj48L2ZvbnQ+PGZvbnQgc3R5bGU9ImZvbnQt
c2l6ZTogMTBwdDsiIGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPiZuYnNwOyBGaWxlIDxicj4iL3Vz
ci9saWIvcHltb2R1bGVzL3B5dGhvbjIuNi9kYnVzL3Byb3hpZXMucHkiLCBsaW5lIDY4LCBpbiBf
X2NhbGxfXzwvZm9udD48Zm9udCBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyIgZmFjZT0iVmVyZGFu
YSIgc2l6ZT0iMiI+PGJyPjxicj48L2ZvbnQ+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsi
IGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPiZuYnNwOyZuYnNwOyZuYnNwOyByZXR1cm48YnI+IHNl
bGYuX3Byb3h5X21ldGhvZCgqYXJncywgKiprZXl3b3Jkcyk8L2ZvbnQ+PGZvbnQgc3R5bGU9ImZv
bnQtc2l6ZTogMTBwdDsiIGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPjxicj48YnI+PC9mb250Pjxm
b250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj4mbmJz
cDsgRmlsZSA8YnI+Ii91c3IvbGliL3B5bW9kdWxlcy9weXRob24yLjYvZGJ1cy9wcm94aWVzLnB5
IiwgbGluZSAxNDAsIGluIF9fY2FsbF9fPC9mb250Pjxmb250IHN0eWxlPSJmb250LXNpemU6IDEw
cHQ7IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj48YnI+PGJyPjwvZm9udD48Zm9udCBzdHlsZT0i
Zm9udC1zaXplOiAxMHB0OyIgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+Jm5ic3A7Jm5ic3A7Jm5i
c3A7IDxicj4qKmtleXdvcmRzKTwvZm9udD48Zm9udCBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyIg
ZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+PGJyPjxicj48L2ZvbnQ+PGZvbnQgc3R5bGU9ImZvbnQt
c2l6ZTogMTBwdDsiIGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPiZuYnNwOyBGaWxlIDxicj4iL3Vz
ci9saWIvcHltb2R1bGVzL3B5dGhvbjIuNi9kYnVzL2Nvbm5lY3Rpb24ucHkiLCBsaW5lIDYyMCwg
aW4gPGJyPmNhbGxfYmxvY2tpbmc8L2ZvbnQ+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsi
IGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPjxicj48YnI+PC9mb250Pjxmb250IHN0eWxlPSJmb250
LXNpemU6IDEwcHQ7IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj4mbmJzcDsmbmJzcDsmbmJzcDsg
PGJyPm1lc3NhZ2UsIHRpbWVvdXQpPC9mb250Pjxmb250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7
IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj48YnI+PGJyPjwvZm9udD48Zm9udCBzdHlsZT0iZm9u
dC1zaXplOiAxMHB0OyIgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+ZGJ1cy5leGNlcHRpb25zLkRC
dXNFeGNlcHRpb246PGJyPiBvcmcuZnJlZWRlc2t0b3AuREJ1cy5FcnJvci5Vbmtub3duTWV0aG9k
OiBNZXRob2QgIlNldFByb3BlcnR5IiB3aXRoIDxicj5zaWduYXR1cmUgInNiIiBvbiBpbnRlcmZh
Y2UgIm9yZy5vZm9uby5Nb2RlbSIgZG9lc24ndCBleGlzdDwvZm9udD48Zm9udCBzdHlsZT0iZm9u
dC1zaXplOiAxMHB0OyIgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+PGJyPjxicj48L2ZvbnQ+PGZv
bnQgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiIGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tPC9mb250Pjxmb250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBm
YWNlPSJWZXJkYW5hIiBzaXplPSIyIj48YnI+PC9mb250Pjxicj48L3ByZT48Zm9udCBzdHlsZT0i
Zm9udC1zaXplOiAxMHB0OyIgZmFjZT0iVmVyZGFuYSIgc2l6ZT0iMiI+SGF2ZSBhIG5pY2UgdGlt
ZS48L2ZvbnQ+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiIGZhY2U9IlZlcmRhbmEiIHNp
emU9IjIiPjxicj48L2ZvbnQ+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiIGZhY2U9IlZl
cmRhbmEiIHNpemU9IjIiPjxicj48L2ZvbnQ+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsi
IGZhY2U9IlZlcmRhbmEiIHNpemU9IjIiPlJlZ2FyZHMsPC9mb250Pjxmb250IHN0eWxlPSJmb250
LXNpemU6IDEwcHQ7IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj48YnI+PC9mb250Pjxmb250IHN0
eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNlPSJWZXJkYW5hIiBzaXplPSIyIj5LcmlzaG5hIEsg
S2FuZHVsYTwvZm9udD48Zm9udCBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyIgZmFjZT0iVmVyZGFu
YSIgc2l6ZT0iMiI+PGJyPjwvZm9udD48YnI+IAkJIAkgICAJCSAgPGJyIC8+PGhyIC8+VGhlIGJh
dHRsZSBmb3IgdGhlIEZJSCBIb2NrZXkgV29ybGQgQ3VwIDxhIGhyZWY9J2h0dHA6Ly9zcGVjaWFs
cy5tc24uY28uaW4vc3AxMC9ob2NrZXkvaW5kZXguYXNweCcgdGFyZ2V0PSdfbmV3Jz5EcmFnIG4n
IGRyb3A8L2E+PC9ib2R5Pgo8L2h0bWw+
--===============4476074944464854483==--

