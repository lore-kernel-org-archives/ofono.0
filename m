Content-Type: multipart/mixed; boundary="===============3439010959614024025=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 0/8] Prototype to integrate gatserver with oFono
Date: Tue, 13 Apr 2010 22:18:11 +0800
Message-ID: <1271168299-4862-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3439010959614024025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These 8 patches are prototypes to integrate gatserver with oFono core:

1. Move watch_list into struct ofono_atom so that each component can be wat=
ched in an unique way.
2. Add src/emulator.c and dbus interface to create emulator.
3. Add at emulator plugin to watch call status and handle dial command requ=
est. Now it calls modem's "Dial" method through dbus interface, so it's not=
 so effective. To avoid dbus method call, however, require big changes in o=
fono core code.


--===============3439010959614024025==--

