Content-Type: multipart/mixed; boundary="===============9163947524270260078=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 08/11] Add a buffer size parameter to convert_utf8_to_gsm
Date: Tue, 01 Jun 2010 18:50:09 -0500
Message-ID: <201006011850.10018.denkenz@gmail.com>
In-Reply-To: <1275310044-27469-8-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9163947524270260078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> This is needed when encoding a string into gsm that needs to fit a
> in a given number of bytes.  Just taking the first N bytes of the
> resulting string may leave you with byte 1 of a two-byte character at
> the end of the buffer.  As far as I can tell there's no easier way to
> avoid that.

In gsm it is actually pretty easy, the escape character for two-byte sequen=
ce =

is always 0x1b, so chopping a string up could be done quite easily.

>  unsigned char *convert_utf8_to_gsm_with_lang(const char *text, long len,
>  long *items_read, long *items_written, unsigned char terminator,
> +				long max_size,
>  				enum gsm_dialect locking_shift_lang,
>  				enum gsm_dialect single_shift_lang);

If there's still need for this, I'd prefer we reuse long *items_written as =
an =

in/out argument for the max size or add another function entirely, adding y=
et =

another int argument is getting a bit ridiculous.

Regards,
-Denis

--===============9163947524270260078==--

