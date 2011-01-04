Content-Type: multipart/mixed; boundary="===============2918383904969657913=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 2/7] cdma-sms: Add CDMA SMS Support
Date: Tue, 04 Jan 2011 17:06:36 -0600
Message-ID: <4D23A7FC.7050305@gmail.com>
In-Reply-To: <1294182050-5526-1-git-send-email-lei.2.yu@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2918383904969657913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lei,

On 01/04/2011 05:00 PM, Lei Yu wrote:
> ---
>  Makefile.am        |    3 +-
>  include/cdma-sms.h |   67 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 69 insertions(+), 1 deletions(-)
>  create mode 100644 include/cdma-sms.h
> =


Still doesn't apply:
denkenz(a)ubuntu:~/ofono-master$ git am --3way ~/merge/\[PATCH\ v2\,\
2_7\]\ cdma-sms\:\ Add\ CDMA\ SMS\ Support.eml
Applying: cdma-sms: Add CDMA SMS Support
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merging Makefile.am
CONFLICT (content): Merge conflict in Makefile.am
Failed to merge in the changes.
Patch failed at 0001 cdma-sms: Add CDMA SMS Support
When you have resolved this problem run "git am -3 --resolved".
If you would prefer to skip this patch, instead run "git am -3 --skip".
To restore the original branch and stop patching run "git am -3 --abort".

Have you rebased to the latest git?

Regards,
-Denis

--===============2918383904969657913==--

