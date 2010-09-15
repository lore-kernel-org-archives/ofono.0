Content-Type: multipart/mixed; boundary="===============3898741251835579992=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH] Fix common misspellings
Date: Wed, 15 Sep 2010 13:26:44 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4732A79D8BA@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <AANLkTinSaL8amVpp1KOUkmWuL1xZj6YqLrWsHJZAtY_E@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3898741251835579992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi


>
>Yes, I use a script I made based on the format of misspelling
>corrections available at wikipedia. I've uploaded the 3 files I used
>to http://people.profusion.mobi/~lucas/playground/
>
>First, and most important: fix-typos.sh. It reads from stdin the words
>to fix in the following format:
>
>word->correction
>
>If there is more than 1 possible fix, use a "," in the end of the
>correction. In that case it will output to stderr the suggestions
>instead of automatically fixing.
>
>The second file, typos.txt, is the dictionary, based on that of
>wikipedia. I prepared it paying attention to some problematic words
>and suggestions from other projects (mainly EFL and Linux kernel)
>
>The third file is a script to get the changed words in the format I
>used in commit message. It needs to be in a git repository in order to
>work.
>
>
>I usually run like this:
>
>~/bin/fix-typos.sh 2>&1 > /tmp/log.txt < ~/tmp/typos.txt | tee /tmp/log2.t=
xt
>
>In /tmp/log.txt will be the progress of the substitutions. It will
>print it word it's searching for.
>In /tmp/log2.txt will be the fixes made and suggestions about other
>words that can be manually fixed later.
>
>
>I hope this helps.

Thanks for sharing the useful scripts!

Regards,
-Yang

--===============3898741251835579992==--

