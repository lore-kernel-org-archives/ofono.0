Content-Type: multipart/mixed; boundary="===============4801195811170809493=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH] Fix common misspellings
Date: Tue, 14 Sep 2010 19:36:13 -0300
Message-ID: <AANLkTinSaL8amVpp1KOUkmWuL1xZj6YqLrWsHJZAtY_E@mail.gmail.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4732A73C43E@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4801195811170809493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 14, 2010 at 12:21 AM, Gu, Yang <yang.gu@intel.com> wrote:
> This is an interesting patch. I guess you must have some tool/script to h=
elp you find all the misspellings against this list. Could you please share=
 the tool/script? After all, we can check the code in the future as this ki=
nd of mistake may happen from time to time.

Yes, I use a script I made based on the format of misspelling
corrections available at wikipedia. I've uploaded the 3 files I used
to http://people.profusion.mobi/~lucas/playground/

First, and most important: fix-typos.sh. It reads from stdin the words
to fix in the following format:

word->correction

If there is more than 1 possible fix, use a "," in the end of the
correction. In that case it will output to stderr the suggestions
instead of automatically fixing.

The second file, typos.txt, is the dictionary, based on that of
wikipedia. I prepared it paying attention to some problematic words
and suggestions from other projects (mainly EFL and Linux kernel)

The third file is a script to get the changed words in the format I
used in commit message. It needs to be in a git repository in order to
work.


I usually run like this:

~/bin/fix-typos.sh 2>&1 > /tmp/log.txt < ~/tmp/typos.txt | tee /tmp/log2.txt

In /tmp/log.txt will be the progress of the substitutions. It will
print it word it's searching for.
In /tmp/log2.txt will be the fixes made and suggestions about other
words that can be manually fixed later.


I hope this helps.



regards

Lucas De Marchi

--===============4801195811170809493==--

