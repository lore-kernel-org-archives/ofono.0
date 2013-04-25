Content-Type: multipart/mixed; boundary="===============5912847227140289097=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/3] bluez5: Unify bt_register_profile_* into a single
 function
Date: Thu, 25 Apr 2013 03:39:52 -0500
Message-ID: <5178EBD8.50900@gmail.com>
In-Reply-To: <1366752112-8007-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5912847227140289097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 04/23/2013 04:21 PM, Vinicius Costa Gomes wrote:
> It was a cause of confusion for little gain to have separate
> functions for registering profiles with extra information, for
> example "role" and "features". We remove those helper functions
> in favor of a single one with more parameters, "role" and
> "feature" when NULL, will be ignored.
> ---
>   dundee/bluez5.c         |  4 ++--
>   plugins/bluez5.c        | 17 +++++++----------
>   plugins/bluez5.h        |  7 ++-----
>   plugins/dun_gw_bluez5.c |  2 +-
>   plugins/hfp_ag_bluez5.c |  2 +-
>   plugins/hfp_hf_bluez5.c |  2 +-
>   6 files changed, 14 insertions(+), 20 deletions(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============5912847227140289097==--

