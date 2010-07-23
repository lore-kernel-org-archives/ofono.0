Content-Type: multipart/mixed; boundary="===============5612414287335514433=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 0/5] Add oFono DUN emulator
Date: Fri, 23 Jul 2010 17:40:29 +0800
Message-ID: <1279878034-12971-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5612414287335514433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

These are the updated patches for DUN emulator. First, it listens modem "On=
line" signal to register itself to bluetooth library. Second, it register D=
UN record through D-Bus interface. Btio library from Obex is simplified to =
only keep RFCOMM part.

Thanks,
Zhenhua

--===============5612414287335514433==--

