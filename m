Content-Type: multipart/mixed; boundary="===============1859135821928351796=="
MIME-Version: 1.0
From: krishna k <id_kishore@live.in>
Subject: FW: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Fri, 07 May 2010 18:15:17 +0530
Message-ID: <COL106-W2227DD990907A7F684C0F6F6F60@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1859135821928351796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

Dario, Thanks for your valuable inputs.

Hi andrzej zaborowski,

I am using NOKIA E71 phone as a modem through usb cable...

I enabled modem using test/modem_enable script....

I tried with test/list_modem to check whether it is able to detect the modem
or not. ..

it got detected and i got the following output...
-------------------------------------------------------------------
[ /isimodem0 ]
    Powered =3D 1
    Interfaces =3D org.ofono.NetworkRegistration org.ofono.Phonebook org.of=
ono.VoiceCallManager org.ofono.SimManager =

    Model =3D Nokia E71
    Manufacturer =3D Nokia
    Serial =3D xxxxxxxx
    Revision =3D V ICPR71_09w22
29-05-09
RM-346
(c) Nokia
    [ org.ofono.NetworkRegistration ]
        Status =3D unknown
        Operator =3D =

        AvailableOperators =3D dbus.Array([], signature=3Ddbus.Signature('o=
'), variant_level=3D1)
        Mode =3D auto
    [ org.ofono.Phonebook ]
    [ org.ofono.VoiceCallManager ]
        EmergencyNumbers =3D 112 911 000 08 110 999 118 119 =

        MultipartyCalls =3D =

        Calls =3D =

    [ org.ofono.SimManager ]
        SubscriberNumbers =3D =

        LockedPins =3D =

        PinRequired =3D none
        SubscriberIdentity =3D xxxxxx

-----------------------------------------------------------------------
still i am not getting the gui...

I used following process...

ofono-phonesim -p 12345 -gui ~/data/moblin.xml
sudo ofonod -nd --> ofono deamon is up and running... I am getting debug me=
ssages on console...



any suggestions?

Thanks in advance.

Regards,
Krishna K Kandula. 		 	   		  =

_________________________________________________________________
The amazing world in sharp snaps
http://news.in.msn.com/gallery/archive.aspx

--===============1859135821928351796==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8c3R5bGU+PCEtLQouaG1tZXNzYWdlIFAKewptYXJnaW46MHB4OwpwYWRk
aW5nOjBweAp9CmJvZHkuaG1tZXNzYWdlCnsKZm9udC1zaXplOiAxMHB0Owpmb250LWZhbWlseTpW
ZXJkYW5hCn0KLS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBjbGFzcz0naG1tZXNzYWdlJz4KSGks
PGJyPjxicj5EYXJpbywgVGhhbmtzIGZvciB5b3VyIHZhbHVhYmxlIGlucHV0cy48YnI+PGJyPkhp
IGFuZHJ6ZWogemFib3Jvd3NraSw8YnI+PGJyPkkgYW0gdXNpbmcgTk9LSUEgRTcxIHBob25lIGFz
IGEgbW9kZW0gdGhyb3VnaCB1c2IgY2FibGUuLi48YnI+PGJyPkkgZW5hYmxlZCBtb2RlbSB1c2lu
ZyB0ZXN0L21vZGVtX2VuYWJsZSBzY3JpcHQuLi4uPGJyPjxicj5JIHRyaWVkIHdpdGggdGVzdC9s
aXN0X21vZGVtIHRvIGNoZWNrIHdoZXRoZXIgaXQgaXMgYWJsZSB0byBkZXRlY3QgdGhlIG1vZGVt
PGJyPm9yIG5vdC4gLi48YnI+PGJyPml0IGdvdCBkZXRlY3RlZCBhbmQgaSBnb3QgdGhlIGZvbGxv
d2luZyBvdXRwdXQuLi48YnI+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj5bIC9pc2ltb2RlbTAgXTxicj4mbmJzcDsm
bmJzcDsmbmJzcDsgUG93ZXJlZCA9IDE8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IEludGVyZmFjZXMg
PSBvcmcub2Zvbm8uTmV0d29ya1JlZ2lzdHJhdGlvbiBvcmcub2Zvbm8uUGhvbmVib29rIG9yZy5v
Zm9uby5Wb2ljZUNhbGxNYW5hZ2VyIG9yZy5vZm9uby5TaW1NYW5hZ2VyIDxicj4mbmJzcDsmbmJz
cDsmbmJzcDsgTW9kZWwgPSBOb2tpYSBFNzE8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IE1hbnVmYWN0
dXJlciA9IE5va2lhPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyBTZXJpYWwgPSB4eHh4eHh4eDxicj4m
bmJzcDsmbmJzcDsmbmJzcDsgUmV2aXNpb24gPSBWIElDUFI3MV8wOXcyMjxicj4yOS0wNS0wOTxi
cj5STS0zNDY8YnI+KGMpIE5va2lhPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyBbIG9yZy5vZm9uby5O
ZXR3b3JrUmVnaXN0cmF0aW9uIF08YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IFN0YXR1cyA9IHVua25vd248YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7IE9wZXJhdG9yID0gPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyBBdmFpbGFibGVPcGVyYXRvcnMgPSBkYnVzLkFycmF5KFtdLCBzaWdu
YXR1cmU9ZGJ1cy5TaWduYXR1cmUoJ28nKSwgdmFyaWFudF9sZXZlbD0xKTxicj4mbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgTW9kZSA9IGF1dG88YnI+Jm5ic3A7Jm5i
c3A7Jm5ic3A7IFsgb3JnLm9mb25vLlBob25lYm9vayBdPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyBb
IG9yZy5vZm9uby5Wb2ljZUNhbGxNYW5hZ2VyIF08YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IEVtZXJnZW5jeU51bWJlcnMgPSAxMTIgOTExIDAwMCAwOCAxMTAg
OTk5IDExOCAxMTkgPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyBNdWx0aXBhcnR5Q2FsbHMgPSA8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7IENhbGxzID0gPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyBbIG9yZy5vZm9uby5TaW1N
YW5hZ2VyIF08YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IFN1
YnNjcmliZXJOdW1iZXJzID0gPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyBMb2NrZWRQaW5zID0gPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyBQaW5SZXF1aXJlZCA9IG5vbmU8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IFN1YnNjcmliZXJJZGVudGl0eSA9IHh4eHh4eDxicj48YnI+LS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS08YnI+c3RpbGwgaSBhbSBub3QgZ2V0dGluZyB0aGUgZ3VpLi4uPGJyPjxicj5J
IHVzZWQgZm9sbG93aW5nIHByb2Nlc3MuLi48YnI+PGJyPjxiPm9mb25vLXBob25lc2ltIC1wIDEy
MzQ1IC1ndWkgfi9kYXRhL21vYmxpbi54bWw8L2I+PGJyPjxiPnN1ZG8gb2Zvbm9kIC1uZDwvYj4g
LS0mZ3Q7IG9mb25vIGRlYW1vbiBpcyB1cCBhbmQgcnVubmluZy4uLiBJIGFtIGdldHRpbmcgZGVi
dWcgbWVzc2FnZXMgb24gY29uc29sZS4uLjxicj48YnI+PGJyPjxicj5hbnkgc3VnZ2VzdGlvbnM/
PGJyPjxicj5UaGFua3MgaW4gYWR2YW5jZS48YnI+PGJyPlJlZ2FyZHMsPGJyPktyaXNobmEgSyBL
YW5kdWxhLiAJCSAJICAgCQkgIDxiciAvPjxociAvPkNhdGNoIHRoZSBjaGFuZ2luZyBzZWN1cml0
eSBlbnZpcm9ubWVudCA8YSBocmVmPSdodHRwOi8vbmV3cy5pbi5tc24uY29tL2ludGVybmFsc2Vj
dXJpdHkvJyB0YXJnZXQ9J19uZXcnPkdldCBpdCBub3cuPC9hPjwvYm9keT4KPC9odG1sPg==
--===============1859135821928351796==--

