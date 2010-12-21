Content-Type: multipart/mixed; boundary="===============5210799939379858302=="
MIME-Version: 1.0
From: krishna k <id_kishore@live.in>
Subject: Failed to create CAIF socket for AT
Date: Tue, 21 Dec 2010 10:50:23 +0530
Message-ID: <COL106-W31BF5D57E4F7B7C4D521C9F61A0@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5210799939379858302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello Sjur,

Thanks for your reply.

I am trying to understand CAIF protocol implementation in OFono.  I am gett=
ing "Failed to create CAIF socket for AT" when i am trying to enable my mod=
em.

I appended below rule to 97-ofono-rules in /etc/udev.

ATTRS{idVendor}=3D=3D"major-number", ATTRS{idProduct}=3D=3D"minor-number", =
ENV{OFONO_DRIVER}=3D"ste"

After appending the above line in rules file, my modem insertion and remova=
l is getting recognized by oFono core daemon and displaying debug statement=
s like below..

plugins/udev.c:remove_modem() xxxxxx.

When i list my modem information with "list-modem" script. I got output as =
below..

[ /ste0 ]
    Interfaces =3D
    Powered =3D 0
    Features =3D
    Online =3D 0

If i am connecting nokia Phone in PC Suite mode it is working fine. I am ge=
tting below information if i list nokia phone info using list-modem script

[ /isigen1 ]
    Features =3D sim =

    Powered =3D 1
    Interfaces =3D org.ofono.Phonebook org.ofono.SimManager org.ofono.Voice=
CallManager =

    Online =3D 0
    Model =3D Nokia E71
    Manufacturer =3D Nokia
    Serial =3D xxxx
    Revision =3D xxx
09-02-10
RM-346
(c) Nokia
    [ org.ofono.Phonebook ]
    [ org.ofono.SimManager ]
        FixedDialing =3D 0
        SubscriberNumbers =3D =

        BarredDialing =3D 0
        CardIdentifier =3D 123456566
        LockedPins =3D =

        PinRequired =3D none
        SubscriberIdentity =3D 123445566
        Present =3D 1
    [ org.ofono.VoiceCallManager ]
        EmergencyNumbers =3D 119 118 999 110 08 000 911 112 =



I found add_isi() (every modem vendor have their own in udev.c) function is=
 getting get invoked, when i am dealing with nokia phone (PC Suite Mode). I=
s it necessary to have "add_ste()" function to work with CAIF protocol.

Please suggest.

Please suggest me how to start open contribution for oFono Testing.

Thank You.

Regards,
Kris 		 	   		 =20

