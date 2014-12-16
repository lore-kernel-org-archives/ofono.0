Content-Type: multipart/mixed; boundary="===============2205969884799993498=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: "IPv6.Settings" in interface "org.ofono.ConnectionContext" is not
 a valid name
Date: Mon, 15 Dec 2014 23:12:33 -0600
Message-ID: <548FBF41.3030806@gmail.com>
In-Reply-To: <CAJ-KqdzPe=-phOwH4Eh52jWRWmT-CLrL5OV9RTF_N3nFt8nAQw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2205969884799993498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/15/2014 09:57 PM, vicamo(a)gmail.com wrote:
> Hi all,
>
> I happen to find a strange property "IPv6.Settings" in
> ConnectionContext. According to DBus specification [1], dbus member
> names can only be consisted of character set "[A-Z][a-z][0-9]_" and may
> not begin with a digit. Any plan to get rid of it? Or is a patch to this
> welcomed? It will certainly break compatibility to existing programs.
>
> [1]:
> http://dbus.freedesktop.org/doc/dbus-specification.html#message-protocol-=
names
>

Properties are not member names, so the restrictions you mention do not =

apply.  See the DBus Specification:

"Strictly speaking, D-Bus property names are not required to follow the =

same naming restrictions as member names, but D-Bus property names that =

would not be valid member names (in particular, GObject-style =

dash-separated property names) can cause interoperability problems and =

should be avoided. "

Since the oFono DBus API is currently frozen, there are no plans on =

"fixing" this particular property.

Regards,
-Denis

--===============2205969884799993498==--

