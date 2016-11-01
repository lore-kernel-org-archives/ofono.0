Content-Type: multipart/mixed; boundary="===============4319839789849920444=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: avoid remove context when context operation is in
 progress
Date: Tue, 01 Nov 2016 11:35:24 -0500
Message-ID: <5818C44C.6030106@gmail.com>
In-Reply-To: <1477981151-28551-1-git-send-email-caiwen.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4319839789849920444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 11/01/2016 01:19 AM, caiwen.zhang(a)intel.com wrote:
> From: Caiwen Zhang <caiwen.zhang@intel.com>
>
> If remove the context before context activation / deactivation is
> completed, it may cause crash.
> ---
>   src/gprs.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============4319839789849920444==--

