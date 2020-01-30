Content-Type: multipart/mixed; boundary="===============0320216023886112997=="
MIME-Version: 1.0
From: jagernicolas@legtux.org
Subject: AuthenticationMethod can't be set to none
Date: Thu, 30 Jan 2020 13:02:41 +0000
Message-ID: <20200130130241.3099.82762@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0320216023886112997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
I have a device with a Quectel EC21 module. I have to make `ofono` working =
to connect internet using the lte. In the past, another company use `pppd` =
to connect internet. Using their scripts, I can connect internet when the m=
odule is set to avoid authentication (`noauth`). Now I try to do the same w=
ith `ofono` (I have no prior knowledge of ofono/connman and even the use of=
 cell module).
 =

According to `connman-api.txt`,
```
string AuthenticationMethod [readwrite]
	Holds the PPP authentication method to use.  Valid values are "pap", "chap=
" and "none".
	Defaults to "chap".
```

I could set the value of AuthenticationMethod  to "pap, "chap" and "none". =
For example,
```
	context.SetProperty("AuthenticationMethod", dbus.String("pap"), timeout =
=3D 100)
```
will set the value. but,
```
	context.SetProperty("AuthenticationMethod", dbus.String("none"), timeout =
=3D 100)
```
I got the following error,
```
	org.ofono.Error.InvalidFormat: Argument format is not recognized
```

According to `lte-api.txt`,
```
string AuthenticationMethod [readwrite, experimental]

			Sets the Method used for the authentication
			for the default APN.

			Available values are "none", "pap" and "chap".
			Default is "none".

			If the AuthenticationMethod is set to 'none',
			no authentication is performed for the default attach
			APN.  Username and Password properties are ignored,
			even if containing a valid value.  If Username or
			Password are empty, AuthenticationMethod is implicitly
			assumed to be set to 'none'.
```
we can read that `If Username or Password are empty, AuthenticationMethod i=
s implicitly assumed to be set to 'none'.`. I try that using the `connman-a=
pi`, but yet no internet.
Using the `lte-api` don't work much, It seems the field `AuthenticationMeth=
od` is not present. When I print what come from `lte.GetProperties()` I got=
 only the field `DefaultAccessPointName`,
```
DefaultAccessPointName
dbus.Dictionary({dbus.String('DefaultAccessPointName'): dbus.String('', var=
iant_level=3D1)}, signature=3Ddbus.Signature('sv'))
```
I don't see how I could solve this. Help would be appreciated.


Additionnal informations:
versions:
```
# ofonod -v
1.24
# connmand -v
1.35
```


regards,
--===============0320216023886112997==--

