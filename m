Content-Type: multipart/mixed; boundary="===============0555404676819218110=="
MIME-Version: 1.0
From: krishna k <id_kishore@live.in>
Subject: FW: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Fri, 07 May 2010 16:23:39 +0530
Message-ID: <COL106-W4E56D0EA71CF82AF31100F6F60@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0555404676819218110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



Hi Dario,

Thank you for your quick reply. I didn't power on the modem. Can you sugges=
t me whether we can use NOKIA E71 as modem?

Please see the following output ...

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
51: USB 00.a: 10200 Modem                                       =

  [Created at usb.122]
  UDI: /org/freedesktop/Hal/devices/usb_device_421_ab_noserial_if0_4_serial=
_unknown_0
  Unique ID: UuWO.XzI_Vd3lIbF
  Parent ID: 7eqy.v+N+B0xY+P6
  SysFS ID: /devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1:1.10
  SysFS BusID: 6-1:1.10
  Hardware Class: modem
  Model: "Nokia Mobile Phones Nokia E71"
  Hotplug: USB
  Vendor: usb 0x0421 "Nokia Mobile Phones"
  Device: usb 0x00ab "Nokia E71"
  Revision: "1.00"
  Driver: "cdc_acm"
  Driver Modules: "cdc_acm"
  Device File: /dev/ttyACM0
  Device Files: /dev/ttyACM0, /dev/char/166:0, /dev/serial/by-path/pci-0000=
:00:1d.0-usb-0:1:1.10, /dev/serial/by-id/usb-Nokia_Nokia_E71-if0a
  Speed: 12 Mbps
  Init1: ATZ
  Init2: AT Q0 V1 E1 S0=3D0 &C1 &D2 +FCLASS=3D0
  Module Alias: "usb:v0421p00ABd0100dc02dsc00dp00ic02isc02ip01"
  Driver Info #0:
    Driver Status: cdc_acm is active
    Driver Activation Cmd: "modprobe cdc_acm"
  Config Status: cfg=3Dnew, avail=3Dyes, need=3Dno, active=3Dunknown
  Attached to: #36 (Hub)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Is it necessary that we need to power-on the modem before launching the emu=
lator?

Thanks in advance.

Regards,
Krishna K Kandula.

From: id_kishore(a)live.in
To: ofono(a)ofono.org
Subject: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Fri, 7 May 2010 15:52:24 +0530








Hi All,

Any body who is working ofono-phonesim suggest how to start ofono-phonesim =
simulator?

I installed ofono-phonesim from synaptic package manager in ubuntu lucid (1=
0.04) and i am trying start the simulator with the following ...

1. I modified modem.conf file with following content...
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[phonesim]
Driver=3Dphonesim
Address=3D127.0.0.1
Port=3D12345
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

2. phonesim -p 12345  -gui ~/data/moblin.xml (i created data file in user h=
ome directory and placed moblin.xml file inside data)

But it is not displaying anything on the screen. But if i check with "ps ax=
 | grep phonesim" I am getting below o/p.

 5822 pts/1    S+     0:00 phonesim -p 12345 -gui /home/kandukis/data/mobli=
n.xml
 5842 pts/2    S+     0:00 grep --color=3Dauto phonesim

What is the problem and why simulator is not visible?

Please correct me if i am doing wrong...

Thanks and Regards,
Krishna.

Have you tried powering on the modem? ;)
Bye, Dario.

 		 	   		  =

The latest auto launches and test drives Drag n' drop 		 	   		  =

_________________________________________________________________
Climate, controversies and the changing signatures of nature
http://green.in.msn.com/

