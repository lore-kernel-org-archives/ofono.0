Content-Type: multipart/mixed; boundary="===============5840511156307741357=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] Add original patch format checking script
Date: Mon, 19 Jul 2010 12:50:12 -0500
Message-ID: <4C449054.3010509@gmail.com>
In-Reply-To: <1279520369-13214-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5840511156307741357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07/19/2010 01:19 AM, Yang Gu wrote:
> This test script is just a copy from kernel project. oFono uses this one
> to check if the patch has some coding style issue.
> ---
>  test/checkpatch.pl | 2615 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 2615 insertions(+), 0 deletions(-)
>  create mode 100755 test/checkpatch.pl
> =


I'm a bit hesitant to include this in oFono tree. I have zero Perl
knowledge and I want to keep it this way ;)

If someone someone commits to maintaining checkpatch.pl and making sure
all changes are synced with the kernel upstream version then I can
re-consider.  Perhaps a simpler script that uses
/usr/src/linux/checkpatch.pl might be easier to maintain?

Regards,
-Denis

--===============5840511156307741357==--

