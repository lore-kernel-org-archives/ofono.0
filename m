Content-Type: multipart/mixed; boundary="===============7261183007718338989=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] monitor-ofono: Fix to print non-English characters
Date: Fri, 27 Jul 2012 00:34:50 -0500
Message-ID: <5012287A.4010109@gmail.com>
In-Reply-To: <1343318274-19845-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7261183007718338989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 07/26/2012 10:57 AM, Philippe Nunes wrote:
> The default encoding for a Python bytestring is ASCII. But the
> SMS/USSD text is encoded in UTF-8.
> This is why trying to convert non-English characters (Unicode
> characters beyond 128) produces the error
> "UnicodeEncodeError: 'ascii' codec can't encode character".
> ---
>   test/monitor-ofono |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>

Patch has been applied, thanks.

Regards,
-Denis

--===============7261183007718338989==--

