Content-Type: multipart/mixed; boundary="===============8257358159592396765=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: Modernize phonesim codebase
Date: Tue, 12 Nov 2019 22:37:06 +0100
Message-ID: <20191112213719.9309-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8257358159592396765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear maintainers,
as mentioned earlier I'm now sending the remaining patches to ofono phonesi=
m.

I tried to split them up logically and to explain them in their description=
s. If anything is still unclear, please ask.
Overall the patchset fixes all compiler warnings that appear with the recom=
medations of Qt, as found in QtCreator.

The changes that have been made automatically using clang tooling are marke=
d as such in their descriptions, and should be reproducible when running cl=
ang-tidy again.

Some of the patches are independent of the others and can be left out if no=
t wanted.

I'd still require some help testing the scripting functionality after my ch=
anges. If someone has a working scripting setup, I'd be glad if they could =
test this.
The changes related to scripting are basically a switch of the java script =
engine from the deprecated QtScript to QtQml.

Kind regards,
Jonah


--===============8257358159592396765==--

