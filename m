Content-Type: multipart/mixed; boundary="===============7949566133010398338=="
MIME-Version: 1.0
From: TengChou Yang <threefure@gmail.com>
Subject: Voicecall while context is activate
Date: Wed, 30 Oct 2013 11:29:32 -0700
Message-ID: <CAHtt_wkiBZgFZDZzyH8vi_7X1-da9XVWJAhDaScg-2915-tAoQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7949566133010398338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
I am able to create voicecalls, creating contexts by using Option module
GTM661W. Please see following for the issue,
if I activate the context,
/usr/lib/ofono/test/list-contexts
[ /hso_0 ]
    [ /hso_0/context1 ]
        Username =3D isp(a)cingulargprs.com
        Protocol =3D ip
        Name =3D Data Connect (old)
        Settings =3D { }
        IPv6.Settings =3D { }
        Active =3D 0
        AccessPointName =3D isp.cingular
        Password =3D cingular1
        Type =3D internet

/usr/lib/ofono/test/activate-context,
{ConnectionContext} [/hso_0/context1] Settings =3D { DomainNameServers =3D
209.183.35.23 209.183.33.23, Method =3D static, Netmask =3D 255.255.255.255,
Address =3D 166.204.XXX.XX, Interface =3D hso0, Gateway =3D 0.0.0.0 }
{ConnectionContext} [/hso_0/context1] Active =3D True
{ConnectionContext} [/hso_0/context1] Settings =3D {}
{ConnectionContext} [/hso_0/context1] Active =3D False

and than create the voicecall,

root(a)g2:~# /usr/lib/ofono/test/dial-number XXXXXXXXXX
Using modem /hso_0
/hso_0/voicecall01

the test case shows it had been created in voicecall01, but when I list the
phone call
root(a)g2:~# /usr/lib/ofono/test/list-calls
[ /hso_0 ]
    [ /hso_0/voicecall02 ]
        Name =3D
        LineIdentification =3D 9496796229
        Multiparty =3D 0
        Emergency =3D 0
        RemoteHeld =3D 0
        State =3D alerting
        RemoteMultiparty =3D 0

the voicecall which supposed to be at the first
interface(/hso_0/voicecall01) will be created at second
interface(/hso_0/voicecall02).

Does anyone have any clue for this problem?

Sincerely,
TengChou Yang