--===============5210799939379858302==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8c3R5bGU+PCEtLQouaG1tZXNzYWdlIFAKewptYXJnaW46MHB4OwpwYWRk
aW5nOjBweAp9CmJvZHkuaG1tZXNzYWdlCnsKZm9udC1zaXplOiAxMHB0Owpmb250LWZhbWlseTpU
YWhvbWEKfQotLT48L3N0eWxlPgo8L2hlYWQ+Cjxib2R5IGNsYXNzPSdobW1lc3NhZ2UnPgpIZWxs
byBTanVyLDxicj48YnI+VGhhbmtzIGZvciB5b3VyIHJlcGx5Ljxicj48YnI+SSBhbSB0cnlpbmcg
dG8gdW5kZXJzdGFuZCBDQUlGIHByb3RvY29sIGltcGxlbWVudGF0aW9uIGluIE9Gb25vLiZuYnNw
OyBJIGFtIGdldHRpbmcgIkZhaWxlZCB0byBjcmVhdGUgQ0FJRiBzb2NrZXQgZm9yIEFUIiB3aGVu
IGkgYW0gdHJ5aW5nIHRvIGVuYWJsZSBteSBtb2RlbS48YnI+PGJyPkkgYXBwZW5kZWQgYmVsb3cg
cnVsZSB0byA5Ny1vZm9uby1ydWxlcyBpbiAvZXRjL3VkZXYuPGJyPjxicj5BVFRSU3tpZFZlbmRv
cn09PSJtYWpvci1udW1iZXIiLCBBVFRSU3tpZFByb2R1Y3R9PT0ibWlub3ItbnVtYmVyIiwgRU5W
e09GT05PX0RSSVZFUn09InN0ZSI8YnI+PGJyPkFmdGVyIGFwcGVuZGluZyB0aGUgYWJvdmUgbGlu
ZSBpbiBydWxlcyBmaWxlLCBteSBtb2RlbSBpbnNlcnRpb24gYW5kIHJlbW92YWwgaXMgZ2V0dGlu
ZyByZWNvZ25pemVkIGJ5IG9Gb25vIGNvcmUgZGFlbW9uIGFuZCBkaXNwbGF5aW5nIGRlYnVnIHN0
YXRlbWVudHMgbGlrZSBiZWxvdy4uPGJyPjxicj5wbHVnaW5zL3VkZXYuYzpyZW1vdmVfbW9kZW0o
KSB4eHh4eHguPGJyPjxicj5XaGVuIGkgbGlzdCBteSBtb2RlbSBpbmZvcm1hdGlvbiB3aXRoICJs
aXN0LW1vZGVtIiBzY3JpcHQuIEkgZ290IG91dHB1dCBhcyBiZWxvdy4uPGJyPjxicj5bIC9zdGUw
IF08YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IEludGVyZmFjZXMgPTxicj4mbmJzcDsmbmJzcDsmbmJz
cDsgUG93ZXJlZCA9IDA8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IEZlYXR1cmVzID08YnI+Jm5ic3A7
Jm5ic3A7Jm5ic3A7IE9ubGluZSA9IDA8YnI+PGJyPklmIGkgYW0gY29ubmVjdGluZyBub2tpYSBQ
aG9uZSBpbiBQQyBTdWl0ZSBtb2RlIGl0IGlzIHdvcmtpbmcgZmluZS4gSSBhbSBnZXR0aW5nIGJl
bG93IGluZm9ybWF0aW9uIGlmIGkgbGlzdCBub2tpYSBwaG9uZSBpbmZvIHVzaW5nIGxpc3QtbW9k
ZW0gc2NyaXB0PGJyPjxicj5bIC9pc2lnZW4xIF08YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IEZlYXR1
cmVzID0gc2ltIDxicj4mbmJzcDsmbmJzcDsmbmJzcDsgUG93ZXJlZCA9IDE8YnI+Jm5ic3A7Jm5i
c3A7Jm5ic3A7IEludGVyZmFjZXMgPSBvcmcub2Zvbm8uUGhvbmVib29rIG9yZy5vZm9uby5TaW1N
YW5hZ2VyIG9yZy5vZm9uby5Wb2ljZUNhbGxNYW5hZ2VyIDxicj4mbmJzcDsmbmJzcDsmbmJzcDsg
T25saW5lID0gMDxicj4mbmJzcDsmbmJzcDsmbmJzcDsgTW9kZWwgPSBOb2tpYSBFNzE8YnI+Jm5i
c3A7Jm5ic3A7Jm5ic3A7IE1hbnVmYWN0dXJlciA9IE5va2lhPGJyPiZuYnNwOyZuYnNwOyZuYnNw
OyBTZXJpYWwgPSB4eHh4PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyBSZXZpc2lvbiA9IHh4eDxicj4w
OS0wMi0xMDxicj5STS0zNDY8YnI+KGMpIE5va2lhPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyBbIG9y
Zy5vZm9uby5QaG9uZWJvb2sgXTxicj4mbmJzcDsmbmJzcDsmbmJzcDsgWyBvcmcub2Zvbm8uU2lt
TWFuYWdlciBdPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBG
aXhlZERpYWxpbmcgPSAwPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyBTdWJzY3JpYmVyTnVtYmVycyA9IDxicj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgQmFycmVkRGlhbGluZyA9IDA8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IENhcmRJZGVudGlmaWVyID0gMTIzNDU2NTY2PGJyPiZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBMb2NrZWRQaW5zID0gPGJyPiZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBQaW5SZXF1aXJlZCA9IG5v
bmU8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFN1YnNjcmli
ZXJJZGVudGl0eSA9IDEyMzQ0NTU2Njxicj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsgUHJlc2VudCA9IDE8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IFsgb3JnLm9mb25v
LlZvaWNlQ2FsbE1hbmFnZXIgXTxicj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsgRW1lcmdlbmN5TnVtYmVycyA9IDExOSAxMTggOTk5IDExMCAwOCAwMDAgOTExIDEx
MiA8YnI+PGJyPjxicj5JIGZvdW5kIGFkZF9pc2koKSAoZXZlcnkgbW9kZW0gdmVuZG9yIGhhdmUg
dGhlaXIgb3duIGluIHVkZXYuYykgZnVuY3Rpb24gaXMgZ2V0dGluZyBnZXQgaW52b2tlZCwgd2hl
biBpIGFtIGRlYWxpbmcgd2l0aCBub2tpYSBwaG9uZSAoUEMgU3VpdGUgTW9kZSkuIElzIGl0IG5l
Y2Vzc2FyeSB0byBoYXZlICJhZGRfc3RlKCkiIGZ1bmN0aW9uIHRvIHdvcmsgd2l0aCBDQUlGIHBy
b3RvY29sLjxicj48YnI+UGxlYXNlIHN1Z2dlc3QuPGJyPjxicj5QbGVhc2Ugc3VnZ2VzdCBtZSBo
b3cgdG8gc3RhcnQgb3BlbiBjb250cmlidXRpb24gZm9yIG9Gb25vIFRlc3RpbmcuPGJyPjxicj5U
aGFuayBZb3UuPGJyPjxicj5SZWdhcmRzLDxicj5LcmlzIAkJIAkgICAJCSAgPC9ib2R5Pgo8L2h0
bWw+
--===============5210799939379858302==--

