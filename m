Content-Type: multipart/mixed; boundary="===============4923471593894256261=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: Potential Memory Leak in isimodem
Date: Tue, 07 Jul 2009 10:27:26 +0300
Message-ID: <bdbd7349cbd98d722a4782a4f18d37d5@localhost>
In-Reply-To: <38D9F46DFF92C54980D2F2C1E8EE313001A497F938@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4923471593894256261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 7 Jul 2009 09:43:41 +0800, "Gu, Yang" <yang.gu@intel.com> wrote:
> In isimodem_init() of file drivers/isimodem/isimodem.c, memory of size of
> "struct isi_data" is allocated, but I find no place to free it. Is this a
> real memory leak?

Yes. I've got some patches lined up that will fix it.

Cheers,
Aki

--===============4923471593894256261==--

