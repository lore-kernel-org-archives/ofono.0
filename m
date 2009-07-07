Content-Type: multipart/mixed; boundary="===============1632874475150613734=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: Potential Memory Leak in isimodem
Date: Tue, 07 Jul 2009 09:43:41 +0800
Message-ID: <38D9F46DFF92C54980D2F2C1E8EE313001A497F938@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1632874475150613734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In isimodem_init() of file drivers/isimodem/isimodem.c, memory of size of "=
struct isi_data" is allocated, but I find no place to free it. Is this a re=
al memory leak?

Regards,
-Yang


--===============1632874475150613734==--

