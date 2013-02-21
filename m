Content-Type: multipart/mixed; boundary="===============1000220636065054650=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v1 5/7] handsfree-audio: Call Agent "Release" when exiting
Date: Wed, 20 Feb 2013 21:29:33 -0600
Message-ID: <5125949D.9010909@gmail.com>
In-Reply-To: <1361397351-5841-6-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1000220636065054650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 02/20/2013 03:55 PM, Claudio Takahasi wrote:
> This patch notifies the Agent implementation that it is no longer
> registered to the service daemon.
> ---
>   src/handsfree-audio.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>

<snip>

> @@ -136,6 +147,8 @@ void __ofono_handsfree_audio_manager_cleanup(void)
>   	g_dbus_unregister_interface(ofono_dbus_get_connection(), "/",
>   						HFP_AUDIO_MANAGER_INTERFACE);
>
> -	if (agent)
> +	if (agent) {
> +		agent_release(agent);
>   		agent_free(agent);
> +	}
>   }

Please note that at this point the main loop has been stopped, so it is =

unlikely for this message to ever reach the recipient.

Regards,
-Denis

--===============1000220636065054650==--

