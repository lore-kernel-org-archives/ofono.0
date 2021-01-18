Content-Type: multipart/mixed; boundary="===============4205263098044277792=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: Adding support for building phonesim with Qt 6
Date: Mon, 18 Jan 2021 17:46:14 +0100
Message-ID: <20210118164621.52831-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4205263098044277792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear ofono maintainers,

Qt 6 is out now, and it was possible to add support for building phonesim
with it without too much effort.

Unfortunately, I couldn't find a pkgconfig file for the Qt5Compat module in=
 Qt6,
so this patchset includes a port of the buildsystem to CMake,
which is the recommended buildsystem for Qt 6, which Qt now uses itself.
It allows quite easily supporting Qt5 and Qt6 with not much code.
Of course a change of the buildsystem might need more discussion,
so obviously feel free to reject this if it doesn't fit your plans.

As a compromise, you could also just skip the patch that removes the old bu=
ildsystems,
and provide two choices, but this is in my opinion unnecessary maintainance=
 load.

Regarding testing the build with Qt 6, you can use the Qt installer from th=
e Qt Company.
Make sure to install the Qt5Compat module, as it's still needed for QTextCo=
dec.

Since the installer installs Qt 6 to a custom prefix, it is necessary to pa=
ss it to cmake, like this:

  cmake -DCMAKE_PREFIX_PATH=3D~/.local/Qt/6.0.1/gcc_64

(Assuming ~/.local/Qt was choosen as install destination)

Yours sincerely,
Jonah Br=C3=BCchert



--===============4205263098044277792==--

