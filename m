Content-Type: multipart/mixed; boundary="===============3214734291091734408=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] emulator: Add ofono_emulator framework
Date: Tue, 13 Jul 2010 20:46:44 -0500
Message-ID: <4C3D1704.1020403@gmail.com>
In-Reply-To: <33AB447FBD802F4E932063B962385B351F7EE603@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3214734291091734408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> I grabed code from obex to register&start DUN GW service when we parse ad=
apter properties. From patch 6/6, you can see my current implementation is =
to find the first powered modem that having GRPS atom. Load settings from m=
odem.conf could be another option. But what if the modem is detected from u=
dev? It could be huawei0, huawei1 or huawei<N>.

Doing it via .conf file is still possible.  E.g. we might be able to
stipulate that only modems with a particular driver get exported (e.g.
driver=3D"huawei" or driver=3D"isi")  Or perhaps a hardcoded path / first
modem available.  I wouldn't worry about it for now, do whatever is
easiest.  The more interesting part is getting the oFono core emulator
bits working.

Regards,
-Denis

--===============3214734291091734408==--

