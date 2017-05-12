Content-Type: multipart/mixed; boundary="===============2598703384504684235=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] simfs: Prevent a crash in sim_fs_notify_file_watches
Date: Fri, 12 May 2017 14:37:54 -0500
Message-ID: <6bc29eea-c71f-a35a-0f94-e6ec83e4c87b@gmail.com>
In-Reply-To: <1494603616-19298-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2598703384504684235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 05/12/2017 10:40 AM, Slava Monich wrote:
> If no file watchers have ever been added, context->file_watches
> is NULL and sim_fs_notify_file_watches() should take that into
> account.
> ---
>  src/simfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>

Applies, thanks.

Regards,
-Denis


--===============2598703384504684235==--

