Content-Type: multipart/mixed; boundary="===============0394996650899938232=="
MIME-Version: 1.0
From: krishna k <id_kishore@live.in>
Subject: Getting Modem properties using qt dbus programming -reg
Date: Thu, 27 May 2010 18:05:44 +0530
Message-ID: <COL106-W39D2FB4FE36047A6B0D0FFF6EA0@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0394996650899938232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

I am trying to implement application using qt dbus module, Which will call =
SetProperty with parameters QString, QVariant.

using dbus-send i am using the following command...

sudo dbus-send --system --type=3Dmethod_call --print-reply --dest=3Dorg.ofo=
no /phonesim0 org.ofono.Modem.SetProperty string:"Powered" variant:boolean:=
true

In the above command, According to my knowledge, I interpreted the things a=
s below...

Type of bus       : systembus
Type of call       : method call
service name    : org.ofono
object path        : /phonesim0
Interface name : org.ofono.Modem
method name   : SetProperty

which means ( "sv" -- string, variant)


I am trying the same thing using qt program...

    QDBusConnection bus =3D QDBusConnection::systemBus();
 =

    QDBusInterface dbus_iface("org.ofono", "/phonesim0/operator/23402",
                                  "org.ofono.Modem", bus);
     bool value =3D true;
     dbus_iface.call("SetProperty", QString("Powered"), QVariant(QVariant::=
Bool, &value));

I am getting output as below o/p..






