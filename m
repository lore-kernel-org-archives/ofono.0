Content-Type: multipart/mixed; boundary="===============0674466847970345659=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] ofono_sim_context api header changes.
Date: Thu, 03 Feb 2011 13:17:49 -0600
Message-ID: <4D4AFF5D.4060307@gmail.com>
In-Reply-To: <1296260961-15155-4-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0674466847970345659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 01/28/2011 06:29 PM, Andrzej Zaborowski wrote:
> This patch introduces sim FS contexts which are used to queue file
> read and write operations.  When a context is freed all pending
> operations in that context are cancelled preventing callbacks from
> being called causing segfaults.  This patch breaks the build without
> patch 5/5.
> =

> ofono_sim_read/_write function names are not changed because they
> seem better names than ofono_sim_context_read/_write.
> ---
>  include/sim.h |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============0674466847970345659==--

