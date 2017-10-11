Content-Type: multipart/mixed; boundary="===============8912626394034664052=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 04/11] sim: new API to check for a UST service only
Date: Wed, 11 Oct 2017 10:34:51 -0500
Message-ID: <34594d39-a2fa-ea62-78e9-3e57768cd09e@gmail.com>
In-Reply-To: <1507671380-7625-4-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8912626394034664052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/10/2017 04:36 PM, James Prestwood wrote:
> The existing service check API takes both SST and UST services
> and could inadvertently return success on a service if one
> (SST or UST) service did not exist. This adds an API specifically
> for checking for a UST service, and if the UST dir is not available
> it will return FALSE, rather than possibly returning true on some
> other SST service.
> ---
>   src/ofono.h | 2 ++
>   src/sim.c   | 9 +++++++++
>   2 files changed, 11 insertions(+)
> =


Patch 3 & 4 applied, thanks.

Regards,
-Denis


--===============8912626394034664052==--

