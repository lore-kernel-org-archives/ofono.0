Content-Type: multipart/mixed; boundary="===============1739602307459216455=="
MIME-Version: 1.0
From: Moises Silva <moises.silva@gmail.com>
Subject: Using ofono HFP
Date: Sun, 26 Sep 2010 11:51:20 -0400
Message-ID: <AANLkTimM6B4VQZW=cTP4DfzOukrKCM9wEKs-iCRbFPDK@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1739602307459216455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi there,

Bluetooth newbie here, try to be gentle :-)

I am trying to use ofono HFP. But I am not having success so far.

I have Fedora release 13 in vmware fusion virtual machine (the host is a mac
book pro). When I connect my usb bluetooth adapter and bridge it to the vm,
bluez detects it just fine and I can see it with hciconfig.

hci0:   Type: BR/EDR  Bus: USB
        BD Address: 00:15:83:15:A3:10  ACL MTU: 672:3  SCO MTU: 128:2
        UP RUNNING PSCAN
        RX bytes:4726 acl:46 sco:0 events:140 errors:0
        TX bytes:1555 acl:74 sco:0 commands:39 errors:0

I can see my cell phone using "hcitool scan" and the HF Voice Gateway
service using "sdtool browse", the service is at channel 4.

The information retrieved from my cell is:

root(a)fedora test # hcitool info 00:1D:28:4B:9A:A8
Requesting information ...
        BD Address:  00:1D:28:4B:9A:A8
        Device Name: Moycell
        LMP Version: 1.2 (0x2) LMP Subversion: 0x41c
        Manufacturer: Philips Semiconductors (37)
        Features: 0xff 0xed 0x8d 0xf8 0x1a 0x08 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot
offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <channel quality> <SCO link> <HV3 packets>
                <u-law log> <A-law log> <CVSD> <power control>
                <transparent SCO> <broadcast encrypt> <enhanced iscan>
                <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
                <extended SCO> <EV5 packets> <AFH cap. slave>
                <AFH class. slave> <AFH cap. master>

I paired my cell phone using blueman utilities. I was able to transfer a
file from linux to the cell phone. The cell phone sees the hands free
service from linux, but, when I try to connect from my cell phone to Linux,
I get this in /var/log/messages:

Sep 26 08:29:56 fedora bluetoothd[19854]: link_key_request
(sba=3D00:15:83:15:A3:10, dba=3D00:1D:28:4B:9A:A8)

And I get a prompt from blueman asking me to allow the cell phone to
connect, I accept and after a few seconds the cell phone reports the
bluetooth connection as failed. Nothing in /var/log/messages.

ofono version is 0.28

Output of rpm -qa | grep bluez is:

bluez-compat-4.64-1.fc13.i686
bluez-libs-devel-4.64-1.fc13.i686
bluez-alsa-4.64-1.fc13.i686
bluez-libs-4.64-1.fc13.i686
pybluez-0.16-2.fc13.i686
bluez-4.64-1.fc13.i686
bluez-hcidump-1.42-4.fc12.i686

dbus version is dbus-1.2.24-1.fc13.i686

I decided both bluez and ofono from latest git sources (latest as of 2 days
ago), and the only difference is I get an additional error after the
link_key_request:

bluetoothd[14120]: audio/headset.c:rfcomm_io_cb() ERR or HUP on RFCOMM
socket

I was advised by padovan on IRC that I should try dbus >=3D 1.3 ... I am go=
ing
to try that today, I was putting that off cuz this seemed like a lower level
issue and upgrading dbus seemed like non-trivial since many things depend on
dbus and fedora 13 does not seem to include rpm for dbus >=3D 1.3

Can I somehow to try ofono connect to my cell and not the other way around?

