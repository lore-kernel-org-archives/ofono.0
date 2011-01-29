Content-Type: multipart/mixed; boundary="===============4302425523783956711=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] smsutil: do not allow larger file names
Date: Fri, 28 Jan 2011 20:38:56 -0600
Message-ID: <4D437DC0.9030403@gmail.com>
In-Reply-To: <1296182939-32316-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4302425523783956711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 01/27/2011 08:48 PM, Lucas De Marchi wrote:
> If file name had anything in the name after addr-msgid, it would be
> parsed as well. This is not what we want, since there could be temporary
> files lying around.
> ---
>  src/smsutil.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============4302425523783956711==--

