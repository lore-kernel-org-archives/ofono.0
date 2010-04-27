Content-Type: multipart/mixed; boundary="===============0047299200209755902=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: Option GTM 382
Date: Tue, 27 Apr 2010 09:12:02 +0300
Message-ID: <87y6g9qv9p.fsf@potku.valot.fi>
In-Reply-To: <p2w35f991da1004260633q80d32ae4r5831ddd64e1b98bc@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0047299200209755902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Teemu Piiroinen <teemu.piiroinen@gmail.com> writes:

> No luck yet..
>
> Did I setup the sw correcty?
> - I run configure, make and make install
> - Added ofono.rules to /etc/udev/rules.d and /lib/udev/rules.d/
> - Started ofono by running ofonod from shell
>
> Is there something else I need to do?

Enable all debugs and try to check from logs what's wrong:

sudo OFONO_AT_DEBUG=3D1 ./ofonod -n -d 'plugins/* src/* drivers/*'

-- =

Kalle Valo

--===============0047299200209755902==--

