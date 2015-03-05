Content-Type: multipart/mixed; boundary="===============7782030252116202872=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: telit he910 activate-context issue
Date: Thu, 05 Mar 2015 10:02:51 -0600
Message-ID: <54F87E2B.7030102@gmail.com>
In-Reply-To: <CAH4ZQwucs3nSLTHtzfA1yXSu5UBbn7WWFH+5TkHWoVaYSRTOWQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7782030252116202872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

Please do not top-post on this mailing list.

On 03/05/2015 06:09 AM, Enrico Sau wrote:
> Hi,
> try to add the following line to he910 plugin:
>
> g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);

Was this change required?  I didn't think Telit suffered from dropping =

carrier issue.  If so, feel free to send a patch.

>
> Moreover change
>
> g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix,NULL, NULL, NULL=
);
>
> to
>
> g_at_chat_send(data->chat, "AT#AUTOATT=3D1", none_prefix,NULL, NULL, NULL=
);
>

oFono expects auto-attach to be disabled.  So this change is actually =

incorrect.  What was going wrong that was fixed by this change?

Regards,
-Denis

--===============7782030252116202872==--

