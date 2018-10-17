Content-Type: multipart/mixed; boundary="===============0358829107618500826=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/2] Gemalto: voicecall atom
Date: Wed, 17 Oct 2018 17:04:21 -0500
Message-ID: <0a2369a4-841f-7f05-7bf4-f7d065716b72@gmail.com>
In-Reply-To: <20181017202457.16403-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0358829107618500826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/17/2018 03:24 PM, Giacinto Cifelli wrote:
> Added voicecall atom specific for Gemalto modems.
> This atom uses the URC ^SLCC to monitor the call status, as well as
> incoming calls.
> Note the use in the atom of the variable GemaltoVtsQuotes: this is
> needed to support future modules, as of today not yet available in the
> plugin.
> ---
>   Makefile.am                         |   3 +-
>   drivers/gemaltomodem/gemaltomodem.c |   3 +
>   drivers/gemaltomodem/gemaltomodem.h |   5 +
>   drivers/gemaltomodem/voicecall.c    | 578 ++++++++++++++++++++++++++++
>   4 files changed, 588 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gemaltomodem/voicecall.c
> =


I went ahead and applied both of these after cleaning up some style issues.

Regards,
-Denis


--===============0358829107618500826==--

