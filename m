Content-Type: multipart/mixed; boundary="===============7658358939885735673=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stk: Fix crash seen in stk_alpha_id_unset
Date: Fri, 15 Jul 2011 11:35:33 -0500
Message-ID: <4E206C55.4030103@gmail.com>
In-Reply-To: <1310747367-6817-1-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7658358939885735673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 07/15/2011 11:29 AM, Jeevaka Badrappan wrote:
> If there is no default agent, then current agent also will
> be NULL. So, call stk_agent_request_cancel only when there is a valid
> current agent.
> ---
>  src/stk.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============7658358939885735673==--