--===============0555404676819218110==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8c3R5bGU+PCEtLQouaG1tZXNzYWdlIFAKewptYXJnaW46MHB4OwpwYWRk
aW5nOjBweAp9CmJvZHkuaG1tZXNzYWdlCnsKZm9udC1zaXplOiAxMHB0Owpmb250LWZhbWlseTpW
ZXJkYW5hCn0KLS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBjbGFzcz0naG1tZXNzYWdlJz4KPGJy
PkhpIERhcmlvLDxicj48YnI+VGhhbmsgeW91IGZvciB5b3VyIHF1aWNrIHJlcGx5LiBJIGRpZG4n
dCBwb3dlciBvbiB0aGUgbW9kZW0uIENhbiB5b3Ugc3VnZ2VzdCBtZSB3aGV0aGVyIHdlIGNhbiB1
c2UgTk9LSUEgRTcxIGFzIG1vZGVtPzxicj48YnI+UGxlYXNlIHNlZSB0aGUgZm9sbG93aW5nIG91
dHB1dCAuLi48YnI+PGJyPj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PTxicj41MTogVVNCIDAwLmE6IDEw
MjAwIE1vZGVtJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IDxicj4mbmJzcDsgW0NyZWF0ZWQgYXQgdXNiLjEyMl08YnI+Jm5ic3A7IFVESTog
L29yZy9mcmVlZGVza3RvcC9IYWwvZGV2aWNlcy91c2JfZGV2aWNlXzQyMV9hYl9ub3NlcmlhbF9p
ZjBfNF9zZXJpYWxfdW5rbm93bl8wPGJyPiZuYnNwOyBVbmlxdWUgSUQ6IFV1V08uWHpJX1ZkM2xJ
YkY8YnI+Jm5ic3A7IFBhcmVudCBJRDogN2VxeS52K04rQjB4WStQNjxicj4mbmJzcDsgU3lzRlMg
SUQ6IC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZC4wL3VzYjYvNi0xLzYtMToxLjEwPGJy
PiZuYnNwOyBTeXNGUyBCdXNJRDogNi0xOjEuMTA8YnI+Jm5ic3A7IEhhcmR3YXJlIENsYXNzOiBt
b2RlbTxicj4mbmJzcDsgTW9kZWw6ICJOb2tpYSBNb2JpbGUgUGhvbmVzIE5va2lhIEU3MSI8YnI+
Jm5ic3A7IEhvdHBsdWc6IFVTQjxicj4mbmJzcDsgVmVuZG9yOiB1c2IgMHgwNDIxICJOb2tpYSBN
b2JpbGUgUGhvbmVzIjxicj4mbmJzcDsgRGV2aWNlOiB1c2IgMHgwMGFiICJOb2tpYSBFNzEiPGJy
PiZuYnNwOyBSZXZpc2lvbjogIjEuMDAiPGJyPiZuYnNwOyBEcml2ZXI6ICJjZGNfYWNtIjxicj4m
bmJzcDsgRHJpdmVyIE1vZHVsZXM6ICJjZGNfYWNtIjxicj4mbmJzcDsgRGV2aWNlIEZpbGU6IC9k
ZXYvdHR5QUNNMDxicj4mbmJzcDsgRGV2aWNlIEZpbGVzOiAvZGV2L3R0eUFDTTAsIC9kZXYvY2hh
ci8xNjY6MCwgL2Rldi9zZXJpYWwvYnktcGF0aC9wY2ktMDAwMDowMDoxZC4wLXVzYi0wOjE6MS4x
MCwgL2Rldi9zZXJpYWwvYnktaWQvdXNiLU5va2lhX05va2lhX0U3MS1pZjBhPGJyPiZuYnNwOyBT
cGVlZDogMTIgTWJwczxicj4mbmJzcDsgSW5pdDE6IEFUWjxicj4mbmJzcDsgSW5pdDI6IEFUIFEw
IFYxIEUxIFMwPTAgJmFtcDtDMSAmYW1wO0QyICtGQ0xBU1M9MDxicj4mbmJzcDsgTW9kdWxlIEFs
aWFzOiAidXNiOnYwNDIxcDAwQUJkMDEwMGRjMDJkc2MwMGRwMDBpYzAyaXNjMDJpcDAxIjxicj4m
bmJzcDsgRHJpdmVyIEluZm8gIzA6PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyBEcml2ZXIgU3RhdHVz
OiBjZGNfYWNtIGlzIGFjdGl2ZTxicj4mbmJzcDsmbmJzcDsmbmJzcDsgRHJpdmVyIEFjdGl2YXRp
b24gQ21kOiAibW9kcHJvYmUgY2RjX2FjbSI8YnI+Jm5ic3A7IENvbmZpZyBTdGF0dXM6IGNmZz1u
ZXcsIGF2YWlsPXllcywgbmVlZD1ubywgYWN0aXZlPXVua25vd248YnI+Jm5ic3A7IEF0dGFjaGVk
IHRvOiAjMzYgKEh1Yik8YnI+PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PGJyPjxicj5JcyBpdCBuZWNl
c3NhcnkgdGhhdCB3ZSBuZWVkIHRvIHBvd2VyLW9uIHRoZSBtb2RlbSBiZWZvcmUgbGF1bmNoaW5n
IHRoZSBlbXVsYXRvcj88YnI+PGJyPlRoYW5rcyBpbiBhZHZhbmNlLjxicj48YnI+UmVnYXJkcyw8
YnI+S3Jpc2huYSBLIEthbmR1bGEuPGJyPjxicj48aHIgaWQ9InN0b3BTcGVsbGluZyI+RnJvbTog
aWRfa2lzaG9yZUBsaXZlLmluPGJyPlRvOiBvZm9ub0BvZm9uby5vcmc8YnI+U3ViamVjdDogSG93
IHRvIHN0YXJ0IG9mb25vLXBob25lc2ltIGluIHVidW50dS0xMC4wNCAtcmVnPGJyPkRhdGU6IEZy
aSwgNyBNYXkgMjAxMCAxNTo1MjoyNCArMDUzMDxicj48YnI+CgoKCjxzdHlsZT4KLkV4dGVybmFs
Q2xhc3MgLmVjeGhtbWVzc2FnZSBQCntwYWRkaW5nOjBweDt9Ci5FeHRlcm5hbENsYXNzIGJvZHku
ZWN4aG1tZXNzYWdlCntmb250LXNpemU6MTBwdDtmb250LWZhbWlseTpWZXJkYW5hO30KPC9zdHls
ZT4KCgpIaSBBbGwsPGJyPjxicj5BbnkgYm9keSB3aG8gaXMgd29ya2luZyBvZm9uby1waG9uZXNp
bSBzdWdnZXN0IGhvdyB0byBzdGFydCBvZm9uby1waG9uZXNpbSBzaW11bGF0b3I/PGJyPjxicj5J
IGluc3RhbGxlZCBvZm9uby1waG9uZXNpbSBmcm9tIHN5bmFwdGljIHBhY2thZ2UgbWFuYWdlciBp
bjxiPiB1YnVudHUgbHVjaWQ8L2I+ICgxMC4wNCkgYW5kIGkgYW0gdHJ5aW5nIHN0YXJ0IHRoZSBz
aW11bGF0b3Igd2l0aCB0aGUgZm9sbG93aW5nIC4uLjxicj48YnI+PGZvbnQgc3R5bGU9IiIgY29s
b3I9IiM0ZjgxYmQiPjxiPjEuPC9iPjwvZm9udD4gSSBtb2RpZmllZCBtb2RlbS5jb25mIGZpbGUg
d2l0aCBmb2xsb3dpbmcgY29udGVudC4uLjxicj49PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PGJyPjxwcmU+PGk+W3Bob25lc2ltXTxicj48L2k+PGk+RHJpdmVyPXBob25lc2ltPGJy
PjwvaT48aT5BZGRyZXNzPTEyNy4wLjAuMTxicj48L2k+PGk+UG9ydD0xMjM0NTxicj48L2k+PC9w
cmU+PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PTxicj48YnI+PGZvbnQgc3R5bGU9
IiIgY29sb3I9IiMxZjQ5N2QiPjxiPjIuPC9iPjwvZm9udD4gcGhvbmVzaW0gLXAgMTIzNDUmbmJz
cDsgLWd1aSB+L2RhdGEvbW9ibGluLnhtbCAoaSBjcmVhdGVkIGRhdGEgZmlsZSBpbiB1c2VyIGhv
bWUgZGlyZWN0b3J5IGFuZCBwbGFjZWQgbW9ibGluLnhtbCBmaWxlIGluc2lkZSBkYXRhKTxicj48
YnI+QnV0IGl0IGlzIG5vdCBkaXNwbGF5aW5nIGFueXRoaW5nIG9uIHRoZSBzY3JlZW4uIEJ1dCBp
ZiBpIGNoZWNrIHdpdGggIjxiPnBzIGF4IHwgZ3JlcCBwaG9uZXNpbTwvYj4iIEkgYW0gZ2V0dGlu
ZyBiZWxvdyBvL3AuPGJyPjxicj4mbmJzcDs1ODIyIHB0cy8xJm5ic3A7Jm5ic3A7Jm5ic3A7IFMr
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDA6MDAgcGhvbmVzaW0gLXAgMTIzNDUgLWd1aSAvaG9t
ZS9rYW5kdWtpcy9kYXRhL21vYmxpbi54bWw8YnI+Jm5ic3A7NTg0MiBwdHMvMiZuYnNwOyZuYnNw
OyZuYnNwOyBTKyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAwOjAwIGdyZXAgLS1jb2xvcj1hdXRv
IHBob25lc2ltPGJyPjxicj5XaGF0IGlzIHRoZSBwcm9ibGVtIGFuZCB3aHkgc2ltdWxhdG9yIGlz
IG5vdCB2aXNpYmxlPzxicj48YnI+UGxlYXNlIGNvcnJlY3QgbWUgaWYgaSBhbSBkb2luZyB3cm9u
Zy4uLjxicj48YnI+VGhhbmtzIGFuZCBSZWdhcmRzLDxicj5LcmlzaG5hLjxicj48YnI+PHByZT5I
YXZlIHlvdSB0cmllZCBwb3dlcmluZyBvbiB0aGUgbW9kZW0/IDspPGJyPkJ5ZSwgRGFyaW8uPGJy
PjwvcHJlPjxicj4gCQkgCSAgIAkJICA8YnI+PGhyPlRoZSBsYXRlc3QgYXV0byBsYXVuY2hlcyBh
bmQgdGVzdCBkcml2ZXMgPGEgaHJlZj0iaHR0cDovL2F1dG9zLmluLm1zbi5jb20vIj5EcmFnIG4n
IGRyb3A8L2E+IAkJIAkgICAJCSAgPGJyIC8+PGhyIC8+SW52ZXN0IHlvdXIgbW9uZXkgd2lzZWx5
IHBvc3QgQnVkZ2V0IDxhIGhyZWY9J2h0dHA6Ly9uZXdzLmluLm1zbi5jb20vbW9uZXlzcGVjaWFs
LycgdGFyZ2V0PSdfbmV3Jz5TaWduIHVwIG5vdy48L2E+PC9ib2R5Pgo8L2h0bWw+
--===============0555404676819218110==--

