Content-Type: multipart/mixed; boundary="===============7889189485133626007=="
MIME-Version: 1.0
From: Simon Josefsson <simon@josefsson.org>
Subject: License question: Why GPLv2 only?
Date: Tue, 12 May 2009 08:50:11 +0200
Message-ID: <87fxfaak7w.fsf@mocca.josefsson.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7889189485133626007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

Interesting project.  I read some of the source code you have published,
and some files are licensed under the GPLv2 or later:

http://git.kernel.org/?p=3Dnetwork/ofono/ofono.git;a=3Dblob;f=3Dgdbus/mainl=
oop.c;hb=3DHEAD

However, many files are licensed under the GPLv2 only, with no option of
using later license versions, for example:

http://git.kernel.org/?p=3Dnetwork/ofono/ofono.git;a=3Dblob;f=3Dgatchat/gat=
chat.c;hb=3DHEAD
http://git.kernel.org/?p=3Dnetwork/ofono/ofono.git;a=3Dblob;f=3Dsrc/dbus-gs=
m.c;hb=3DHEAD

Has it been a conscious decision to use GPLv2-only for some files?

Are you aware that using GPLv2-only makes your work license incompatible
with (L)GPLv3 work?  If I understand correctly, you cannot combine any
of your GPLv2-only work with code licensed under the LGPLv3 or GPLv3.
The GPLv2-only license is not compatible with the (L)GPLv3 license, see:

http://www.gnu.org/licenses/gpl-faq.html#AllCompatibility

I would humbly request that you use GPLv2-or-later for code instead, to
allow you, and everyone else, to combine your work with (L)GPLv3 code.

Thanks,
/Simon

--===============7889189485133626007==--

