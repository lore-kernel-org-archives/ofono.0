Content-Type: multipart/mixed; boundary="===============6613674075894556976=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] plugins-mbm: Remove data->reopen_source timer before
 setting up new one
Date: Fri, 14 Jan 2011 14:41:32 +0100
Message-ID: <1295012492.3873.137.camel@aeonflux>
In-Reply-To: <1295012115-11605-1-git-send-email-tomasz.gregorek@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6613674075894556976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tomasz,

> Check if there is a timer running already and remove it before
> creating a new one. This will prevent calling reopen_callback() more
> than if mbm_disconnect() is called more than once.
> ---
>  plugins/mbm.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

patch has been applied, but same comment about the prefix applies here
as well.

Regards

Marcel



--===============6613674075894556976==--

