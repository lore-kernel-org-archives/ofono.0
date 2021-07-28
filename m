Content-Type: multipart/mixed; boundary="===============4198349880462908637=="
MIME-Version: 1.0
From: ajlennon@dynamicdevices.co.uk
Subject: Documentation on when to free structures in/after callbacks
Date: Wed, 28 Jul 2021 16:32:24 +0000
Message-ID: <20210728163224.2797.88718@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4198349880462908637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm trying to write a driver for Quectel modems as I need some specific bit=
s and bobs - mainly signal strengths for the serving cell and neighbourhood=
 cells

I can't quite get my head around when I am supposed to provide free() funct=
ions to to calls and when to free in callbacks on success or error conditio=
ns.

Is there a bit of a document somewhere somebody could direct me to that exp=
lains this?

Or maybe I am overthinking and somebody could just explain the logic behind=
 it?

Thanks!

Alex
--===============4198349880462908637==--

