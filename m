Content-Type: multipart/mixed; boundary="===============6746233042655835964=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Build issue
Date: Tue, 31 Jan 2012 19:11:01 -0800
Message-ID: <1328065861.1955.236.camel@aeonflux>
In-Reply-To: <4F289FBE.2000900@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6746233042655835964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> Patch 38c6525 - btio: Add support for getting the Encryption Key Size =

> via btio (Vinicius Costa Gomes 6 days ago)
> =

> breaks oFono build.
> =

> make --no-print-directory all-am
> CC plugins/bluetooth.o
> CC btio/btio.o
> btio/btio.c: In function =E2=80=98get_key_size=E2=80=99:
> btio/btio.c:522: error: =E2=80=98struct bt_security=E2=80=99 has no membe=
r named =E2=80=98key_size=E2=80=99
> make[1]: *** [btio/btio.o] Error 1
> make: *** [all] Error 2
> =

> Do you know how to fix this?
> Thanks a lot.

install a recent set of Bluetooth headers and this will be fine.

Regards

Marcel



--===============6746233042655835964==--

