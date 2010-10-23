Content-Type: multipart/mixed; boundary="===============5950638474887231716=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] stk: Handle the Send DTMF proactive command.
Date: Fri, 22 Oct 2010 22:55:48 -0500
Message-ID: <4CC25CC4.5080503@gmail.com>
In-Reply-To: <1287637748-7230-2-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5950638474887231716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/21/2010 12:09 AM, Andrzej Zaborowski wrote:
> The default_agent_notify and session_agent_notify changes below are
> needed for respond_on_exit commands to be able to free up their
> resources, reset alpha id, etc.  Commands other than Send DTMF that
> use respond_on_exit are all associated with a agent method call and
> get notified about agent exit in the callback.
> ---
>  src/stk.c |  143 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 142 insertions(+), 1 deletions(-)
> =


Patch has been applied, thanks.

I did find one minor error here:

> +	if (error =3D=3D EINVAL)
> +		send_simple_response(stk, STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD);

Seems positive EINVAL can never be returned.  If I missed something, let
me know.

Regards,
-Denis

--===============5950638474887231716==--

