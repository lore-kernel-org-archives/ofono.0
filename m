Content-Type: multipart/mixed; boundary="===============9128382863358455896=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] gatchat: Emit notification when command is sent to
 modem.
Date: Thu, 29 Apr 2010 22:00:27 -0500
Message-ID: <201004292200.27678.denkenz@gmail.com>
In-Reply-To: <1272540766-19069-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9128382863358455896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> +/*!
> + * Same as g_at_chat_send but with an ability to return a notification t=
he
> + * moment the command finally leaves the queue and is submitted to lower
> + * layer.
> + *
> + * This is useful for cases where the modem's response time needs to be
> + * measured, assuming that the lower layers processing time is shorter
> + * than the minimum accuracy needed.
> + */
> +guint g_at_chat_send_with_callback(GAtChat *chat, const char *cmd,
> +					const char **valid_resp,
> +					GAtSubmitNotifyFunc sent,
> +					GAtResultFunc func,
> +					gpointer user_data,
> +					GDestroyNotify notify);
> +

So I'm fine with the implementation but the name needs work.  Can we use =

g_at_chat_send_with_submit_notify? Or maybe g_at_chat_send_full, similar to =

how GLib does it.

Perhaps enabling submit_notification for a given command after it has been =

submitted with g_at_chat_send?

e.g. g_at_chat_set_submit_notify(GAtChat *chat, guint command, =

GAtSubmitNotifyFunc sent, gpointer user_data, GDestroyNotify notify);

Regards,
-Denis

--===============9128382863358455896==--

