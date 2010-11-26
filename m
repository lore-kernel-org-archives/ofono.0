Content-Type: multipart/mixed; boundary="===============9145221798880103082=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] text-telephony: add documentation
Date: Fri, 26 Nov 2010 13:29:04 -0600
Message-ID: <4CF00A80.4000908@gmail.com>
In-Reply-To: <1290706920-24740-3-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9145221798880103082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 11/25/2010 11:41 AM, Lucas De Marchi wrote:
> ---
>  Makefile.am                |    2 +-
>  doc/text-telephony-api.txt |   39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 1 deletions(-)
>  create mode 100644 doc/text-telephony-api.txt
> =


Patch has been applied, however I made the following commit afterwards:

> +Properties	boolean	Powered [readwrite]
> +

This one was renamed to Enabled.

Regards,
-Denis

--===============9145221798880103082==--

