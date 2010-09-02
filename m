Content-Type: multipart/mixed; boundary="===============7711315407851793740=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] Add so called reduced charset support to SMS
Date: Thu, 02 Sep 2010 11:43:40 -0500
Message-ID: <4C7FD43C.4020300@gmail.com>
In-Reply-To: <1283413960-31490-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7711315407851793740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 09/02/2010 02:52 AM, Aki Niemi wrote:
> This "reduced" charset support is available in some current phones to
> reduce the number of segments that a message takes.
> =

> Normally, when characters are encountered that don't have a
> representation in the GSM 7 bit alphabet, the encoding switches to
> UCS-2 that takes roughly twice as much space.
> =

> This reduced charset feature transliterates the input string, so that
> more unicode characters fit the GSM alphabet. The obvious downside is
> that transliterating loses information, i.e., the text gets dumbed
> down, and what the recipient receives is not the original text.
> =

> Nevertheless, in some regions, this is a must-have feature.
> ---
>  src/util.c       |  137 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  src/util.h       |    4 ++
>  unit/test-util.c |   18 +++++++

Please break this up into two patches.  By convention patches that touch
multiple directories should be broken up, unless needed for compilation
to succeed.

>  3 files changed, 152 insertions(+), 7 deletions(-)

<snip>

> =

> -	if (locking_lang >=3D GSM_DIALECT_INVALID)
> +	if (locking_lang > GSM_DIALECT_INVALID)
>  		return NULL;
>  =

> -	if (single_lang >=3D GSM_DIALECT_INVALID)
> +	if (single_lang > GSM_DIALECT_INVALID)
>  		return NULL;
>  =


I think this is simply too evil, can't we just change
unicode_single_shift_lookup and gsm_locking_shift_lookup to take the
codepoint table and length directly?  Then breakout the core of
convert_gsm_to_utf8_with_lang into a separate function and pass the
table + len to it.  Should be cleaner and more readable in my opinion.

Regards,
-Denis

--===============7711315407851793740==--

