Content-Type: multipart/mixed; boundary="===============8161199634077880201=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4][RFC] stkutil: Refactor command parser error handling
Date: Tue, 22 Jun 2010 16:44:32 -0500
Message-ID: <201006221644.32955.denkenz@gmail.com>
In-Reply-To: <1276702015-8711-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8161199634077880201==
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
> =

> The tests succeed but please check that it doesn't break the logic.

I'm ok with the approach, however the patch no longer applies.  Can you ple=
ase =

rebase and resubmit?

Thanks,
-Denis

--===============8161199634077880201==--

