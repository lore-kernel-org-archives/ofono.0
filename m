Content-Type: multipart/mixed; boundary="===============0943924143432286398=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] plugins-mbm: Adding timer removal to mbm_remove()
Date: Fri, 14 Jan 2011 14:41:33 +0100
Message-ID: <1295012493.3873.139.camel@aeonflux>
In-Reply-To: <1295012088-11579-1-git-send-email-tomasz.gregorek@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0943924143432286398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tomasz,

> In case the modem is disconnected during enabling process, mbm_disconnect=
()
> will set up data->reopen_source timer. This timer needs to be
> removed in mbm_remove() to stop execution of reopen_callback() after
> hardware disconnection.
> ---
>  plugins/mbm.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

patch has been applied. However as general rule for prefix of patches to
the plugin director we just use the plugin name. So in your case mbm:
would be correct. I fixed this up for you.

Regards

Marcel



--===============0943924143432286398==--

