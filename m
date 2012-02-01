Content-Type: multipart/mixed; boundary="===============8286248703898770134=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Build issue
Date: Tue, 31 Jan 2012 18:13:18 -0800
Message-ID: <4F289FBE.2000900@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8286248703898770134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

Patch 38c6525 - btio: Add support for getting the Encryption Key Size =

via btio (Vinicius Costa Gomes 6 days ago)

breaks oFono build.

make --no-print-directory all-am
CC plugins/bluetooth.o
CC btio/btio.o
btio/btio.c: In function =E2=80=98get_key_size=E2=80=99:
btio/btio.c:522: error: =E2=80=98struct bt_security=E2=80=99 has no member =
named =E2=80=98key_size=E2=80=99
make[1]: *** [btio/btio.o] Error 1
make: *** [all] Error 2

Do you know how to fix this?
Thanks a lot.

Kind regards,
Guillaume

--===============8286248703898770134==--

