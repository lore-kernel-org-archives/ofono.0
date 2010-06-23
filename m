Content-Type: multipart/mixed; boundary="===============0061746384577816476=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/8] stkutil: Refactor command parser error handling
Date: Wed, 23 Jun 2010 14:36:43 -0500
Message-ID: <201006231436.44825.denkenz@gmail.com>
In-Reply-To: <1277205651-29369-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0061746384577816476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> When parsing the full command fails but Command Details has been parsed,
> return a struct stk_command containing this information and the type of
> parsing problem found.  We need the command details to be able to
> even respond to the command.
> =

> This patch also makes the parser skip over unknown data objects found
> in the BER-TLV, if they don't have Comprehension Required set.

I double checked the logic and it looked sound to me.  Patch has been appli=
ed, =

thanks.

Regards,
-Denis

--===============0061746384577816476==--

