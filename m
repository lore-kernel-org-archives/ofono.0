Content-Type: multipart/mixed; boundary="===============8656248196186516661=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] smsutil: Fix receiving UTF-16 encoded messages with split
 4-byte char
Date: Fri, 18 Nov 2016 09:35:29 -0600
Message-ID: <582F1FC1.2060305@gmail.com>
In-Reply-To: <1479471439-18482-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8656248196186516661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 11/18/2016 06:17 AM, Slava Monich wrote:
> The spec supports UCS2, but in reality UTF-16 is used, which supports
> 4-byte characters, which could be split into different message
> fragments. Accumulate the entire UTF-16 message before converting to
> UTF8.
>
> Author: Martin Jones <martin.jones@jolla.com>
> ---
>   src/smsutil.c | 30 ++++++++++++++++++++++++++----
>   1 file changed, 26 insertions(+), 4 deletions(-)
>

Applied, thanks.  It'd be nice to have a unit test for this as well.

Regards,
-Denis


--===============8656248196186516661==--

