Content-Type: multipart/mixed; boundary="===============4375500160219126121=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test/test-modem: display more properties (Name, Online,
 Lockdown...)
Date: Tue, 08 Mar 2011 13:33:41 -0600
Message-ID: <4D768495.30608@gmail.com>
In-Reply-To: <1299596921-6708-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4375500160219126121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 03/08/2011 09:08 AM, Bertrand Aygon wrote:
> ---
>  test/test-modem |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> =


When I applied this patch I received this:

Applying: test/test-modem: display more properties (Name, Online,
Lockdown...)
/home/denkenz/ofono-master/.git/rebase-apply/patch:15: trailing whitespace.
		=

fatal: 1 line adds whitespace errors.
Patch failed at 0001 test/test-modem: display more properties (Name,
Online, Lockdown...)
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

Please configure your editor to remove indentation for empty lines.  I
fixed it for you and applied this patch (with a modified commit message).

Thanks,
-Denis

--===============4375500160219126121==--

