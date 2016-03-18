Content-Type: multipart/mixed; boundary="===============0606627177896860333=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] gprs: implement ofono_gprs_cid_activated
Date: Fri, 18 Mar 2016 10:10:37 -0500
Message-ID: <56EC1A6D.6010706@gmail.com>
In-Reply-To: <1458302334-6149-4-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0606627177896860333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On 03/18/2016 06:58 AM, Dragos Tatulea wrote:
> It works by looking for a context with the same APN and tries to use
> that. Otherwise it will create it's own.
>
> Then it assigns a gprs context driver and calls it's read_settings if
> it exists.
> ---
>   src/gprs.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 114 insertions(+)
>

Applied, thanks.

Regards,
-Denis


--===============0606627177896860333==--

