Content-Type: multipart/mixed; boundary="===============6395769031795544788=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] test: tweak monitor-ofono to display special
 characters
Date: Tue, 07 Aug 2012 01:19:35 -0500
Message-ID: <5020B377.2040205@gmail.com>
In-Reply-To: <1344348152-20479-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6395769031795544788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 08/07/2012 09:02 AM, Guillaume Zajac wrote:
> ---
>   test/monitor-ofono |    4 +++-
>   1 files changed, 3 insertions(+), 1 deletions(-)
>

git show 9f3f5bce6f89045918ae9b7fede66abf0c51d59e.

Just set your terminal encoding to a UTF-8 based locale and be done with =

it.  Quit trying to find python hacks.

The only reason to use str() is to convert non-string types for easy =

printing.  Of course calling str() on utf8 strings is still not going to =

work.  There are plenty of places that still get this wrong, but this is =

not one of them.

Regards,
-Denis

--===============6395769031795544788==--

