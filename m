Content-Type: multipart/mixed; boundary="===============4985826056165552377=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] stk: Fix issue in stk_alpha_id_set
Date: Wed, 26 Jan 2011 15:26:22 -0600
Message-ID: <4D40917E.8090103@gmail.com>
In-Reply-To: <1296072911-3301-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4985826056165552377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 01/26/2011 02:15 PM, Jeevaka Badrappan wrote:
> Fixes the crash seen with the null alpha identifier.
> Also removed the icon check as icon will always be a valid pointer.
> ---
>  src/stk.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> =


Applied with a slightly modified commit description.

Regards,
-Denis

--===============4985826056165552377==--