QDBusMessage(type=3DError, service=3D"", error name=3D"org.freedesktop.DBus=
.Error.UnknownMethod", =

error message=3D"Method "SetProperty" with signature "sb" on interface "org=
.ofono.Modem" doesn't exist
", signature=3D"", contents=3D([]) ) =


Please find that "sb" which is analysed as "string and boolean" parameters.

Can any one suggest what is wrong with is piece of code...
regards,KK.

 		 	   		  =

_________________________________________________________________
South Cinema This Decade
http://entertainment.in.msn.com/southcinemathisdecade/

--===============0394996650899938232==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CjxoZWFkPgo8c3R5bGU+PCEtLQouaG1tZXNzYWdlIFAKewptYXJnaW46MHB4OwpwYWRk
aW5nOjBweAp9CmJvZHkuaG1tZXNzYWdlCnsKZm9udC1zaXplOiAxMHB0Owpmb250LWZhbWlseTpW
ZXJkYW5hCn0KLS0+PC9zdHlsZT4KPC9oZWFkPgo8Ym9keSBjbGFzcz0naG1tZXNzYWdlJz4KSGks
PGJyPjxicj5JIGFtIHRyeWluZyB0byBpbXBsZW1lbnQgYXBwbGljYXRpb24gdXNpbmcgcXQgZGJ1
cyBtb2R1bGUsIFdoaWNoIHdpbGwgY2FsbCBTZXRQcm9wZXJ0eSB3aXRoIHBhcmFtZXRlcnMgUVN0
cmluZywgUVZhcmlhbnQuPGJyPjxicj51c2luZyBkYnVzLXNlbmQgaSBhbSB1c2luZyB0aGUgZm9s
bG93aW5nIGNvbW1hbmQuLi48YnI+PGJyPnN1ZG8gZGJ1cy1zZW5kIC0tc3lzdGVtIC0tdHlwZT1t
ZXRob2RfY2FsbCAtLXByaW50LXJlcGx5IC0tZGVzdD1vcmcub2Zvbm8gL3Bob25lc2ltMCBvcmcu
b2Zvbm8uTW9kZW0uU2V0UHJvcGVydHkgc3RyaW5nOiJQb3dlcmVkIiB2YXJpYW50OmJvb2xlYW46
dHJ1ZTxicj48YnI+SW4gdGhlIGFib3ZlIGNvbW1hbmQsIEFjY29yZGluZyB0byBteSBrbm93bGVk
Z2UsIEkgaW50ZXJwcmV0ZWQgdGhlIHRoaW5ncyBhcyBiZWxvdy4uLjxicj48YnI+VHlwZSBvZiBi
dXMmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgOiBzeXN0ZW1idXM8YnI+VHlw
ZSBvZiBjYWxsJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDogbWV0aG9kIGNh
bGw8YnI+c2VydmljZSBuYW1lJm5ic3A7Jm5ic3A7Jm5ic3A7IDogb3JnLm9mb25vPGJyPm9iamVj
dCBwYXRoJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDogL3Bob25l
c2ltMDxicj5JbnRlcmZhY2UgbmFtZSA6IG9yZy5vZm9uby5Nb2RlbTxicj5tZXRob2QgbmFtZSZu
YnNwOyZuYnNwOyA6IFNldFByb3BlcnR5PGJyPjxicj53aGljaCBtZWFucyAoICJzdiIgLS0gc3Ry
aW5nLCB2YXJpYW50KTxicj48YnI+PGJyPkkgYW0gdHJ5aW5nIHRoZSBzYW1lIHRoaW5nIHVzaW5n
IHF0IHByb2dyYW0uLi48YnI+PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyBRREJ1c0Nvbm5lY3Rpb24g
YnVzID0gUURCdXNDb25uZWN0aW9uOjpzeXN0ZW1CdXMoKTs8YnI+Jm5ic3A7PGJyPiZuYnNwOyZu
YnNwOyZuYnNwOyBRREJ1c0ludGVyZmFjZSBkYnVzX2lmYWNlKCJvcmcub2Zvbm8iLCAiL3Bob25l
c2ltMC9vcGVyYXRvci8yMzQwMiIsPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAib3Jn
Lm9mb25vLk1vZGVtIiwgYnVzKTs8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IGJvb2wgdmFs
dWUgPSB0cnVlOzxicj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgZGJ1c19pZmFjZS5jYWxsKCJT
ZXRQcm9wZXJ0eSIsIFFTdHJpbmcoIlBvd2VyZWQiKSwgUVZhcmlhbnQoUVZhcmlhbnQ6OkJvb2ws
ICZhbXA7dmFsdWUpKTs8YnI+PGJyPkkgYW0gZ2V0dGluZyBvdXRwdXQgYXMgYmVsb3cgby9wLi48
YnI+PGJyPgo8bWV0YSBuYW1lPSJxcmljaHRleHQiIGNvbnRlbnQ9IjEiPjxtZXRhIGh0dHAtZXF1
aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij48c3R5
bGUgdHlwZT0idGV4dC9jc3MiPgpwLCBsaSB7IHdoaXRlLXNwYWNlOiBwcmUtd3JhcDsgfQo8L3N0
eWxlPgo8dGFibGUgc3R5bGU9Im1hcmdpbjogNHB4OyIgaGVpZ2h0PSI2MyIgd2lkdGg9Ijg4NiI+
Cjx0Ym9keT48dHI+Cjx0ZCBzdHlsZT0iYm9yZGVyOiBtZWRpdW0gbm9uZTsiPgo8cCBzdHlsZT0i
bWFyZ2luOiAwcHg7IHRleHQtaW5kZW50OiAwcHg7Ij48IS0tU3RhcnRGcmFnbWVudC0tPlFEQnVz
TWVzc2FnZSh0eXBlPUVycm9yLCZuYnNwO3NlcnZpY2U9IiIsJm5ic3A7ZXJyb3ImbmJzcDtuYW1l
PSJvcmcuZnJlZWRlc2t0b3AuREJ1cy5FcnJvci5Vbmtub3duTWV0aG9kIiwgPGJyPjwvcD48cCBz
dHlsZT0ibWFyZ2luOiAwcHg7IHRleHQtaW5kZW50OiAwcHg7Ij5lcnJvciZuYnNwO21lc3NhZ2U9
Ik1ldGhvZCZuYnNwOyJTZXRQcm9wZXJ0eSImbmJzcDt3aXRoJm5ic3A7c2lnbmF0dXJlJm5ic3A7
InNiIiZuYnNwO29uJm5ic3A7aW50ZXJmYWNlJm5ic3A7Im9yZy5vZm9uby5Nb2RlbSImbmJzcDtk
b2Vzbid0Jm5ic3A7ZXhpc3Q8YnI+IiwmbmJzcDtzaWduYXR1cmU9IiIsJm5ic3A7Y29udGVudHM9
KFtdKSZuYnNwOykgPGJyPjwvcD48cCBzdHlsZT0ibWFyZ2luOiAwcHg7IHRleHQtaW5kZW50OiAw
cHg7Ij48YnI+PC9wPjxwIHN0eWxlPSJtYXJnaW46IDBweDsgdGV4dC1pbmRlbnQ6IDBweDsiPjxm
b250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNlPSJBcmlhbCIgc2l6ZT0iMiI+UGxlYXNl
IGZpbmQgdGhhdCAic2IiPC9mb250Pjxmb250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNl
PSJBcmlhbCIgc2l6ZT0iMiI+IHdoaWNoIGlzIGFuYWx5c2VkIGFzICJzdHJpbmcgYW5kIGJvb2xl
YW4iIDwvZm9udD48Zm9udCBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyIgZmFjZT0iQXJpYWwiIHNp
emU9IjIiPnBhcmFtZXRlcnMuPC9mb250Pjxmb250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBm
YWNlPSJBcmlhbCIgc2l6ZT0iMiI+PGJyPjwvZm9udD48L3A+PHAgc3R5bGU9Im1hcmdpbjogMHB4
OyB0ZXh0LWluZGVudDogMHB4OyI+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiIGZhY2U9
IkFyaWFsIiBzaXplPSIyIj48YnI+PC9mb250PjwvcD48cCBzdHlsZT0ibWFyZ2luOiAwcHg7IHRl
eHQtaW5kZW50OiAwcHg7Ij48Zm9udCBzdHlsZT0iZm9udC1zaXplOiAxMHB0OyIgZmFjZT0iQXJp
YWwiIHNpemU9IjIiPkNhbiBhbnkgb25lIHN1Z2dlc3Qgd2hhdCBpcyB3cm9uZyB3aXRoIGlzIHBp
ZWNlIG9mIGNvZGUuLi48L2ZvbnQ+PC9wPjxwIHN0eWxlPSJtYXJnaW46IDBweDsgdGV4dC1pbmRl
bnQ6IDBweDsiPjxmb250IHN0eWxlPSJmb250LXNpemU6IDEwcHQ7IiBmYWNlPSJBcmlhbCIgc2l6
ZT0iMiI+PGJyPjwvZm9udD48L3A+PHAgc3R5bGU9Im1hcmdpbjogMHB4OyB0ZXh0LWluZGVudDog
MHB4OyI+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiIGZhY2U9IkFyaWFsIiBzaXplPSIy
Ij5yZWdhcmRzLDwvZm9udD48L3A+PHAgc3R5bGU9Im1hcmdpbjogMHB4OyB0ZXh0LWluZGVudDog
MHB4OyI+PGZvbnQgc3R5bGU9ImZvbnQtc2l6ZTogMTBwdDsiIGZhY2U9IkFyaWFsIiBzaXplPSIy
Ij5LSzwvZm9udD4uPGJyPjwhLS1FbmRGcmFnbWVudC0tPjwvcD48L3RkPjwvdHI+PC90Ym9keT48
L3RhYmxlPjxicj4gCQkgCSAgIAkJICA8YnIgLz48aHIgLz5UaGUgbGF0ZXN0IGF1dG8gbGF1bmNo
ZXMgYW5kIHRlc3QgZHJpdmVzIDxhIGhyZWY9J2h0dHA6Ly9hdXRvcy5pbi5tc24uY29tLycgdGFy
Z2V0PSdfbmV3Jz5EcmFnIG4nIGRyb3A8L2E+PC9ib2R5Pgo8L2h0bWw+
--===============0394996650899938232==--

