Content-Type: multipart/mixed; boundary="===============2307487443165688309=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 02/11] simutil: Added authenticate builder/parser API
Date: Wed, 11 Oct 2017 10:30:35 -0500
Message-ID: <667d8fac-7fe9-e021-78e6-801fab18a1a3@gmail.com>
In-Reply-To: <1507671380-7625-2-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2307487443165688309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/10/2017 04:36 PM, James Prestwood wrote:
> Used to compose/parse non-TLV formatted authenticate commands
> for GSM and UMTS authentication.
> ---
>   src/simutil.c | 130 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   src/simutil.h |  14 +++++++
>   2 files changed, 144 insertions(+)
> =


<snip>

> +
> +#include <stdio.h>
> +

I silently took out this #include and applied this patch.


--===============2307487443165688309==--

