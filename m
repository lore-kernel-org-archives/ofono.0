Content-Type: multipart/mixed; boundary="===============7798462220684739571=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v1 5/5] Use tabs as Denis required
Date: Tue, 23 Feb 2021 14:08:20 -0600
Message-ID: <08ea8330-e97c-2326-5c91-806f26d98958@gmail.com>
In-Reply-To: <20210223044653.4933-6-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7798462220684739571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jupiter,

On 2/22/21 10:46 PM, Bing Jupiter wrote:
> From: Jupiter <jupiter.hce@gmail.com>

Please make sure your authorship information is updated in the commit meta-=
data =

as well for  all the patches you're submitting.

> =

> ---
>   drivers/atmodem/vendor.h |  2 +-
>   drivers/qmimodem/gprs.c  | 26 +++++++++++++-------------
>   plugins/gobi.c           | 14 +++++++-------
>   plugins/udevng.c         |  6 +++---
>   4 files changed, 24 insertions(+), 24 deletions(-)
> =


No, please don't do it this way.  This patch should not  exist.  Instead ta=
ke =

the changes from this patch and amend the previous 4 patches.  In other wor=
ds, =

the previous 4 patches should be following the coding style as documented i=
n =

doc/coding-style.txt.

Regards,
-Denis
--===============7798462220684739571==--