A few days ago I tried the project "nohands" (
http://nohands.sourceforge.net/), which connect to the cell phone just fine
and I am able to place and receive calls, but since the project looks like
kind of dead I decided to give ofono a try because looks more active.

The final goal here is NOT use this with pulseaudio, but rather have access
to the SCO socket so I can manipulate the audio.

Any advice will be certainly welcomed,

--
Moises Silva

--===============1739602307459216455==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgdGhlcmUsPGRpdj48YnI+PC9kaXY+PGRpdj5CbHVldG9vdGggbmV3YmllIGhlcmUsIHRyeSB0
byBiZSBnZW50bGUgOi0pPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGFtIHRyeWluZyB0byB1
c2Ugb2Zvbm8gSEZQLiBCdXQgSSBhbSBub3QgaGF2aW5nIHN1Y2Nlc3Mgc28gZmFyLsKgPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5JIGhhdmUgRmVkb3JhIHJlbGVhc2UgMTMgaW4gdm13YXJlIGZ1
c2lvbiB2aXJ0dWFsIG1hY2hpbmUgKHRoZSBob3N0IGlzIGEgbWFjIGJvb2sgcHJvKS4gV2hlbiBJ
IGNvbm5lY3QgbXkgdXNiIGJsdWV0b290aCBhZGFwdGVyIGFuZCBicmlkZ2UgaXQgdG8gdGhlIHZt
LCBibHVleiBkZXRlY3RzIGl0IGp1c3QgZmluZcKgYW5kIEkgY2FuIHNlZSBpdCB3aXRoIGhjaWNv
bmZpZy48L2Rpdj4KPGRpdj48YnI+PC9kaXY+CjxkaXY+PGRpdj5oY2kwOiDCoCBUeXBlOiBCUi9F
RFIgwqBCdXM6IFVTQjwvZGl2PjxkaXY+wqDCoCDCoCDCoCDCoEJEIEFkZHJlc3M6IDAwOjE1Ojgz
OjE1OkEzOjEwIMKgQUNMIE1UVTogNjcyOjMgwqBTQ08gTVRVOiAxMjg6MjwvZGl2PjxkaXY+wqDC
oCDCoCDCoCDCoFVQIFJVTk5JTkcgUFNDQU7CoDwvZGl2PjxkaXY+wqDCoCDCoCDCoCDCoFJYIGJ5
dGVzOjQ3MjYgYWNsOjQ2IHNjbzowIGV2ZW50czoxNDAgZXJyb3JzOjA8L2Rpdj4KCjxkaXY+wqDC
oCDCoCDCoCDCoFRYIGJ5dGVzOjE1NTUgYWNsOjc0IHNjbzowIGNvbW1hbmRzOjM5IGVycm9yczow
PC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGNhbiBzZWUgbXkgY2VsbCBwaG9uZSB1
c2luZyAmcXVvdDtoY2l0b29sIHNjYW4mcXVvdDsgYW5kIHRoZSBIRiBWb2ljZSBHYXRld2F5IHNl
cnZpY2UgdXNpbmcgJnF1b3Q7c2R0b29sIGJyb3dzZSZxdW90OywgdGhlIHNlcnZpY2UgaXMgYXQg
Y2hhbm5lbCA0LsKgPC9kaXY+Cgo8ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSBpbmZvcm1hdGlvbiBy
ZXRyaWV2ZWQgZnJvbSBteSBjZWxsIGlzOjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj5y
b290QGZlZG9yYSB0ZXN0ICMgaGNpdG9vbCBpbmZvIDAwOjFEOjI4OjRCOjlBOkE4PC9kaXY+PGRp
dj5SZXF1ZXN0aW5nIGluZm9ybWF0aW9uIC4uLjwvZGl2PjxkaXY+wqDCoCDCoCDCoCDCoEJEIEFk
ZHJlc3M6IMKgMDA6MUQ6Mjg6NEI6OUE6QTg8L2Rpdj4KCjxkaXY+wqDCoCDCoCDCoCDCoERldmlj
ZSBOYW1lOiBNb3ljZWxsPC9kaXY+PGRpdj7CoMKgIMKgIMKgIMKgTE1QIFZlcnNpb246IDEuMiAo
MHgyKSBMTVAgU3VidmVyc2lvbjogMHg0MWM8L2Rpdj48ZGl2PsKgwqAgwqAgwqAgwqBNYW51ZmFj
dHVyZXI6IFBoaWxpcHMgU2VtaWNvbmR1Y3RvcnMgKDM3KTwvZGl2PjxkaXY+wqDCoCDCoCDCoCDC
oEZlYXR1cmVzOiAweGZmIDB4ZWQgMHg4ZCAweGY4IDB4MWEgMHgwOCAweDAwIDB4MDA8L2Rpdj4K
CjxkaXY+wqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZsdDszLXNsb3QgcGFja2V0cyZndDsgJmx0
OzUtc2xvdCBwYWNrZXRzJmd0OyAmbHQ7ZW5jcnlwdGlvbiZndDsgJmx0O3Nsb3Qgb2Zmc2V0Jmd0
O8KgPC9kaXY+PGRpdj7CoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O3RpbWluZyBhY2N1cmFj
eSZndDsgJmx0O3JvbGUgc3dpdGNoJmd0OyAmbHQ7aG9sZCBtb2RlJmd0OyAmbHQ7c25pZmYgbW9k
ZSZndDvCoDwvZGl2Pgo8ZGl2PgrCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O3Bhcmsgc3Rh
dGUmZ3Q7ICZsdDtjaGFubmVsIHF1YWxpdHkmZ3Q7ICZsdDtTQ08gbGluayZndDsgJmx0O0hWMyBw
YWNrZXRzJmd0O8KgPC9kaXY+PGRpdj7CoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O3UtbGF3
IGxvZyZndDsgJmx0O0EtbGF3IGxvZyZndDsgJmx0O0NWU0QmZ3Q7ICZsdDtwb3dlciBjb250cm9s
Jmd0O8KgPC9kaXY+PGRpdj7CoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O3RyYW5zcGFyZW50
IFNDTyZndDsgJmx0O2Jyb2FkY2FzdCBlbmNyeXB0Jmd0OyAmbHQ7ZW5oYW5jZWQgaXNjYW4mZ3Q7
wqA8L2Rpdj4KCjxkaXY+wqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZsdDtpbnRlcmxhY2VkIGlz
Y2FuJmd0OyAmbHQ7aW50ZXJsYWNlZCBwc2NhbiZndDsgJmx0O2lucXVpcnkgd2l0aCBSU1NJJmd0
O8KgPC9kaXY+PGRpdj7CoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O2V4dGVuZGVkIFNDTyZn
dDsgJmx0O0VWNSBwYWNrZXRzJmd0OyAmbHQ7QUZIIGNhcC4gc2xhdmUmZ3Q7wqA8L2Rpdj48ZGl2
PsKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmbHQ7QUZIIGNsYXNzLiBzbGF2ZSZndDsgJmx0O0FG
SCBjYXAuIG1hc3RlciZndDvCoDwvZGl2PgoKPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIHBh
aXJlZCBteSBjZWxsIHBob25lIHVzaW5nIGJsdWVtYW4gdXRpbGl0aWVzLiBJIHdhcyBhYmxlIHRv
IHRyYW5zZmVyIGEgZmlsZSBmcm9tIGxpbnV4IHRvIHRoZSBjZWxsIHBob25lLiBUaGUgY2VsbCBw
aG9uZSBzZWVzIHRoZSBoYW5kcyBmcmVlIHNlcnZpY2UgZnJvbSBsaW51eCwgYnV0LCB3aGVuIEkg
dHJ5IHRvIGNvbm5lY3QgZnJvbSBteSBjZWxsIHBob25lIHRvIExpbnV4LCBJIGdldCB0aGlzIGlu
IC92YXIvbG9nL21lc3NhZ2VzOjwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+U2VwIDI2
IDA4OjI5OjU2IGZlZG9yYSBibHVldG9vdGhkWzE5ODU0XTogbGlua19rZXlfcmVxdWVzdCAoc2Jh
PTAwOjE1OjgzOjE1OkEzOjEwLCBkYmE9MDA6MUQ6Mjg6NEI6OUE6QTgpPC9kaXY+PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5BbmQgSSBnZXQgYSBwcm9tcHQgZnJvbSBibHVlbWFuIGFza2luZyBt
ZSB0byBhbGxvdyB0aGUgY2VsbCBwaG9uZSB0byBjb25uZWN0LCBJIGFjY2VwdCBhbmQgYWZ0ZXIg
YSBmZXcgc2Vjb25kcyB0aGUgY2VsbCBwaG9uZSByZXBvcnRzIHRoZSBibHVldG9vdGggY29ubmVj
dGlvbiBhcyBmYWlsZWQuIE5vdGhpbmcgaW4gL3Zhci9sb2cvbWVzc2FnZXMuPC9kaXY+CjxkaXY+
PGJyPjwvZGl2PjxkaXY+b2Zvbm8gdmVyc2lvbiBpcyAwLjI4PC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5PdXRwdXQgb2YgcnBtIC1xYSB8IGdyZXAgYmx1ZXogaXM6PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj48ZGl2PmJsdWV6LWNvbXBhdC00LjY0LTEuZmMxMy5pNjg2PC9kaXY+PGRpdj5ibHVl
ei1saWJzLWRldmVsLTQuNjQtMS5mYzEzLmk2ODY8L2Rpdj48ZGl2PmJsdWV6LWFsc2EtNC42NC0x
LmZjMTMuaTY4NjwvZGl2Pgo8ZGl2PmJsdWV6LWxpYnMtNC42NC0xLmZjMTMuaTY4NjwvZGl2Pjxk
aXY+cHlibHVlei0wLjE2LTIuZmMxMy5pNjg2PC9kaXY+PGRpdj5ibHVlei00LjY0LTEuZmMxMy5p
Njg2PC9kaXY+PGRpdj5ibHVlei1oY2lkdW1wLTEuNDItNC5mYzEyLmk2ODY8L2Rpdj48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PmRidXMgdmVyc2lvbiBpc8KgZGJ1cy0xLjIuMjQtMS5mYzEzLmk2
ODY8L2Rpdj48ZGl2Pgo8YnI+PC9kaXY+PGRpdj48ZGl2PkkgZGVjaWRlZCBib3RoIGJsdWV6IGFu
ZCBvZm9ubyBmcm9tIGxhdGVzdCBnaXQgc291cmNlcyAobGF0ZXN0IGFzIG9mIDIgZGF5cyBhZ28p
LCBhbmQgdGhlIG9ubHkgZGlmZmVyZW5jZSBpcyBJIGdldCBhbiBhZGRpdGlvbmFsIGVycm9yIGFm
dGVyIHRoZSBsaW5rX2tleV9yZXF1ZXN0OjwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
Ymx1ZXRvb3RoZFsxNDEyMF06IGF1ZGlvL2hlYWRzZXQuYzpyZmNvbW1faW9fY2IoKSBFUlIgb3Ig
SFVQIG9uIFJGQ09NTSBzb2NrZXTCoDwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgd2FzIGFk
dmlzZWQgYnkgcGFkb3ZhbiBvbiBJUkMgdGhhdCBJIHNob3VsZCB0cnkgZGJ1cyAmZ3Q7PSAxLjMg
Li4uIEkgYW0gZ29pbmcgdG8gdHJ5IHRoYXQgdG9kYXksIEkgd2FzIHB1dHRpbmcgdGhhdCBvZmYg
Y3V6IHRoaXMgc2VlbWVkIGxpa2UgYSBsb3dlciBsZXZlbCBpc3N1ZSBhbmQgdXBncmFkaW5nIGRi
dXMgc2VlbWVkIGxpa2Ugbm9uLXRyaXZpYWwgc2luY2UgbWFueSB0aGluZ3MgZGVwZW5kIG9uIGRi
dXMgYW5kIGZlZG9yYSAxMyBkb2VzIG5vdCBzZWVtIHRvIGluY2x1ZGUgcnBtIGZvciBkYnVzICZn
dDs9IDEuMzwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2PkNhbiBJIHNvbWVob3cgdG8gdHJ5IG9m
b25vIGNvbm5lY3QgdG8gbXkgY2VsbCBhbmQgbm90IHRoZSBvdGhlciB3YXkgYXJvdW5kPzwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+QSBmZXcgZGF5cyBhZ28gSSB0cmllZCB0aGUgcHJvamVjdCAm
cXVvdDtub2hhbmRzJnF1b3Q7ICg8YSBocmVmPSJodHRwOi8vbm9oYW5kcy5zb3VyY2Vmb3JnZS5u
ZXQvIj5odHRwOi8vbm9oYW5kcy5zb3VyY2Vmb3JnZS5uZXQvPC9hPiksIHdoaWNoIGNvbm5lY3Qg
dG8gdGhlIGNlbGwgcGhvbmUganVzdCBmaW5lIGFuZCBJIGFtIGFibGUgdG8gcGxhY2UgYW5kIHJl
Y2VpdmUgY2FsbHMsIGJ1dCBzaW5jZSB0aGUgcHJvamVjdCBsb29rcyBsaWtlIGtpbmQgb2YgZGVh
ZCBJIGRlY2lkZWQgdG8gZ2l2ZSBvZm9ubyBhIHRyeSBiZWNhdXNlIGxvb2tzIG1vcmUgYWN0aXZl
LjwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSBmaW5hbCBnb2FsIGhlcmUgaXMgTk9UIHVz
ZSB0aGlzIHdpdGggcHVsc2VhdWRpbywgYnV0IHJhdGhlciBoYXZlIGFjY2VzcyB0byB0aGUgU0NP
IHNvY2tldCBzbyBJIGNhbiBtYW5pcHVsYXRlIHRoZSBhdWRpby48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PkFueSBhZHZpY2Ugd2lsbCBiZSBjZXJ0YWlubHkgd2VsY29tZWQsPC9kaXY+PGRpdj48
YnI+CjwvZGl2PjxkaXY+LS08YnIgY2xlYXI9ImFsbCI+PGRpdj5Nb2lzZXMgU2lsdmE8L2Rpdj4K
PC9kaXY+Cg==

--===============1739602307459216455==--

