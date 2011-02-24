Content-Type: multipart/mixed; boundary="===============0962378109660329050=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] tools: add client to receive location reporting
Date: Wed, 23 Feb 2011 18:58:14 -0600
Message-ID: <4D65AD26.5090803@gmail.com>
In-Reply-To: <1298490584-11743-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0962378109660329050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 02/23/2011 01:49 PM, Lucas De Marchi wrote:
> As of now there's no support for fd-passing in D-Bus Python bindings,
> hence a small C client is needed in order to test location-reporting
> atom.
> ---
>  Makefile.am          |    5 +-
>  tools/get-location.c |  259 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 263 insertions(+), 1 deletions(-)
>  create mode 100644 tools/get-location.c
> =


Patch has been applied, but please check my follow on commit for
correctness.

Regards,
-Denis

--===============0962378109660329050==--