--===============7949566133010398338==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGksPGRpdj48aDEgc3R5bGU9ImRpc3BsYXk6aW5saW5lO2ZvbnQtc2l6
ZToxMC45MDkwOTA5OTU3ODg1NzRweDtmb250LXdlaWdodDpub3JtYWw7Y29sb3I6cmdiKDAsMCww
KTtmb250LWZhbWlseTpUYWhvbWEsJiMzOTtTYW5zIFNlcmlmJiMzOTssQXJpYWw7d2hpdGUtc3Bh
Y2U6bm93cmFwIj5JIGFtIGFibGUgdG8gY3JlYXRlIHZvaWNlY2FsbHMsIGNyZWF0aW5nIGNvbnRl
eHRzIGJ5IHVzaW5noDwvaDE+Ck9wdGlvbiBtb2R1bGUgR1RNNjYxVy4gUGxlYXNlIHNlZSBmb2xs
b3dpbmcgZm9yIHRoZSBpc3N1ZTxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoMCwwLDApO2ZvbnQtZmFt
aWx5OlRhaG9tYSwmIzM5O1NhbnMgU2VyaWYmIzM5OyxBcmlhbDtmb250LXNpemU6MTAuOTA5MDkw
OTk1Nzg4NTc0cHg7d2hpdGUtc3BhY2U6bm93cmFwIj4sPC9zcGFuPjwvZGl2PjxkaXY+PGZvbnQg
Y29sb3I9IiMwMDAwMDAiIGZhY2U9IlRhaG9tYSwgU2FucyBTZXJpZiwgQXJpYWwiPjxzcGFuIHN0
eWxlPSJmb250LXNpemU6MTFweDt3aGl0ZS1zcGFjZTpub3dyYXAiPmlmIEkgYWN0aXZhdGUgdGhl
IGNvbnRleHQsPC9zcGFuPjwvZm9udD48L2Rpdj4KPGRpdj48Zm9udCBjb2xvcj0iIzAwMDAwMCIg
ZmFjZT0iVGFob21hLCBTYW5zIFNlcmlmLCBBcmlhbCI+PGRpdiBzdHlsZT0iZm9udC1zaXplOjEx
cHg7d2hpdGUtc3BhY2U6bm93cmFwIj4vdXNyL2xpYi9vZm9uby90ZXN0L2xpc3QtY29udGV4dHMg
oKA8L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTFweDt3aGl0ZS1zcGFjZTpub3dyYXAiPlsg
L2hzb18wIF08L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTFweDt3aGl0ZS1zcGFjZTpub3dy
YXAiPgqgIKAgWyAvaHNvXzAvY29udGV4dDEgXTwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZTox
MXB4O3doaXRlLXNwYWNlOm5vd3JhcCI+oCCgIKAgoCBVc2VybmFtZSA9IDxhIGhyZWY9Im1haWx0
bzppc3BAY2luZ3VsYXJncHJzLmNvbSI+aXNwQGNpbmd1bGFyZ3Bycy5jb208L2E+PC9kaXY+PGRp
diBzdHlsZT0iZm9udC1zaXplOjExcHg7d2hpdGUtc3BhY2U6bm93cmFwIj6gIKAgoCCgIFByb3Rv
Y29sID0gaXA8L2Rpdj4KPGRpdiBzdHlsZT0iZm9udC1zaXplOjExcHg7d2hpdGUtc3BhY2U6bm93
cmFwIj6gIKAgoCCgIE5hbWUgPSBEYXRhIENvbm5lY3QgKG9sZCk8L2Rpdj48ZGl2IHN0eWxlPSJm
b250LXNpemU6MTFweDt3aGl0ZS1zcGFjZTpub3dyYXAiPqAgoCCgIKAgU2V0dGluZ3MgPSB7IH08
L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTFweDt3aGl0ZS1zcGFjZTpub3dyYXAiPqAgoCCg
IKAgSVB2Ni5TZXR0aW5ncyA9IHsgfTwvZGl2Pgo8ZGl2IHN0eWxlPSJmb250LXNpemU6MTFweDt3
aGl0ZS1zcGFjZTpub3dyYXAiPqAgoCCgIKAgQWN0aXZlID0gMDwvZGl2PjxkaXYgc3R5bGU9ImZv
bnQtc2l6ZToxMXB4O3doaXRlLXNwYWNlOm5vd3JhcCI+oCCgIKAgoCBBY2Nlc3NQb2ludE5hbWUg
PSBpc3AuY2luZ3VsYXI8L2Rpdj48ZGl2IHN0eWxlPSJmb250LXNpemU6MTFweDt3aGl0ZS1zcGFj
ZTpub3dyYXAiPqAgoCCgIKAgUGFzc3dvcmQgPSBjaW5ndWxhcjE8L2Rpdj4KPGRpdiBzdHlsZT0i
Zm9udC1zaXplOjExcHg7d2hpdGUtc3BhY2U6bm93cmFwIj6gIKAgoCCgIFR5cGUgPSBpbnRlcm5l
dDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtc2l6ZToxMXB4O3doaXRlLXNwYWNlOm5vd3JhcCI+PGJy
PjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMXB4O3doaXRlLXNwYWNlOm5vd3Jh
cCI+L3Vzci9saWIvb2Zvbm8vdGVzdC9hY3RpdmF0ZS1jb250ZXh0LDwvc3Bhbj48YnI+CjwvZGl2
PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMXB4O3doaXRlLXNwYWNlOm5vd3JhcCI+PGRp
dj57Q29ubmVjdGlvbkNvbnRleHR9IFsvaHNvXzAvY29udGV4dDFdIFNldHRpbmdzID0geyBEb21h
aW5OYW1lU2VydmVycyA9IDIwOS4xODMuMzUuMjMgMjA5LjE4My4zMy4yMywgTWV0aG9kID0gc3Rh
dGljLCBOZXRtYXNrID0gMjU1LjI1NS4yNTUuMjU1LCBBZGRyZXNzID0gMTY2LjIwNC5YWFguWFgs
IEludGVyZmFjZSA9IGhzbzAsIEdhdGV3YXkgPSAwLjAuMC4wIH08L2Rpdj4KPGRpdj57Q29ubmVj
dGlvbkNvbnRleHR9IFsvaHNvXzAvY29udGV4dDFdIEFjdGl2ZSA9IFRydWU8L2Rpdj48ZGl2PntD
b25uZWN0aW9uQ29udGV4dH0gWy9oc29fMC9jb250ZXh0MV0gU2V0dGluZ3MgPSB7fTwvZGl2Pjxk
aXY+e0Nvbm5lY3Rpb25Db250ZXh0fSBbL2hzb18wL2NvbnRleHQxXSBBY3RpdmUgPSBGYWxzZTwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+YW5kIHRoYW4gY3JlYXRlIHRoZSB2b2ljZWNhbGwsPC9k
aXY+CjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdj5yb290QGcyOn4jIC91c3IvbGliL29mb25vL3Rl
c3QvZGlhbC1udW1iZXIgWFhYWFhYWFhYWDwvZGl2PjxkaXY+VXNpbmcgbW9kZW0gL2hzb18wPC9k
aXY+PGRpdj4vaHNvXzAvdm9pY2VjYWxsMDE8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PnRoZSB0ZXN0IGNhc2Ugc2hvd3MgaXQgaGFkIGJlZW4gY3JlYXRlZCBpbiB2b2ljZWNhbGwwMSwg
YnV0IHdoZW4gSSBsaXN0IHRoZSBwaG9uZSBjYWxsPC9kaXY+CjxkaXY+PGRpdj5yb290QGcyOn4j
IC91c3IvbGliL29mb25vL3Rlc3QvbGlzdC1jYWxsc6A8L2Rpdj48ZGl2PlsgL2hzb18wIF08L2Rp
dj48ZGl2PqAgoCBbIC9oc29fMC92b2ljZWNhbGwwMiBdPC9kaXY+PGRpdj6gIKAgoCCgIE5hbWUg
PaA8L2Rpdj48ZGl2PqAgoCCgIKAgTGluZUlkZW50aWZpY2F0aW9uID0gOTQ5Njc5NjIyOTwvZGl2
PjxkaXY+oCCgIKAgoCBNdWx0aXBhcnR5ID0gMDwvZGl2Pgo8ZGl2PqAgoCCgIKAgRW1lcmdlbmN5
ID0gMDwvZGl2PjxkaXY+oCCgIKAgoCBSZW1vdGVIZWxkID0gMDwvZGl2PjxkaXY+oCCgIKAgoCBT
dGF0ZSA9IGFsZXJ0aW5nPC9kaXY+PGRpdj6gIKAgoCCgIFJlbW90ZU11bHRpcGFydHkgPSAwPC9k
aXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj50aGUgdm9pY2VjYWxsIHdoaWNoIHN1cHBvc2Vk
IHRvIGJlIGF0IHRoZSBmaXJzdCBpbnRlcmZhY2UoL2hzb18wL3ZvaWNlY2FsbDAxKSB3aWxsIGJl
IGNyZWF0ZWQgYXQgc2Vjb25kIGludGVyZmFjZSgvaHNvXzAvdm9pY2VjYWxsMDIpLjwvZGl2Pgo8
ZGl2Pjxicj48L2Rpdj48ZGl2PkRvZXMgYW55b25lIGhhdmUgYW55IGNsdWUgZm9yIHRoaXMgcHJv
YmxlbT88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlNpbmNlcmVseSw8L2Rpdj48ZGl2PlRlbmdD
aG91IFlhbmc8L2Rpdj48L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMXB4O3doaXRlLXNw
YWNlOm5vd3JhcCI+PGRpdj48YnI+PC9kaXY+PC9zcGFuPjwvZGl2PjwvZm9udD48L2Rpdj4KPC9k
aXY+Cg==

--===============7949566133010398338==--

